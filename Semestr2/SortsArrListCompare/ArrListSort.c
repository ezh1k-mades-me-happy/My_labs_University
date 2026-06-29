#define _POSIX_C_SOURCE 199309L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// Структура узла связного списка
typedef struct Node {
    unsigned long long data;
    struct Node* next;
} Node;

// Глобальные переменные для ЛКГ
unsigned long long a = 1844674407385880829ULL;
unsigned long long c = 1ULL;
unsigned long long seed = 0ULL;

int sizes[] = {10, 50, 100, 200, 500, 1000, 5000, 10000, 25000, 50000, 100000};

// Генератор псевдослучайных чисел
unsigned long long my_rand() {
    seed = seed * a + c;
    return seed;
}

// Заполнение массива псевдослучайными числами
void fill_array(unsigned long long* arr, int n) {
    for (int i = 0; i < n; i++) {
        arr[i] = my_rand();
    }
}

// Сортировка вставками (максимумами) для массива
void insertion_sort_max_array(unsigned long long* arr, int n) {
    for (int i = n - 1; i > 0; i--) {
        int max_idx = 0;
        for (int j = 1; j <= i; j++) {
            if (arr[j] > arr[max_idx]) {
                max_idx = j;
            }
        }

        unsigned long long max_val = arr[max_idx];
        for (int j = max_idx; j < i; j++) {
            arr[j] = arr[j + 1];
        }
        arr[i] = max_val;
    }
}

// Создание нового узла
Node* create_node(unsigned long long data) {
    Node* node = (Node*)malloc(sizeof(Node));
    if (!node) {
        fprintf(stderr, "Ошибка выделения памяти\n");
        exit(EXIT_FAILURE);
    }
    node->data = data;
    node->next = NULL;
    return node;
}

// Заполнение списка из массива
Node* fill_list_from_array(unsigned long long* arr, int n) {
    Node* head = NULL;
    Node* tail = NULL;

    for (int i = 0; i < n; i++) {
        Node* node = create_node(arr[i]);
        if (!head) {
            head = node;
            tail = node;
        } else {
            tail->next = node;
            tail = node;
        }
    }
    return head;
}

// Освобождение памяти списка
void free_list(Node* head) {
    Node* cur = head;
    while (cur) {
        Node* next = cur->next;
        free(cur);
        cur = next;
    }
}

// Сортировка вставками (максимумами) для списка
Node* insertion_sort_max_list(Node* head) {
    if (!head || !head->next) return head;

    Node* unsorted = head;
    Node* sorted = NULL;

    while (unsorted) {
        Node* max_prev = NULL;
        Node* max_node = unsorted;
        Node* prev = unsorted;
        Node* cur = unsorted->next;

        while (cur) {
            if (cur->data > max_node->data) {
                max_node = cur;
                max_prev = prev;
            }
            prev = cur;
            cur = cur->next;
        }

        if (max_prev == NULL) {
            unsorted = unsorted->next;
        } else {
            max_prev->next = max_node->next;
        }

        max_node->next = sorted;
        sorted = max_node;
    }

    return sorted;
}

// Возвращает текущее время в секундах
double get_time() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

// Выполняет сортировку массива несколько раз и возвращает среднее время
double CalcTimeArr(const unsigned long long* ref_arr, unsigned long long* work_arr, int n, int runs) {
    for (int run = 0; run < runs; run++) {
        memcpy(work_arr, ref_arr, n * sizeof(unsigned long long));
        insertion_sort_max_array(work_arr, n);
    }
    double time = 0.0;
    printf("Выполним %d сортировок для прогретого массива из %d элементов:\n", runs, n);
    for (int run = 0; run < runs; run++) {
        memcpy(work_arr, ref_arr, n * sizeof(unsigned long long));
        double t_start = get_time();
        insertion_sort_max_array(work_arr, n);
        double t_end = get_time();
        double curr_time = t_end - t_start;
        time += curr_time;
        printf("%d) %llf\n", run+1, curr_time);
    }

    return time / runs;
}

// Выполняет сортировку списка несколько раз и возвращает среднее время
double CalcTimeList(unsigned long long* ref_arr, int n, int runs) {
    // Прогрев
    for (int run = 0; run < runs; run++) {
        Node* head = fill_list_from_array(ref_arr, n);
        Node* sorted_head = insertion_sort_max_list(head);
        free_list(sorted_head);
    }
    double time = 0.0;
    printf("Выполним %d сортировок для прогретого списка из %d элементов:\n", runs, n);
    for (int run = 0; run < runs; run++) {
        Node* head = fill_list_from_array(ref_arr, n);
        double t_start = get_time();
        Node* sorted_head = insertion_sort_max_list(head);
        double t_end = get_time();
        double curr_time = t_end - t_start;
        time += curr_time;
        printf("%d) %llf\n", run+1, curr_time);
        free_list(sorted_head);
    }
    return time / runs;
}

int main(void) {
    const int RUNS = 5;
    int num_sizes = sizeof(sizes) / sizeof(sizes[0]);

    for (int si = 0; si < num_sizes; si++) {
        int n = sizes[si];

        unsigned long long* ref_arr = (unsigned long long*)malloc(n * sizeof(unsigned long long));
        unsigned long long* work_arr = (unsigned long long*)malloc(n * sizeof(unsigned long long));

        // Формируем эталонный массив
        seed = 42ULL;
        fill_array(ref_arr, n);

        // Замер времени для массива
        double arr_time = CalcTimeArr(ref_arr, work_arr, n, RUNS);
        // Замер времени для списка
        double list_time = CalcTimeList(ref_arr, n, RUNS);
        printf("Count\tArray\t\tList\n%d\t%.6f\t%.6f\n", n, arr_time, list_time);

        free(ref_arr);
        free(work_arr);
    }
    return 0;
}
