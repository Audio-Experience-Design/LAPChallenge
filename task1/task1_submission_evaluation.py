""" This script evaluates the score of the LAP submission's. 
The results obtained on 2024-07-03 are: 
1. IOA3D: 0.2375
2. Bahu: 0.9125
3. Kalimoxto: .9500

All three submissions passed the validation test. 

2024-07-03 Roberto Barumerli
"""

from lap_task1.eval import classification_accuracy
from itertools import chain, product
from pathlib import Path
import random
import numpy as np

random.seed(1024)

## Config
path = "/home/robaru/repos/datasets/LAP/task1/IOA3D"

# repeat evaluation ten times 
accs = np.zeros((10, ))

for i in range(accs.size):
    print(i)
    common_positions = chain(product(range(-180, 180, 10), [-30, 0, 30]), product(range(-180, 180, 20), [60]))
    side = 'any-left'
    sample_rate = 44100
    hrir_length = 235
    accs[i, ], _ = classification_accuracy(Path(path), i, common_positions, side, sample_rate, hrir_length)

# print results 
print(accs)
print("%.4f" % np.mean(accs))

# Code run on 2024-07-03
# Kalimoxto: .9500 [0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95 0.95]
# Bahu: 0.9212 [0.9125 0.93125 0.95 0.9125  0.9125  0.91875 0.9125  0.9375  0.9125 0.9125]
# IOA3D: 0.2700 [0.25    0.275   0.28125 0.26875 0.3     0.28125 0.2875  0.2625  0.25625 0.2375]