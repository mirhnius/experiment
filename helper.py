from random import sample

def DBM_sample_filename(r):
    dir_ = "/mnt/out/out_2/vol"
    #dir_ = "/data/origami/niusha/out/out_s/"
    if r>=0 and r<=9:
        return dir_ + "000" + str(r) + ".nii.gz"
    elif r>=10 and r<=99:
        return dir_ + "00" + str(r) + ".nii.gz"
    else:
        return dir_ + "0" + str(r) + ".nii.gz"

def write_samples_filename(filename, ID_list):    
    f = open(filename, "w")
    for id in ID_list:
        f.write(DBM_sample_filename(id)+ "\n")
    f.close()