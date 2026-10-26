#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>

#define N 4
#define CELLS 16
#define MAX_DEPTH 255
#define Table_BITS 22
#define Table_SIZE (1u << Table_BITS)
#define INF 1000000
#define FOUND (-1)


int dist[15][CELLS]; // dist[фишка][клетка] - манхэттенское расстояние до цели
int nb[CELLS][4];    // соседи клетки (-1, если за краем поля)

typedef struct {
    uint64_t key;  // состояние: 16 клеток по 4 бита
    uint32_t iter; // номер итерации, в которой запись сделана
    uint8_t  g;    // наименьшее g, с которым состояние встретилось на этой итерации
} State;

State* array;
uint8_t  board[CELLS];
uint64_t key;
uint8_t  path[MAX_DEPTH];
int bound, solution_len;
uint32_t iter;
unsigned long long nodes, total_nodes;

// Инициализация таблиц
void init_tables() {
    for (int i = 1; i <= 14; i++) {
        int gr = (i - 1) / N;
        int gc = (i - 1) % N;
        for (int c = 0; c < CELLS; c++) dist[i][c] = abs(c / N - gr) + abs(c % N - gc);
    }

    const int dr[4] = {-1, 0, 1, 0};
    const int dc[4] = {0, 1, 0, -1};

    for (int i = 0; i < CELLS; i++) {
        for (int d = 0; d < 4; d++) {
            int r = i / N + dr[d];
            int c = i % N + dc[d];
            nb[i][d] = (r >= 0 && r < N && c >= 0 && c < N) ? r * N + c : -1;
        }
    }
}

//Эвристики
// Длина наибольшей возрастающей подпоследовательности (k <= 4)
int lis(const int* a, int k) {
    int d[4], best = 0;
    for (int i = 0; i < k; i++) {
        d[i] = 1;
        for (int j = 0; j < i; j++)
            if (a[j] < a[i] && d[j] + 1 > d[i]) d[i] = d[j] + 1;
        if (d[i] > best) best = d[i];
    }
    return best;
}

// Linear conflict строки r: фишки, стоящие в своей строке, но в неверном порядке.
// Минимум (k - LIS) фишек должны покинуть строку и вернуться: +2 хода каждая.
int row_conflict(int r) {
    int seq[4], k = 0;
    for (int c = 0; c < N; c++) {
        int t = board[r * N + c];
        if (t && (t - 1) / N == r) seq[k++] = (t - 1) % N;
    }
    return 2 * (k - lis(seq, k));
}

int col_conflict(int c) {
    int seq[4], k = 0;
    for (int r = 0; r < N; r++) {
        int t = board[r * N + c];
        if (t && (t - 1) % N == c) seq[k++] = (t - 1) / N;
    }
    return 2 * (k - lis(seq, k));
}

// Полный пересчёт h
int full_heuristic() {
    int h = 0;
    for (int c = 0; c < CELLS; c++) if (board[c]) h += dist[board[c]][c];
    for (int i = 0; i < N; i++) h += row_conflict(i) + col_conflict(i);
    return h;
}

// Конфликты только в тех линиях, которых касается ход from->to
int local_lc(int from, int to) {
    int rf = from / N, rt = to / N, cf = from % N, ct = to % N;
    int s = row_conflict(rf) + col_conflict(cf);

    if (rt != rf) s += row_conflict(rt);
    if (ct != cf) s += col_conflict(ct);
    return s;
}

// Ходы
// Применяем ход
int apply_move(int from, int to) {
    int t = board[from];
    int old_lc = local_lc(from, to);

    board[to] = (uint8_t)t;
    board[from] = 0;

    key ^= ((uint64_t)t << (4 * from)) ^ ((uint64_t)t << (4 * to));
    return dist[t][to] - dist[t][from] + local_lc(from, to) - old_lc;
}

// Отменяем ход
void undo_move(int from, int to) {
    int t = board[to];
    board[from] = (uint8_t)t;
    board[to] = 0;
    key ^= ((uint64_t)t << (4 * from)) ^ ((uint64_t)t << (4 * to));
}

