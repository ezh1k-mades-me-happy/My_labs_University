/* ───────────── *
│  Простой цикл │
* ───────────── */

#define constant5 5

int j5, k5, i5;

int main( argc, argv )
     int argc;
     char **argv;
{
    j5 = 0;
    k5 = 10000;
    do {
        k5 = k5 - 1;
        j5 = j5 + 1;
        i5 = (k5 * 3) / (j5 * constant5);
    } while ( k5 > 0 );

    return i5;
}
