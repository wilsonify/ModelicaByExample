"""
In this example, the FMU represents a simple bouncing ball model,
with a single input (representing the restitution of the ball)
and a single output (representing the position of the ball).
"""
import numpy as np
from matplotlib import pyplot as plt
from matplotlib.gridspec import GridSpec
from pyfmi import load_fmu
from pyfmi.fmi import FMUException

import gymnasium as gym
from gymnasium.spaces import Discrete
from objective import desire


def to_number(x):
    if isinstance(x, np.ndarray):
        y = float(x[0])
    y = float(y)
    return y


class BouncingBallEnv(gym.Env):
    """
    The observation_space is defined as a single-dimensional box,
    with a lower bound of negative infinity and an upper bound of positive infinity.

    The action_space is also defined as a single-dimensional box,
    with a lower bound of -1.0 and an upper bound of 1.0,
    representing the minimum and maximum values for the external force applied to the ball.
    """
    metadata = {
        "render_modes": ["human", "text"],
        "render_fps": 2,
    }

    def __init__(self, render_mode='human'):
        self.fmu_path = "BouncingBall.fmu"
        self.plant = load_fmu(self.fmu_path)
        self.estimate = load_fmu(self.fmu_path)
        self.observation_space = gym.spaces.Box(
            low=np.array([0], dtype=np.float64),
            high=np.array([10], dtype=np.float64),
            shape=(1,),
            dtype=np.float64
        )
        self.action_space = Discrete(2)
        self.dt = 0.02
        self.plant_model_mismatch = {}
        self.plant_model_mismatch_prev = {}
        self.render_mode = render_mode
        self.t_list = []
        self.h_plant_list = []
        self.h_est_list = []
        self.v_plant_list = []
        self.v_est_list = []

    def reset(self, seed=None, options=None):
        """
        The reset method initializes the FMU and sets the input to 0.0.
        The step method sets the input to the action provided by the agent and runs the simulation for a single step,
        with a step size of self.dt (0.01 seconds in this example).
        """
        try:
            self.plant.initialize(0, 2.0, True)
        except FMUException:
            self.plant.reset()
            self.plant.initialize(0, 2.0, True)
        self.plant.set('e', 0.5)
        self.plant.set('g', 10.0)

        try:
            self.estimate.initialize(0, 2.0, True)
        except FMUException:
            self.estimate.reset()
            self.estimate.initialize(0, 2.0, True)

        self.estimate.set('e', 0.7)
        self.estimate.set('g', 9.0)
        self.plant_model_mismatch = self.plant.get('e') - self.estimate.get('e')
        self.t_list = []
        self.h_plant_list = []
        self.h_est_list = []
        self.v_plant_list = []
        self.v_est_list = []
        return self.observe(), {}

    def step(self, action):
        assert self.action_space.contains(action), f"{action!r} ({type(action)}) invalid"
        e_change = np.float(action) * 0.01
        e_prev = self.estimate.get('e')
        e_next = e_prev + e_change
        self.estimate.set('e', e_next)
        self.plant.do_step(current_t=self.plant.time, step_size=self.dt)
        self.estimate.do_step(current_t=self.plant.time, step_size=self.dt)
        new_obs = self.observe()
        reward = self.compute_reward()
        done = self.plant.time > 2.0
        truncated = False
        info = {}
        return new_obs, reward, done, truncated, info

    def observe(self):
        """
        The observe method returns the current position of the ball,
        represented as a single-dimensional array.
        """
        obs = self.plant.get('h')
        if not isinstance(obs, np.ndarray):
            obs = np.asarray(obs, dtype=np.float64)
        self.t_list.append(self.plant.time)
        self.h_plant_list.append(to_number(self.plant.get('h')))
        self.h_est_list.append(to_number(self.estimate.get('h')))
        self.v_plant_list.append(to_number(self.plant.get('v')))
        self.v_est_list.append(to_number(self.estimate.get('v')))
        return [self.t_list, self.h_plant_list, self.h_est_list, self.v_plant_list, self.v_est_list]

    def compute_reward(self):
        """
        The compute_reward method returns a reward proportional to the absolute value of the ball's position,
        with a negative sign, to encourage the agent to keep the ball as close to the center as possible.
        """
        height_to_target = desire(
            h=self.estimate.get('h'),
            low=self.observation_space.low,
            target=self.plant.get('h'),
            high=self.observation_space.high
        )
        self.plant_model_mismatch_prev = self.plant_model_mismatch.copy()
        self.plant_model_mismatch = self.plant.get('e') - self.estimate.get('e')
        mismatch_to_constant = desire(
            h=self.plant_model_mismatch,
            low=0.0,
            target=self.plant_model_mismatch_prev,
            high=1.0
        )
        overall = mismatch_to_constant * height_to_target
        return [overall]

    def render(self):
        if self.render_mode == "human":
            self.render_human()
        if self.render_mode == "text":
            self.render_text()

    def render_human(self):
        gs = GridSpec(nrows=2, ncols=1, height_ratios=[1, 1])
        fig = plt.figure()
        fig.title = 'FMI Bouncing Ball'
        ax0 = fig.add_subplot(gs[0])
        ax1 = fig.add_subplot(gs[1])
        ax0.set_xlabel('Time (s)')
        ax0.set_ylabel('Height (m)')
        ax1.set_xlabel('Time (s)')
        ax1.set_ylabel('Velocity (m/s)')
        ax0.plot(self.t_list, self.h_plant_list, label="plant", c='k')
        ax1.plot(self.t_list, self.v_plant_list, label="plant", c='k')
        ax0.plot(self.t_list, self.h_est_list, label=f"estimate", c='r')
        ax1.plot(self.t_list, self.v_est_list, label=f"estimate", c='r')
        plt.show()
        plt.close()

    def render_text(self):
        print(self.observation_space)
        print(f"action_space = {self.action_space}")
        print(f"action_space.sample() = {self.action_space.sample()}")
        print(f"action_space.sample() = {self.action_space.sample()}")
        print(f"observation_space.low = {self.observation_space.low}")
        print(f"observation_space.high = {self.observation_space.high}")

    def update_ball_random(self, nsteps=10):
        for i in range(nsteps):  # loop 10 times
            self.step(self.action_space.sample())  # take a random action
            if i % 50 == 0:
                self.render()
