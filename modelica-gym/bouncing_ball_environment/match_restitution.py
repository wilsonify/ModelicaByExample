import gymnasium as gym
from bouncing_ball_env import BouncingBallEnv


def update_ball_better(env, nepisodes=100, nsteps=100):
    """
    play multiple episodes
    """
    env.reset()  # reset the environment before starting
    for i in range(nepisodes):
        print(f'i={i}')
        # initialize variables
        game_reward = 0
        pedometer = 0
        for j in range(nsteps):
            pedometer += 1
            print(f"pedometer = {pedometer}")
            action = env.action_space.sample()  # choose a random action
            print(f"action = {action}")
            new_obs, reward, done, truncated, info = env.step(action)  # take a step in the environment
            game_reward += reward
            print(f"new_obs = {new_obs}")
            print(f"reward = {reward}")
            print(f"done = {done}")
            print(f"truncated = {truncated}")
            print(f"info = {info}")
            print(f"game_reward = {game_reward}")
            if done:
                print(f"Episode {i} finished, reward: {game_reward}")
                env.reset()
                break


def main():
    gym.register(id="BouncingBall-v1", entry_point=BouncingBallEnv)
    with gym.make("BouncingBall-v1", render_mode='human') as env:
        env.reset()
        env.update_ball_random(nsteps=100)
        update_ball_better(env, nepisodes=100, nsteps=100)
        env.render()


if __name__ == "__main__":
    main()
