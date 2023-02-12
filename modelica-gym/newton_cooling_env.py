"""
In this example, the FMU represents the behavior.discrete.cooling.NewtonCoolingDynamic Modelica model,
with a single input (representing the valve position) and a single output (representing the temperature of the system).

The observation_space is defined as a one-dimensional box,
with a lower bound of negative infinity and an upper bound of positive infinity, representing the temperature.

The action_space is defined as a Discrete space with three possible values,
representing the three possible valve positions (0.0, 0.5, and 1.0).

The reset method initializes the FMU.
The step method sets the valve position based on the action provided by the agent
and runs the simulation for a single step, with a step size of self. dt (0.01 seconds in this example).

The observe method returns the current temperature of the system,
represented as a one-dimensional array.

The compute_reward method returns a reward equal to the negative absolute difference
between the current temperature and 20, to encourage the agent to cool the system to 20.

The is_done method returns True if the absolute difference between the current temperature and 20 is less than 0.1,
signaling the end of the episode.
"""
import gym
import numpy as np
import pyfmi

class NewtonCoolingEnv(gym.Env):
    def __init__(self, fmu_path):
        self.fmu = pyfmi.load_fmu(fmu_path)
        self.observation_space = gym.spaces.Box(
            low=-np.inf, high=np.inf, shape=(1,), dtype=np.float32)
        self.action_space = gym.spaces.Discrete(3)
        self.dt = 0.01

    def reset(self):
        self.fmu.reset()
        return self.observe()

    def step(self, action):
        if action == 0:
            self.fmu.set('valve', 0.0)
        elif action == 1:
            self.fmu.set('valve', 0.5)
        elif action == 2:
            self.fmu.set('valve', 1.0)
        self.fmu.do_step(current_t=self.fmu.time, step_size=self.dt)
        reward = self.compute_reward()
        done = self.is_done()
        return self.observe(), reward, done, {}

    def observe(self):
        return np.array([self.fmu.get('T')])

    def compute_reward(self):
        T = self.fmu.get('T')
        return -abs(T - 20)

    def is_done(self):
        T = self.fmu.get('T')
        return abs(T - 20) < 0.1
