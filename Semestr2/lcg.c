#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h> 
#include <locale.h>

unsigned long long my_rand(); // Функция лкг
unsigned long long findPeriod(); // Нахождение пероида
int findS(); // Нахождение мощности
int xi_2(); // Проверка Хи-квадрата
void is_ok_xi_2();
int konflikt(); // Проверка критерия конфликтов
void normal_for_konf(int* normal_values, int N, int M); // Подсчет номального количества конфликтов для соотношения урн и мячей
void is_ok_konflikt();

// Параметры ЛКГ
unsigned long long a = 1844674407385880829ULL;
unsigned long long c = 1ULL;
// m = 2^64
unsigned long long seed = 0ULL;

int main() {
    setlocale(LC_ALL, "Russian");
    
    int schitaem_period = 0;
    printf("\nПоиск периода...\n");
    if (schitaem_period) printf("Период = %llu\n", findPeriod());
    else printf("За 10 часов период не найден; период > 26660000000000\n");;

    printf("\nРассчет мощности...\n");
    int S = findS();
    (S) ? printf("Мощность = %d\n", S) : printf("Ошибка в подсчетах!\n");

    printf("\nПроверка разброса Хи-квадрата...\n");
    is_ok_xi_2();

    printf("\nПроверка на критерий конфликтов...\n");
    is_ok_konflikt();

    return 0;
}

unsigned long long my_rand() {
    seed = seed * a + c;
    return seed;
}

unsigned long long findPeriod() {
    seed = time(NULL);
    unsigned long long start = my_rand();
    for (unsigned long long i = 0ULL; i < 1844674407385880829ULL; i++) {
        if (my_rand() == start) return i + 1;
    }
    return 0;
}

int findS() {
    unsigned long long current;
    current = 1;
    for (int S = 1; S < 100; S++) {
        current = current * (a - 1);
        if (current == 0) return S;
    }
    return 0;
}

int xi_2() {
    double V = 0;
    double intervals[100], k = 100;
    int s;
    for (int i = 0; i < (int)k; i++) intervals[i] = 0;
    for (int i = 0; i < 100000; i++) { // проверяем 100 интервалов по 1000 чисел
        s = my_rand() / (4294967296 / k) / 4294967296; // Определяем в каком интервале число (m = 2^64 = 2^32 * 2^32)
        intervals[s] += 1.0;
    }
    // Считаем Хи-квадрат последовательности
    double expected = 100000 / k;
    for (int i = 0; i < k; i++) {
        V += ((intervals[i] - expected) * (intervals[i] - expected)) / expected;
    }
    double normal_values[6] = { 69.230, 77.046, 81.449, 117.407, 123.225, 134.642 };
    int rez = 0;
    if (V >= normal_values[2] && V <= normal_values[3]) return 1;
    else if (V >= normal_values[1] && V <= normal_values[4]) return 2;
    else if (V >= normal_values[0] && V <= normal_values[5]) return 3;
    return rez;
}

void is_ok_xi_2() {
    int rez, good = 0, almost_suspicious = 0, suspicious = 0, bad = 0;
    for (int i = 0; i < 100; i++) {
        seed = time(NULL) + i * 1234567ULL;
        rez = xi_2();
        if (rez == 1) good++;
        else if (rez == 2) almost_suspicious++;
        else if (rez == 3) suspicious++;
        else bad++;
    }
    printf("Хороших Хи-квадратов – %d, почти подозрительных – %d, подозрительных – %d, плохих – %d\n", good, almost_suspicious, suspicious, bad);
}

int konflikt() {
    int M = 1048575, N = 16384; // 2^20-1 урн b 2^14 шаров
    int *urn = (int*) calloc(M, sizeof(int));
    int konflikts = 0;
    
    for (int i = 0; i < N; i++) {
        int idx = (int) (my_rand() % M);
        
        if (urn[idx]) {
            konflikts++;
        } else {
            urn[idx] = 1;
        }
    }
    
    free(urn);

    int normal_values[6];
    normal_for_konf(normal_values, N, M);
    int rez = 0;
    if (konflikts >= normal_values[2] && konflikts <= normal_values[3]) return 1;
    else if (konflikts >= normal_values[1] && konflikts <= normal_values[4]) return 2;
    else if (konflikts >= normal_values[0] && konflikts <= normal_values[5]) return 3;
    return rez;
}

void normal_for_konf(int* normal_values, int N, int M) {
    double T[6] = {0.01, 0.05, 0.1, 0.9, 0.95, 0.99};
    double* A = (double*)calloc(N+1, sizeof(double));
    for (int i = 0; i < N; i++) A[i] = 0.0;
    A[1] = 1.0;
    int j0 = 1; int j1 = 1;
    for (int st = 0; st < N; st++) {
        j1++;
        for (int j = j1; j >= j0; j--) {
            double Aj = 0.0;
            double Aj_pr = (j > 0) ? A[j - 1] : 0.0;
            Aj = ((double)j / M) * A[j] + ((1.0 + (1.0 / M)) - (double)j / M) * Aj_pr;
            A[j] = Aj;
            if (A[j] < 1e-20) {
                A[j] = 0.0;
                if (j == j1) j1--;
                if (j == j0) j0++;
            }
        }
    }
    
    double p = 0.0;
    int t = 0, unsorted_normal_values[6];
    for (int j = j0 - 1; j < N && t < 6; j++) {
        p += A[j];
        if (p > T[t]) {
            unsorted_normal_values[t] = N - j - 1;
            t++;
        }
    }
    free(A);

    int j = 5;
    for (int i = 0; i < 6; i++) {
        normal_values[i] = unsorted_normal_values[j];
        j--;
    }
}

void is_ok_konflikt() {
    int rez, good = 0, almost_suspicious = 0, suspicious = 0, bad = 0;
    for (int i = 0; i < 100; i++) {
        seed = time(NULL) + i * 1234567ULL;
        rez = konflikt();
        if (rez == 1) good++;
        else if (rez == 2) almost_suspicious++;
        else if (rez == 3) suspicious++;
        else bad++;
    }
    printf("Результаты критерия конфликтов:\nХороших – %d, почти подозрительных – %d, подозрительных – %d, плохих – %d\n", good, almost_suspicious, suspicious, bad);
}