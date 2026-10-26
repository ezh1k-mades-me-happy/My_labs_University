// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
// #include <windows.h>

int combineWords(char *result, const char *word1, const char *word2);

int main() {
    // SetConsoleCP(1251);
    // SetConsoleOutputCP(1251);
    int n;
    scanf("%d", &n);
    
    char word1[33], word2[33];
    char result[65];
    
    for (int i = 0; i < n; i++) {
        scanf("%s %s", word1, word2);
        combineWords(result, word1, word2);
        printf("%s\n", result);
    }
    
    return 0;
}

int combineWords(char *result, const char *word1, const char *word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    int maxequel = 0;
    for (int equel = 1; equel <= len1 && equel <= len2; equel++) {
        int match = 1;
        for (int i = 0; i < equel; i++) {
            if (word1[len1 - equel + i] != word2[i]) {
                match = 0;
                break;
            }
        }
        if (match) {
            maxequel = equel;
        }
    }
    strcpy(result, word1);
    strcat(result, word2 + maxequel);
    return 0;
}