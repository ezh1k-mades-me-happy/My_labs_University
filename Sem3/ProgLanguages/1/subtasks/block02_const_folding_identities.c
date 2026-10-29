/* ────────────────────────────────────────── *
│ Свертка констант, арифметические тождества │
│ и излишние операции загрузки/сохранения    │
* ────────────────────────────────────────── */

#include <stdio.h>

int    i;
int    i2, j2, k2;
int    i3, i4, i5;
double flt_1, flt_2, flt_3, flt_4, flt_5, flt_6;

int main( argc, argv )
     int argc;
     char **argv;
{
    i3 = 1 + 2;
    flt_1 = 2.4 + 6.3;
    i2 = 5;
    j2 = i + 0;
    k2 = i / 1;
    i4 = i * 1;
    i5 = i * 0;

#ifndef NO_ZERO_DIVIDE
    /*
     *   Некоторые компиляторы распознают ошибку
     *   деления на нуль и не генерируют объектный код
     */
    i2 = i / 0;
    flt_2 = flt_1 / 0.0;
#else
    printf( "This compiler handles divide-by-zero as an error\n");
#endif
    flt_3 = 2.4 / 1.0;
    flt_4 = 1.0 + 0.0000001;
    flt_5 = flt_6 * 0.0;
    flt_6 = flt_2 * flt_3;

    return i3;
}
