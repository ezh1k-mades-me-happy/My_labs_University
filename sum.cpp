#include <stdio.h>
// Можно еще реализовать перебор вообще всех комбинаций чисел:\
arr[x] x - введенное число, допустим x = 5, тогда рассмотрим следующий пример работы программы:\
Первый цикл: arr = {0, 0, 0, 0, 0}, второй: arr = {0, 0, 0, 0, 1}, шестой: arr = {1, 1, 1, 1, 1} (выводим),\
седьмой: arr = {0, 0, 0, 0, 2}, восьмой: arr = {0, 0, 0, 1, 2}, десятый: arr = {0, 1, 1, 1, 2} (выводим) и т.д.

void summer(int n, int max_val, int* arr, int pos);
void output(int* arr, int length);

int main() {
    int x;
    scanf("%d", &x);
    int arr[25];
    summer(x, x-1, arr, 0); // первый аргумент - оставшаяся сумма, \
    втророй - максимальное слагаемое, третий - массив слагаемых, четвертый - индекс текущего слагаемого
    return 0;
}

void summer(int ost, int max_val, int* arr, int pos) {
    if (ost == 0) output(arr, pos);
    int cur_slag = 1;
    while (cur_slag <= max_val && cur_slag <= ost) {
        arr[pos] = cur_slag;
        summer(ost - cur_slag, cur_slag, arr, pos + 1);
        cur_slag++;
    }
}

void output(int* arr, int len) {
    for (int i = len-1; i >= 0; i--) {
        if (i != len-1) printf("+");
        printf("%d", arr[i]);
    }
    printf("\n");
}
