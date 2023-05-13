#!/bin/bash

echo "test_singularity_fsl.sh is running"
# cd $WORKING_DIR

fslinfo /mnt/input/DBM_data.nii
echo "test 1"
melodic -i /mnt/input/DBM_data.nii -o /mnt/code/test/test-1 -d 30 --Oall 
echo "no melodc"