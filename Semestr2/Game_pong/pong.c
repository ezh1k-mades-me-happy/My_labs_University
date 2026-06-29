#include <stdio.h>

void drawing_pool(int w, int h, int ro1, int ro2, int ball_x, int ball_y);
int next_hod_x(int w, int ro1, int ro2, int ball_hod_x, int ball_x, int ball_y);
int next_hod_y(int y, int ball_hod_y, int ball_y, int pool_start);
int next_ro1(int ro1, int pool_start, int h, char hod);
int next_ro2(int ro2, int pool_start, int h, char hod);
void drawaing(int pool_start, int h, int w, int ro1, int ro2, int ball_x, int ball_y, int count_left,
              int count_right);

int main() {
    int pool_start = 1;
    int h = pool_start + 27, w = 82;
    int ro1 = pool_start + 12, ro2 = pool_start + 12;
    int ball_hod_x = 1, ball_hod_y = 1;
    int ball_x = 40, ball_y = pool_start + 13;
    int count_left = 0, count_right = 0;

    while (1) {
        char hod = getchar();  // Получаем первый введенный символ
        if (hod != 'a' && hod != 'z' && hod != 'k' && hod != 'm' &&
            hod != ' ') {  // Если первый введенный символ какая-то команда
            printf("Ошибка! Введите a, z, k, m или \" \"\n");
            if (hod != '\n') {
                while (getchar() != '\n') {
                }  // Удаляем все символы после первых двух
            }
            continue;
        }
        if (getchar() != '\n') {
            printf("Ошибка! Введите a, z, k, m или \" \"\n");
            while (getchar() != '\n') {
            }  // Удаляем все символы после первых двух
            continue;
        }
        ball_hod_x =
            next_hod_x(w, ro1, ro2, ball_hod_x, ball_x, ball_y);  // Проверка отскакивает ли мяч от ракетки
        ball_hod_y =
            next_hod_y(h, ball_hod_y, ball_y, pool_start);  // Проверка отскакивает ли мяч от up/down границ
        ro1 = next_ro1(ro1, pool_start, h, hod);  // Движение ракетки 1
        ro2 = next_ro2(ro2, pool_start, h, hod);  // Движение ракетки 2

        ball_x += ball_hod_x;                            // Меняем координаты по х
        ball_y += ball_hod_y;                            // Меняем координаты по у
        if (ball_x == 0 || ball_x == w - 1) {            // Если мяч за пределами поля
            ball_x == 0 ? count_right++ : count_left++;  // Увеличиваем счет
            ball_x = 40;
            ball_y = pool_start + 13;
            ro1 = ro2 = pool_start + 12;  // Сброс позиций
        }
        drawaing(pool_start, h, w, ro1, ro2, ball_x, ball_y, count_left, count_right);  // Отрисовываем всё
        if (count_left == 21 || count_right == 21) {  // Проверка победил ли кто-то из игроков
            printf("Победил %s игрок", count_left == 21 ? "левый" : "правый");
            return 0;
        }
    }
    return 0;
}

int next_hod_x(int w, int ro1, int ro2, int ball_hod_x, int ball_x, int ball_y) {
    int next_ball_x = ball_x + ball_hod_x;  // Следующая координата мяча по х
    if (next_ball_x == 1 && (ball_y == ro1 || ball_y == ro1 + 1 || ball_y == ro1 + 2))
        return ball_hod_x * -1;  // Если стукается об левую ракетку
    else if (next_ball_x == w - 2 && (ball_y == ro2 || ball_y == ro2 + 1 || ball_y == ro2 + 2))
        return ball_hod_x * -1;  // Если стукается об правую ракетку, меням направление мячика по х
    else
        return ball_hod_x;  // Если не стукается
}

int next_hod_y(int h, int ball_hod_y, int ball_y, int pool_start) {
    int next_ball_y = ball_y + ball_hod_y;
    if (next_ball_y == pool_start + 1)
        return ball_hod_y * -1;  // Если стукается об верх
    else if (next_ball_y == h - 1)
        return ball_hod_y * -1;  // Если стукается об низ
    return ball_hod_y;           // Если не стукается
}

int next_ro1(int ro1, int pool_start, int h, char hod) {
    if (hod == 'a') {                // Если была нажата A
        if (ro1 > pool_start + 2) {  // Если возможно передвинуть ракетку наверх
            ro1 -= 1;                // Передвигаем
        }
    } else if (hod == 'z') {  // Если была нажата Z
        if (ro1 < h - 4) {    // Если возможно передвинуть ракетку вниз
            ro1 += 1;         // Передвигаем
        }
    }
    return ro1;
}

int next_ro2(int ro2, int pool_start, int h, char hod) {
    if (hod == 'k') {                // Если была нажата K
        if (ro2 > pool_start + 2) {  // Если возможно передвинуть ракетку наверх
            ro2 -= 1;                // Передвигаем
        }
    } else if (hod == 'm') {  // Если была нажата M
        if (ro2 < h - 4) {    // Если возможно передвинуть ракетку вниз
            ro2 += 1;         // Передвигаем
        }
    }
    return ro2;
}

void drawaing(int pool_start, int h, int w, int ro1, int ro2, int ball_x, int ball_y, int count_left,
              int count_right) {
    // Отрисовываем поле
    printf("\33[0d\33[2J");            // Очищаем консоль
    for (int y = 0; y < h; y++) {      // Перебираем координату у
        for (int x = 0; x < w; x++) {  // Перебираем координату х
            if (y == pool_start - 1) {
                if (x == 38) printf("%d / %d", count_left, count_right);  // Выводим счет
            }
            if (y == pool_start + 1 || y == h - 1) {
                printf("Z");  // Создаем верхнюю и нижнюю грани
            } else if ((x == 0 || x == w - 1) && y > pool_start) {
                printf("|");  // Создаем боковые стенки
            } else if (x == 1 && (y == ro1 || y == ro1 + 1 || y == ro1 + 2)) {
                printf("H");  // Создаем первую ракетку
            } else if (x == w - 2 && (y == ro2 || y == ro2 + 1 || y == ro2 + 2)) {
                printf("H");  // Создаем вторую ракетку
            } else if (x == ball_x && y == ball_y) {
                printf("*");  // Создаем мяч
            } else
                printf(" ");  // Остальное заполняем пробелами
        }
        printf("\n");  // отрисовываем новую строку (переходим на следующий y)
    }
}
