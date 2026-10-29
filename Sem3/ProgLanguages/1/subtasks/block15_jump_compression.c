/* ───────────────────────────────────────────────────── *
│  Функция: jump_compression                            │
│           Эта программа полезна для демонстрации      │
│           сжатия цепочки переходов. goto end_1 может  │
│           быть заменен на прямой переход на beg_1.    │
* ───────────────────────────────────────────────────── */

#ifndef NO_PROTOTYPES
int jump_compression( int, int, int, int, int );
#else
int jump_compression();
#endif

int main( argc, argv )
     int argc;
     char **argv;
{
    return jump_compression( argc, argc+1, argc+2, argc+3, argc+4 );
}

       int jump_compression( i, j, k, l, m )
       int i, j, k, l, m;
           {
        beg_1:
               if( i < j )
                   if( j < k )
                       if( k < l )
			   if( l < m )
                               l += m;
                           else
                               goto end_1;
                       else
                           k += l;
                   else {
                       j += k;
        end_1:
                       goto beg_1;
                   }
               else
                   i += j;
               return( i + j + k + l + m );
           } /* Конец jump_compression */
