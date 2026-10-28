#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <limits.h>
#include <stdint.h>
#include <time.h>

#define N 4 // Размер поля
#ifndef MAX_MOVES
#define MAX_MOVES 100
#endif
#ifndef Table_BITS
#define Table_BITS 16 // 1 МиБ при размере записи 16 байт.
#endif
#if Table_BITS < 0 || Table_BITS > 24
#error Table_BITS must be between 0 and 24
#endif
#if MAX_MOVES < 1 || MAX_MOVES > 255
#error MAX_MOVES must be between 1 and 255
#endif

/*
1 2 3 4 5 6 7 8 9 10 0 12 13 14 11 0    1 step
1 2 3 0 5 6 8 4 9 10 7 12 13 14 11 0    4 steps
1 2 3 4 9 10 11 12 5 6 7 8 13 14 0 0    22 steps
0 0 14 13 12 11 10 9 8 7 6 5 4 3 2 1    many steps
*/

// Одна изменяемая доска; в списке детей хранятся только описания ходов.
typedef struct {
    uint8_t board[N * N];
    uint8_t zero[2];
    uint16_t rows[N], cols[N]; // Коды строк и столбцов в системе счисления по основанию 5.
    int h;
    uint64_t key;
} State;

typedef struct {
    uint8_t from, to;
    int h;
} Move;

unsigned char dist[15][N * N];
uint16_t row_value[15][N * N], col_value[15][N * N];
unsigned char line_penalty[625]; // 5^4 вариантов строки: 0 — посторонняя фишка.
int tables_ready;
unsigned char neighbors[N * N][4];
unsigned char neighbor_count[N * N];
uint64_t path_keys[MAX_MOVES + 1];
uint64_t goal_key;
uint8_t solution_moves[MAX_MOVES]; // from и to занимают по четыре бита.
int solution_depth = -1;

// Ограниченный кэш: совпадение индекса не означает совпадение досок.
#define Table_SIZE (1u << Table_BITS)

typedef struct {
    uint64_t key;
    uint32_t generation;
    int depth;
} Transposition;

Transposition transpositions[Table_SIZE];
uint32_t generation;

// Метка прохода логически очищает кэш без обнуления всего массива.
void next_iteration(void) {
    if (++generation == 0) {
        memset(transpositions, 0, sizeof(transpositions));
        generation = 1;
    }
}

size_t table_index(uint64_t key) {
    key ^= key >> 30;
    key *= UINT64_C(0xbf58476d1ce4e5b9);
    key ^= key >> 27;
    key *= UINT64_C(0x94d049bb133111eb);
    key ^= key >> 31;
    return (size_t)key & (Table_SIZE - 1);
}

int seen_at_better_depth(uint64_t key, int depth) {
    Transposition *entry = &transpositions[table_index(key)];
    if (entry->generation == generation && entry->key == key && entry->depth <= depth) return 1;
    entry->generation = generation;
    entry->key = key; // Коллизия лишь вытесняет старую запись.
    entry->depth = depth;
    return 0;
}

int read_token(char *token, size_t capacity) {
    int c;
    size_t used = 0;
    int invalid_token = 0;
    do { c = getchar(); } while (c != EOF && isspace((unsigned char)c));
    if (c == EOF) return 0;
    do {
        if (used + 1 < capacity) token[used++] = (char)c;
        else invalid_token = 1;
        if (c == '\0') invalid_token = 1;
        c = getchar();
    } while (c != EOF && !isspace((unsigned char)c));
    token[used] = '\0';
    return invalid_token ? -1 : 1;
}

int input_board(int board[N][N]) {
    for (int p = 0; p < N * N; ++p) {
        char token[64], *end;
        if (read_token(token, sizeof(token)) != 1) return 0;
        errno = 0;
        long value = strtol(token, &end, 10);
        if (errno == ERANGE || end == token || *end != '\0' || value < 0 || value > 14)
            return 0;
        board[p / N][p % N] = (int)value;
    }
    return 1;
}

void print_board(int board[N][N]) {
    for (int row = 0; row < N; ++row) {
        for (int col = 0; col < N; ++col) {
            if (board[row][col] == 0)
                printf("   ");
            else if (board[row][col] < 10)
                printf("%d  ", board[row][col]);
            else
                printf("%d ", board[row][col]);
        }
        putchar('\n');
    }
}

