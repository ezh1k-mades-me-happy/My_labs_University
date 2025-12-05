#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <locale.h>
#define NMAX 256
#include <windows.h>

char* str_redactor(char* s1, char* s2, char* rez);
char vid_bukvi(char c);

int main() {
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);
    
    char s1[NMAX / 2];
    char s2[NMAX / 2];
    char rez[NMAX];

    while (1) {
        scanf("%s", s1);
        scanf("%s", s2);

        str_redactor(s1, s2, rez);
        printf("%s", rez);
    }
    return 0;
}

char* str_redactor(char* s1, char* s2, char* rez) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int max_len = len1 > len2 ? len1 : len2;
    int j = 0;

    for (int i = 0; i < max_len; i++) {
        if (i < len1 && i < len2) {
            if (s1[i] == s2[i]) {
                // глас или согл => 1 или 3
                char vid_buk = vid_bukvi(s1[i]);
                if (vid_buk == 's') {
                    // код одинаковых для согласных
                    rez[j++] = s1[i];
                    rez[j++] = s1[i];
                    rez[j++] = s1[i];
                }
                else {
                    // код одинаковых для гласных и других символов
                    rez[j++] = s1[i];
                }
            }
            else {
                if (i < len1) rez[j++] = s1[i];
                if (i < len2) rez[j++] = s2[i];
            }
        }
        else if (i < len1) rez[j++] = s1[i];
        else if (i < len2) rez[j++] = s2[i];
    }
    rez[j] = '\0';
    return rez;
}

char vid_bukvi(char c) {
    char char_rez = 'o';
    char sogl[] = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZбвгджзйклмнпрстфхцчшщБВГДЖЗЙКЛМНПРСТФХЦЧШЩ\0";
    char glasn[] = "aeiouAEIOUаеёиоуыэюяАЕЁИОУЫЭЮЯ\0";
    for (int i = 0; i < strlen(sogl); i++) {
        if (c == sogl[i]) {
            char_rez = 's';
            break;
        }
    }
    for (int i = 0; i < strlen(glasn); i++) {
        if (c == glasn[i]) {
            char_rez = 'g';
            break;
        }
    }
    return char_rez;
}