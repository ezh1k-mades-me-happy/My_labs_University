#include <stdio.h>
#include <stdlib.h>

struct letter {
    char c;
    struct letter *p;
};

typedef struct letter Letter;

Letter* add(Letter *pLast, char c) {
    Letter *t = (Letter *)malloc(sizeof(Letter));
    t->c = c;
    (*t).p = pLast;
    return t;
}

int main(int argc, char* argv[]) {
    FILE* fin = fopen(argv[1], "w");
    fprintf(fin, "Hello World!\nI am programmer. My name is Anton Goodkovsky)");
    fclose(fin);
    fin = fopen(argv[1], "rb");
    FILE* fout = fopen(argv[2], "wb");
    int ch = getc(fin);

    Letter *pLast = (Letter *)malloc(sizeof(Letter));
    pLast->p  = NULL;

    while (ch != EOF) {
        pLast = add(pLast, ch);
        ch = getc(fin);
    }
    int sym;
    while (pLast->p) {
        sym = pLast->c;
        if (sym != '\n') {
            putc(sym, fout);
        }
        Letter *toFree = pLast;
        pLast = pLast->p;
        free(toFree);
    }
    free(pLast);

    fclose(fin);
    fclose(fout);
    return 0;
}