"""
Tools for generating a designed experiment
"""
from collections import defaultdict

import numpy as np

from doepy.build import plackett_burman
from doepy.doe_functions import build_box_behnken, build_full_fact


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
