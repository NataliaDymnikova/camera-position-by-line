#include<iostream>

#include "draw_lines.h"
#include "match_lines.h"

using namespace std;

int main() {
    cout << "0 -- match lines" << endl << "1 -- draw_lines" << endl;
    int i;
    cin >> i;

    if (i == 0) {
        match_lines();
    } else if (i == 1) {
        draw_lines();
    }
}