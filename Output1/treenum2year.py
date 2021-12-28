import os
import shutil


def findfile():
    if os.path.exists("TreeNum") == 0:
        os.mkdir("TreeNum")
    outputpath = "Output/"
    treenumpath = "TreeNum/"
    files = os.listdir(outputpath)
    for f in files:
        if 'TreeNum' in f:
            shutil.copy(outputpath+f,treenumpath)

    files = os.listdir(treenumpath)
    for i in range(0,301, 10):
        yearpath="year" + str(i)
        if os.path.exists(yearpath) == 0:
            os.mkdir(treenumpath+yearpath)
        for f in files:
            if f.endswith('_'+str(i)+'.asc'):
                shutil.move(treenumpath+f,treenumpath+yearpath)
    # os.rmdir("TreeNum")

if __name__ == '__main__':
    findfile()
