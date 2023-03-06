"""
demonstrates how to implement the [Actor-Critic](https://papers.nips.cc/paper/1786-actor-critic-algorithms.pdf)
method using TensorFlow to train an agent on the [Open AI Gym](https://gym.openai.com/)
have some familiarity with policy gradient methods of reinforcement learning.

**Actor-Critic methods**
Actor-Critic methods are temporal difference (TD) learning methods that
represent the policy function independent of the value function.

A policy function (or policy) returns a probability distribution over actions that the agent
can take based on the given state.

A value function determines the expected return for an agent starting at a given state and acting according
to a particular policy forever after.

In the Actor-Critic method,
the policy is referred to as the *actor* that proposes a set of possible actions given a state,
and the estimated value function is referred to as the *critic*,
which evaluates actions taken by the *actor* based on the given policy.


"""

import collections
import statistics
from typing import List, Tuple

import numpy as np
import tensorflow as tf
from keras import layers

import gymnasium as gym
from bouncing_ball_env import BouncingBallEnv

eps = 0.00001  # np.finfo(np.float32).eps.item()  # Small epsilon value for stabilizing division operations
gym.register(id="BouncingBall-v1", entry_point=BouncingBallEnv)
env = gym.make("BouncingBall-v1", render_mode='human')


class ActorCritic(tf.keras.Model):
    """
    Combined actor-critic network.
    Model
    The *Actor* and *Critic* will be modeled using one neural network that generates
    the action probabilities and critic value respectively.
    This tutorial uses model subclassing to define the model.

    During the forward pass,
    the model will take in the state as the input and will output both action probabilities and critic value $V$,
    which models the state-dependent
    [value function](https://spinningup.openai.com/en/latest/spinningup/rl_intro.html#value-functions).
    The goal is to train a model that chooses actions based on a policy $\pi$ that
    maximizes expected [return](https://spinningup.openai.com/en/latest/spinningup/rl_intro.html#reward-and-return).

    For Cartpole-v0, there are four values representing the state:
    cart position, cart-velocity, pole angle and pole velocity respectively.
    The agent can take two actions to push the cart left (0) and right (1) respectively.

    Refer to [OpenAI Gym's CartPole-v0 wiki page](http://www.derongliu.org/adp/adp-cdrom/Barto1983.pdf)
    for more information.
    """

    def __init__(
            self,
            num_actions: int,
            num_hidden_units: int):
        """Initialize."""
        super().__init__()

        self.common = layers.Dense(num_hidden_units, activation="relu")
        self.actor = layers.Dense(num_actions)
        self.critic = layers.Dense(1)

    def call(self, inputs: tf.Tensor) -> Tuple[tf.Tensor, tf.Tensor]:
        x = self.common(inputs)
        return self.actor(x), self.critic(x)


def env_step(action: np.ndarray) -> Tuple[np.ndarray, np.ndarray, np.ndarray]:
    """
    Wrap OpenAI Gym's `env.step` call as an operation in a TensorFlow function.
    This would allow it to be included in a callable TensorFlow graph.
    Returns state, reward and done flag given an action.
    """

    state, reward, done, trunc, _ = env.step(action)
    return (state.astype(np.float32),
            np.array(reward, np.int32),
            np.array(done, np.int32))


def tf_env_step(action: tf.Tensor) -> List[tf.Tensor]:
    return tf.numpy_function(
        env_step,
        [action],
        [tf.float32, tf.int32, tf.int32]
    )


# + id="a4qVRV063Cl9"
def run_episode(
        initial_state: tf.Tensor,
        model: tf.keras.Model,
        max_steps: int) -> Tuple[tf.Tensor, tf.Tensor, tf.Tensor]:
    """Runs a single episode to collect training data."""

    action_probs = tf.TensorArray(dtype=tf.float32, size=0, dynamic_size=True)
    values = tf.TensorArray(dtype=tf.float32, size=0, dynamic_size=True)
    rewards = tf.TensorArray(dtype=tf.int32, size=0, dynamic_size=True)

    initial_state_shape = initial_state.shape
    state = initial_state

    for t in tf.range(max_steps):
        # Convert state into a batched tensor (batch size = 1)
        state = tf.expand_dims(state, 0)

        # Run the model and to get action probabilities and critic value
        action_logits_t, value = model(state)

        # Sample next action from the action probability distribution
        action = tf.random.categorical(action_logits_t, 1)[0, 0]
        action_probs_t = tf.nn.softmax(action_logits_t)

        # Store critic values
        values = values.write(t, tf.squeeze(value))

        # Store log probability of the action chosen
        action_probs = action_probs.write(t, action_probs_t[0, action])

        # Apply action to the environment to get next state and reward
        state, reward, done = tf_env_step(action)
        state.set_shape(initial_state_shape)

        # Store reward
        rewards = rewards.write(t, reward)

        if tf.cast(done, tf.bool):
            break

    action_probs = action_probs.stack()
    values = values.stack()
    rewards = rewards.stack()

    return action_probs, values, rewards


