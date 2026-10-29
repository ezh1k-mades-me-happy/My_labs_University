/* ────────────────────────────────────── *
│  Вынесение инвариантного кода          │
│  (j * k) может быть вынесено из цикла  │
* ────────────────────────────────────── */

#define max_vector 1000
typedef unsigned char uchar;
uchar ivector2[ max_vector + 1 ];

int main()
{
    int j;
    int k;
    scanf("%d", &j);
    scanf("%d", &k);
    for(int i = 0; i <= max_vector; i++)
        ivector2[i] = j * k;

    return ivector2[0];
}
