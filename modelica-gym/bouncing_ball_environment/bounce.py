"""
Demonstrates simulation of FMUs
"""
import logging
from collections import defaultdict

import numpy as np
import pandas as pd
import plotly.graph_objects as go
from matplotlib import pyplot as plt
from matplotlib.animation import FuncAnimation
from matplotlib.gridspec import GridSpec
from pyfmi import load_fmu
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import PolynomialFeatures

from doepy.build import plackett_burman
from doepy.doe_functions import build_box_behnken, build_full_fact

bd = {"e": [0.1, 1.0], "g": [1.0, 10.0]}
limits = {"h": [0, 1], "time": [0, 2]}


def pbdesign(dd):
    df = plackett_burman(dd)
    result = []
    for ind, trial in df.iterrows():
        result.append(trial.to_dict())
    return result


def bbdesign(dd):
    levels = defaultdict(list)
    for var in dd:
        levels[var] = [0, 0, 0]
        levels[var][0] = dd[var][0]
        levels[var][1] = (dd[var][0] + dd[var][1]) / 2
        levels[var][2] = dd[var][1]
    df = build_box_behnken(levels, center=1)
    result = []
    for ind, trial in df.iterrows():
        result.append(trial.to_dict())
    return result


def ffdesign(dd, levels=3):
    levels_dict = {}
    for var in dd:
        regular = np.linspace(
            start=dd[var][0],
            stop=dd[var][1],
            num=levels
        )
        spacing = np.diff(regular).mean().round(2)
        levels_dict[var] = list(np.arange(
            start=dd[var][0],
            stop=dd[var][1],
            step=spacing
        ).round(2))

    df = build_full_fact(levels_dict)
    result = []
    for ind, trial in df.iterrows():
        result.append(trial.to_dict())
    return result


def desire(h, low, target, high):
    if h < low:
        return 0
    if h > high:
        return 0
    if low < h <= target:
        return -low / (-low + target) + h / (-low + target)
    if target <= h < high:
        return 1 + target / (high - target) - h / (high - target)


