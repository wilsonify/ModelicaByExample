import gym
import numpy as np
import pyfmi


class FmuEnv(gym.Env):
    def __init__(self, fmu_path):
        self.fmu = pyfmi.load_fmu(fmu_path)
        self.observation_space = gym.spaces.Box(
            low=-np.inf, high=np.inf, shape=(...,), dtype=np.float32)
        self.action_space = gym.spaces.Box(
            low=-1.0, high=1.0, shape=(...,), dtype=np.float32)

    def reset(self):
        self.fmu.reset()
        return self.observe()

    def step(self, action):
        self.set_action(action)
        self.fmu.do_step(current_t=self.fmu.time, step_size=self.dt)
        reward = self.compute_reward()
        done = self.is_done()
        return self.observe(), reward, done, {}

    def observe(self):
        ...

    def set_action(self, action):
        ...

    def compute_reward(self):
        ...

    def is_done(self):
        ...
