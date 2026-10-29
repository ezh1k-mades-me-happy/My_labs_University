/* ───────────────────────────── *
│  Удаление общих подвыражений  │
* ───────────────────────────── */

#include <stdio.h>

int g3, h3, i3, k3, m3;

int main( argc, argv )
     int argc;
     char **argv;
{
    if(( h3 + k3 ) < 0 || ( h3 + k3 ) > 5 )
        printf("Common subexpression elimination\n");
    else {
        m3 = ( h3 + k3 ) / i3;
        g3 = i3 + (h3 + k3);
    }

    return g3 + m3;
}
