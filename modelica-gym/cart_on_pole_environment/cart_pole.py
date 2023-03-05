"""
RL cycle
RL requires an agent and an environment to interact with each other,
problems stem from the large number of interactions that an agent has to execute with the
environment in order to learn good behaviors.

It is infeasible to require hundreds, thousands, or even millions of actions,
In many cases, the task can be fully simulated.

To research and implement RL algorithms, games, and robots are a perfect testbed because,
in order to be solved, they require capabilities such as planning, strategy, and long-term memory.

games have a clear reward system and can be completely simulated in a computer,
allowing fast interactions that accelerate the learning process.

OpenAI Gym, an open source toolkit for developing and researching RL algorithms,
was created to provide a common and shared interface for environments,
while making a large and diverse collection of environments available.

These include Atari 2600 games,
continuous control tasks, classic control theory problems, simulated robotic goal-based tasks,
and simple text games.

Owing to its generality, many environments created by third parties are using the Gym interface.
"""

import gymnasium as gym
from cartpole import CartPoleEnv


def show_cartpole(env):
    print(env.observation_space)
    print(f"action_space = {env.action_space}")
    print(f"action_space.sample() = {env.action_space.sample()}")
    print(f"action_space.sample() = {env.action_space.sample()}")
    print(f"observation_space.low = {env.observation_space.low}")
    print(f"observation_space.high = {env.observation_space.high}")


def reset_cartpole(env):
    env.reset()


def update_cartpole_random(env, nsteps=10):
    for i in range(nsteps):  # loop 10 times
        env.step(env.action_space.sample())  # take a random action
        env.render()  # render the game
        if i % 50 == 0:
            show_cartpole(env)


def update_cartpole_better(env, ngames=100, nsteps=100):
    """
    play multiple games
    """
    for i in range(ngames):
        print(f'i={i}')
        # initialize game variables
        game_reward = 0
        pedometer = 0
        for j in range(nsteps):
            pedometer += 1
            print(f"pedometer = {pedometer}")
            action = env.action_space.sample()  # choose a random action
            new_obs, reward, done, truncated, info = env.step(action)  # take a step in the environment
            game_reward += reward
            print(f"new_obs = {new_obs}")
            print(f"reward = {reward}")
            print(f"done = {done}")
            print(f"truncated = {truncated}")
            print(f"info = {info}")
            print(f"game_reward = {game_reward}")
            env.render()
            if done:
                print(f"Episode {i} finished, reward: {game_reward}")
                reset_cartpole(env)
                break


def main():
    gym.register(id="CartPole-v5", entry_point=CartPoleEnv)
    with gym.make("CartPole-v5", render_mode='human') as env:
        reset_cartpole(env)  # reset the environment before starting
        show_cartpole(env)
        update_cartpole_random(env, nsteps=100)
        reset_cartpole(env)  # reset the environment before starting
        update_cartpole_better(env, ngames=100, nsteps=100)
        show_cartpole(env)


if __name__ == "__main__":
    main()
