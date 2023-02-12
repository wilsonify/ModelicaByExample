"""
In this example,
the FMU represents the SpatiallyDistributedHeatTransfer Modelica model,
with a single input (representing the heat flow) and n outputs (representing the temperature of each segment).

The observation_space is defined as a Box space with n dimensions,
with a lower bound of negative infinity and an upper bound of positive infinity,
representing the temperature of each segment.

The action_space is defined as a Discrete space with two possible values,
representing the two possible heat flow values (0.0 and 1.0).

The reset method initializes the FMU.
The step method sets the heat flow based on the action provided
by the agent and runs the simulation for a single step,
with a step size of self.dt (0.01 seconds in this example).

The observe method returns the current temperatures of each segment,
represented as an n-dimensional array.

The compute_reward method returns a reward equal to the negative
sum of the absolute differences between the current temperatures and 20,
to encourage the agent to cool all the segments to 20.

"""
import gym
import numpy as np
import pyfmi


class SpatiallyDistributedHeatTransferEnv(gym.Env):
    def __init__(self, fmu_path, n):
        self.fmu = pyfmi.load_fmu(fmu_path)
        self.n = n
        self.observation_space = gym.spaces.Box(
            low=-np.inf, high=np.inf, shape=(n,), dtype=np.float32)
        self.action_space = gym.spaces.Discrete(2)
        self.dt = 0.01

    def reset(self):
        self.fmu.reset()
        return self.observe()

    def step(self, action):
        if action == 0:
            self.fmu.set('heatFlow', 0.0)
        elif action == 1:
            self.fmu.set('heatFlow', 1.0)
        self.fmu.do_step(current_t=self.fmu.time, step_size=self.dt)
        reward = self.compute_reward()
        done = self.is_done()
        return self.observe(), reward, done, {}

    def observe(self):
        return np.array([self.fmu.get(f'T[{i + 1}]') for i in range(self.n)])

    def compute_reward(self):
        T = np.array([self.fmu.get(f'T[{i + 1}]') for i in range(self.n)])
        return -np.sum(np.abs(T - 20))

    def is_done(self):
        T = np.array([self.fmu.get(f'T[{i + 1}]') for i in range(self.n)])
        return np.all(np.abs(T - 20) < 0.1)
