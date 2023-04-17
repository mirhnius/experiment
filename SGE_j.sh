#!/bin/bash
#$ -N jackknife_array_job
#$ -M niushamirhakimi@gmail.com
#$ -m besa
#$ -t 1-100:1
#$ -S /bin/bash

#the output stuff??
INPUT_LIST="/mnt/input/" # your list of filenames (0001.nii.gz etc.)

arr=()
while IFS="" read -r FILENAME || [ -n "$FILENAME" ]
do
    arr+=($FILENAME)

done < $INPUT_LIST
INPUTFILES=arr #is it ok????
PROJECT_SUBDIR="round"

INPUTFILENAME="${INPUTFILES[$SGE_TASK_ID -1]}"
DESTINATION_DIR="/data/origami/niusha/out/out_jackknife/$PROJECT_SUBDIR-$SGE_TASK_ID"
if [! -d "$DESTINATION_DIR"]
then 
    mkdir -p $DESTINATION_DIR
fi

