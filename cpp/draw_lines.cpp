#include "draw_lines.h"
#include <iostream>

#include <opencv2/line_descriptor.hpp>
#include <opencv2/features2d.hpp>
#include <opencv2/highgui.hpp>
#include <dirent.h>

using namespace cv;
using namespace cv::line_descriptor;
using namespace std;

int draw_lines()
{
//    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg1_floor\rgb\
//    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg3_cabinet\rgb\
//    C:\MyProga\diploma\camera-position-by-line\cpp\Real_tests\rgbd_dataset_freiburg3_large_cabinet\rgb\
    /* get parameters from comand line */
    cout << "Directory with images:\n";
    char *directory = new char[1000];
    cin >> directory;

    DIR *dir;
    struct dirent *ent;
    vector<string> files;
    if ((dir = opendir(directory)) != NULL) {

        /* print all the files and directories within directory */
        while ((ent = readdir(dir)) != NULL) {
            if (ent->d_name[0] == '.') {
                continue;
            }

            string image_path = directory + string(ent->d_name);
            /* load image */
            cv::Mat imageMat = imread(image_path, 1);
            if (imageMat.data == NULL) {
                std::cout << "Error, image could not be loaded. Please, check its path" << std::endl;
            }

            /* create a ramdom binary mask */
            cv::Mat mask = Mat::ones(imageMat.size(), CV_8UC1);

            /* create a pointer to a BinaryDescriptor object with deafult parameters */
            Ptr<BinaryDescriptor> bd = BinaryDescriptor::createBinaryDescriptor();

            /* create a structure to store extracted lines */
            vector<KeyLine> lines;

            /* extract lines */
            bd->detect(imageMat, lines, mask);

            /* draw lines extracted from octave 0 */
            cv::Mat output = imageMat.clone();
            if (output.channels() == 1)
                cvtColor(output, output, COLOR_GRAY2BGR);
            for (size_t i = 0; i < lines.size(); i++) {
                KeyLine kl = lines[i];
                if (kl.octave == 0) {
                    /* get a random color */
                    int R = (rand() % (int) (255 + 1));
                    int G = (rand() % (int) (255 + 1));
                    int B = (rand() % (int) (255 + 1));

                    /* get extremes of line */
                    Point pt1 = Point(kl.startPointX, kl.startPointY);
                    Point pt2 = Point(kl.endPointX, kl.endPointY);

                    /* draw line */
                    line(output, pt1, pt2, Scalar(B, G, R), 5);
                }

            }

            /* show lines on image */
            imshow("Lines", output);
            waitKey(3);
        }
        closedir (dir);
    }
    return 1;
}