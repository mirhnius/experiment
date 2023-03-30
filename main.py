import numpy as np
import pandas as pd
from helper import *

#subject_df = pd.read_csv("/mnt/input/subject_IDs.csv")
subject_df = pd.read_csv("/data/origami/niusha/input/subject_IDs.csv")


N = len(subject_df.ID)
ID_map = dict(zip(range(N),subject_df.ID))

Healthy_index = np.where(subject_df.PD == 0)
Healthy_subject = subject_df.ID.iloc[Healthy_index]

PD_index = np.where(subject_df.PD == 1)
PD_subject = subject_df.ID.iloc[PD_index]

from random import sample
PD_sample = sample((PD_index[0]).tolist(), len(PD_index[0]))
Healthy_sample = sample((Healthy_index[0]).tolist(), len(Healthy_index[0]))

PD_filenames = filename_list(PD_sample)

# Healthy_filenames = filename_list(Healthy_sample)
write_samples_filename(PD_filenames, 3)
ICA_decomposition(PD_filenames, 3)
