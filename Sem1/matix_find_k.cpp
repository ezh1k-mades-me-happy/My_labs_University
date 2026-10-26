#include <stdio.h>
#define N 3
#define M 3

void finder(long arr[N][M], long* rez_i, long* rez_j);

int main() {
    long arr[N][M];
    long rez_i = 0; long rez_j = 0;
    for (long i = 0; i < N; i++) {
        for (long j = 0; j < M; j++) {
            scanf("%ld", &arr[i][j]);
        }
    }
    finder(arr, &rez_i, &rez_j);
    (rez_i == 0 && rez_j == 0) ? printf("Строк не найдено") : printf("i-ая строка: %ld; j-ая строка: %ld\n", rez_i, rez_j);
    return 0;
}

void finder(long arr[N][M], long* rez_i, long* rez_j) {
    for (long i = 0; i < N; i++) {
        for (long j = i + 1; j < N; j++) {
            int valid = 1; // флаг валидности соотношения
            double k = 0;
            int k_found = 0; // флаг того, что коэффициент k найден
            
            // Находим коэффициент k по первому ненулевому элементу
            for (long x = 0; x < M && !k_found; x++) {
                if (arr[i][x] == 0 && arr[j][x] == 0) {
                    continue; // оба нуля - пропускаем этот х
                }
                if (arr[j][x] == 0) {
                    valid = 0; // ноль во второй строке - невалидно, невыполняется условие arr[i][x] == arr[j][x] * k
                    break;
                }
                else if (arr[j][x] == 0 && arr[j][x] != 0) {
                    valid = 0; // невыполняется условие arr[i][x] == arr[j][x] * k
                    break;
                }
                k = (double) arr[i][x] / (double) arr[j][x];
                k_found = 1;
            }
            
            // Если коэффициент найден, проверяем все элементы
            if (valid && k_found) {
                for (long x = 0; x < M; x++) {
                    if (arr[i][x] == 0 && arr[j][x] == 0) {
                        continue; // оба нуля - ок
                    }
                    if (arr[i][x] == 0 || arr[j][x] == 0) {
                        valid = 0; // один ноль, другой не ноль
                        break;
                    }
                    if ((double)arr[i][x] / (double)arr[j][x] != k) {
                        valid = 0;
                        break;
                    }
                }
            }
            
            // Если соотношение выполняется для всех элементов
            if (valid && k_found) {
                *rez_i = i;
                *rez_j = j;
                return; // нашли первую пару - выходим
            }
        }
    }
    // Если не нашли ни одной пары
    *rez_i = 0;
    *rez_j = 0;
}