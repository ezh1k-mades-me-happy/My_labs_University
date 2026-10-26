#include <stdio.h>
#include <string.h>

int main() {
    printf("#include <stdio.h>\n#include <string.h>\n\nint main() {\n    ");
    char* rez = "printf(\"#include <stdio.h>\\n#include <string.h>\\n\\nint main() {\\n    \");\n    char* rez = \"\";\n    int cnt_kov = 0, first = 1, end = 0;\n    for (size_t i = 0; i < strlen(rez); i++) {\n        if (first || end) {\n            printf(\"%c\", rez[i]);\n            if (rez[i] == \'\"\') { cnt_kov++; }\n            if (cnt_kov == 3) { i = -1; first = 0; cnt_kov = 999; }\n        }\n        else {\n            if (rez[i] == \'\"\' || rez[i] == \'\\\'\' || rez[i] == \'\\\\\') {\n                printf(\"\\\\%c\", rez[i]);\n            } else if (rez[i] == \'\\n\') {\n                printf(\"\\\\n\");\n            } else {\n                printf(\"%c\", rez[i]);\n            }\n            if (i == strlen(rez)-1) { end = 1; i = 89; }\n        }\n    }\n    return 0;\n}\n";
    int cnt_kov = 0, first = 1, end = 0;
    for (size_t i = 0; i < strlen(rez); i++) {
        if (first || end) {
            printf("%c", rez[i]);
            if (rez[i] == '"') { cnt_kov++; }
            if (cnt_kov == 3) { i = -1; first = 0; cnt_kov = 999; }
        }
        else {
            if (rez[i] == '"' || rez[i] == '\'' || rez[i] == '\\') {
                printf("\\%c", rez[i]);
            } else if (rez[i] == '\n') {
                printf("\\n");
            } else {
                printf("%c", rez[i]);
            }
            if (i == strlen(rez)-1) { end = 1; i = 89; }
        }
    }
    return 0;
}
/*
gcc -std=c11 -Wall -Werror -Wextra write_my_prog.c -o write_my_prog
./write_my_prog > write_my_prog_output.txt
diff write_my_prog_output.txt write_my_prog.c
*/