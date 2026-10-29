#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>


#define N 4 // Размер поля
#define MAX_MOVES 50 // Максимальное количество ходов
#define HASH_SIZE 1000003  // Простое число для размера хэш-таблицы


// Структура для хранения состояния
typedef struct {
    int board[N][N];
    int zero_x[2];    // координаты пустых клеток (x - столбец)
    int zero_y[2];    // координаты пустых клеток (y - строка)
    int f;            // Манхеттенское расстояние
} State;

void input_board(int board[N][N]);
void print_board(int board[N][N]);
int find_solution(int initial_board[N][N]);
int is_correct_input(int board[N][N]);
State create_state(int board[N][N]);
void add_start_state(State start);
void generate_moves(State state, int index_move);
int calculate_possible_moves(State state, State* moves);
void copy_board(int dst[N][N], const int src[N][N]);
void qSort(int l, int r, State* A);
unsigned long long hash_state(int board[N][N]);
int find_zeros(int board[N][N], int zero_x[2], int zero_y[2]);
int manhattan_distance(int board[N][N]);
int is_goal(int board[N][N]);
int is_duplicate(int board[N][N], unsigned long long* hash_table, int index_move);
void print_solution(int index_move, int goal_index);
void print_step(int step, int prev[N][N], int curr[N][N]);

// Глобальные переменные
unsigned long long hash_table[HASH_SIZE] = {0};
int hash_table_indexes_moves[HASH_SIZE];
State visited_states[MAX_MOVES + 1];
int win = 0;

// Целевое состояние
int goal[N][N] = {
    {1, 2, 3, 4},
    {5, 6, 7, 8},
    {9, 10, 11, 12},
    {13, 14, 0, 0}
};

int main() {
    int initial_board[N][N];
    input_board(initial_board); // Ввод начального положения чисел
    printf("\nInitial board:\n");
    print_board(initial_board); // Вывод введенной доски

    if (is_correct_input(initial_board)) {
        printf("\nSearching for solves...\n");
        find_solution(initial_board); // Ищем решение, если ввод верный
    }else {
        printf("Incorrect input!");
    }

    return 0;
}

// Ввод начальной доски
void input_board(int board[N][N]) {
    printf("\nEnter initial board (4x4, 0 - void):\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            scanf("%d", &board[i][j]);
        }
    }
}

// Вывод доски
void print_board(int board[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (board[i][j] == 0)
                printf("   ");
            else if (board[i][j] < 10)
                printf("%d  ", board[i][j]);
            else
                printf("%d ", board[i][j]);
        }
        printf("\n");
    }
}

// Поиск решения
int find_solution(int initial_board[N][N]) {
    State start = create_state(initial_board); // Создаем начальное состояние
    add_start_state(start); // Добавление начальное состояние в хэш-таблицу и список посещённых
    generate_moves(start, 0);
    return 0;
}

// Проверка ввода
int is_correct_input(int board[N][N]) {
    int counter[15] = {0}; // счетчик для чисел 0-14
    // По индексу каждого числа ставим 1
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (board[i][j] > 14 || board[i][j] < 0) return 0; // Число вне нужного диапазона
            counter[board[i][j]] += 1;
        }
    }

    if (counter[0] != 2) return 0; // проверяем, что нуля 2

    // Проверяем, что числа 1-14 встречаются ровно по одному разу
    for (int i = 1; i <= 14; i++) {
        if (counter[i] != 1) return 0;
    }

    return 1; // все условия выполнены
}

// Создать начальное состояние
State create_state(int board[N][N]) {
    State state;
    copy_board(state.board, board); // Копируем доску
    find_zeros(state.board, state.zero_x, state.zero_y); // НАХОДИМ ПУСТЫЕ КЛЕТКИ В СОХРАНЕННОЙ ДОСКЕ!
    state.f = manhattan_distance(state.board); // Вычисляем манхеттенское расстояние
    return state;
}

