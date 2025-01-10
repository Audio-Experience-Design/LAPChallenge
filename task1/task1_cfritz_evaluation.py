""" This script evaluates the score of the LAP submission's
using the club fritz spherical grid for the evaluation.

2025-01-09 Roberto Barumerli
"""

from lap_task1.eval import classification_accuracy
from itertools import chain, product
from pathlib import Path
import numpy as np


## Config
path = "Bahu"

# load common positions across collections
# common_positions = chain(product(range(-180, 180, 10), [-30, 0, 30]), product(range(-180, 180, 20), [60]))
common_positions = chain([tuple(row) for row in np.loadtxt('task1/cfritz_evaluation_coords.csv', delimiter=',') if len(row) == 2])

side = 'any-left'
sample_rate = 44100
hrir_length = 235
rseed = 1024

mean_acc, std_acc = classification_accuracy(Path(path), rseed, common_positions, side, sample_rate, hrir_length)

# print results 
print("%.4f stdev %.4f" % (mean_acc, std_acc))

# IOA3D 0.325 stdev 0.0318
# Arevalo 0.9500 stdev 0.0468
# Bahu 0.8938 stdev 0.0897