import sys
import pathlib
import argparse 
import FSL_helper
import numpy as np

sys.path.insert(0, '/data/origami/niusha/code/local-experiment')
from original_cohort import PD_index, Healthy_index

parser = argparse.ArgumentParser()
parser.add_argument("iteration_number", type=int,
                    help="number of bootstrap iterations")
parser.add_argument("path", help="parent directory that input files will be stored in it.")
parser.add_argument("container_path", help="cohorts' paths in the container")
args = parser.parse_args()

n = args.iteration_number
P = pathlib.Path(args.path)  / "files_list"

for i in range(n):
    PD_sample = list(np.random.choice(PD_index, len(PD_index)))
    Healthy_sample = list(np.random.choice(Healthy_index, len(Healthy_index)))
    filenames = FSL_helper.filename_list(PD_sample+Healthy_sample)
    FSL_helper.write_samples_filename(filenames, P, i)

FSL_helper.store_filenames(P.parent, args.comtainer_path, n)
