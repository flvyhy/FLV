import sys
import shutil



def replace(file_path, new_str):

    f = open(file_path, 'r+')
    all_lines = f.readlines()
    f.seek(0)
    f.truncate()
    for line in all_lines:
        line = line.replace("year200", new_str)
        f.write(line)
    f.close()


for year in range(210, 301, 10):
    shutil.copy("year200.hip", "year" + str(year) + ".hip")
    shutil.copy("./hda/year200.hda", "./hda/year" + str(year) + ".hda")
    file_name = "year" + str(year) + ".hip"
    replace(file_name, "year" + str(year))
print("Complete")