def get_expected_return(
        rewards: tf.Tensor,
        gamma: float,
        standardize: bool = True) -> tf.Tensor:
    """

    Compute expected returns per timestep.
    The sequence of rewards for each timestep $t$, $\{r_{t}\}^{T}_{t=1}$
    collected during one episode is converted into a sequence of
    expected returns $\{G_{t}\}^{T}_{t=1}$ in which the sum of rewards is taken from the
    current timestep $t$ to $T$ and each reward is multiplied with an
    exponentially decaying discount factor $\gamma$:
    $$G_{t} = \sum^{T}_{t'=t} \gamma^{t'-t}r_{t'}$$
    Since $\gamma\in(0,1)$, rewards further out from the current timestep are given less weight.
    Intuitively, expected return simply implies that rewards now are better than rewards later.
    In a mathematical sense, it is to ensure that the sum of the rewards converges.
    To stabilize training, the resulting sequence of returns is also standardized
    (i.e. to have zero mean and unit standard deviation).
    """

    n = tf.shape(rewards)[0]
    returns = tf.TensorArray(dtype=tf.float32, size=n)

    # Start from the end of `rewards` and accumulate reward sums
    # into the `returns` array
    rewards = tf.cast(rewards[::-1], dtype=tf.float32)
    discounted_sum = tf.constant(0.0)
    discounted_sum_shape = discounted_sum.shape
    for i in tf.range(n):
        reward = rewards[i]
        discounted_sum = reward + gamma * discounted_sum
        discounted_sum.set_shape(discounted_sum_shape)
        returns = returns.write(i, discounted_sum)
    returns = returns.stack()[::-1]

    if standardize:
        returns = ((returns - tf.math.reduce_mean(returns)) /
                   (tf.math.reduce_std(returns) + eps))

    return returns


huber_loss = tf.keras.losses.Huber(reduction=tf.keras.losses.Reduction.SUM)


def compute_loss(
        action_probs: tf.Tensor,
        values: tf.Tensor,
        returns: tf.Tensor) -> tf.Tensor:
    """
    Computes the combined actor-critic loss.
    The actor-critic loss
    Since a hybrid actor-critic model is used,
    the chosen loss function is a combination of actor and critic losses for training, as shown below:
    $$L = L_{actor} + L_{critic}$$

    #### Actor loss
    The actor loss is based on [policy gradients with the critic as a
    state dependent baseline](https://www.youtube.com/watch?v=EKqxumCuAAY&t=62m23s)
    and computed with single-sample (per-episode) estimates.
    $$L_{actor} = -\sum^{T}_{t=1} \log\pi_{\theta}(a_{t} | s_{t})[G(s_{t}, a_{t})  - V^{\pi}_{\theta}(s_{t})]$$

    where:
    $T$: the number of timesteps per episode, which can vary per episode
    $s_{t}$: the state at timestep $t$
    $a_{t}$: chosen action at timestep $t$ given state $s$
    $\pi_{\theta}$: is the policy (actor) parameterized by $\theta$
    $V^{\pi}_{\theta}$: is the value function (critic) also parameterized by $\theta$
    $G = G_{t}$: the expected return for a given state, action pair at timestep $t$

    A negative term is added to the sum since the idea is to
    maximize the probabilities of actions yielding higher rewards by minimizing the combined loss.

    ##### Advantage
    The $G - V$ term in our $L_{actor}$ formulation is called the
    [advantage](https://spinningup.openai.com/en/latest/spinningup/rl_intro.html#advantage-functions),
    which indicates how much better an action is given a particular state over
    a random action selected according to the policy $\pi$ for that state.

    While it's possible to exclude a baseline,
    this may result in high variance during training.
    And the nice thing about choosing the critic $V$ as a
    baseline is that it trained to be as close as possible to $G$, leading to a lower variance.

    In addition, without the critic,
    the algorithm would try to increase probabilities for actions taken on a
    particular state based on expected return,
    which may not make much of a difference if the relative probabilities between actions remain the same.

    For instance, suppose that two actions for a given state would yield the same expected return.
    Without the critic, the algorithm would try to raise the probability of
    these actions based on the objective $J$.
    With the critic, it may turn out that there's no advantage ($G - V = 0$) and
    thus no benefit gained in increasing the actions'
    probabilities and the algorithm would set the gradients to zero.

    #### Critic loss
    Training $V$ to be as close possible to $G$ can be set up as a
    regression problem with the following loss function:
    $$L_{critic} = L_{\delta}(G, V^{\pi}_{\theta})$$
    where $L_{\delta}$ is the [Huber loss](https://en.wikipedia.org/wiki/Huber_loss),
    which is less sensitive to outliers in data than squared-error loss.
    """
    advantage = returns - values
    action_log_probs = tf.math.log(action_probs)
    actor_loss = -tf.math.reduce_sum(action_log_probs * advantage)
    critic_loss = huber_loss(values, returns)
    return actor_loss + critic_loss


