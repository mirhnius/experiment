#!/bin/bash

# melodic -i /mnt/input/DBM_data.nii -o /mnt/code/test/test-1 -d 30 --Oall 

WORKING_DIR="${PARENT_DIR_MELODIC}/test-${SGE_TASK_ID}"

COMMAND="fslmerge -t ${WORKING_DIR}/boot${SGE_TASK_ID}.nii.gz" 
while IFS="" read -r FILENAME || [ -n "$FILENAME" ]
do
  COMMAND="${COMMAND} ${FILENAME}"

done < $INPUTFILENAME

eval $COMMAND

melodic -i ${WORKING_DIR}/boot${SGE_TASK_ID}.nii.gz -o ${WORKING_DIR} -d 30 