#include <stdio.h>

int main() {
    double a1  = 1.0;
    double a2  = 1.;
    double a3  = 01.0;
    double a4  = 001.000;
    double a5  = 0.1e1;
    double a6  = 0.1E1;
    double a7  = .1e1;
    double a8  = .1E1;
    double a9  = 10.e-1;
    double a10 = 10.E-1;
    double a11 = 100.e-2;
    double a12 = 100.E-2;
    double a13 = 0.01e2;
    double a14 = 0.01E2;
    double a15 = .01e2;
    double a16 = .01E2;
    double a17 = 0.001e3;
    double a18 = 1.000000e0;
    double a19 = 1.000000E0;
    double a20 = 0001.000000e0;

    // Эти числа тоже равны 1.0, но находятся в комментарии и должны игнорироваться:
    // 1.0 1. .1e1 10.e-1 100.e-2

    /*
        И эти тоже должны игнорироваться:
        1.0
        1.
        .1e1
        10.e-1
    */

    char* s1 = "1.0 1. .1e1 10.e-1";
    char* s2 = "0.01e2 0.001e3 1.000000E0";

    double h1 = 0x1p0;
    double h2 = 0x2p-1;
    double h3 = 0x1.0p0;
    
    printf("%lf %lf %lf\n", a20, h2, h3);
    return 0;
}