@tf.function
def train_step(
        initial_state: tf.Tensor,
        model: tf.keras.Model,
        optimizer: tf.keras.optimizers.Optimizer,
        gamma: float,
        max_steps_per_episode: int) -> tf.Tensor:
    """
    Runs a model training step.
    ### 4. Defining the training step to update parameters
    All of the steps above are combined into a training step that is run every episode.
    All steps leading up to the loss function are executed with the
    `tf.GradientTape` context to enable automatic differentiation.
    This tutorial uses the Adam optimizer to apply the gradients to the model parameters.
    The sum of the undiscounted rewards, `episode_reward`, is also computed in this step.
    This value will be used later on to evaluate if the success criterion is met.
    The `tf.function` context is applied to the `train_step`
    function so that it can be compiled into a callable TensorFlow graph,
    which can lead to 10x speedup in training.
    """

    with tf.GradientTape() as tape:
        # Run the model for one episode to collect training data
        action_probs, values, rewards = run_episode(
            initial_state, model, max_steps_per_episode)

        # Calculate expected returns
        returns = get_expected_return(rewards, gamma)

        # Convert training data to appropriate TF tensor shapes
        action_probs, values, returns = [
            tf.expand_dims(x, 1) for x in [action_probs, values, returns]]

        # Calculating loss values to update our network
        loss = compute_loss(action_probs, values, returns)

    # Compute the gradients from the loss
    grads = tape.gradient(loss, model.trainable_variables)

    # Apply the gradients to the model's parameters
    optimizer.apply_gradients(zip(grads, model.trainable_variables))

    episode_reward = tf.math.reduce_sum(rewards)

    return episode_reward


def render_episode(env: gym.Env, model: tf.keras.Model, max_steps: int):
    """
    Render an episode and save as a GIF file
    After training,
    it would be good to visualize how the model performs in the environment.
    You can run the cells below to generate a GIF animation of one episode run of the model.
    """
    screen = env.render()
    images = []
    state = tf.constant(env.reset(), dtype=tf.float32)
    for i in range(1, max_steps + 1):
        state = tf.expand_dims(state, 0)
        action_probs, _ = model(state)
        action = np.argmax(np.squeeze(action_probs))
        state, _, done, trunc, _ = env.step(action)
        state = tf.constant(state, dtype=tf.float32)
        if i % 10 == 0:  # Render screen every 10 steps
            env.render_mode = 'human'
            env.render()
            env.render_mode = 'rgb_array'
        if done:
            break
    return images


def main():
    """
    Training
    To train the agent, you will follow these steps:

    1. Run the agent on the environment to collect training data per episode.
    2. Compute expected return at each time step.
    3. Compute the loss for the combined actor-critic model.
    4. Compute gradients and update network parameters.
    5. Repeat 1-4 until either success criterion or max episodes has been reached.

    ### 1. Collecting training data
    As in supervised learning, in order to train the actor-critic model, you need
    to have training data. However, in order to collect such data, the model would
    need to be "run" in the environment.

    Training data is collected for each episode.
    Then at each time step,
    the model's forward pass will be run on the environment's state in order to generate action
    probabilities and the critic value based on the current policy parameterized by the model's weights.

    The next action will be sampled from the action probabilities generated by the model,
    which would then be applied to the environment,
    causing the next state and reward to be generated.

    This process is implemented in the `run_episode` function,
    which uses TensorFlow operations so that it can later be
    compiled into a TensorFlow graph for faster training.
    Note that `tf.TensorArray`s were used to support Tensor iteration on variable length arrays.

    5. Run the training loop
    Training is executed by running the training step until either
    the success criterion or maximum number of episodes is reached.
    A running record of episode rewards is kept in a queue.
    Once 100 trials are reached, the oldest reward is removed at the left (tail)
    end of the queue and the newest one is added at the head (right).
    A running sum of the rewards is also maintained for computational efficiency.
    Depending on your runtime, training can finish in less than a minute.
    """

    seed = 42  # Set seed for experiment reproducibility
    env.seed = seed
    tf.random.set_seed(seed)
    np.random.seed(seed)

    num_actions = env.action_space.n  # 2
    num_hidden_units = 128
    model = ActorCritic(num_actions, num_hidden_units)
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.01)
    min_episodes_criterion = 100
    max_episodes = 10000
    max_steps_per_episode = 1000
    reward_threshold = 195  # Cartpole-v0 is considered solved if average reward is >= 195 over 100 consecutive trials
    running_reward = 0
    gamma = 0.99  # Discount factor for future rewards
    episodes_reward: collections.deque = collections.deque(maxlen=min_episodes_criterion)  # Keep last episodes reward
    for i in range(max_episodes):
        initial_state = tf.constant(env.reset()[0], dtype=tf.float32)
        episode_reward = int(train_step(initial_state, model, optimizer, gamma, max_steps_per_episode))
        episodes_reward.append(episode_reward)
        running_reward = statistics.mean(episodes_reward)
        if i % 10 == 0:  # Show average episode reward every 10 episodes
            print(f'Episode {i}: episode_reward: {episode_reward}')
        if running_reward > reward_threshold and i >= min_episodes_criterion:
            break
    print(f'Solved at episode {i}: average reward: {running_reward:.2f}')


if __name__ == "__main__":
    main()
    env.render()
