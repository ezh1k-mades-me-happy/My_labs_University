#include <stdio.h>

int main() {
    FILE* fin = fopen("test.c", "rb");
    FILE* fout = fopen("test.wc", "wb");

    int position = 0; // 0 - ok, 1 - once kov, 2 - double kov, 3 - once comm, 4 - multi comm
    int ch = getc(fin);
    while (ch != EOF) {
        if (ch == '\'' && position == 0) position = 1; // once kov
        else if (ch == '\"' && position == 0) position = 2; // double kov
        else if (ch == '/' && position == 0) {
            int next_ch = getc(fin);
            if (next_ch == '/') position = 3; // once comm
            else if (next_ch == '*') position = 4; // multi comm
            else { // Не комментарий
                ungetc(next_ch, fin);
            }
        }
        else if ((ch == '\'' && position == 1) || (ch == '\"' && position == 2)) position = 0; // Закрыли кавычку
        else if ((ch == '\n' || ch == '\r') && (position == 1 || position == 2)) position = 0; // Закрыли кавычку, тк переход на новую строку
        else if ((ch == '\n' || ch == '\r') && position == 3) position = 0; // Закрыли однострочный комментарий
        else if (ch == '*' && position == 4) {
            int next_ch = getc(fin);
            if (next_ch == '/') {
                position = 0; // Закрыли многострочный комментарий
                ch = getc(fin);
            }
            else ch = next_ch;
            continue;
        }
        else if (ch == '\\' && (position == 1 || position == 2)) { // Если встретили \ в строке
            putc(ch, fout);
            ch = getc(fin); // Переходим к следующему символу
            if (ch == '\n' || ch == '\r') {
                putc(ch, fout);
                ch = getc(fin);
            }
        }
        else if (ch == '\\' && position == 3) { // Если встретили \ в однострочном комментарии
            ch = getc(fin);
            if (ch == '\n' || ch == '\r') {
                ch = getc(fin);
            }
        }
        if ((position == 0 || position == 1 || position == 2) && ch != EOF) putc(ch, fout); // Выводим символ
        ch = getc(fin);
    }
    fclose(fin);
    fclose(fout);
    return 0;
}
// Я ненавижу автотесты