// Добавление в хэш-таблицу и список посещённых
void add_start_state(State start) {
    // По индексу (равному хэшу текущего состояния) задаем значение true (хэш есть), по умолчанию значения 0 (false)
    hash_table[hash_state(start.board)%HASH_SIZE] = hash_state(start.board);
    visited_states[0] = start; // Добавляем начальное состояние в массив посещённых
}

// Сгенерировать новые состояния из текущего
void generate_moves(State state, int index_move) {
    if (win) return;
    if (is_goal(state.board)) {
        win = 1;
        print_solution(index_move, win); // Передаем пройденные состояния и индекс максимального
        return;
    }

    State moves[8]; // Возможные ходы (создаём массив ходов)
    // Вычисляем возможные ходы, сортируем, сохраняем их количество
    int cnt_moves = calculate_possible_moves(state, moves);
    index_move++; // индекс хода в последовательности решения

    for (int i = 0; i < cnt_moves; i++) {
        // Переходим к следующему ходу, если состояния совпадают или превышено максимальное количество ходов
        if (index_move >= MAX_MOVES || is_duplicate(moves[i].board, hash_table, index_move)) continue;
        visited_states[index_move] = moves[i]; // добавляем в посещённые
        generate_moves(visited_states[index_move], index_move);
    }

    if (index_move == 1 && !win) {
        print_solution(index_move, win);
    }
}

// Вычисление возможных ходов для ноля
int calculate_possible_moves(State state, State moves[8]) {
    int cnt_moves = 0;
    int dx[4] = {-1, 0, 1, 0};
    int dy[4] = {0, 1, 0, -1};
    // Какие ходы есть
    for (int z = 1; z >= 0; z--) {
        int empty_x = state.zero_x[z];
        int empty_y = state.zero_y[z];
        for (int d = 0; d < 4; d++) {
            int nx = empty_x + dx[d];
            int ny = empty_y + dy[d];
            // Проверяем, что не выходим за пределы доски и что не обмениваем ноль с нулём
            if (nx >= 0 && nx < N && ny >= 0 && ny < N && state.board[ny][nx] != 0) {
                int new_board[N][N]; // Создаем новую доску
                copy_board(new_board, state.board); // заполняем новую доску из доски состояния
                // Передвигаем ноль
                new_board[empty_y][empty_x] = new_board[ny][nx];
                new_board[ny][nx] = 0;
                // Добавляем новое состояние
                moves[cnt_moves] = create_state(new_board);
                cnt_moves++;
            }
        }
    }
    qSort(0, cnt_moves-1, moves); // Сортируем по Манхеттенскому расстоянию
    return cnt_moves;
}

// Копирование доски
void copy_board(int dst[N][N], const int src[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            dst[i][j] = src[i][j];
        }
    }
    /* ИЛИ
    memcpy(dst, src, sizeof(int) * N * N);
     */
}

// Сортируем массив состояний по эвристикам
void qSort(int l, int r, State* A) {
    int i = l, j = r;
    State temp;
    int x = A[(l + r) / 2].f;
    do {
        while (A[i].f < x) {
            i++;
        }
        while (A[j].f > x) {
            j--;
        }
        if (i <= j) {
            if (i != j && A[i].f != A[j].f) {
                temp = A[i];
                A[i] = A[j];
                A[j] = temp;
            }
            i++; j--;
        }
    } while (i <= j);
    if (j > l) qSort(l, j, A);
    if (i < r) qSort(i, r, A);
}

// Функция для создания хэша состояния
unsigned long long hash_state(int board[N][N]) {
    unsigned long long hash = 0;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            hash = hash * 31 + board[i][j];
        }
    }
    return hash;
} // max hash = 15037917882917351417

