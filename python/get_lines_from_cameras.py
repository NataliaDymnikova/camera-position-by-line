import cv2
import numpy as np
import os

def get_lines(file):
    img = cv2.imread(file)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray,50,150,apertureSize = 3)

    lines = cv2.HoughLines(edges,1,np.pi/180,100)
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

def find_on_lines(point, lines):
    for i in range(0, len(lines)):
        line = lines[i]
        if line[0] * point[0] + line[1] * point[1] + line[2] == 0:
            return i
    return -1



def get_true_lines(kp1, kp2, kp3, matches1, matches2, lines1, lines2, lines3):
    res1 = []
    res2 = []
    res = []
    for mat in matches1:
        # Get the matching keypoints for each of the images
        img1_idx = mat.queryIdx
        img2_idx = mat.trainIdx

        # x - columns
        # y - rows
        (x1,y1) = kp1[img1_idx].pt
        ind1 = find_on_lines((x1,y1), lines1)
        (x2,y2) = kp2[img2_idx].pt
        ind2 = find_on_lines((x2, y2), lines2)

        if ind1 != -1 and ind2 != -1:
            res1.append((ind1, ind2))

    for mat in matches2:
        # Get the matching keypoints for each of the images
        img1_idx = mat.queryIdx
        img2_idx = mat.trainIdx

        # x - columns
        # y - rows
        (x1,y1) = kp2[img1_idx].pt
        ind1 = find_on_lines((x1,y1), lines2)
        (x2,y2) = kp3[img2_idx].pt
        ind2 = find_on_lines((x2, y2), lines3)

        if ind1 != -1 and ind2 != -1:
            res2.append((ind1, ind2))

    for r1 in res1:
        for r2 in res2:
            if r1[1] == r2[0]:
                res.append([r1[0],r1[1],r2[1]])

    return res

def put_lines_to_files(directory, name):
    files = os.listdir(directory)
    if not os.path.exists(name):
        os.makedirs(name)

    for i in range(0, min (100, len(files) - 2)):
        if not os.path.exists(str(i)):
            os.makedirs(str(i))

        file1 = directory + files[i]
        file2 = directory + files[i+1]
        file3 = directory + files[i+2]

        lines1 = get_lines(file1)
        lines2 = get_lines(file2)
        lines3 = get_lines(file3)

        kp1, kp2, kp3, matches1, matches2 = get_mathces(file1, file2, file3)
        lines = get_true_lines(kp1, kp2, kp3, matches1, matches2, lines1, lines2, lines3)

        with open(name + '/' + str(i) + '/0', "w+") as f:
            for line in lines:
                f.write(str(line[0]) + ' ' + str(line[1]) + ' ' + str(line[2]) + '\n')


def get_mathces(file1, file2, file3):
    img1 = cv2.imread(file1)
    img1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
    img2 = cv2.imread(file2)
    img2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
    img3 = cv2.imread(file3)
    img3 = cv2.cvtColor(img3, cv2.COLOR_BGR2GRAY)

    # Initiate SIFT detector
    orb = cv2.ORB()

    # find the keypoints and descriptors with SIFT
    kp1, des1 = orb.detectAndCompute(img1,None)
    kp2, des2 = orb.detectAndCompute(img2, None)
    kp3, des3 = orb.detectAndCompute(img3, None)

    # create BFMatcher object
    bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

    # Match descriptors.
    matches1 = bf.match(des1, des2)
    matches2 = bf.match(des2, des3)

    # Sort them in the order of their distance.
    matches1 = sorted(matches1, key=lambda x: x.distance)
    matches2 = sorted(matches2, key=lambda x: x.distance)

    return (kp1, kp2, kp3, matches1, matches2)

put_lines_to_files("Real_tests/rgbd_dataset_freiburg1_floor/rgb/", "floor")
put_lines_to_files("Real_tests/rgbd_dataset_freiburg3_cabinet/rgb/", "cabinet")