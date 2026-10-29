/* ────────────────────────────────────── *
│  Управление переменной индукции цикла  │
* ────────────────────────────────────── */

int i;
int ivector5[ 100 ];

int main( argc, argv )
     int argc;
     char **argv;
{
    for( i = 0; i < 100; i++ )
        ivector5[ i * 2 + 3 ] = 5;

    return ivector5[3];
}
