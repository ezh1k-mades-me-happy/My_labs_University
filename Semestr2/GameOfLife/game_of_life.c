#include <ncurses.h>  // Библиотека для создания текстового интерфейса в терминале
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define WIDTH 80
#define HEIGHT 25

/*
clang-format -i *
valgrind --tool=memcheck --leak-check=yes
cppcheck --enable=all --suppress=missingIncludeSystem
gcc -std=c11 -Wall -Werror -Wextra game_of_life.c -lncurses -o game_of_life
./game_of_life < datasets/1.txt
*/

typedef struct data{
    // unsigned char* playfieldArray;
    signed char* playfieldArray;
    int dataSize;
    int cnt;
    struct data* next;
} data;

data* head = NULL;
int colonies = 0;
int global_cycle_found = 0;
int global_period = 0;
int global_start_step = 0;
double memory = 0;

int fileInput(char playfieldArray[HEIGHT][WIDTH]);
void ncursesPreparation(void);
void renderPlayfield(const char playfieldArray[HEIGHT][WIDTH], int step, int delay, int running);
void gameProcessor(char playfieldArray[HEIGHT][WIDTH]);
int gameOfLifeRules(const char playfieldArray[HEIGHT][WIDTH], int checkY, int checkX);
int playfieldBordersCheck(int currentCoordinate, int borderCoordinate);
void userInput(int *running, int *delay, int *spaceIsPressed);
data* add(char playfieldArray[HEIGHT][WIDTH], int step);
void fill(char map[HEIGHT][WIDTH], int visited[HEIGHT][WIDTH], int y, int x);
void detectCycle(const char playfieldArray[HEIGHT][WIDTH], int current_step);
unsigned char* compress(const unsigned char playfieldArray[HEIGHT][WIDTH], int* outSize);
signed char* compress2(const unsigned char playfieldArray[HEIGHT][WIDTH], int* outSize);
void decompress(const unsigned char* compressed, int Size, unsigned char dist[HEIGHT][WIDTH]);
void decompress2(const signed char* compressed, int Size, unsigned char dist[HEIGHT][WIDTH]);
int compareC(const signed char* compressed1, int size1, const signed char* compressed2, int size2);
void freeDataList();

/*
clang-format -i *
valgrind --tool=memcheck --leak-check=yes
gcc -std=c11 -Wall -Werror -Wextra game_of_life.c -lncurses
cppcheck --enable=all --suppress=missingIncludeSystem
./a.out < datasets/1.txt
*/

int main() {
    char playfieldArray[HEIGHT][WIDTH] = {0};
    int err = fileInput(playfieldArray);

    if (!err) {
        ncursesPreparation();

        int delay = 100;
        int running = 0;
        int spaceIsPressed = 0;
        int step = 0;

        while (!spaceIsPressed) {
            userInput(&running, &delay, &spaceIsPressed);
            renderPlayfield(playfieldArray, step, delay, running);
            if (running) {
                gameProcessor(playfieldArray);
                step++;
                if (!global_cycle_found) {
                    head = add(playfieldArray, step);
                    detectCycle(playfieldArray, step);
                }
            }
            timeout(delay);
        }
        endwin();
        freeDataList();
        printf("----------\nGame Over\n----------\n");
    } else {
        printf("----------\nn/a\n----------\n");
        return 0;
    }
}

int fileInput(char playfieldArray[HEIGHT][WIDTH]) {
    int err = 0;
    for (int i = 0; i < HEIGHT && !err; i++) {
        for (int j = 0; j < WIDTH && !err; j++) {
            int val;
            if (scanf("%d", &val) != 1) {
                err++;
            } else {
                playfieldArray[i][j] = (char)val;
            }
        }
    }
    if (freopen("/dev/tty", "r", stdin) == NULL)
        err++;
    return err;
}

void userInput(int *running, int *delay, int *spaceIsPressed) {
    int key = getch();

    switch (key) {
        case 'p':
        case 'P':
            *running = !*running;
            break;
        case ' ':
            *spaceIsPressed = 1;
            break;
        case 'a':
        case 'A':
            *delay -= 10;
            if (*delay < 20) *delay = 20;
            break;
        case 'z':
        case 'Z':
            *delay += 10;
            if (*delay > 800) *delay = 800;
            break;
    }
}

