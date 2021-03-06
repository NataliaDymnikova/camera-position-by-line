#include "match_lines.h"

#include <iostream>
#include <fstream>
#include <algorithm>

#include <opencv2/line_descriptor.hpp>
#include <opencv2/features2d.hpp>
#include <opencv2/highgui.hpp>
#include <dirent.h>

using namespace cv;
using namespace cv::line_descriptor;
using namespace std;


vector<double**> getMatches(string basic_string, string basicString, string file3);
double* get_line(KeyLine line);
std::vector<DMatch> sort_by_length(std::vector<DMatch> vector,std::vector<KeyLine> keylines);

vector<DMatch> filter_by_length(vector<DMatch> matches, vector<KeyLine> keylines);

int match_lines() {
    cout << "Directories should be with \\ in the end:\n";

/*
    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg1_floor\rgb\
    C:\MyProga\diploma\camera-position-by-line\cpp\floor\
*/
/*
    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg3_cabinet\rgb\
    C:\MyProga\diploma\camera-position-by-line\cpp\cabinet\
*/
/*
    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg3_large_cabinet\rgb\
    C:\MyProga\diploma\camera-position-by-line\cpp\large\
*/

    cout << "Directory with images:\n";
    char *directory = new char[1000];
//    cin >> directory;
    string d = "C:\\MyProga\\diploma\\camera-position-by-line\\cpp\\Real_tests\\rgbd_dataset_freiburg1_floor\\rgb\\";
    strcpy(directory, d.c_str());
    cout << "Name of directory for result:\n";
    string name;
//    cin >> name;
     name = "C:\\MyProga\\diploma\\camera-position-by-line\\cpp\\floor\\";

    int step = 1;

    name = name + to_string(step) + "\\";

    DIR *dir;
    struct dirent *ent;
    vector<string> files;
    if ((dir = opendir(directory)) != NULL) {

        /* print all the files and directories within directory */
        while ((ent = readdir (dir)) != NULL) {
            if (ent->d_name[0] == '.') {
                continue;
            }
            files.push_back(string(ent->d_name));
        }

        mkdir(name.data());

        int len = (int) files.size();
        for (int i = 0; i < len - 2*step-1; i++){
            string file1 = files[i];
            string file2 = files[i+step];
            string file3 = files[i+2*step];

            vector<double**> matches = getMatches(directory+file1, directory+file2, directory+file3);

            ofstream myfile;
            myfile.open(name + to_string(i));

            for (double** lines : matches) {
                string str;
                for (int j = 0; j < 3; j++)
                    str.append(to_string(lines[j][0]) + " " + to_string(lines[j][1]) + " " + to_string(lines[j][2]) + " ");
                myfile << str << endl;
            }

            for (int j = 0; j < matches.size(); j++)
                for (int k = 0; k < 3; k++)
                    delete (matches[j][k]);
            myfile.close();
        }

        closedir (dir);
    }

    delete (directory);
    delete (dir);

    return 0;
}

vector<double**> getMatches(string image_path1, string image_path2, string image_path3) {

    cv::Mat image1 = imread(image_path1, 1);
    cv::Mat image2 = imread(image_path2, 1);
    cv::Mat image3 = imread(image_path3, 1);
    cv::Mat imageMat1, imageMat2, imageMat3;


    vector<double> distCoef = {0.2624, -0.9531, -0.0054, 0.0026, 1.1633};

    vector<double> camMat = {517.3,.0,318.6, 0,516.5,255.3, 0,0,1};
    cv::Mat rMat(3,3,CV_64FC1);
    cv::Mat dMat(1, (int) distCoef.size(), CV_64FC1);

    for (int i = 0; i < distCoef.size(); i++) {
        dMat.at<double>(0, i) = distCoef[i];
    }
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; ++j) {
            rMat.at<double>(i,j) = camMat[i+j];
        }
    }

    image1.copyTo(imageMat1);
    image2.copyTo(imageMat2);
    image3.copyTo(imageMat3);

//    int i = 0;
//    cv::undistort(image1, imageMat1, rMat, dMat);
//    cv::undistort(image2, imageMat2, rMat, dMat);
//    cv::undistort(image3, imageMat3, rMat, dMat);

    /* create a binary mask */
    cv::Mat mask1 = Mat::ones(imageMat1.size(), CV_8UC1);
    cv::Mat mask2 = Mat::ones(imageMat2.size(), CV_8UC1);
    cv::Mat mask3 = Mat::ones(imageMat3.size(), CV_8UC1);

    /* create a pointer to a BinaryDescriptor object with default parameters */
    Ptr <BinaryDescriptor> bd = BinaryDescriptor::createBinaryDescriptor();

    /* compute lines */
    std::vector<Vec4i> key1, key2, key3;
    std::vector<KeyLine> keylines1, keylines2, keylines3;

    bd->detect(imageMat1, keylines1, mask1);
    bd->detect(imageMat2, keylines2, mask2);
    bd->detect(imageMat3, keylines3, mask3);
