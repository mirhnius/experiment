#!/bin/bash
#$ -N test_singularity1
#$ -M niushamirhakimi@gmail.com
#$ -m besa
#$ -t 1-1:1
#$ -cwd
#$ -S /bin/bash
#$ -o $JOB_NAME_$TASK_ID.out
#$ -e $JOB_NAME_$TASK_ID.err


INPUTFILES=(/data/origami/niusha/out/out_2/vol0000.nii.gz vol0001.nii.gz)

INPUTFILENAME="${INPUTFILES[$SGE_TASK_ID -1]}"
DESTINATION_DIR="/data/origami/niusha/code/experiment/test/test-$SGE_TASK_ID"

if [ ! -d "$DESTINATION_DIR" ]
then 
    mkdir -p $DESTINATION_DIR
fi


WORKING_DIR="/data/origami/niusha/code/experiment/test/test-$SGE_TASK_ID-working"

if [ ! -d "$WORKING_DIR" ]
then
    mkdir -p $WORKING_DIR
fi

cp $INPUTFILENAME $WORKING_DIR
cd $WORKING_DIR

# #Run the program
# singularity exec /data/origami/niusha/fsl_python.sif \
# --bind /data/origami/niusha/code/experiment/test:/mnt \ 
#  -c "bash /data/origami/niusha/code/experiment/test_singularity_fsl.sh"

singularity exec --bind /data/origami/niusha/code/experiment:/mnt/code \
--bind /data/origami/niusha/input:/mnt/input:ro \
/data/origami/niusha/fsl_python.sif \
/mnt/code/test_singularity_fsl.sh



# OUTPUT = "$INPUT_DIR/output"
# if [! -d "$OUTPUT"]
# then
#     mkdir -p $OUTPUT
# fi

# exit 

# cd ./output

# cp * $DESTINATION_DIR
# rm -rf $WORKING_DIR
