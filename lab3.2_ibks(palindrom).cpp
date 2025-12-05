#include <stdio.h>
#include <string.h>
#include <ctype.h>

int is_palindrom(const char* word, int len);

int main() {
    char input[101] = "";
    char result[101] = "";
    fgets(input, 101, stdin);
    char word[101] = "";
    int word_len = 0;
    int first_word = 1;
    int input_len = strlen(input);
    
    for (int i = 0; i <= input_len; i++) {
        if (input[i] == ' ' || input[i] == '\n' || input[i] == '\0') {
            if (word_len > 0) { // Проверяем, что слово не пустое
                if (is_palindrom(word, word_len)) {
                    if (!first_word) {
                        strcat(result, " ");
                    }
                    // Добавляем слово в результат
                    strncat(result, word, word_len);
                    first_word = 0;
                }
                // Сбрасываем слово
                word_len = 0;
                word[0] = '\0';
            }
        } else {
            if (word_len < 100) {
                word[word_len] = input[i];
                word_len++;
                word[word_len] = '\0';
            }
        }
    }
    
    printf("%s\n", result);
    return 0;
} 

int is_palindrom(const char* word, int len) {
    if (len <= 0) return 0;
    for (int i = 0; i < len / 2; i++) {
        if (word[i] != word[len - 1 - i]) {
            return 0;
        }
    }
    return 1;
}