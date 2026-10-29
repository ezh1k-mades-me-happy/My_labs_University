/* ──────────────────────────────────────────────────── *
│  Функция: unnecessary_loop                           │
│           Цикл в следующей функции ненужен, так как  │
│           значение присваивания постоянно. В идеале  │
│           цикл должен быть удален.                   │
* ──────────────────────────────────────────────────── */

#ifndef NO_PROTOTYPES
void unnecessary_loop( void );
#else
void unnecessary_loop();
#endif

int i, j5, k5;

int main( argc, argv )
     int argc;
     char **argv;
{
    unnecessary_loop();
    return k5;
}
  /* Цикл не должен генерироваться */
void unnecessary_loop()
{
    int x;

    x = 0;
    for( i = 0; i < 5; i++ )
        k5 = x + j5;
}