// Поиск
// Возвращает FOUND, либо минимальное f среди обрезанных узлов (новый порог)
int search(int g, int h, int last_from, int last_to) {
    int f = g + h;
    if (f > bound) return f;
    if (h == 0) {
        solution_len = g;
        return FOUND;
    }
    if (g >= MAX_DEPTH) return INF;
    nodes++;

    // Таблица вариантов. Если это состояние уже было на этой итерации с g не хуже, то обрезаем
    State* elem = &array[(uint32_t)((key * 0x9E3779B97F4A7C15ULL) >> (64 - Table_BITS))];
    if (elem->key == key && elem->iter == iter && elem->g <= g) return INF;
    elem->key = key;
    elem->iter = iter;
    elem->g = (uint8_t)g;

    int zeros[2], zc = 0;
    for (int c = 0; c < CELLS && zc < 2; c++)
        if (board[c] == 0) zeros[zc++] = c;

    int min_over = INF;
    // Проход 0: ходы, приближающие фишку к цели; проход 1: остальные
    for (int pass = 0; pass < 2; pass++) {
        for (int zi = 0; zi < 2; zi++) {
            int z = zeros[zi];
            for (int d = 0; d < 4; d++) {
                int n = nb[z][d];
                if (n < 0 || board[n] == 0) continue; // край поля или обмен нуля с нулём
                int t = board[n];
                int closer = dist[t][z] < dist[t][n];
                if (closer != (pass == 0)) continue;
                if (n == last_to && z == last_from) continue; // обратный ход бесполезен

                int dh = apply_move(n, z);
                path[g] = (uint8_t)((n << 4) | z);
                int r = search(g + 1, h + dh, n, z);
                undo_move(n, z);

                if (r == FOUND) return FOUND;
                if (r < min_over) min_over = r;
            }
        }
    }
    return min_over;
}

// Основной цикл IDA*. Возвращает длину кратчайшего решения или -1
int IDA() {
    int h0 = full_heuristic(); // начаольный порог
    bound = h0; // граница
    iter = 0;
    total_nodes = 0;
    while (1) {
        iter++;
        nodes = 0;
        clock_t t0 = clock();
        int t = search(0, h0, -1, -1);
        total_nodes += nodes;
        printf("bound = %2d  nodes = %llu  time = %.2f s\n", bound, nodes, (double)(clock() - t0) / CLOCKS_PER_SEC);

        if (t == FOUND) return solution_len;
        if (t >= INF)   return -1;

        bound = t;   // следующий порог = минимальное f среди обрезанных
    }
}

int is_correct_input(const int* b) {
    int counter[15] = {0};
    for (int i = 0; i < CELLS; i++) {
        if (b[i] < 0 || b[i] > 14) return 0;
        counter[b[i]]++;
    }
    if (counter[0] != 2) return 0;
    for (int i = 1; i <= 14; i++)
        if (counter[i] != 1) return 0;
    return 1;
}

int input_board(int* b) {
    printf("\nEnter initial board (4x4, 0 - void):\n");
    for (int i = 0; i < CELLS; i++)
        if (scanf("%d", &b[i]) != 1) return 0;
    return 1;
}

void print_cell(int v) {
    if (v == 0) printf("   ");
    else if (v < 10) printf("%d  ", v);
    else printf("%d ", v);
}

void print_board(const uint8_t* b) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) print_cell(b[i * N + j]);
        printf("\n");
    }
}

void print_step(int step, const uint8_t* prev, const uint8_t* curr) {
    printf("Step %d:\n", step);
    printf("Before:         After:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) print_cell(prev[i * N + j]);
        printf("    ");
        for (int j = 0; j < N; j++) print_cell(curr[i * N + j]);
        printf("\n");
    }
    printf("\n");
}

void print_solution(const uint8_t* start, int len) {
    printf("\nSolve found! Total steps: %d\n", len);
    uint8_t prev[CELLS], cur[CELLS];
    memcpy(cur, start, CELLS);
    for (int i = 0; i < len; i++) {
        memcpy(prev, cur, CELLS);
        int from = path[i] >> 4, to = path[i] & 15;
        cur[to] = cur[from];
        cur[from] = 0;
        print_step(i + 1, prev, cur);
    }
    printf("Final board:\n");
    print_board(cur);

    printf("\nMoves (tile: row,col -> row,col):\n");
    memcpy(cur, start, CELLS);
    for (int i = 0; i < len; i++) {
        int from = path[i] >> 4, to = path[i] & 15;
        printf("%2d. tile %2d: (%d,%d) -> (%d,%d)\n", i + 1, cur[from],
               from / N + 1, from % N + 1, to / N + 1, to % N + 1);
        cur[to] = cur[from];
        cur[from] = 0;
    }
}

int main() {
    int in[CELLS];
    if (!input_board(in) || !is_correct_input(in)) {
        printf("Incorrect input!\n");
        return 1;
    }

    uint8_t start[CELLS];
    key = 0;
    for (int i = 0; i < CELLS; i++) {
        start[i] = board[i] = (uint8_t)in[i];
        key |= (uint64_t)in[i] << (4 * i);
    }

    printf("\nInitial board:\n");
    print_board(start);

    array = (State*)calloc(Table_SIZE, sizeof(State));
    if (!array) {
        printf("Not enough memory for state table!\n");
        return 1;
    }
    init_tables();

    printf("\nSearching\n");
    clock_t t0 = clock();
    int len = IDA();
    double sec = (double)(clock() - t0) / CLOCKS_PER_SEC;

    if (len < 0) printf("\nNo solves found!\n");
    else print_solution(start, len);
    printf("\nTotal nodes: %llu, time: %.2f s\n", total_nodes, sec);

    free(array);
    return 0;
}


//
// Created by vikto on 26.10.2026.
//
