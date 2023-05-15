#!/bin/bash
#$ -N test_singularity1
#$ -l h_vmem=8G
#$ -M niushamirhakimi@gmail.com
#$ -m besa
#$ -t 1-1:1
#$ -cwd
#$ -S /bin/bash
#$ -o $JOB_NAME_$TASK_ID.out
#$ -e $JOB_NAME_$TASK_ID.err

PARENT_DIR="/data/origami/niusha/code/experiment/test"
PARENT_DIR_MELODIC="/mnt/code/test"

INPUTFILES=(/data/origami/niusha/out/test.txt)

INPUTFILENAME="${INPUTFILES[$SGE_TASK_ID -1]}"
DESTINATION_DIR="${PARENT_DIR}/test-$SGE_TASK_ID"

if [ ! -d "$DESTINATION_DIR" ]
then 
    mkdir -p $DESTINATION_DIR
fi

cp $INPUTFILENAME $DESTINATION_DIR
cd $DESTINATION_DIR

# #Run the program
export SGE_TASK_ID
export PARENT_DIR_MELODIC


singularity exec --bind /data/origami/niusha/code/experiment:/mnt/code \
--bind /data/origami/niusha/input:/mnt/input:ro \
--bind /data/origami/niusha/out:/mnt/out \
/data/origami/niusha/fsl_python.sif \
/mnt/code/test_singularity_fsl.sh

# rm ${DESTINATION_DIR}/boot${SGE_TASK_ID}.nii.gz
