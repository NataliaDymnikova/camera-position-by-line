import cv2
import numpy as np
import os

def get_lines(file):
    img = cv2.imread(file)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray,50,150,apertureSize = 3)

    lines = cv2.HoughLines(edges,1,np.pi/180,150)
    abc_lines = []
    for rho,theta in lines[0]:
        a = np.cos(theta)
        b = np.sin(theta)
        c = -rho
        abc_lines.append([a,b,c])
    return abc_lines

def get_t_R(directory): # [t1,t2,t3, a,b,c,d]
    file = open(directory + "groundtruth.txt")
    data = file.read()
    lines = data.replace(",", " ").replace("\t", " ").split("\n")
    list = [[v.strip() for v in line.split(" ") if v.strip() != ""] for line in lines if
            len(line) > 0 and line[0] != "#"]
    list = [ [float(l[j]) for j in range(1, len(l))] for l in list if len(l) > 1]
    return list


# get_t_R("Real_tests/rgbd_dataset_freiburg1_floor/")
# get_lines("Real_tests/rgbd_dataset_freiburg1_floor/rgb/1305033527.701984.png")

def put_lines_to_files(directory, name):
    files = os.listdir(directory)
    if not os.path.exists(name):
        os.makedirs(name)

    for i in range(0, min (100, len(files))):
        lines = get_lines(directory + files[i])

        with open(name + '/' + str(i), "w+") as f:
            for line in lines:
                f.write(str(line[0]) + ' ' + str(line[1]) + ' ' + str(line[2]) + '\n')


put_lines_to_files("Real_tests/rgbd_dataset_freiburg1_floor/rgb/", "floor")