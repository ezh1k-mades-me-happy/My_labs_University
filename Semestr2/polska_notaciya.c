#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NMAX 83

void remover(char* str, char* rem);
char* token(char* func, int len, int* token_count);
int validation(const char* func, int len);
char* ReversePolishNotation(char* results_tokens, int token_count);
int Calculate(char* rpn, long long* answer);

int isOperand(char token);
int isDigit(char token);
int isLetter(char token);
int isOperation(char token);
int priority(char op);
int isCalculated(char* rpn);

int main() {
    char func[NMAX];
    while (fgets(func, sizeof(func), stdin) != NULL) {
        if (strchr(func, '\n') == NULL && !feof(stdin)) {
            int ch;
            while ((ch = getchar()) != '\n' && ch != EOF) {}
            printf("error\n");
            continue;
        }
        remover(func, " \t\r\n"); // Удаляем \n тут
        int len = strlen(func);
        if (validation(func, len)) {
            int token_count = 0;
            char* results_tokens = token(func, len, &token_count);
            char* rpn = ReversePolishNotation(results_tokens, token_count);
            if (isCalculated(rpn)) {
                long long answer;
                if (Calculate(rpn, &answer)) {
                    printf("%s = %lld\n", rpn, answer);
                } else {
                    printf("error\n");
                    free(results_tokens); // ВАЖНО: добавил очистку памяти при ошибке
                    free(rpn);
                    continue;
                }
            } else {
                printf("%s\n", rpn);
            }
            free(results_tokens);
            free(rpn);
        } else {
            printf("error\n");
        }
    }
    return 0;
}

int validation(const char* func, int len) {
    int flag = 0, balance = 0;
    for (int i = 0; i < len; i++) {
        if (strchr("0123456789+-*/()abcdefghijklmnopqrstuvwxyz", func[i]) == NULL)
            break;  // Если неопределенный символ
        if (strchr("0123456789abcdefghijklmnopqrstuvwxyz", func[i]) != NULL && i + 1 < len &&
            strchr("0123456789abcdefghijklmnopqrstuvwxyz", func[i + 1]) != NULL)
            break;  // Если несколько операндов подряд
        if (strchr("+*/-", func[i]) != NULL) {
            if (i == 0 || i == len - 1) {
                break;
            }  // Начнианется или заканчивается операцией
            else if (strchr("+-*/", func[i - 1]) != NULL) {
                break;
            }  // 2 операции подряд
        }
        if (func[i] == '(' && ((i != 0 && strchr("+-*/(", func[i - 1]) == NULL) ||
                               (i != len - 1 && strchr("+-*/)", func[i + 1]) != NULL)))
            break;  // Если до открывающей скобки не операция или после нее операция/закрывающая скобка
        else if (func[i] == ')' && (i != 0 && strchr("+-*/", func[i - 1]) != NULL ||
                                    (i != len - 1 && strchr("0123456789abcdefghijklmnopqrstuvwxyz", func[i + 1]) != NULL)))
            break;  // Если до закрывающей скобки операция или после нее не операция
        else if (func[i] == '/' && i > 0 && strchr("0123456789", func[i - 1]) != NULL && func[i + 1] == '0') {
            break;
        }  // Деление числа на 0
        if (func[i] == '(') {
            balance++;
        } else if (func[i] == ')') {
            balance--;
            if (balance < 0) {
                break;  // Закрывающая скобка без открывающей
            }
        }
        // Func end
        if (i == len - 1 && balance == 0) flag = 1;  // for дошел до конца - ВСЕ ОК!!!
    }
    return flag;
}

char* token(char* func, int len, int* token_count) {
    char* res = (char*)malloc(len * sizeof(char));  // Динамическое выделение памяти для массива токенов
    int count = 0;  // Счетчик токенов
    for (int i = 0; i < len; i++) {
        res[count++] = func[i];
    }
    *token_count = count;  // Возвращаем количество токенов
    return res;
}

void remover(char* str, char* rem) {
    for (int j = 0; j < strlen(rem); j++) {
        char c = rem[j];
        char* p = str;
        for (int i = 0; i < strlen(str); i++) {
            if (str[i] != c) *p++ = str[i];
        }
        *p = 0;
    }
}

int isOperand(char token) { return (strchr("0123456789abcdefghijklmnopqrstuvwxyz", token) != NULL) ? 1 : 0; }
int isDigit(char token) { return (strchr("0123456789", token) != NULL) ? 1 : 0; }
int isLetter(char token) { return (strchr("abcdefghijklmnopqrstuvwxyz", token) != NULL) ? 1 : 0; }
int isOperation(char token) { return (strchr("+-*/", token) != NULL) ? 1 : 0; }
int priority(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}
int isCalculated(char* rpn) {
    for (int i = 0; i < strlen(rpn); i++) {
        if (isLetter(rpn[i])) return 0;
    }
    return 1;
}

char* ReversePolishNotation(char* results_tokens, int token_count) {
    char* output = (char*)malloc((token_count + 1) * sizeof(char));
    char* stack = (char*)malloc((token_count + 1) * sizeof(char));

    int out_pos = 0;
    int top = -1;

    for (int i = 0; i < token_count; i++) {
        char M = results_tokens[i];

        // 1. Операнд или открывающая скобка
        if (isOperand(M)) {
            output[out_pos++] = M;
        } else if (M == '(') {
            stack[++top] = M;
        }

        // 2. Закрывающая скобка
        else if (M == ')') {
            while (top >= 0 && stack[top] != '(') {
                output[out_pos++] = stack[top--];
            }
            if (top >= 0 && stack[top] == '(') {
                top--;
            }  // удаляем '(' из стека
        }

        // 3. Оператор
        else if (isOperation(M)) {
            while (top >= 0 && isOperation(stack[top]) && priority(stack[top]) >= priority(M)) {
                output[out_pos++] = stack[top--];
            }
            stack[++top] = M;
        }
    }

    // 4. Выталкиваем остаток стека
    while (top >= 0) {
        if (stack[top] != '(' && stack[top] != ')') {
            output[out_pos++] = stack[top];
        }
        top--;
    }
    output[out_pos] = '\0';
    free(stack);
    return output;
}

int Calculate(char* rpn, long long* answer) {
    int len = strlen(rpn);
    long long* stack = (long long*)malloc(len * sizeof(long long));
    int top = -1;

    for (int i = 0; i < len; i++) {
        char token = rpn[i];
        // Если число — кладем в стек
        if (isDigit(token)) {
            stack[++top] = token - '0';
        }
        // Если оператор — достаем 2 операнда и считаем
        else if (isOperation(token)) {
            if (top < 1) {
                free(stack);
                return 0;
            }
            long long right = stack[top--];
            long long left = stack[top--];
            long long result = 0;
            if (token == '+') {
                result = left + right;
            } else if (token == '-') {
                result = left - right;
            } else if (token == '*') {
                result = left * right;
            } else if (token == '/') {
                if (right == 0) {
                    free(stack);
                    return 0;
                }
                result = left / right;
            }
            stack[++top] = result;
        }
    }

    if (top != 0) {
        free(stack);
        return 0;
    }
    *answer = stack[top];
    free(stack);
    return 1;
}
