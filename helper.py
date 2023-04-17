from random import sample
import pathlib
from nilearn.decomposition import CanICA

def DBM_sample_filename(r): # rerwite with zfill
    # dir_ = "/mnt/out/out_2/vol"
    dir_ = "/data/origami/niusha/out/out_s/"
    if r>=0 and r<=9:
        return dir_ + "000" + str(r) + ".nii.gz"
    elif r>=10 and r<=99:
        return dir_ + "00" + str(r) + ".nii.gz"
    else:
        return dir_ + "0" + str(r) + ".nii.gz"

def filename_list(IDS):
    filenames = []
    for s in IDS:
        filenames.append(DBM_sample_filename(s))
    return filenames

def write_samples_filename(filenames, i):    #rewrite it with pathlib
   
    P = pathlib.Path('/data/origami/niusha/out/ICAs') / (f"ICs_{i}")
    P.mkdir(exist_ok=False)
    f = open(P / "PD.txt", "w")
    for name in filenames:
        f.write(name+ "\n")
    f.close()

def ICA_decomposition(filenames, i):
    canica = CanICA(n_components=3,
                memory="nilearn_cache", memory_level=2,
                verbose=10,
                mask_strategy='whole-brain-template',
                random_state=0)
    canica.fit(filenames)

    P = pathlib.Path('/data/origami/niusha/out/ICAs') / (f"ICs_{i}")
    canica_components_img = canica.components_img_
    canica_components_img.to_filename(P / (f'ICAs{i}.nii.gz'))
