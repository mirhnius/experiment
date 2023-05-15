#!/bin/bash
fslmaths /mnt/out/ica_original_maps/melodic_IC.nii.gz -thr 3 -bin /mnt/out/ica_original_maps/melodic_IC_thr_bin.nii.gz
fslsplit /mnt/out/ica_original_maps/melodic_IC_thr_bin.nii.gz -t /mnt/out/ica_original_maps/masks 
fslmeants /mnt/input/DBM_data.nii.gz  -m /mnt/out/ica_original_maps/masks/vol0000.nii.gz /mnt/out/ica_original_maps/ic_mean/mean0.txt
fslsplit /mnt/out/ica_original_maps/melodic_IC_thr_bin.nii.gz -t /mnt/out/ica_original_maps/masks 
fslinfo /mnt/out/out_2/vol0000.nii.gz
#####
INPUT_LIST="/mnt/out/test.txt" # your list of filenames (0001.nii.gz etc.)

COMMAND="fslmerge -t /mnt/out/test/out.nii.gz" # beginning of the command

# loop over the input list (not sure if this works)
while IFS="" read -r FILENAME || [ -n "$FILENAME" ]
do
    # echo ${FILENAME}
  # append to command
  COMMAND="${COMMAND} ${FILENAME}"

done < $INPUT_LIST

echo $COMMAND
eval $COMMAND
#####
#run with python
/data/origami/niusha/miniconda3/bin/python /data/origami/niusha/code/experiment/main.py

""""
melodic -i /mnt/input/PD.txt -a concat -o /mnt/out/pd_ica --nobet -d 30

singularity shell --bind /data/origami/niusha/input:/mnt/input:ro --bind /data/origami/niusha/out:/mnt/out /data/origami/niusha/fsl_python.sif
"""
fslchfiletype NIFTI_GZ /mnt/input/DBM_data.nii.gz /mnt/out/DBM_data.nii 