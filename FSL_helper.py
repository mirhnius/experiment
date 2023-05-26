import pathlib

def DBM_sample_filename(r, dir_name="/mnt/input/DBM_maps_split/"):
    return dir_name + 'vol' + str(r).zfill(4) + ".nii.gz"

def filename_list(IDS):
    filenames = []
    for s in IDS:
        filenames.append(DBM_sample_filename(s))
    return filenames

def write_samples_filename(filenames, P:pathlib.Path, i, name="cohort"):  
   
    P.mkdir(exist_ok=True)
    with open(P / f"name_{i+1}.txt", "w") as f:
        for name in filenames:
            f.write(name + "\n")
        f.close()

def samples_indices(file_path:pathlib.Path):
    
    content = file_path.read_text(encoding="utf-8") 
    indices = [] 
    for line in content.splitlines():  
        position = line.find("vol")
        indices.append(int(line[position:].removeprefix("vol").removesuffix(".nii.gz")))
        
    return indices