// Найти пустые клетки
int find_zeros(int board[N][N], int zero_x[2], int zero_y[2]) {
    int count = 0;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (board[i][j] == 0) {
                zero_y[count] = i;
                zero_x[count] = j;
                count++;
                if (count == 2) return count;
            }
        }
    }
    return count;
}

// Манхеттенское расстояние
int manhattan_distance(int board[N][N]) {
    int distance = 0;
    // Создаем карту целевых позиций для чисел 1-14
    // Для двух пустых клеток (0) - они в целевых позициях (3,2) и (3,3)
    int target_x[16], target_y[16];

    // Инициализируем -1 (не найдено)
    for (int i = 0; i < 16; i++) target_x[i] = target_y[i] = -1;

    // Заполняем из целевого состояния
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            int val = goal[i][j];
            if (val >= 0 && val < 16) {
                target_x[val] = i;
                target_y[val] = j;
            }
        }
    }

    int cnt_0 = 0;
    int summ1 = 0, summ2 = 0;
    // Для ВСЕХ клеток считаем расстояние
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            int val = board[i][j];
            if (val == 0) cnt_0++;
            // Если это не пустая клетка И она должна быть где-то в цели
            if (val != 0 && target_x[val] != -1) {
                distance += (abs(i - target_x[val]) + abs(j - target_y[val])); // Можно х2 чтобы влияло в большей степени, чем 0
            }
            else if (val == 0 && cnt_0 == 1) {
                summ1 += abs(i - target_x[val] + 1) + abs(j - target_y[val]); 
                summ2 += abs(i - target_x[val]) + abs(j - target_y[val]);
            }
            else if (val == 0 && cnt_0 == 2) {
                summ1 += abs(i - target_x[val]) + abs(j - target_y[val]); 
                summ2 += abs(i - target_x[val] + 1) + abs(j - target_y[val]);
            }
        }
    }

    (summ1 < summ2) ? (distance += summ1) : (distance += summ2);

    return distance;
}

// Проверка на целевое состояние
int is_goal(int board[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (board[i][j] != goal[i][j]) {
                return 0;
            }
        }
    }
    return 1;
}

// Проверка на разность хэшей
int is_duplicate(int board[N][N], unsigned long long* hash_table, int index_move) {
    unsigned long long hash = hash_state(board); // Вычисляем хэш для доски
    // Если мы были в этом состоянии и дошли до него за большее или такое же количество ходов, что и в наилучший раз - это дубликат
    if (hash_table[hash%HASH_SIZE] == hash && hash_table_indexes_moves[hash%HASH_SIZE] <= index_move) return 1;
    //Добавляем состояние в хэш-таблицу
    hash_table[hash%HASH_SIZE] = hash;
    hash_table_indexes_moves[hash%HASH_SIZE] = index_move;
    return 0;
}

// Вывод решения
void print_solution(int index_move, int goal_index) {
    if (!goal_index) {
        printf("\nNo solves found!\n");
        return;
    }

    // Выводим решение
    printf("\nSolve found! Total steps: %d\n", index_move);
    for (int i = 1; i <= index_move; i++) print_step(i, visited_states[i-1].board, visited_states[i].board);

    printf("Final board:\n");
    print_board(visited_states[index_move].board);
}

// Вывод шага
void print_step(int step, int prev[N][N], int curr[N][N]) {
    printf("Step %d:\n", step);
    printf("Before:         After:\n");

    for (int i = 0; i < N; i++) {
        // Левая часть - до хода
        for (int j = 0; j < N; j++) {
            if (prev[i][j] == 0)
                printf("   ");
            else if (prev[i][j] < 10)
                printf("%d  ", prev[i][j]);
            else
                printf("%d ", prev[i][j]);
        }

        printf("    ");

        // Правая часть - после хода
        for (int j = 0; j < N; j++) {
            if (curr[i][j] == 0)
                printf("   ");
            else if (curr[i][j] < 10)
                printf("%d  ", curr[i][j]);
            else
                printf("%d ", curr[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}