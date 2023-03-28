import numpy as np
import pandas as pd

subject_df = pd.read_csv("/mnt/input/subject_IDs.csv")
#subject_df = pd.read_csv("/data/origami/niusha/input/subject_IDs.csv")


N = len(subject_df.ID)
ID_map = dict(zip(range(N),subject_df.ID))

Healthy_index = np.where(subject_df.PD == 0)
Healthy_subject = subject_df.ID.iloc[Healthy_index]

PD_index = np.where(subject_df.PD == 1)
PD_subject = subject_df.ID.iloc[PD_index]


PD_sample = sample((PD_index[0]).tolist(), len(PD_index[0]))
Healthy_sample = sample((Healthy_index[0]).tolist(), len(Healthy_index[0]))

PD_filenames = DBM_sample_filename(PD_sample)
Healthy_filenames = DBM_sample_filename(Healthy_sample)

from nilearn.decomposition import CanICA

canica = CanICA(n_components=3,
                memory="nilearn_cache", memory_level=2,
                verbose=10,
                mask_strategy='whole-brain-template',
                random_state=0)
canica.fit(PD_filenames)

canica_components_img = canica.components_img_
canica_components_img.to_filename('ICAs.nii.gz')