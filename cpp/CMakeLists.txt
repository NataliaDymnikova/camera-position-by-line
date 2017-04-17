cmake_minimum_required(VERSION 3.2)
project(test)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# Where to find CMake modules and OpenCV
set(OpenCV_DIR "C:\\MyProga\\libraries\\opencv3\\opencv\\mingw-build\\install")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(test_cv main.cpp)

# add libs you need
set(OpenCV_LIBS opencv_calib3d opencv_core opencv_features2d opencv_flann
        opencv_highgui opencv_imgcodecs opencv_imgproc opencv_ml
        opencv_line_descriptor)

# linking
target_link_libraries(test_cv ${OpenCV_LIBS})