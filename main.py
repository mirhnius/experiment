import sys
import FSL_helper
import pathlib
import numpy as np

sys.path.insert(0, '/data/origami/niusha/code/local-experiment')
from original_cohort import PD_index, Healthy_index

PD_sample = list(np.random.choice(PD_index, len(PD_index)))
Healthy_sample = list(np.random.choice(Healthy_index, len(Healthy_index)))

P = pathlib.Path('/data/origami/niusha/code/experiment/test/files_list')
filenames = FSL_helper.filename_list(PD_sample+Healthy_sample)
FSL_helper.write_samples_filename(filenames, P, 0)

