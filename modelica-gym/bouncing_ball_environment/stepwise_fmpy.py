import logging

import pandas as pd
from fmpy import extract, instantiate_fmu, read_model_description
from matplotlib import pyplot as plt
from matplotlib.animation import ArtistAnimation
from matplotlib.gridspec import GridSpec

from objective import desire, to_number

WORK_DIR = "/media/thom/SSD1/mrepos/github.com/wilsonify/ModelicaByExample/modelica-gym/bouncing_ball_environment"
bd = {"e": [0.1, 1.0], "g": [1.0, 10.0]}
limits = {"h": [0.0, 1.0], "time": [0.0, 2.0]}

controllable_inputs = ['e', 'g']
uncontrolled_inputs = ['time']
cofactors = []
outputs = ['h']
x_cols = ['e', 'g', 'time']
y_cols = ['h']

fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
unzipdir = extract(fmu_name)
model_description = read_model_description(unzipdir)
vrs = {}  # collect the value references
for variable in model_description.modelVariables:
    vrs[variable.name] = variable.valueReference
e_vr = vrs['e']
g_vr = vrs['g']
h_vr = vrs['h']
v_vr = vrs['v']

def initialize_plant():
    fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
    unzipdir = extract(fmu_name)    
    fmu = instantiate_fmu(
        unzipdir=unzipdir,
        model_description=model_description,
        fmi_type=None,
        visible=False,
        debug_logging=False,
        logger=None,
        fmi_call_logger=None,
        library_path=None,
        early_return_allowed=False,
        event_mode_used=False,
        intermediate_update=None,
        require_functions=True
    )
    fmu.setupExperiment(tolerance=0.001, startTime=0.0, stopTime=2.0)    
    fmu.enterInitializationMode()
    fmu.setReal([e_vr], [0.6])
    fmu.setReal([g_vr], [10.2])
    fmu.exitInitializationMode()
    return fmu


def initialize_estimator():
    fmu_name = f"{WORK_DIR}/BouncingBall.fmu"
    unzipdir = extract(fmu_name)
    model_description = read_model_description(unzipdir)
    fmu = instantiate_fmu(
        unzipdir=unzipdir,
        model_description=model_description,
        fmi_type=None,
        visible=False,
        debug_logging=False,
        logger=None,
        fmi_call_logger=None,
        library_path=None,
        early_return_allowed=False,
        event_mode_used=False,
        intermediate_update=None,
        require_functions=True
    )
    fmu.setupExperiment(tolerance=0.001, startTime=0.0, stopTime=2.0)
    fmu.enterInitializationMode()
    fmu.setReal([e_vr], [0.7])
    fmu.setReal([g_vr], [7.1])
    fmu.exitInitializationMode()
    return fmu


def initialize_ax0(ax):
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Height (m)')


def initialize_ax1(ax):
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Velocity (m/s)')


def trajectory_lines(ax0, ax1, h_est_list, h_plant_list, t_list, v_est_list, v_plant_list):
    l_h_plant = ax0.plot(t_list, h_plant_list, c="k")[0]
    l_h_est = ax0.plot(t_list, h_est_list, c="r")[0]
    v_h_plant = ax1.plot(t_list, v_plant_list, c="k")[0]
    v_h_est = ax1.plot(t_list, v_est_list, c="r")[0]
    return l_h_est, l_h_plant, v_h_est, v_h_plant


def scatter_markers(time, ax0, ax1, model_estimator, model_plant):
    p_h_plant = ax0.plot(
        time,
        to_number(model_plant.getReal([h_vr])),
        marker="o",
        markersize=8,
        markeredgecolor="black",
        markerfacecolor="black"
    )[0]
    p_h_est = ax0.plot(
        time,
        to_number(model_estimator.getReal([h_vr])),
        marker="o",
        markersize=8,
        markeredgecolor="red",
        markerfacecolor="red"
    )[0]
    p_v_plant = ax1.plot(
        time,
        to_number(model_plant.getReal([v_vr])),
        marker="o",
        markersize=8,
        markeredgecolor="black",
        markerfacecolor="black"
    )[0]
    p_v_est = ax1.plot(
        time,
        to_number(model_estimator.getReal([v_vr])),
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
    initialize_ax1(ax1)
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
    steps = list(range(0, 100))
    for step_count in steps:
        step_time = step_count * step_size
        print(f'step_count={step_count} of {len(steps)}')
        print(f"step_time={step_time}")
        model_plant.doStep(currentCommunicationPoint=step_time, communicationStepSize=step_size)
        model_estimator.doStep(currentCommunicationPoint=step_time, communicationStepSize=step_size)
        matched = desire(
            h=to_number(model_estimator.getReal([h_vr])),
            low=limits['h'][0],
            target=to_number(model_plant.getReal([h_vr])),
            high=limits['h'][1]
        )
        obs_df = pd.DataFrame()
        obs_df.loc[step_time, 'time'] = step_time
        obs_df.loc[step_time, 'h'] = to_number(model_plant.getReal([h_vr]))
        obs_df.loc[step_time, 'h1'] = to_number(model_plant.getReal([h_vr]))
        obs_df.loc[step_time, 'h2'] = to_number(model_estimator.getReal([h_vr]))
        obs_df.loc[step_time, 'matched'] = matched
        sim_df_list.append(obs_df)

        t_list.append(step_time)
        h_plant_list.append(to_number(model_plant.getReal([h_vr])))
        h_est_list.append(to_number(model_estimator.getReal([h_vr])))
        v_plant_list.append(to_number(model_plant.getReal([v_vr])))
        v_est_list.append(to_number(model_estimator.getReal([v_vr])))

        p_h_est, p_h_plant, p_v_est, p_v_plant = scatter_markers(
            step_time, ax0, ax1, model_estimator, model_plant
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
    sim_df.to_csv("dueling_ball.csv")

    anim = ArtistAnimation(fig=fig, artists=artists_list)
    anim.save(f'{WORK_DIR}/dueling_ball.mp4', fps=10, extra_args=['-vcodec', 'libx264'])


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    main()
