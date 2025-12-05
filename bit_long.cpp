#include <stdio.h>

int main() {
    long num;
    scanf("%ld", &num);
    if (num == 0) {
        printf("0\n");
        return 0;
    }
    int started = 0;
    long size = sizeof(long);
    for (int i = size - 1; i >= 0; i--) {
        int bit = (num >> i) & 1;
        if (bit) started = 1;
        if (started) {
            printf("%d", bit);
        }
    }
    printf("\n");
    return 0;
}