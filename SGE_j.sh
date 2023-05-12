#!/bin/bash
#$ -N jackknife_array_job
#$ -M niushamirhakimi@gmail.com
#$ -m besa
#$ -t 1-100:1
#$ -cwd
#$ -S /bin/bash


#the output stuff??
INPUT_LIST="/data/origami/niusha/input/jackknife_inputfiles" # your list of filenames (0001.nii.gz etc.)

arr=()
while IFS="" read -r FILENAME || [ -n "$FILENAME" ]
do
    arr+=($FILENAME)

done < $INPUT_LIST
INPUTFILES=arr #is it ok????
PROJECT_SUBDIR="round"

INPUTFILENAME="${INPUTFILES[$SGE_TASK_ID -1]}"
DESTINATION_DIR="/data/origami/niusha/out/out_jackknife/${PROJECT_SUBDIR-$SGE_TASK_ID}"

if [ ! -d "$DESTINATION_DIR" ]
then 
    mkdir -p $DESTINATION_DIR
fi

WORKING_DIR="/data/origami/niusha/out/out_jackknife/${PROJECT_SUBDIR}-${SGE_TASK_ID}-working"

if [ ! -d "$WORKING_DIR" ]
then
    mkdir -p $WORKING_DIR
fi

cp $INPUTFILENAME $WORKING_DIR
cd $WORKING_DIR

#Run the program
singularity shell --bind /data/origami/niusha/input:/mnt/input:ro \
--bind /data/origami/niusha/out:/mnt/out \
/data/origami/niusha/fsl_python.sif

NII_MERGE="test_merge_232_bootstrap.nii.gz"
INPUT_DIR ="/mnt/out/out_jackknife/${PROJECT_SUBDIR-$SGE_TASK_ID}-working"
INPUT_NII_FILES="${INPUT_DIR}/PD.txt" # your list of filenames (0001.nii.gz etc.)
COMMAND="fslmerge -t ${INPUT_DIR}/${NII_MERGE}" # beginning of the command

while IFS="" read -r INPUT_NII_FILES || [ -n "$INPUT_NII_FILES" ]
do
  COMMAND="${COMMAND} ${INPUT_NII_FILES}"
done < $INPUT_NII_FILES
eval $COMMAND

OUTPUT = "${INPUT_DIR}/output"
if [ ! -d "$OUTPUT" ]
then
    mkdir -p $OUTPUT
fi

melodic -i $INPUT_NII_FILES  -o $OUTPUT -d 30 --all

exit 

cd ./output

cp * $DESTINATION_DIR
rm -rf $WORKING_DIR