/*
    cv::Mat img1, img2, img3;
    Canny(imageMat1, img1, 50, 200, 3);
    Canny(imageMat2, img2, 50, 200, 3);
    Canny(imageMat3, img3, 50, 200, 3);

    HoughLinesP(img1, key1, 1, CV_PI/180, 80, 75, 15 );
    HoughLinesP(img2, key2, 1, CV_PI/180, 80, 75, 15 );
    HoughLinesP(img3, key3, 1, CV_PI/180, 80, 75, 15 );
//    imshow("v1", img1);
//    imshow("v2", img2);
//    imshow("v3", img3);
//    waitKey(500);

    for (Vec4i i : key1) {
        line(mask1, cv::Point(i[0],i[1]), cv::Point(i[2],i[3]), cv::Scalar(255,255,255), 1);
    }
    for (Vec4i i : key2) {
        line(mask2, cv::Point(i[0],i[1]), cv::Point(i[2],i[3]), cv::Scalar(255,255,255), 1);
    }
    for (Vec4i i : key3) {
        line(mask3, cv::Point(i[0],i[1]), cv::Point(i[2],i[3]), cv::Scalar(255,255,255), 1);
    }
    cout << key1.size() << endl;
//    imshow("v1", img1);
//    imshow("v2", img2);
//    imshow("v3", img3);
//    waitKey(5);

    bd->detect(mask1, keylines1);
    bd->detect(mask2, keylines2);
    bd->detect(mask3, keylines3);

    cout << keylines1.size()<< endl<<endl;
    for (KeyLine i : keylines1) {
        line(img1, i.getStartPoint(), i.getEndPoint(), cv::Scalar(255,255,255), 2);
    }
    imshow("w3", img1);
    waitKey(5);

*/
    /* compute descriptors */
    cv::Mat descr1, descr2, descr3;
    bd->compute( imageMat1, keylines1, descr1 );
    bd->compute( imageMat2, keylines2, descr2 );
    bd->compute( imageMat3, keylines3, descr3 );

    /* create a BinaryDescriptorMatcher object */
    Ptr<BinaryDescriptorMatcher> bdm = BinaryDescriptorMatcher::createBinaryDescriptorMatcher();

    /* require match */
    std::vector<DMatch> matches1, matches2;
    bdm->match( descr2, descr1, matches1 );
    bdm->match( descr2, descr3, matches2 );

//    matches1 = sort_by_length(matches1, keylines2);
//    matches1 = filter_by_length(matches1, keylines2);

    vector<double**> matches;
    for (int i = 0; i < matches1.size(); i++) {
        for (int j = 0; j < matches2.size(); j++) {
            if (matches1[i].queryIdx == matches2[j].queryIdx) {
                double **res = new double*[3];
                line(imageMat1, keylines1[matches1[i].trainIdx].getStartPoint(), keylines1[matches1[i].trainIdx].getEndPoint(), cv::Scalar(255,255,0), 4);
                line(imageMat2, keylines2[matches1[i].queryIdx].getStartPoint(), keylines2[matches1[i].queryIdx].getEndPoint(), cv::Scalar(255,255,0), 4);
                line(imageMat3, keylines3[matches2[j].trainIdx].getStartPoint(), keylines3[matches2[j].trainIdx].getEndPoint(), cv::Scalar(255,255,0), 4);
                res[0] = get_line(keylines1[matches1[i].trainIdx]);
                res[1] = get_line(keylines2[matches1[i].queryIdx]);
                res[2] = get_line(keylines3[matches2[j].trainIdx]);
                matches.push_back(res);
            }
        }
    }
    imshow("v1", imageMat1);
    imshow("v2", imageMat2);
    imshow("v3", imageMat3);
    waitKey(50);

    return matches;
}

std::vector<DMatch> filter_by_length(std::vector<DMatch> matches, std::vector<KeyLine> keylines) {
    std::vector<DMatch> res;
    for (DMatch i : matches) {
        if (keylines[i.queryIdx].lineLength > 15)
            res.push_back(i);
    }

    return res;

}

std::vector<DMatch> sort_by_length(std::vector<DMatch> matches, std::vector<KeyLine> keylines){
    std::vector<DMatch> res;
    sort(matches.begin(), matches.end(),
         [keylines](DMatch a, DMatch b) -> bool {
             return keylines[b.queryIdx].lineLength < keylines[a.queryIdx].lineLength;
         }
    );

    return matches;
}


double* get_line(KeyLine line) {
    double fx = 535.4,//517.306408, // focal length x
        fy = 516.469215, // focal length y
        cx = 318.643040, // optical center x
        cy = 255.313989; // optical center y
/*
 * fx 0 cx     x     fx*x + cx  |        fx*x
 * 0 fy cy  *  y  =  fy*y + cy  |  =     fy*y
 * 0  0  1     1          1     |     cx*x+cy*y+1
 * */


    double  *res = new double[3];

    double zs = (cx * line.startPointX  + cy * line.startPointY + 1);
    double ze = (cx * line.endPointX + cy * line.endPointY + 1);
    double xs = fx * line.startPointX / zs;
    double ys = fy * line.startPointY / zs;
    double xe = fx * line.endPointX / ze;
    double ye = fy * line.endPointY / ze;


//    float xs = line.startPointX ;
//    float ys = line.startPointY ;
//    float xe = line.endPointX ;
//    float ye = line.endPointY ;

    res[0] = ye - ys;
    res[1] = xs - xe;
    res[2] = ys*xe - xs*ye;
    return  res;
}