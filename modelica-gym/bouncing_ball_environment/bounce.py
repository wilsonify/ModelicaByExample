"""
Demonstrates simulation of FMUs
"""
import logging

import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.animation import FuncAnimation
from matplotlib.gridspec import GridSpec
from pyfmi import load_fmu
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import PolynomialFeatures

from experiment import pbdesign, bbdesign, ffdesign
from objective import desire, composite, to_number

WORK_DIR = "/media/thom/SSD1/mrepos/github.com/wilsonify/ModelicaByExample/modelica-gym/bouncing_ball_environment"
bd = {"e": [0.1, 1.0], "g": [1.0, 10.0]}
limits = {"h": [0.0, 1.0], "time": [0.0, 2.0]}

controllable_inputs = ['e', 'g']
uncontrolled_inputs = ['time']
cofactors = []
outputs = ['h']
x_cols = ['e', 'g', 'time']
y_cols = ['h']


def main_pb():
    fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
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
    lm.fit(doe_results_df[x_cols], doe_results_df[y_cols])
    plt.savefig(f"{WORK_DIR}/pb.png")


def main_bb():
    fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
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
    plt.show()


def main_ff(response_surface):
    ffdoe = ffdesign({"h": [0, 1], "time": [0, 2]}, levels=10)
    doe_results_list = []
    count = 0
    for trail in ffdoe:
        trail_df = pd.DataFrame()
        trail_df.loc[count, 'h'] = trail['h']
        trail_df.loc[count, 'time'] = trail['time']
        yhat = response_surface.predict(trail_df[x_cols])
        trail_df.loc[count, 'e_rs'] = yhat[0][0]
        trail_df.loc[count, 'g_rs'] = yhat[0][1]
        doe_results_list.append(trail_df)
        count += 1
    doe_results_df = pd.concat(doe_results_list)


def main():
    fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
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
    ax2.set_ylim(5, 11)
    ax2.hlines(10.2, xmin=0, xmax=2)

    model_plant = load_fmu(fmu_name)
    model_plant.initialize(0, 2.0, True)
    model_plant.set('e', 0.6)
    model_plant.set('g', 10.2)

    model_estimator = load_fmu(f"{WORK_DIR}/BouncingBall.fmu")
    model_estimator.initialize(0, 2.0, True)
    e_init = 0.6
    g_init = 7.1

    def update(t_ind):
        step_size = 0.02
        step_time = t_ind * step_size
        print(f'Writing frame: {t_ind} of 100; step_time={step_time}')
        model_plant.do_step(current_t=step_time, step_size=step_size, new_step=True)
        t = model_plant.time
        h1 = model_plant.get('h')[-1]
        print(f"h1 = {h1}")
        print(f"t = {t}")
        model_estimator.reset()
        model_estimator.initialize(0, 2.0, True)
        model_estimator.set('e', e_init)
        model_estimator.set('g', g_init)

        for sim_time_ind in range(0, t_ind):
            sim_step_time = sim_time_ind * step_size
            model_estimator.do_step(current_t=sim_step_time, step_size=step_size, new_step=True)

        h2 = model_estimator.get('h')[-1]
        desirability = desire(h2, low=limits['h'][0], target=h1, high=limits['h'][1])
        ffdoe = ffdesign({"e": [0.1, 1], "g": [1.0, 18.0]}, levels=10)
        ff_results_list = []
        count = 0
        for fftrail in ffdoe:
            fftrail_df = pd.DataFrame()
            fftrail_df.loc[count, 'time'] = t
            fftrail_df.loc[count, 'e'] = fftrail['e']
            fftrail_df.loc[count, 'g'] = fftrail['g']
            yhat = rsm.predict(fftrail_df[x_cols])
            h_pred = yhat[0][0]
            d = composite(
                h=h_pred,
                low_h=limits['h'][0],
                target_h=h1,
                high_h=limits['h'][1],
                suggested_g=fftrail['g'],
                low_g=bd['g'][0],
                previous_g=to_number(model_estimator.get('g')),
                high_g=bd['g'][1],
                suggested_e=fftrail['e'],
                low_e=bd['e'][0],
                previous_e=to_number(model_estimator.get('e')),
                high_e=bd['e'][1]
            )
            fftrail_df.loc[count, 'h_rs'] = yhat[0][0]
            fftrail_df.loc[count, 'd'] = d
            ff_results_list.append(fftrail_df)
            count += 1
        ff_results_df = pd.concat(ff_results_list)
        most_desirable_index = ff_results_df['d'].idxmax()
        e_proposed = ff_results_df.loc[most_desirable_index, 'e']
        g_proposed = ff_results_df.loc[most_desirable_index, 'g']
        print(f"e_proposed = {e_proposed}")
        print(f"g_proposed = {g_proposed}")

        obs_df = pd.DataFrame()
        obs_df.loc[step_time, 'time'] = t
        obs_df.loc[step_time, 'h'] = h1
        obs_df.loc[step_time, 'h1'] = h1
        obs_df.loc[step_time, 'h2'] = h1
        obs_df.loc[step_time, 'desirability'] = desirability
        model_estimator.set('e', e_proposed)
        model_estimator.set('g', g_proposed)
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
        f'{WORK_DIR}/ball.mp4',
        fps=10, extra_args=['-vcodec', 'libx264']
    )


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    main()
