#include <iostream>
#include <fstream>

#include <opencv2/line_descriptor.hpp>
#include <opencv2/features2d.hpp>
#include <opencv2/highgui.hpp>
#include <dirent.h>

using namespace cv;
using namespace cv::line_descriptor;
using namespace std;


vector<float**> getMatches(string basic_string, string basicString, string file3);
float* get_line(KeyLine line);

int main() {
    cout << "Directories should be with \\ in the end:\n";

/*
 * C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg1_floor\rgb\
    C:\MyProga\diploma\camera-position-by-line\cpp\floor\
    */
/*    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg3_cabinet\rgb\
    C:\MyProga\diploma\camera-position-by-line\cpp\cabinet\
    */

    cout << "Directory with images:\n";
    char *directory = new char[1000];
    cin >> directory;
    cout << "Name of directory for result:\n";
    char *name = new char[1000];
    cin >> name;

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

        mkdir(name);

        int len = (int) min((int) files.size(), 100);
        for (int i = 0; i < len - 2; i++){
            string file1 = files[i];
            string file2 = files[i+1];
            string file3 = files[i+2];

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
    delete (name);
    delete (dir);
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


float* get_line(KeyLine line) {
    float *res = new float[3];
    res[0] = line.endPointY - line.startPointY;
    res[1] = line.startPointX - line.endPointX;
    res[2] = line.startPointY * line.endPointX - line.startPointX * line.endPointY;
    return  res;
}