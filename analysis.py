#!/usr/bin/env python3

import sys
sys.path.insert(0, '/data/origami/niusha/code/local-experiment')
from original_cohort import subject_df

import pathlib
import argparse
import FSL_helper
import numpy as np
from scipy.stats import ttest_ind
from statsmodels.stats.multitest import multipletests

parser = argparse.ArgumentParser()
parser.add_argument("iteration_number", type=int,
                    help="number of bootstrap iterations")
parser.add_argument("path", help="Directory that input files are stored in it.")
args = parser.parse_args()

n = args.iteration_number
parent_dir = pathlib.Path(args.path)

aligned = np.zeros((1,n))
max_t = np.zeros((1,n))
min_p = np.zeros((1,n))

for i in range(n):
    cohort_path = parent_dir / 'files_list' / (f'cohort_{i+1}.txt')
    idx = FSL_helper.samples_indices(cohort_path)
    bootstrapped_cohort = subject_df.PD.iloc[idx] 
    PD_bootstrapped_cohort = bootstrapped_cohort.iloc[np.where(bootstrapped_cohort==1)].index.to_list()
    Healthy_bootstrapped_cohort = bootstrapped_cohort.iloc[np.where(bootstrapped_cohort==0)].index.to_list()

    t_modes = np.loadtxt(parent_dir / (f"test-{i+1}/Tmodes"))

    PD_tmodes = t_modes[PD_bootstrapped_cohort][:]
    Healthy_tmodes = t_modes[Healthy_bootstrapped_cohort][:]

    Tstat = np.zeros((1,30))
    Pval = np.zeros((1,30))

    for j in range(30):
        Tstat[0,j], Pval[0,j] = ttest_ind(Healthy_tmodes[:,j], PD_tmodes[:,j], alternative="less")

    
    idx_p = np.argmin(Pval[0,:])
    idx_t = np.argmin(Tstat[0,:])
    # idx_p and idx_t must be same for one sided t-test
    max_t[0,i] = Tstat[0, idx_t]
    min_p[0,i] = Pval[0, idx_p] * 30 if Pval[0, idx_p] * 30 <= 1 else 1
    print(idx_p, Pval[0,idx_p], idx_t, Tstat[0,idx_t])
    



import matplotlib.pyplot as plt
import seaborn as sns

f, ax = plt.subplots(nrows=1, ncols=2, figsize=(7,5))
entry_name = ["p-value", "t-statistic"]
entry = [min_p[0,:], max_t[0,:]]
for i in range(2):
    ax[i] = sns.histplot(entry[i], ax=ax[i], bins=10)
    ax[i].title.set_text(entry_name[i])
f.savefig(f"test{n}.png")

print(len(min_p[0,(min_p[0,:] <= 0.05)]))
# print(min_p[0,(min_p[0,:] <= 0.05)])

# print(min_p)

# import random
# shuffeled_index = random.shuffle(len(Healthy_bootstrapped_cohort)*[0] + len(PD_bootstrapped_cohort)*[1])