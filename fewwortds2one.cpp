#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <wchar.h>
#include <locale.h>
#include <string.h>

int combineWords(wchar_t *result, const wchar_t *word1, const wchar_t *word2);

int main() {
    // Установка локали для поддержки широких символов
    setlocale(LC_ALL, "");
    wchar_t input[81];
    fgetws(input, 81, stdin);
    
    int len = wcslen(input);
    // Удаляем символ новой строки, если он есть
    if (len > 0 && input[len - 1] == L'\n') input[--len] = L'\0';
    
    wchar_t rez[len + 1] = L"", word1[len + 1] = L"", word2[len + 1] = L"";
    int index = 0, first_w = 1;

    while (input[index] != L'\0') {
        // Записываем первое слово
        int cnt = 0;
        while (input[index] != L' ' && input[index] != L'\0') {
            word1[cnt++] = input[index++];
        }
        word1[cnt] = L'\0';
        
        if (first_w) {
            wcscpy(rez, word1);
            first_w = 0;
        }
        index++; // Пропускаем пробел
        // Записываем второе слово
        cnt = 0;
        while (input[index] != L' ' && input[index] != L'\0') {
            word2[cnt++] = input[index++];
        }
        word2[cnt] = L'\0';
        if (cnt != 0) combineWords(rez, word1, word2);

        if (input[index] != L'\0') index -= cnt;
    }
    wprintf(L"%ls\n", rez);
    return 0;
}

int combineWords(wchar_t *result, const wchar_t *word1, const wchar_t *word2) {
    int len1 = wcslen(word1);
    int len2 = wcslen(word2);
    int maxequel = 0;
    
    // Находим максимальное совпадение конца первого слова и начала второго
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
    wcscat(result, word2 + maxequel);
    return 0;
}