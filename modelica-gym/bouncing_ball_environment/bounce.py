"""
Demonstrates simulation of FMUs
"""
import logging
import os.path

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.gridspec import GridSpec
from pyfmi import load_fmu
from scipy.optimize import differential_evolution
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import PolynomialFeatures
from xgboost import XGBRegressor

from experiment import ffdesign
from objective import desire

WORK_DIR = os.path.abspath(os.path.dirname(__file__))
bd = {"e": [0.1, 1.0], "g": [1.0, 10.0]}
ld = {"e": np.arange(0.1, 1.0, 0.1), "g": np.arange(1.0, 10.0, 1.0)}
limits = {"h": [0.0, 1.0], "time": [0.0, 2.0]}

controllable_inputs = ['e', 'g']
uncontrolled_inputs = ['time']
cofactors = []
outputs = ['h']
x_cols = ['e', 'g']
y_cols = ['desirability']

desire_vector = np.vectorize(desire)


def main_ff():
    fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
    model_simulator = load_fmu(fmu_name)
    model_simulator.initialize(0, 2.0, True)
    model_plant = load_fmu(fmu_name)
    model_plant.initialize(0, 2.0, True)
    model_plant.set('e', 0.6)
    model_plant.set('g', 10.2)
    doe = ffdesign(bd, levels=10)
    doe_results_list = []
    count = 0
    for trial in doe:
        count += 1
        print(f"e={trial['e']}")
        print(f"g={trial['g']}")
        model_plant.reset()
        model_simulator.reset()
        model_simulator.set('e', trial['e'])
        model_simulator.set('g', trial['g'])
        res_plant = model_plant.simulate(final_time=2.)
        res_plant_t = res_plant['time']
        after_bounce = res_plant_t > 0.5
        res_plant_h = res_plant['h'][after_bounce]
        nobs = len(res_plant_h)
        res_sim = model_simulator.simulate(final_time=2.)
        res_sim_t = res_sim['time']
        res_sim_h = res_sim['h'][after_bounce]
        trail_df = pd.DataFrame()
        trail_df.loc[count, 'trial'] = count
        trail_df.loc[count, 'e'] = trial['e']
        trail_df.loc[count, 'g'] = trial['g']
        trail_df.loc[count, 'desirability'] = np.nanmedian(
            desire_vector(
                h=res_sim_h,
                low=np.ones(nobs) * limits['h'][0],
                target=res_plant_h,
                high=np.ones(nobs) * limits['h'][1]
            ))
        doe_results_list.append(trail_df)

    doe_results_df = pd.concat(doe_results_list)
    doe_results_df.to_csv("doe_results_df.csv")


def main_opt():
    doe_results_df = pd.read_csv("doe_results_df.csv")
    rsm = Pipeline([
        ('poly', PolynomialFeatures(degree=2)),
        ('xgb', XGBRegressor())
    ])
    rsm.fit(doe_results_df[x_cols].values, doe_results_df[y_cols].values)

    def cost(arr):
        return -rsm.predict(arr.reshape(1, -1))[0]

    optimum = differential_evolution(
        func=cost,
        bounds=[bd['e'], bd['g']]
    )
    print(f"optimum = {optimum.x}")

    fmu_name = f'{WORK_DIR}/BouncingBall.fmu'
    model_simulator = load_fmu(fmu_name)
    model_simulator.initialize(0, 2.0, True)
    model_plant = load_fmu(fmu_name)
    model_plant.initialize(0, 2.0, True)
    model_plant.set('e', 0.6)
    model_plant.set('g', 10.2)

    model_plant.reset()
    res_plant = model_plant.simulate(final_time=2.)
    res_plant_h = res_plant['h']
    res_plant_v = res_plant['v']
    res_plant_t = res_plant['time']
    model_simulator.reset()
    model_simulator.set('e', optimum.x[0])
    model_simulator.set('g', optimum.x[1])

    res_sim = model_simulator.simulate(final_time=2.)
    res_sim_h = res_sim['h']
    res_sim_v = res_sim['v']
    res_sim_t = res_sim['time']

    gs = GridSpec(nrows=2, ncols=1, height_ratios=[1, 1])
    fig = plt.figure()
    fig.title = 'FMI Bouncing Ball'
    ax0 = fig.add_subplot(gs[0])
    ax1 = fig.add_subplot(gs[1])
    ax0.set_xlabel('Time (s)')
    ax0.set_ylabel('Height (m)')
    ax1.set_xlabel('Time (s)')
    ax1.set_ylabel('Velocity (m/s)')
    ax0.plot(res_plant_t, res_plant_h, label="plant", c='k')
    ax1.plot(res_plant_t, res_plant_v, label="plant", c='k')

    ax0.plot(res_sim_t, res_sim_h, label="sim", c='r')
    ax1.plot(res_sim_t, res_sim_v, label="sim", c='r')

    plt.show()


def main():
    main_ff()
    main_opt()


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    main()
