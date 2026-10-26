#include <stdio.h>

int my_strcmp(char* s1, char* s2);

int main() {
    char s1[] = "Hello";
    char s2[] = "Ha";
    printf("%d\n", my_strcmp(s1, s2));
    return 0;
}

int my_strcmp(char* s1, char* s2) {
    int i = 0;
    while (s1[i] == s2[i] && s1[i] != '\0' && s2[i] != '\0') i++;
    return s1[i] - s2[i];
}