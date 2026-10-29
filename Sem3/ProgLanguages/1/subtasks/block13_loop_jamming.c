/* ──────────────────────────────────────────────────── *
│  Функция: loop_jamming                               │
│           Два цикла в этой функции имеют одинаковые  │
│           заголовки и могут быть слиты в один.       │
* ──────────────────────────────────────────────────── */

#ifndef NO_PROTOTYPES
int loop_jamming( int, int, int );
#else
int loop_jamming();
#endif


int main()
{   
    int A[100];
    int B[100];
    int C[100];
    int D[100];
    
    for (int i = 0; i < 1000; i++) {
        A[i] = B[i] * C[i];
    }
    for (int j = 0; j < 1000; j++) {
        B[j] += 5;
    }

    for (int i = 0; i < 1000; i++) {
       printf("%d\n", A[i]);
       printf("%d\n", B[i]);
       printf("%d\n", C[i]);
       printf("%d\n", D[i]);
    }
    return 0;
       
}
