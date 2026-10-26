#include <stdio.h>
#include <math.h>
#include <stdlib.h>

void input(unsigned long long *arr, int len);
int is_perfect_square(unsigned long long n);

int main() {
    unsigned long long* arr; // массив
    int len; // длина массива
    scanf("%d", &len);
    arr = (unsigned long long*) malloc(sizeof(unsigned long long) * len);
    input(arr, len);
    
    unsigned long long max = 0;
    int index = -1;
    
    for (int i = 0; i < len; i++) {
        if (is_perfect_square(arr[i])) {
            if (index == -1 || arr[i] > max) {
                max = arr[i];
                index = i;
            }
        }
    }
    
    printf("%d", index);
    free(arr);
    return 0;
}

void input(unsigned long long *arr, int len) {
    for (int i = 0; i < len; i++) {
        scanf("%llu", &arr[i]);
    }
}

int is_perfect_square(unsigned long long n) {
    int is_square = 0;
    if (n == 0) is_square = 1;
    else {
        unsigned long long rez_sqrt = (unsigned long long) sqrt((double) n);
        // Проверка трех кандидатв для компенсаци ошибок округления
        for (unsigned long long r = (rez_sqrt > 1 ? rez_sqrt - 1 : 0); r < rez_sqrt + 2; r++) {
            if (r * r == n) {
                is_square = 1;
            }
        }
    }
    return is_square;
}