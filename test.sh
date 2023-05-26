#!/bin/bash
#$ -N test_singularity1
#$ -l h_vmem=8G
#$ -M niushamirhakimi@gmail.com
#$ -m besa
#$ -t 1-10:1
#$ -cwd
#$ -S /bin/bash
#$ -o "/data/origami/niusha/code/experiment/test/out/$JOB_NAME_$TASK_ID.out"
#$ -e "/data/origami/niusha/code/experiment/test/err/$JOB_NAME_$TASK_ID.err"

PARENT_DIR="/data/origami/niusha/code/experiment/test"
PARENT_DIR_MELODIC="/mnt/code/test"

INPUT_LIST="$PARENT_DIR/filenames.txt"

INPUTFILES=()
while IFS="" read -r FILENAME || [ -n "$FILENAME" ]
do
    INPUTFILES+=($FILENAME)

done < $INPUT_LIST
echo $INPUTFILES

INPUTFILENAME="${INPUTFILES[$SGE_TASK_ID -1]}"
DESTINATION_DIR="${PARENT_DIR}/test-$SGE_TASK_ID"

if [ ! -d "$DESTINATION_DIR" ]
then 
    mkdir -p $DESTINATION_DIR
fi


# cp $INPUTFILENAME $DESTINATION_DIR
cd $DESTINATION_DIR

#Run the program
export SGE_TASK_ID
export PARENT_DIR_MELODIC
export INPUTFILENAME


singularity exec --bind /data/origami/niusha/code/experiment:/mnt/code \
--bind /data/origami/niusha/input:/mnt/input:ro \
--bind /data/origami/niusha/out:/mnt/out \
/data/origami/niusha/fsl_python.sif \
/mnt/code/test_singularity_fsl.sh


mv  ${DESTINATION_DIR}/melodic_Tmodes ${DESTINATION_DIR}/Tmodes
rm ${DESTINATION_DIR}/eigenvalues_percent
find ${DESTINATION_DIR} -maxdepth 1 -type f -name "melodic*" -delete
find ${DESTINATION_DIR} -maxdepth 1 -type f -name "*.nii.gz" -delete 

