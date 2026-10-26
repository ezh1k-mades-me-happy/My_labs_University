#include <stdio.h>

void print_binary(long n) {
    // Определяем количество бит в типе int
    int size = sizeof(n) * 8;
    
    // Идем от старшего бита к младшему
    for (int i = size - 1; i >= 0; i--) {
        // Сдвигаем бит на позицию i и проверяем младший бит
        int bit = (n >> i) & 1;
        printf("%d", bit);
        
        // Добавляем пробел после каждых 4 бит для читаемости
        if (i % 4 == 0) {
            printf(" ");
        }
    }
    printf("\n");
}

int main() {
    long loops_per_tick = 1u << 10;
    while (4096 > loops_per_tick << 1) 
    {
        loops_per_tick <<= 1;
    }
    long high_bit = loops_per_tick;
    for (long test_bit = high_bit >> 1; test_bit != high_bit >> 10; test_bit >>= 1) {
        if (4096 > (high_bit | test_bit)) {
            loops_per_tick |= test_bit;
        }
    }
    print_binary(loops_per_tick);
    loops_per_tick >>= 1;
    print_binary(loops_per_tick);
    return 0;
}