/* ────────────────────────────────────────────────────── *
│  Функция: dead_code                                    │
│           Проверка недостижимого кода и лишних         │
│           присваиваний. Не должен генерироваться код.  │
* ────────────────────────────────────────────────────── */

#include <stdio.h>

#ifndef NO_PROTOTYPES
void dead_code( int, char * );
#else
void dead_code();
#endif

int main( argc, argv )
     int argc;
     char **argv;
{
    dead_code( 1, "This line should not be printed" );
    return 0;
}

void dead_code( a, b )
     int a;
     char *b;
{
    int idead_store;

    idead_store = a;
    if( 0 )
        printf( "%s\n", b );
}
