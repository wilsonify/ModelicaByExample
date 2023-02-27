"""
In this example, the FMU represents a simple bouncing ball model,
with a single input (representing an external force applied to the ball)
and a single output (representing the position of the ball).
"""
import numpy as np
from pyfmi import load_fmu

import gymnasium as gym
from objective import desire


class BouncingBallEnv(gym.Env):
    """
    The observation_space is defined as a single-dimensional box,
    with a lower bound of negative infinity and an upper bound of positive infinity.

    The action_space is also defined as a single-dimensional box,
    with a lower bound of -1.0 and an upper bound of 1.0,
    representing the minimum and maximum values for the external force applied to the ball.
    """

    def __init__(self, fmu_path):
        self.plant = load_fmu(fmu_path)
        self.estimate = load_fmu(fmu_path)
        self.observation_space = gym.spaces.Box(
            low=0,
            high=10,
            shape=(1,),
            dtype=np.float32
        )

        self.action_space = gym.spaces.Box(
            low=0.1,
            high=1.1,
            shape=(1,),
            dtype=np.float32
        )
        self.dt = 0.02

    def reset(self):
        """
        The reset method initializes the FMU and sets the input to 0.0.
        The step method sets the input to the action provided by the agent and runs the simulation for a single step,
        with a step size of self.dt (0.01 seconds in this example).
        """
        self.plant.reset()
        self.plant.set('e', 0.5)
        self.plant.set('g', 10.0)
        self.estimate.reset()
        self.estimate.set('e', 0.7)
        self.estimate.set('g', 9.0)
        return self.observe()

    def step(self, action):
        self.estimate.set('e', action[0])
        self.plant.do_step(current_t=self.plant.time, step_size=self.dt)
        self.estimate.do_step(current_t=self.plant.time, step_size=self.dt)
        reward = self.compute_reward()
        done = self.is_done()
        return self.observe(), reward, done, {}

    def observe(self):
        """
        The observe method returns the current position of the ball,
        represented as a single-dimensional array.
        """
        return np.array([self.plant.get('h')])

    def compute_reward(self):
        """
        The compute_reward method returns a reward proportional to the absolute value of the ball's position,
        with a negative sign, to encourage the agent to keep the ball as close to the center as possible.
        """
        return desire(
            h=self.estimate.get('h'),
            low=self.observation_space.low,
            target=self.plant.get('h'),
            high=self.observation_space.high
        )

    def is_done(self):
        """
        The is_done method returns True if the ball's position is greater than 10,
        representing that the ball has fallen off the edge of the platform,
        signaling the end of the episode.
        """
        return self.plant.time > 200

    def render(self):
        pass
