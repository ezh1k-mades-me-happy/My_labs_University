/* ────────────────────────────────────────────────────── *
│  Функция: loop_unrolling                               │
│           Цикл в этой функции должен быть заменен      │
│           тремя присваиваниями с использованием        │
│           константной индексации массива или машинно-  │
│           зависимыми командами для инициализации       │
│           блока памяти.                                │
* ────────────────────────────────────────────────────── */

#ifndef NO_PROTOTYPES
void loop_unrolling( int , short* );
#else
void loop_unrolling();
#endif


int main()
{
    int n;
    scanf("%d", &n);
    short ivector4[64];
    loop_unrolling(n, ivector4);
    return ivector4[0];

    for(int i = 0; i < n; i++ )
        printf("%d\n", ivector4[ i ]);
}

void loop_unrolling(int x, short* ivector4)
{
    for(int i = 0; i < 64; i++ )
        ivector4[ i ] = x--;
}