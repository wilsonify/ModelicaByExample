"""
In this example, the FMU represents the Modelica.Fluid.Examples.PumpingSystem model,
with a single input (representing the pressure applied to the pump)
and two outputs (representing the flow rate through the pipe and the head across the pump).
"""
import gym
import numpy as np
import pyfmi

class PumpingSystemEnv(gym.Env):
    """
    The observation_space is defined as a two-dimensional box,
    with a lower bound of negative infinity and an upper bound of positive infinity.

    The action_space is defined as a single-dimensional box,
    with a lower bound of 0.0 and an upper bound of 100.0,
    representing the minimum and maximum values for the pump pressure.
    """
    def __init__(self, fmu_path):
        self.fmu = pyfmi.load_fmu(fmu_path)
        self.observation_space = gym.spaces.Box(
            low=-np.inf, high=np.inf, shape=(2,), dtype=np.float32)
        self.action_space = gym.spaces.Box(
            low=0.0, high=100.0, shape=(1,), dtype=np.float32)
        self.dt = 0.01

    def reset(self):
        """
        The reset method initializes the FMU and sets the pump pressure to 50.0.
        """
        self.fmu.reset()
        self.fmu.set('pump.p', 50.0)
        return self.observe()

    def step(self, action):
        """
        The step method sets the pump pressure to the action provided by the agent and runs the simulation for a single step,
        with a step size of self.dt (0.01 seconds in this example).
        """
        self.fmu.set('pump.p', action[0])
        self.fmu.do_step(current_t=self.fmu.time, step_size=self.dt)
        reward = self.compute_reward()
        done = self.is_done()
        return self.observe(), reward, done, {}

    def observe(self):
        """
        The observe method returns the current flow rate through the pipe and the head across the pump,
        represented as a two-dimensional array.
        """
        return np.array([self.fmu.get('pipe.Q_flow'), self.fmu.get('pipe.h_flow')])

    def compute_reward(self):
        """
        The compute_reward method returns a reward equal to the sum of the flow rate and the head,
        to encourage the agent to maximize both values.
        """
        flow = self.fmu.get('pipe.Q_flow')
        head = self.fmu.get('pipe.h_flow')
        return flow + head

    def is_done(self):
        """
        The is_done method returns True if the flow rate is greater than 100,
        representing that the pump has reached its maximum capacity,
        signaling the end of the episode.
        """
        flow = self.fmu.get('pipe.Q_flow')
        return abs(flow) > 100
