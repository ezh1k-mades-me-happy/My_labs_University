#include <stdio.h>
#include <stdlib.h>
#include <time.h> 
#define N 99999

int C_counter = 0, M_counter = 0, max_razr = 0;
void qSort(int l, int r, int* A);
void AmericanFlagSort(int* arr, int l, int r, int base);
void decision(int* arr1, int* arr2);

int main() {
    int arr1[N];
    int arr2[N];
    srand(time(NULL));
    // Проверка для массивов с рандомными числами
    for (int i = 0; i < N; i++) {
        arr1[i] = arr2[i] = rand();
    }
    decision(arr1, arr2);
    printf("-----------------------------------------------------\nДля отсортированных массивов:\n");
    // Проверка для отсортированных массивов
    decision(arr1, arr2);
    return 0;
}

void decision(int* arr1, int* arr2) {
    C_counter = 0, M_counter = 0;
    qSort(0, N-1, arr1); // Быстрая сортировка
    printf("Quick Sort C: %d    M: %d\n", C_counter, M_counter);
    C_counter = 0, M_counter = 0;
    AmericanFlagSort(arr2, 0, N - 1, 100000); // Сортировка американским флагом
    printf("American Flag Sort C: %d    M: %d\n", C_counter, M_counter);

    int i = 0, flag1 = 0, flag2 = 0;
    while (++i < N || (flag1 && flag2)) { // Проверка на отсортированность массивов
        if (arr1[i-1] > arr1[i]) flag1 = 1;
        if (arr2[i-1] > arr2[i]) flag2 = 1;
    }
    (flag1) ? printf("Error! The array is not sorted by Quick Sort!\n") : printf("The array has been successfully sorted by Quick Sort!\n");
    (flag2) ? printf("Error! The array is not sorted by American Flag Sort!\n") : printf("The array has been successfully sorted by American Flag Sort!\n");
}

void qSort(int l, int r, int* A) {
    int i = l, j = r;
    int x, t;
    x = A[(l + r) / 2];
    do {
        while (A[i] < x) { // Находим в левой части элемент >= опорного
            i++;
            C_counter++;
        } C_counter++;
        while (A[j] > x) { // Находим в правой части элемент <= опорного
            j--;
            C_counter++;
        } C_counter++;
        if (i <= j) {
            if (A[i] != A[j]) {  
                t = A[i]; A[i] = A[j]; A[j] = t; // swap
                M_counter += 3;
            }
            i++; j--;
        }
    } while (i <= j);
    if (j > l) qSort(l, j, A); // qSort для левой части от опорного элемента
    if (i < r) qSort(i, r, A); // qSort для правой части от опорного элемента
}

void AmericanFlagSort(int* arr, int l, int r, int base) {
    if (l >= r || base == 0)
        return;

    int count[10] = { 0 }; // Кол-во чисел с n-ой цифрой в текущей разряде
    int start[10]; // Начальная граница для каждой цифры
    int end[10];  // Конечная граница для каждой цифры
    int i;

    

    for (i = l; i <= r; i++) { // Заполняем массив count
        int digit = (arr[i] / base) % 10;
        count[digit]++;
        // C_counter++;
    }

    start[0] = l;
    for (i = 1; i < 10; i++) { // Заполняем массив start
        start[i] = start[i - 1] + count[i - 1];
        // M_counter++;
    }

    for (i = 0; i < 10; i++) { // Заполняем массив end
        end[i] = start[i] + count[i] - 1;
        // M_counter++;
    }

    int d;
    for (d = 0; d < 10; d++) {
        int pos = start[d];

        while (pos <= end[d]) {
            int digit = (arr[pos] / base) % 10;
            C_counter++;

            if (digit != d) {
                
                int saved = arr[pos];
                int current_pos = pos;
                int const_pos = pos;
               

                do {
                    
                    int target = start[digit];
                    int temp = arr[target];
                    arr[target] = saved;
                    M_counter++;
                    saved = temp;
                    start[digit]++;
                    current_pos = target;
                    digit = (saved / base) % 10;
                    C_counter++;

                } while (current_pos != const_pos);

                pos++;
            }
            else {
                pos++;
            }
        }
    }

    for (d = 0; d < 10; d++) {
        if (count[d] == 0) {
            continue;
        }

        int left = end[d] - count[d] + 1;
        int right = end[d];

        if (left < right) {
            AmericanFlagSort(arr, left, right, base / 10);
        }
    }
}