void renderPlayfield(const char playfieldArray[HEIGHT][WIDTH], int step, int delay, int running) {
    clear();
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            if (playfieldArray[i][j]) {
                attron(COLOR_PAIR(1));
                mvaddch(i, j, '#');
                attroff(COLOR_PAIR(1));
            } else {
                attron(COLOR_PAIR(2));
                mvaddch(i, j, ' ');
                attroff(COLOR_PAIR(2));
            }
        }
    }
    mvprintw(HEIGHT, 0, "Step: %d | Delay: %d ms | State: %s", step, delay, running ? "RUNNING" : "PAUSED");
    mvprintw(HEIGHT + 1, 0, "Controls: P - Play/pause, Spacebar - Exit, A/Z - Change speed");
    if (memory < 1024) {
        mvprintw(HEIGHT + 2, 0, "Memory used: %d bytes", (int)memory);
    } else {
        mvprintw(HEIGHT + 2, 0, "Memory used: %.2lf KB", memory/1024);
    }
    

    if (global_cycle_found) {
        mvprintw(HEIGHT + 3, 0, "Global period = %d, started at step %d", global_period, global_start_step);
        mvprintw(HEIGHT+4, 0, "Number of colonies: %d", colonies);
    }
    refresh();
}

void ncursesPreparation(void) {
    initscr();
    cbreak();
    noecho();
    nodelay(stdscr, TRUE);
    start_color();
    curs_set(0);
    init_pair(1, COLOR_GREEN, COLOR_BLACK);
    init_pair(2, COLOR_BLACK, COLOR_BLACK);
}

void gameProcessor(char playfieldArray[HEIGHT][WIDTH]) {
    char playfieldUpdate[HEIGHT][WIDTH] = {0};

    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            playfieldUpdate[i][j] = gameOfLifeRules(playfieldArray, i, j);
        }
    }
    for (int k = 0; k < HEIGHT; k++) {
        for (int m = 0; m < WIDTH; m++) {
            playfieldArray[k][m] = playfieldUpdate[k][m];
        }
    }
}

int gameOfLifeRules(const char playfieldArray[HEIGHT][WIDTH], int checkY, int checkX) {
    int environmentCount = 0;
    int result;
    for (int y = checkY - 1; y <= checkY + 1; y++) {
        int wrapY = playfieldBordersCheck(y, HEIGHT);
        for (int x = checkX - 1; x <= checkX + 1; x++) {
            if (y == checkY && x == checkX)
                continue;
            int wrapX = playfieldBordersCheck(x, WIDTH);
            if (playfieldArray[wrapY][wrapX]) {
                environmentCount++;
            }
        }
    }
    if (playfieldArray[checkY][checkX]) {
        result = (environmentCount == 2 || environmentCount == 3) ? 1 : 0;
    } else {
        result = (environmentCount == 3) ? 1 : 0;
    }
    return result;
}

int playfieldBordersCheck(int currentCoordinate, int borderCoordinate) {
    if (currentCoordinate < 0) {
        currentCoordinate = borderCoordinate - 1;
    } else if (currentCoordinate >= borderCoordinate) {
        currentCoordinate = 0;
    }
    return currentCoordinate;
}

data* add(char playfieldArray[HEIGHT][WIDTH], int step) {
    data* node = (data*)malloc(sizeof(data));
    // node->playfieldArray = compress((const unsigned char(*)[WIDTH])playfieldArray, &node->dataSize);
    node->playfieldArray = compress2((const unsigned char(*)[WIDTH])playfieldArray, &node->dataSize);
    node->cnt = step;
    node->next = head;
    memory += sizeof(data) + node->dataSize;
    return node;
}

void fill(char map[HEIGHT][WIDTH], int visited[HEIGHT][WIDTH], int y, int x) {
    if (y < 0 || y >= HEIGHT || x < 0 || x >= WIDTH) return;
    if (!map[y][x] || visited[y][x]) return;

    visited[y][x] = 1;

    for (int dy = -1; dy <= 1; dy++){
        for (int dx = -1; dx <= 1; dx++){
            if (dy || dx) fill(map, visited, y + dy, x + dx);
        }
    }
}

