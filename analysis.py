
sys.path.insert(0, '/data/origami/niusha/code/local-experiment')
from original_cohort import subject_df
import FSL_helper
import pathlib
import numpy as np

cohort_path = pathlib.Path('/data/origami/niusha/code/experiment/test/files_list/cohort0.txt')
idx = FSL_helper.samples_indices(cohort_path)
bootstrapped_cohort = subject_df.PD.iloc[idx] 
PD_bootstrapped_cohort = bootstrapped_cohort.iloc[np.where(bootstrapped_cohort==1)].index.to_list()
Healthy_bootstrapped_cohort = bootstrapped_cohort.iloc[np.where(bootstrapped_cohort==0)].index.to_list()

t_modes = np.loadtxt("/data/origami/niusha/code/experiment/test/test-1/Tmodes")

PD_tmodes = t_modes[PD_bootstrapped_cohort][:]
Healthy_tmodes = t_modes[Healthy_bootstrapped_cohort][:]

from scipy.stats import ttest_ind

Tstat = np.zeros((1,30))
Pval = np.zeros((1,30))

for i in range(30):
    Tstat[0,i], Pval[0,i] = ttest_ind(Healthy_tmodes[:,i], PD_tmodes[:,i])

idx_p = np.argmin(Pval)
idx_t = np.argmax(Tstat)