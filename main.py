import numpy as np
import pandas as pd
import pathlib
import helper

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


P = pathlib.Path('/data/origami/niusha/code/experiment/test/files_list')
filenames = helper.filename_list(PD_sample+Healthy_sample)
helper.write_samples_filename(filenames, P, 0)

