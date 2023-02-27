import numpy as np


def to_number(x):
    if isinstance(x, str):
        y = float(x)
    if isinstance(x, int):
        y = float(x)
    if isinstance(x, np.ndarray):
        y = float(x[0])
    y = float(x)
    return y


def desire(h, low, target, high):
    if h <= low:
        return 0.0
    if h >= high:
        return 0.0
    if low < h <= target:
        return -low / (-low + target) + h / (-low + target)
    if target <= h < high:
        return 1.0 + target / (high - target) - h / (high - target)


def penalty_g(suggested, low, previous, high):
    if suggested <= low:
        return 0.0
    if suggested >= high:
        return 0.0
    if low < suggested <= previous:
        return -low / (-low + previous) + suggested / (-low + previous)
    if previous <= suggested < high:
        return 1 + previous / (high - previous) - suggested / (high - previous)


def penalty_e(suggested, low, previous, high):
    if suggested <= low:
        return 0.0
    if suggested >= high:
        return 0.0
    if low < suggested <= previous:
        return -low / (-low + previous) + suggested / (-low + previous)
    if previous <= suggested < high:
        return 1 + previous / (high - previous) - suggested / (high - previous)


def composite(
        h, low_h, target_h, high_h,
        suggested_g, low_g, previous_g, high_g,
        suggested_e, low_e, previous_e, high_e
):
    d = desire(h, low_h, target_h, high_h)
    suggested_g, low_g, previous_g, high_g = suggested_g, low_g, previous_g, high_g
    suggested_e, low_e, previous_e, high_e = suggested_e, low_e, previous_e, high_e
    p_g = penalty_g(suggested_g, low_g, previous_g, high_g)
    p_e = penalty_e(suggested_e, low_e, previous_e, high_e)
    return d - (p_e * p_g)
