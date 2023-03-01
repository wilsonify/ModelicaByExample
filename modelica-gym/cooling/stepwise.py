import logging
import os.path

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.animation import ArtistAnimation
from matplotlib.gridspec import GridSpec
from pyfmi import load_fmu

WORK_DIR = os.path.abspath(os.path.dirname(__file__))
bd = {"e": [0.1, 1.0], "g": [1.0, 10.0]}
limits = {"h": [0.0, 1.0], "time": [0.0, 2.0]}

controllable_inputs = ['e', 'g']
uncontrolled_inputs = ['time']
cofactors = []
outputs = ['h']
x_cols = ['e', 'g', 'time']
y_cols = ['h']


def to_number(x):
    if isinstance(x, str):
        y = float(x)
    if isinstance(x, int):
        y = float(x)
    if isinstance(x, np.ndarray):
        y = float(x[0])
    y = float(x)
    return y


def initialize_plant():
    fmu_name = f'{WORK_DIR}/mbe.c01BasicEquations.CoolingExample.NewtonCoolingWithTypes.fmu'
    model_plant = load_fmu(fmu_name)
    model_plant.initialize(0, 2.0, True)
    model_plant.set('h', 0.6)  # ConvectionCoefficient
    model_plant.set('T_inf', 298.15)  # "Ambient temperature";
    model_plant.set('T0', 363.15)  # "Initial temperature";
    model_plant.set('h', 0.7)  # "Convective cooling coefficient";
    model_plant.set('A', 1.0)  # "Surface area";
    model_plant.set('m', 0.1)  # "Mass of thermal capacitance";
    model_plant.set('c_p', 1.2)  # "Specific heat";
    return model_plant


def initialize_estimator():
    fmu_name = f"{WORK_DIR}/mbe.c01BasicEquations.CoolingExample.NewtonCoolingWithTypes.fmu"
    model_estimator = load_fmu(fmu_name)
    model_estimator.initialize(0, 2.0, True)
    model_estimator.set('h', 0.5)  # ConvectionCoefficient
    model_estimator.set('T_inf', 258.15)  # "Ambient temperature";
    model_estimator.set('T0', 300.15)  # "Initial temperature";
    model_estimator.set('h', 0.7)  # "Convective cooling coefficient";
    model_estimator.set('A', 1.5)  # "Surface area";
    model_estimator.set('m', 0.2)  # "Mass of thermal capacitance";
    model_estimator.set('c_p', 2.2)  # "Specific heat";
    return model_estimator


def initialize_ax0(ax):
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Temperature (K)')


def trajectory_lines(ax0, ax1, h_est_list, h_plant_list, t_list, v_est_list, v_plant_list):
    l_h_plant = ax0.plot(t_list, h_plant_list, c="k")[0]
    l_h_est = ax0.plot(t_list, h_est_list, c="r")[0]
    v_h_plant = ax1.plot(t_list, v_plant_list, c="k")[0]
    v_h_est = ax1.plot(t_list, v_est_list, c="r")[0]
    return l_h_est, l_h_plant, v_h_est, v_h_plant


def scatter_markers(ax0, ax1, model_estimator, model_plant):
    p_h_plant = ax0.plot(
        model_plant.time,
        to_number(model_plant.get('h')),
        marker="o",
        markersize=8,
        markeredgecolor="black",
        markerfacecolor="black"
    )[0]
    p_h_est = ax0.plot(
        model_plant.time,
        to_number(model_estimator.get('h')),
        marker="o",
        markersize=8,
        markeredgecolor="red",
        markerfacecolor="red"
    )[0]
    p_v_plant = ax1.plot(
        model_plant.time,
        to_number(model_plant.get('v')),
        marker="o",
        markersize=8,
        markeredgecolor="black",
        markerfacecolor="black"
    )[0]
    p_v_est = ax1.plot(
        model_plant.time,
        to_number(model_estimator.get('v')),
        marker="o",
        markersize=8,
        markeredgecolor="red",
        markerfacecolor="red"
    )[0]
    return p_h_est, p_h_plant, p_v_est, p_v_plant


def main():
    gs = GridSpec(nrows=2, ncols=1, height_ratios=[1, 1])
    fig = plt.figure()
    fig.title = 'FMI Bouncing Ball'
    ax0 = fig.add_subplot(gs[0])
    ax1 = fig.add_subplot(gs[1])
    initialize_ax0(ax0)

    model_plant = initialize_plant()
    model_estimator = initialize_estimator()
    step_size = 0.02
    artists_list = []
    sim_df_list = []
    t_list = []
    h_plant_list = []
    h_est_list = []
    v_plant_list = []
    v_est_list = []
    steps = list(range(0, 101))
    for step_count in steps:
        step_time = step_count * step_size
        print(f'step_count={step_count} of {len(steps)}')
        print(f"step_time={step_time}")
        model_plant.do_step(current_t=step_time, step_size=step_size, new_step=True)
        model_estimator.do_step(current_t=step_time, step_size=step_size, new_step=True)

        obs_df = pd.DataFrame()
        obs_df.loc[step_time, 'time'] = model_plant.time
        obs_df.loc[step_time, 'h'] = to_number(model_plant.get('h'))
        obs_df.loc[step_time, 'h1'] = to_number(model_plant.get('h'))
        obs_df.loc[step_time, 'h2'] = to_number(model_estimator.get('h'))
        sim_df_list.append(obs_df)

        t_list.append(model_plant.time)
        h_plant_list.append(to_number(model_plant.get('h')))
        h_est_list.append(to_number(model_estimator.get('h')))
        v_plant_list.append(to_number(model_plant.get('v')))
        v_est_list.append(to_number(model_estimator.get('v')))

        p_h_est, p_h_plant, p_v_est, p_v_plant = scatter_markers(
            ax0, ax1, model_estimator, model_plant
        )

        l_h_est, l_h_plant, v_h_est, v_h_plant = trajectory_lines(
            ax0, ax1, h_est_list, h_plant_list, t_list, v_est_list, v_plant_list
        )

        artists_list.append([
            p_h_plant, p_h_est, p_v_plant, p_v_est,
            l_h_plant, l_h_est,
            v_h_plant, v_h_est
        ])

    sim_df = pd.concat(sim_df_list)
    sim_df.to_csv("cooling.csv")

    anim = ArtistAnimation(fig=fig, artists=artists_list)
    anim.save(f'{WORK_DIR}/cooling.mp4', fps=10, extra_args=['-vcodec', 'libx264'])


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    main()
