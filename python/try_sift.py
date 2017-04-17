import cv2
import numpy as np
from matplotlib import pyplot as plt
from drawMatches import drawMatches

img1 = cv2.imread('Real_tests/rgbd_dataset_freiburg1_floor/rgb/1305033527.670034.png')
img2 = cv2.imread('Real_tests/rgbd_dataset_freiburg1_floor/rgb/1305033527.701984.png')
img1 =  cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
img2 =  cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
# Initiate SIFT detector
orb = cv2.ORB()


# find the keypoints and descriptors with SIFT
kp1, des1 = orb.detectAndCompute(img1,None)
kp2, des2 = orb.detectAndCompute(img2,None)

# create BFMatcher object
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

# Match descriptors.
matches = bf.match(des1,des2)

# Sort them in the order of their distance.
matches = sorted(matches, key = lambda x:x.distance)

# Draw first 10 matches.
img3 = drawMatches(img1,kp1,img2,kp2,matches)

plt.imshow(img3)

# gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
# sift = cv2.FeatureDetector_create("SIFT")
# kp = sift.detect(gray,None)
# img=cv2.drawKeypoints(gray,kp,img)
# cv2.imwrite('sift_keypoints.jpg',img)