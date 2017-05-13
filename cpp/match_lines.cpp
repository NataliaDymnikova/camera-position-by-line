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


vector<float**> getMatches(string basic_string, string basicString, string file3);
float* get_line(KeyLine line);
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
    cin >> directory;
    cout << "Name of directory for result:\n";
    string name;
    cin >> name;

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

            vector<float**> matches = getMatches(directory+file1, directory+file2, directory+file3);

            ofstream myfile;
            myfile.open(name + to_string(i));

            for (float** lines : matches) {
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

vector<float**> getMatches(string image_path1, string image_path2, string image_path3) {

    cv::Mat imageMat1 = imread(image_path1, 1);
    cv::Mat imageMat2 = imread(image_path2, 1);
    cv::Mat imageMat3 = imread(image_path3, 1);


    /* create a binary mask */
    cv::Mat mask1 = Mat::ones(imageMat1.size(), CV_8UC1);
    cv::Mat mask2 = Mat::ones(imageMat2.size(), CV_8UC1);
    cv::Mat mask3 = Mat::ones(imageMat3.size(), CV_8UC1);

    /* create a pointer to a BinaryDescriptor object with default parameters */
    Ptr <BinaryDescriptor> bd = BinaryDescriptor::createBinaryDescriptor();

    /* compute lines */
    std::vector<KeyLine> keylines1, keylines2, keylines3;
    bd->detect(imageMat1, keylines1, mask1);
    bd->detect(imageMat2, keylines2, mask2);
    bd->detect(imageMat3, keylines3, mask3);

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
    matches1 = filter_by_length(matches1, keylines2);

    vector<float**> matches;
    for (int i = 0; i < matches1.size(); i++) {
        for (int j = 0; j < matches2.size(); j++) {
            if (matches1[i].queryIdx == matches2[j].queryIdx) {
                float **res = new float*[3];
                res[0] = get_line(keylines1[matches1[i].trainIdx]);
                res[1] = get_line(keylines2[matches1[i].queryIdx]);
                res[2] = get_line(keylines3[matches2[j].trainIdx]);
                matches.push_back(res);
            }
        }
    }
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


float* get_line(KeyLine line) {
    float *res = new float[3];
    res[0] = line.endPointY - line.startPointY;
    res[1] = line.startPointX - line.endPointX;
    res[2] = line.startPointY * line.endPointX - line.startPointX * line.endPointY;
    return  res;
}