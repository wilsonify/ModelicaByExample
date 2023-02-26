"""
In this example, the FMU represents a simple bouncing ball model,
with a single input (representing an external force applied to the ball)
and a single output (representing the position of the ball).
"""
import gymnasium as gym
import numpy as np
import pyfmi


class BouncingBallEnv(gym.Env):
    """
    The observation_space is defined as a single-dimensional box,
    with a lower bound of negative infinity and an upper bound of positive infinity.

    The action_space is also defined as a single-dimensional box,
    with a lower bound of -1.0 and an upper bound of 1.0,
    representing the minimum and maximum values for the external force applied to the ball.
    """

    def __init__(self, fmu_path):
        self.fmu = pyfmi.load_fmu(fmu_path)
        self.observation_space = gym.spaces.Box(
            low=-np.inf,
            high=np.inf,
            shape=(1,),
            dtype=np.float32
        )

        self.action_space = gym.spaces.Box(
            low=-1.0,
            high=1.0,
            shape=(1,),
            dtype=np.float32
        )
        self.dt = 0.01

    def reset(self):
        """
        The reset method initializes the FMU and sets the input to 0.0.
        The step method sets the input to the action provided by the agent and runs the simulation for a single step,
        with a step size of self.dt (0.01 seconds in this example).
        """
        self.fmu.reset()
        self.fmu.set('input', 0.0)
        return self.observe()

    def step(self, action):
        self.fmu.set('input', action[0])
        self.fmu.do_step(current_t=self.fmu.time, step_size=self.dt)
        reward = self.compute_reward()
        done = self.is_done()
        return self.observe(), reward, done, {}

    def observe(self):
        """
        The observe method returns the current position of the ball,
        represented as a single-dimensional array.
        """
        return np.array([self.fmu.get('output')])

    def compute_reward(self):
        """
        The compute_reward method returns a reward proportional to the absolute value of the ball's position,
        with a negative sign, to encourage the agent to keep the ball as close to the center as possible.
        """
        position = self.fmu.get('output')
        return -abs(position)

    def is_done(self):
        """
        The is_done method returns True if the ball's position is greater than 10,
        representing that the ball has fallen off the edge of the platform,
        signaling the end of the episode.
        """
        position = self.fmu.get('output')
        return abs(position) > 10