void detectCycle(const char playfieldArray[HEIGHT][WIDTH], int current_step) {
    if (global_cycle_found) return;

    int currentSize;
    // unsigned char* currentCompressed = compress((const unsigned char(*)[WIDTH])playfieldArray, &currentSize);
    signed char* currentCompressed = compress2((const unsigned char(*)[WIDTH])playfieldArray, &currentSize);
    if (!currentCompressed) return;

    data* cur = head;
    int found = 0;
    int period = 0, start_step = 0;

    while (cur != NULL) {
        if (compareC(currentCompressed, currentSize, cur->playfieldArray, cur->dataSize) && (current_step != cur->cnt)) {
            period = current_step - cur->cnt;
            start_step = cur->cnt;
            found = 1;
            break;
        }
        cur = cur->next;
    }
    free(currentCompressed);

    if (!found) return;

    global_period = period;
    global_start_step = start_step;
    global_cycle_found = 1;

    data** cycle_nodes = malloc(sizeof(data*) * period);
    data* tmp = head;
    int collected = 0;
    while (tmp != NULL && collected < period) {
        if (tmp->cnt >= start_step && tmp->cnt < start_step + period) {
            cycle_nodes[tmp->cnt - start_step] = tmp;
            collected++;
        }
        tmp = tmp->next;
    }

    char union_map[HEIGHT][WIDTH] = {0};
    for (int p = 0; p < period; p++) {
        unsigned char temp[HEIGHT][WIDTH];
        // decompress(cycle_nodes[p]->playfieldArray, cycle_nodes[p]->dataSize, temp);
        decompress2(cycle_nodes[p]->playfieldArray, cycle_nodes[p]->dataSize, temp);
        for (int i = 0; i < HEIGHT; i++) {
            for (int j = 0; j < WIDTH; j++) {
                if (temp[i][j]) union_map[i][j] = 1;
            }
        }
    }
    free(cycle_nodes);

    int visited[HEIGHT][WIDTH] = {0};
    colonies = 0;
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            if (union_map[i][j] && !visited[i][j]) {
                colonies++;
                fill(union_map, visited, i, j);
            }
        }
    }
}

unsigned char* compress(const unsigned char playfieldArray[HEIGHT][WIDTH], int* outSize) {
    unsigned char* result = (unsigned char*)malloc(HEIGHT * WIDTH * 2 * sizeof(char));
    int residx = 0;
    unsigned char currentNum = playfieldArray[0][0];
    unsigned char cnt = 1;

    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            if (i == 0 && j == 0) continue;
            if ((playfieldArray[i][j] == currentNum) && (cnt < 255)) {
                cnt++;
            }
            else {
                result[residx++] = cnt;
                result[residx++] = currentNum;

                currentNum = playfieldArray[i][j];
                cnt = 1;
            }
        }
    }

    result[residx++] = cnt;
    result[residx++] = currentNum;

    result = realloc(result, residx * sizeof(char));
    *outSize = residx;
    return result;
}

signed char* compress2(const unsigned char playfieldArray[HEIGHT][WIDTH], int* outSize) {
    signed char* result = (signed char*)malloc(HEIGHT * WIDTH * 2 * sizeof(char));
    int residx = 0;
    unsigned char currentNum = playfieldArray[0][0];
    signed char cnt = 1;

    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            if (i == 0 && j == 0) continue;
            if ((playfieldArray[i][j] == currentNum) && (cnt < 127)) {
                cnt++;
            }
            else {
                if (currentNum) {
                    result[residx++] = cnt*(-1);
                }else {
                    result[residx++] = cnt;
                }
                currentNum = playfieldArray[i][j];
                cnt = 1;
            }
        }
    }
    if (currentNum) {
        result[residx++] = cnt*(-1);
    }else {
        result[residx++] = cnt;
    }
    result = realloc(result, residx * sizeof(char));
    *outSize = residx;
    return result;
}



void decompress(const unsigned char* compressed, int Size, unsigned char dist[HEIGHT][WIDTH]) {
    int ind = 0;
    int cell = 0;

    while (ind < Size && cell < HEIGHT * WIDTH) {
        unsigned char cnt = compressed[ind++];
        unsigned char num = compressed[ind++];

        for (int i = 0; i < cnt && cell < HEIGHT * WIDTH; i++) {
            int row = cell / WIDTH;
            int col = cell % WIDTH;
            dist[row][col] = (unsigned char)num;
            cell++;
        }
    }
}

void decompress2(const signed char* compressed, int Size, unsigned char dist[HEIGHT][WIDTH]) {
    int ind = 0;
    int cell = 0;

    while (ind < Size && cell < HEIGHT * WIDTH) {
        signed char data = compressed[ind++];
        unsigned char cnt = -1;
        unsigned char num = -1;
        if (data < 0) {
            num = 1;
            cnt = (unsigned char)(-data);
        }else {
            num = 0;
            cnt = (unsigned char)data;
        }

        for (int i = 0; i < cnt && cell < HEIGHT * WIDTH; i++) {
            int row = cell / WIDTH;
            int col = cell % WIDTH;
            dist[row][col] = num;
            cell++;
        }
    }
}

int compareC(const signed char* compressed1, int size1, const signed char* compressed2, int size2) {
    if (size1 != size2) return 0;
    return memcmp(compressed1, compressed2, size1) == 0;
}

void freeDataList() {
    data* cur = head;
    while (cur) {
        data* next = cur->next;
        free(cur->playfieldArray);
        free(cur);
        cur = next;
    }
}