int is_correct_input(int board[N][N]) {
    int counter[15] = {0}; // счетчик для чисел 0-14
    // Подсчитываем, сколько раз встречается каждое значение.
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

// Линейный конфликт: 2 * (число фишек в своей линии - длина LIS).
// Таблица строится один раз; при поиске LIS больше не вычисляется.
void init_conflicts(void) {
    for (int code = 0; code < 625; ++code) {
        int digits[4], lengths[4] = {0}, count = 0, best = 0;
        int remaining = code;
        for (int p = 0; p < N; ++p) {
            digits[p] = remaining % 5;
            remaining /= 5;
            if (!digits[p]) continue;
            ++count;
            lengths[p] = 1;
            for (int q = 0; q < p; ++q)
                if (digits[q] && digits[q] < digits[p] && lengths[q] + 1 > lengths[p])
                    lengths[p] = lengths[q] + 1;
            if (lengths[p] > best) best = lengths[p];
        }
        line_penalty[code] = (unsigned char)(2 * (count - best));
    }
}

void init_tables(void) {
    if (tables_ready) return;
    init_conflicts();
    const int weight[N] = {1, 5, 25, 125};
    goal_key = 0;
    int dx[4] = {-1, 0, 1, 0};
    int dy[4] = {0, 1, 0, -1};
    for (int p = 0; p < N * N; ++p) {
        int row = p / N, col = p % N;
        if (p < 14) goal_key |= (uint64_t)(p + 1) << (4 * p);
        dist[0][p] = 0;
        for (int tile = 1; tile <= 14; ++tile) {
            dist[tile][p] = (unsigned char)(abs(row - (tile - 1) / N)
                                         + abs(col - (tile - 1) % N));
            int goal_row = (tile - 1) / N, goal_col = (tile - 1) % N;
            row_value[tile][p] = (uint16_t)(row == goal_row ? (goal_col + 1) * weight[col] : 0);
            col_value[tile][p] = (uint16_t)(col == goal_col ? (goal_row + 1) * weight[row] : 0);
        }
        neighbor_count[p] = 0;
        for (int d = 0; d < 4; ++d) {
            int next_row = row + dy[d], next_col = col + dx[d];
            if (next_row >= 0 && next_row < N && next_col >= 0 && next_col < N)
                neighbors[p][neighbor_count[p]++] = (unsigned char)(next_row * N + next_col);
        }
    }
    tables_ready = 1;
}

State create_state(int initial_board[N][N]) {
    State state = {0};
    int zeros = 0;
    for (int p = 0; p < N * N; ++p) {
        int tile = initial_board[p / N][p % N];
        state.board[p] = (uint8_t)tile;
        state.key |= (uint64_t)tile << (4 * p);
        state.h += dist[tile][p];
        state.rows[p / N] += row_value[tile][p];
        state.cols[p % N] += col_value[tile][p];
        if (tile == 0) state.zero[zeros++] = (uint8_t)p;
    }
    for (int line = 0; line < N; ++line)
        state.h += line_penalty[state.rows[line]] + line_penalty[state.cols[line]];
    return state;
}

// Ход вдоль линии не меняет порядок её фишек. Конфликт может измениться
// только при выходе из своей строки/колонки или при возвращении в неё.
int conflict_delta(const State *state, int tile, int from, int to) {
    if (from / N != to / N) {
        int a = from / N, b = to / N;
        return line_penalty[state->rows[a] - row_value[tile][from]]
             + line_penalty[state->rows[b] + row_value[tile][to]]
             - line_penalty[state->rows[a]] - line_penalty[state->rows[b]];
    }
    int a = from % N, b = to % N;
    return line_penalty[state->cols[a] - col_value[tile][from]]
         + line_penalty[state->cols[b] + col_value[tile][to]]
         - line_penalty[state->cols[a]] - line_penalty[state->cols[b]];
}

// Сортировка вставками: максимум восемь коротких описаний ходов.
// Равные h сохраняют порядок генерации.
void sort_moves(Move moves[8], int count) {
    for (int i = 1; i < count; ++i) {
        Move move = moves[i];
        int j = i;
        while (j > 0 && moves[j - 1].h > move.h) {
            moves[j] = moves[j - 1];
            --j;
        }
        moves[j] = move;
    }
}

int calculate_possible_moves(const State *state, Move moves[8], int depth, int bound, int last_from, int last_to, int *next_bound) {
    int count = 0;
    for (int z = 1; z >= 0; --z) {
        int to = state->zero[z];
        for (int d = 0; d < neighbor_count[to]; ++d) {
            int from = neighbors[to][d];
            int tile = state->board[from];
            if (tile == 0 || (from == last_to && to == last_from)) continue;
            int next_h = state->h - dist[tile][from] + dist[tile][to] + conflict_delta(state, tile, from, to);
            int estimate = depth + 1 + next_h;
            if (estimate > bound) {
                if (estimate < *next_bound) *next_bound = estimate;
                continue;
            }
            moves[count].from = (uint8_t)from;
            moves[count].to = (uint8_t)to;
            moves[count].h = next_h;
            ++count;
        }
    }
    sort_moves(moves, count);
    return count;
}

// Обратный Move восстанавливает доску, нули и h той же функцией.
void apply_move(State *state, Move move) {
    int tile = state->board[move.from];
    int z = state->zero[0] == move.to ? 0 : 1;
    state->key ^= ((uint64_t)tile << (4 * move.from))
                | ((uint64_t)tile << (4 * move.to));
    state->rows[move.from / N] -= row_value[tile][move.from];
    state->rows[move.to / N] += row_value[tile][move.to];
    state->cols[move.from % N] -= col_value[tile][move.from];
    state->cols[move.to % N] += col_value[tile][move.to];
    state->board[move.to] = (uint8_t)tile;
    state->board[move.from] = 0;
    state->zero[z] = move.from;
    if (state->zero[0] > state->zero[1]) {
        uint8_t temporary = state->zero[0];
        state->zero[0] = state->zero[1];
        state->zero[1] = temporary;
    }
    state->h = move.h;
}

int is_goal(const State *state) {
    return state->key == goal_key;
}

int is_on_path(const State *state, int last_step) {
    for (int step = 0; step <= last_step; ++step)
        if (state->key == path_keys[step]) return 1;
    return 0;
}

int search_iteration(State *state, int depth, int bound, int last_from, int last_to) {
    int estimate = depth + state->h;
    if (estimate > bound) return estimate;
    if (is_goal(state)){
        solution_depth = depth;
        return 0;
    }
    if (depth >= MAX_MOVES) return INT_MAX;
    // Чётность g+h постоянна: Manhattean меняется на 1, конфликты — на чётное число.
    // Следующий возможный порог — bound+2; повтор не должен перескочить его.
    if (seen_at_better_depth(state->key, depth)) return bound + 2;

    Move moves[8];
    int next_bound = INT_MAX;
    int count = calculate_possible_moves(state, moves, depth, bound, last_from, last_to, &next_bound);
    int previous_h = state->h;
    for (int i = 0; i < count; ++i) {
        Move move = moves[i];
        Move undo = {move.to, move.from, previous_h};
        apply_move(state, move);
        if (is_on_path(state, depth)) { apply_move(state, undo); continue; }
        path_keys[depth + 1] = state->key;
        solution_moves[depth] = (uint8_t)((move.from << 4) | move.to);
        int result = search_iteration(state, depth + 1, bound, move.from, move.to);
        apply_move(state, undo); // Откат выполняется и при успехе.
        if (solution_depth >= 0) return 0;
        if (result < next_bound) next_bound = result;
    }
    return next_bound;
}

// Длина кратчайшего пути; -1 — не найден в пределах MAX_MOVES, -2 — неверный ввод.
int find_solution(int initial_board[N][N]) {
    solution_depth = -1;
    if (!is_correct_input(initial_board)) return -2;
    init_tables();
    State state = create_state(initial_board);
    path_keys[0] = state.key;
    int bound = state.h;
    while (bound <= MAX_MOVES) {
        next_iteration();
        int next_bound = search_iteration(&state, 0, bound, -1, -1);
        if (solution_depth >= 0) return solution_depth;
        if (next_bound == INT_MAX) break;
        bound = next_bound;
    }
    return -1;
}

// Восстанавливаем доски только для печати, по сохранённым ходам.
void print_solution(int initial_board[N][N], int length) {
    int board[N][N];
    memcpy(board, initial_board, sizeof(board));
    for (int step = 0; step <= length; ++step) {
        printf("Step %d:\n", step);
        print_board(board);
        if (step < length) {
            int from = solution_moves[step] >> 4, to = solution_moves[step] & 15;
            board[to / N][to % N] = board[from / N][from % N];
            board[from / N][from % N] = 0;
        }
    }
}

int main(void) {
    int initial_board[N][N] = {{0}};
    puts("Enter a 4x4 board (0 is an empty cell):");
    while (!input_board(initial_board)) {
        puts("Incorrect input: use 1..14 once and 0 twice with spaces.");
        if (feof(stdin) || ferror(stdin)) return 2;
    }
    puts("Working...");

    clock_t start = clock();
    int length = find_solution(initial_board);
    clock_t end = clock();
    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    if (length == -2) {
        puts("Incorrect input: use 1..14 once and 0 twice.");
        return 2;
    }
    if (length < 0) {
        printf("No solution found within %d moves.\n", MAX_MOVES);
        return 1;
    }

    printf("Solution length: %d\n", length);
    print_solution(initial_board, length);
    printf("Moves: %d, search time: %.3f s\n", length, elapsed);
    return 0;
}
