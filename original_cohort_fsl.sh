#!/bin/bash
#$ -N test_singularity1
#$ -l h_vmem=7G
#$ -cwd

singularity shell --bind /data/origami/niusha/input:/mnt/input:ro \
--bind /data/origami/niusha/out:/mnt/out \
/data/origami/niusha/fsl_python.sif \
/mnt/code/original_cohort_fsl_singularity.sh