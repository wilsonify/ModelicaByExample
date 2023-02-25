"""
RL cycle
"""

import gym
from gym import register

from newton_cooling_env import NewtonCoolingEnv

register(
    id='NewtonCoolingEnv-v1',
    entry_point=NewtonCoolingEnv,
    reward_threshold=None,
    nondeterministic=False,
    max_episode_steps=500,
    order_enforce=True,
    autoreset=False,
    disable_env_checker=False,
    apply_api_compatibility=False,

)


def make_CartPole():
    # create the environment
    env = gym.make("NewtonCoolingEnv-v1")
    # reset the environment before starting
    env.reset()

    # loop 10 times
    for i in range(10):
        # take a random action
        env.step(env.action_space.sample())
        # render the game
        env.render()

    # close the environment
    env.close()


def make_CartPole_better():
    # create and initialize the environment
    env = gym.make("CartPole-v1")
    env.reset()

    # play 10 games
    for i in range(10):
        # initialize the variables
        done = False
        game_rew = 0

        while not done:
            # choose a random action
            action = env.action_space.sample()
            # take a step in the environment
            new_obs, rew, done, info = env.step(action)
            game_rew += rew

            # when is done, print the cumulative reward of the game and reset the environment
            if done:
                print("Episode %d finished, reward:%d" % (i, game_rew))
                env.reset()


def show_CartPole():
    env = gym.make("CartPole-v1")
    print(env.observation_space)
    print(env.action_space)
    print(env.action_space.sample())
    print(env.action_space.sample())
    print(env.action_space.sample())
    print(env.observation_space.low)
    print(env.observation_space.high)


def main():
    make_CartPole()
    make_CartPole_better()
    show_CartPole()


if __name__ == "__main__":
    main()
