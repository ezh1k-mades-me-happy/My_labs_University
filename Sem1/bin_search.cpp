#include <stdio.h>
#include <stdlib.h>

int input(int* arr, int len); // 66 11 22 44 77 33 99 55 88 52
void bubble_sort(int* arr, int N);
void binary_search(int* arr, int N);

int main() {
    int* arr;
    int len;
    
    int is_error = 0;
    printf("Введите количество элементов в массиве: ");
    int n_enter = scanf("%d", &len);
    char last_char = getchar();
    if (n_enter != 1 || len <= 0 || last_char != '\n') is_error = 1;
    arr = (int*) malloc(sizeof(int) * len);
    if (is_error == 0) {
        is_error = input(arr, len);
    }

    if (is_error == 0) {
        bubble_sort(arr, len);
        binary_search(arr, len);
        free(arr);
    } else {
        printf("Ошибка ввода.");
    }
    return 0;
}

int input(int *arr, int len) {
    int is_error = 0;
    int n_enter;
    char last_char;
    printf("Введите %d чисел в строку, через пробел: ", len);
    for (int *p = arr; p - arr < len; p++) {
        n_enter = scanf("%d", p);
        last_char = getchar();
        if (n_enter != 1 || (last_char != '\n' && last_char != ' ')) {
            is_error = 1;
            break;
        }
    }
    return is_error;
}

void bubble_sort(int* arr, int N) {
    int temp;
    for (int i = 0; i < N - 1; i++) {
        for (int j = 0; j < N - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
    printf("Отсортированный массив: ");
    for (int i = 0; i < N; i++) {
        printf("%d ", arr[i]);
    }
}

void binary_search(int* arr, int N) {
    int left = 0;
    int right = N - 1;
    int iskomoe;
    int flag = 0;
    printf("\nВведите число, которое хотите найти: ");
    int n_enter = scanf("%d", &iskomoe);
    char last_char = getchar();
    if (n_enter == 1 && last_char == '\n') {
        while (left <= right) {
            int middle = left + (right - left) / 2;
            if (arr[middle] == iskomoe) {
                flag = 1;
                while (middle != 0 && arr[middle-1] == iskomoe) middle--;
                printf("\nИндекс искомого числа в отсортированном массиве: %d", middle);
                break;
            }
            if (iskomoe < arr[middle]) {
                right = middle - 1;
            }
            else {
                left = middle + 1;
            }
        }
        if (flag == 0) printf("Числа не найдено!");
    } else {
        printf("Ошибка ввода.");
    }
}