def main():
    fmu_name = '/media/thom/SSD1/mrepos/github.com/wilsonify/ModelicaByExample/modelica-gym/bouncing_ball_environment/BouncingBall.fmu'

    model_simulator = load_fmu(fmu_name)
    model_simulator.initialize(0, 2.0, True)
    model_simulator.reset()

    model_plant = load_fmu(fmu_name)
    model_plant.initialize(0, 2.0, True)
    model_plant.reset()
    model_plant.set('e', 0.6)
    model_plant.set('g', 10.2)
    res_plant = model_plant.simulate(final_time=2.)
    gs = GridSpec(nrows=2, ncols=1, height_ratios=[1, 1])
    fig = plt.figure()
    fig.title = 'FMI Bouncing Ball'
    ax0 = fig.add_subplot(gs[0])
    ax1 = fig.add_subplot(gs[1])
    ax0.set_xlabel('Time (s)')
    ax0.set_ylabel('Height (m)')
    ax1.set_xlabel('Time (s)')
    ax1.set_ylabel('Velocity (m/s)')
    ax0.plot(res_plant['time'], res_plant['h'], label="plant", c='k')
    ax1.plot(res_plant['time'], res_plant['v'], label="plant", c='k')
    doe = pbdesign(bd)
    doe_results_list = []
    for trail in doe:
        print(f"e={trail['e']}")
        print(f"g={trail['g']}")
        model_simulator.reset()
        model_simulator.set('e', trail['e'])
        model_simulator.set('g', trail['g'])
        res_sim = model_simulator.simulate(final_time=2.)
        trail_df = pd.DataFrame(dict(res_sim))
        trail_df['e'] = trail['e']
        trail_df['g'] = trail['g']
        doe_results_list.append(trail_df)
        ax0.plot(res_sim['time'], res_sim['h'], label=f"{trail}")
        ax1.plot(res_sim['time'], res_sim['v'], label=f"{trail}")

    doe_results_df = pd.concat(doe_results_list)
    lm = LinearRegression()
    x_cols = ['h', 'time']
    y_cols = ['e', 'g']
    lm.fit(doe_results_df[x_cols], doe_results_df[y_cols])

    bbdoe = bbdesign(bd)
    doe_results_list = []
    for trail in bbdoe:
        print(f"e={trail['e']}")
        print(f"g={trail['g']}")
        model_simulator.reset()
        model_simulator.set('e', trail['e'])
        model_simulator.set('g', trail['g'])

        res_sim = model_simulator.simulate(final_time=2.)
        trail_df = pd.DataFrame(dict(res_sim))
        trail_df['e'] = trail['e']
        trail_df['g'] = trail['g']
        doe_results_list.append(trail_df)
        ax0.plot(res_sim['time'], res_sim['h'], label=f"{trail}")
        ax1.plot(res_sim['time'], res_sim['v'], label=f"{trail}")

    doe_results_df = pd.concat(doe_results_list)
    rsm = Pipeline([
        ('poly', PolynomialFeatures(degree=2)),
        ('linear', LinearRegression(fit_intercept=False))
    ])
    rsm.fit(doe_results_df[x_cols], doe_results_df[y_cols])

    ffdoe = ffdesign({"h": [0, 1], "time": [0, 2]}, levels=10)
    doe_results_list = []
    count = 0
    for trail in ffdoe:
        trail_df = pd.DataFrame()
        trail_df.loc[count, 'h'] = trail['h']
        trail_df.loc[count, 'time'] = trail['time']
        yhat = rsm.predict(trail_df[x_cols])
        trail_df.loc[count, 'e_rs'] = yhat[0][0]
        trail_df.loc[count, 'g_rs'] = yhat[0][1]
        doe_results_list.append(trail_df)
        count += 1

    doe_results_df = pd.concat(doe_results_list)
    # plt.show()
    plt.close()

    gs = GridSpec(nrows=3, ncols=1, height_ratios=[1, 1, 1])
    fig = plt.figure()
    fig.title = 'FMI Bouncing Ball'
    ax0 = fig.add_subplot(gs[0])
    ax0.set_xlabel('Time (s)')
    ax0.set_ylabel('Height (m)')

    ax1 = fig.add_subplot(gs[1])
    ax1.set_xlabel('Time (s)')
    ax1.set_ylabel('coefficient of restitution')
    ax1.hlines(0.6, xmin=0, xmax=2)

    ax2 = fig.add_subplot(gs[2])
    ax2.set_xlabel('Time (s)')
    ax2.set_ylabel('gravity')
    ax2.hlines(10.2, xmin=0, xmax=2)

    model_plant = load_fmu(fmu_name)
    model_plant.initialize(0, 2.0, True)
    model_plant.set('e', 0.6)
    model_plant.set('g', 10.2)

    model_estimator = load_fmu(
        "/media/thom/SSD1/mrepos/github.com/wilsonify/ModelicaByExample/modelica-gym/bouncing_ball_environment/BouncingBallEst.fmu"
    )
    model_estimator.initialize(0, 2.0, True)
    model_estimator.set('e', 0.4)
    model_estimator.set('g', 7.1)

    def update(t_ind):
        step_size = 0.02
        step_time = t_ind * step_size
        print(f'Writing frame: {t_ind} of 100; step_time={step_time}')
        model_plant.do_step(current_t=step_time, step_size=step_size, new_step=True)
        t = model_plant.time
        h1 = model_plant.get('h')[-1]
        model_estimator.do_step(current_t=step_time, step_size=step_size, new_step=True)
        h2 = model_estimator.get('h')[-1]
        obs_df = pd.DataFrame()
        obs_df.loc[step_time, 'h'] = h1
        obs_df.loc[step_time, 'time'] = t
        print(f"h1 = {h1}")
        print(f"t = {t}")
        yhat = rsm.predict(obs_df[x_cols])
        e_rs = yhat[0][0]
        g_rs = yhat[0][1]
        print(f"e_rs = {e_rs}")
        print(f"g_rs = {g_rs}")
        model_estimator.set('e', e_rs)
        model_estimator.set('g', g_rs)
        point_plant = ax0.plot(
            model_plant.time,
            h1,
            marker="o",
            markersize=8,
            markeredgecolor="black",
            markerfacecolor="black"
        )[0]
        point_est = ax0.plot(
            model_plant.time,
            h2,
            marker="o",
            markersize=8,
            markeredgecolor="red",
            markerfacecolor="red"
        )[0]

        e_est = ax1.plot(
            model_plant.time,
            model_estimator.get('e'),
            marker="o",
            markersize=8,
            markeredgecolor="red",
            markerfacecolor="red"
        )[0]
        g_est = ax2.plot(
            model_plant.time,
            model_estimator.get('g'),
            marker="o",
            markersize=8,
            markeredgecolor="red",
            markerfacecolor="red"
        )[0]
        return point_plant, point_est, e_est, g_est

    anim = FuncAnimation(
        fig=fig,
        func=update,
        frames=100,
        init_func=None,
        fargs=None,
        save_count=None,
        blit=True
    )

    anim.save(
        '/media/thom/SSD1/mrepos/github.com/wilsonify/ModelicaByExample/modelica-gym/bouncing_ball_environment/ball.mp4',
        fps=10, extra_args=['-vcodec', 'libx264']
    )


def rsm_surface_plot(doe_results_df):
    fig = go.Figure(data=[go.Scatter3d(
        x=doe_results_df['time'].values,
        y=doe_results_df['h'].values,
        z=doe_results_df['e_rs'].values,
        mode='markers'
    )])
    fig.update_layout(scene=dict(
        xaxis_title='time',
        yaxis_title='h',
        zaxis_title='e_rs'
    ))
    fig.show()


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    main()
