#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

typedef enum { BLACK, RED } Color;

typedef struct BlackRedTree {
    double num;
    int count; // Счетчик одинаковых элементов
    Color color;
    struct BlackRedTree *left, *right, *parent;
} BlackRedTree;

// Глобальный "фиктивный" узел 
BlackRedTree* NIL = NULL;

// Создание фиктивного узла
BlackRedTree* createNilNode() {
    BlackRedTree* node = (BlackRedTree*)malloc(sizeof(BlackRedTree));
    if (node == NULL) return NULL;
    
    node->num = 0;
    node->count = 0;
    node->color = BLACK;
    node->left = NULL;
    node->right = NULL;
    node->parent = NULL;
    
    return node;
}

// Создание нового узла
BlackRedTree* createNode(double value) {
    BlackRedTree* node = (BlackRedTree*)malloc(sizeof(BlackRedTree));
    if (node == NULL) return NULL;
    
    node->num = value;
    node->count = 1; // Первое вхождение
    node->color = RED; // Все листья изначально красные, чтобы было меньше перекрашиваний
    node->left = NIL;
    node->right = NIL;
    node->parent = NIL;
    
    return node;
}

// Проверка существования узла (не является ли NIL)
bool nodeExists(BlackRedTree* node) {
    return node != NIL;
}

// Левый поворот
void leftRotate(BlackRedTree** root, BlackRedTree* x) {
    BlackRedTree* y = x->right;
    x->right = y->left;
    
    if (nodeExists(y->left)) {
        y->left->parent = x;
    }
    
    y->parent = x->parent;
    
    if (x->parent == NIL) {
        *root = y;
    } else if (x == x->parent->left) {
        x->parent->left = y;
    } else {
        x->parent->right = y;
    }
    
    y->left = x;
    x->parent = y;
}

// Правый поворот
void rightRotate(BlackRedTree** root, BlackRedTree* x) {
    BlackRedTree* y = x->left;
    x->left = y->right;
    
    if (nodeExists(y->right)) {
        y->right->parent = x;
    }
    
    y->parent = x->parent;
    
    if (x->parent == NIL) {
        *root = y;
    } else if (x == x->parent->right) {
        x->parent->right = y;
    } else {
        x->parent->left = y;
    }
    
    y->right = x;
    x->parent = y;
}

// Балансировка после вставки
void balanceTree(BlackRedTree** root, BlackRedTree* newNode) {
    BlackRedTree* uncle;
    
    while (newNode->parent->color == RED) {
        if (newNode->parent == newNode->parent->parent->left) {
            uncle = newNode->parent->parent->right; // Вычисляем дядю
            
            if (uncle->color == RED) {
                newNode->parent->color = BLACK;
                uncle->color = BLACK;
                newNode->parent->parent->color = RED;
                newNode = newNode->parent->parent; // Продолжаем проверку дерева уже от дедушки
            } else {
                if (newNode == newNode->parent->right) { // Если в дереве зигзаг
                    newNode = newNode->parent;
                    leftRotate(root, newNode); // Выпрямляем линию
                }
                newNode->parent->color = BLACK;
                newNode->parent->parent->color = RED;
                rightRotate(root, newNode->parent->parent); // Защита, если у деда красный папа
            }
        } else {
            uncle = newNode->parent->parent->left;
            
            if (uncle->color == RED) {
                newNode->parent->color = BLACK;
                uncle->color = BLACK;
                newNode->parent->parent->color = RED;
                newNode = newNode->parent->parent;
            } else {
                if (newNode == newNode->parent->left) {
                    newNode = newNode->parent;
                    rightRotate(root, newNode);
                }
                newNode->parent->color = BLACK;
                newNode->parent->parent->color = RED;
                leftRotate(root, newNode->parent->parent);
            }
        }
    }
    
    (*root)->color = BLACK;
}


// Поиск узла по значению
BlackRedTree* search(BlackRedTree* root, double value) {
    if (root == NIL || root->num == value) {
        return root;
    }
    
    if (value < root->num) {
        return search(root->left, value);
    } else {
        return search(root->right, value);
    }
}


// Вставка узла в дерево
void insert(BlackRedTree** root, double value) {
    // Проверяем, есть ли уже такой элемент в дереве
    BlackRedTree* existing = search(*root, value);
    if (nodeExists(existing)) {
        existing->count++; // Элемент найден — увеличиваем счетчик
        return;
    }
    
    BlackRedTree* currentNode = *root;
    BlackRedTree* parent = NIL;
    
    // Поиск места для вставки
    while (nodeExists(currentNode)) {
        parent = currentNode;
        if (value < currentNode->num) {
            currentNode = currentNode->left;
        } else {
            currentNode = currentNode->right;
        }
    }
    
    // Создание нового узла
    BlackRedTree* newNode = createNode(value);
    newNode->parent = parent;
    
    if (parent == NIL) {
        *root = newNode;
    } else if (value < parent->num) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }
    
    // Балансировка дерева
    balanceTree(root, newNode);
}

// Поиск минимального узла в поддереве
BlackRedTree* getMin(BlackRedTree* node) {
    while (nodeExists(node->left)) {
        node = node->left;
    }
    return node;
}

// Получение количества детей
int getChildrenCount(BlackRedTree* node) {
    int count = 0;
    if (nodeExists(node->left)) count++;
    if (nodeExists(node->right)) count++;
    return count;
}

// Получение существующего ребенка или NIL
BlackRedTree* getChildOrMock(BlackRedTree* node) {
    if (nodeExists(node->left)) return node->left;
    return node->right;
}

// Пересадка узлов
void transplantNode(BlackRedTree** root, BlackRedTree* toNode, BlackRedTree* fromNode) {
    if (toNode->parent == NIL) {
        *root = fromNode;
    } else if (toNode == toNode->parent->left) {
        toNode->parent->left = fromNode;
    } else {
        toNode->parent->right = fromNode;
    }
    fromNode->parent = toNode->parent;
}

// Восстановление свойств после удаления
void fixRulesAfterRemoval(BlackRedTree** root, BlackRedTree* node) {
    BlackRedTree* brother;
    
    while (node != *root && node->color == BLACK) {
        if (node == node->parent->left) {
            brother = node->parent->right;
            
            if (brother->color == RED) {
                brother->color = BLACK;
                node->parent->color = RED;
                leftRotate(root, node->parent);
                brother = node->parent->right;
            }
            
            if (brother->left->color == BLACK && brother->right->color == BLACK) {
                brother->color = RED;
                node = node->parent;
            } else {
                if (brother->right->color == BLACK) {
                    brother->left->color = BLACK;
                    brother->color = RED;
                    rightRotate(root, brother);
                    brother = node->parent->right;
                }
                brother->color = node->parent->color;
                node->parent->color = BLACK;
                brother->right->color = BLACK;
                leftRotate(root, node->parent);
                node = *root;
            }
        } else {
            brother = node->parent->left;
            
            if (brother->color == RED) {
                brother->color = BLACK;
                node->parent->color = RED;
                rightRotate(root, node->parent);
                brother = node->parent->left;
            }
            
            if (brother->right->color == BLACK && brother->left->color == BLACK) {
                brother->color = RED;
                node = node->parent;
            } else {
                if (brother->left->color == BLACK) {
                    brother->right->color = BLACK;
                    brother->color = RED;
                    leftRotate(root, brother);
                    brother = node->parent->left;
                }
                brother->color = node->parent->color;
                node->parent->color = BLACK;
                brother->left->color = BLACK;
                rightRotate(root, node->parent);
                node = *root;
            }
        }
    }
    node->color = BLACK;
}

// Удаление узла из дерева
void removeNode(BlackRedTree** root, double value) {
    BlackRedTree* nodeToDelete = search(*root, value);
    if (nodeToDelete == NIL) return;
    
    Color removedNodeColor = nodeToDelete->color;
    BlackRedTree* child;
    
    if (getChildrenCount(nodeToDelete) < 2) {
        child = getChildOrMock(nodeToDelete);
        transplantNode(root, nodeToDelete, child);
    } else {
        BlackRedTree* minNode = getMin(nodeToDelete->right);
        nodeToDelete->num = minNode->num;
        removedNodeColor = minNode->color;
        child = getChildOrMock(minNode);
        transplantNode(root, minNode, child);
    }
    
    if (removedNodeColor == BLACK) {
        fixRulesAfterRemoval(root, child);
    }
}

// Симметричный обход дерева
void inorderTraversal(BlackRedTree* root) {
    if (nodeExists(root)) {
        inorderTraversal(root->left);
        printf("%f (Count: %d)\n", root->num, root->count);
        inorderTraversal(root->right);
    }
}

// Освобождение памяти
void freeTree(BlackRedTree* root) {
    if (nodeExists(root)) {
        freeTree(root->left);
        freeTree(root->right);
        free(root);
    }
}

// Поиск вещественных чисел в файле и вставка в дерево
int finder(char* fin_name, BlackRedTree** root) {
    FILE* fin = fopen(fin_name, "rb");
    if (fin == NULL) return 1;

    int position = 0; // 0 - ok, 1 - once kov, 2 - double kov, 3 - once comm, 4 - multi comm
    int prev_ch = ' '; // Предыдущий символ
    int ch = getc(fin);

    while (ch != EOF) {
        if (ch == '\'' && position == 0) position = 1; 
        else if (ch == '\"' && position == 0) position = 2; 
        else if (ch == '/' && position == 0) {
            int next_ch = getc(fin);
            if (next_ch == '/') position = 3; 
            else if (next_ch == '*') position = 4; 
            else ungetc(next_ch, fin);
        }
        else if ((ch == '\'' && position == 1) || (ch == '\"' && position == 2)) position = 0; 
        else if ((ch == '\n' || ch == '\r') && (position == 1 || position == 2)) position = 0; 
        else if ((ch == '\n' || ch == '\r') && position == 3) position = 0; 
        else if (ch == '*' && position == 4) {
            int next_ch = getc(fin);
            if (next_ch == '/') {
                position = 0; 
                prev_ch = '/';
                ch = getc(fin);
            } else {
                prev_ch = ch;
                ch = next_ch;
            }
            continue;
        }
        else if (ch == '\\' && (position == 1 || position == 2 || position == 3)) { 
            prev_ch = ch;
            ch = getc(fin); 
            if (ch == '\n' || ch == '\r') {
                prev_ch = ch;
                ch = getc(fin);
            }
        }

        // Минус считается знаком числа, если перед ним стоит:
        bool minusIsSign = (ch == '-') &&
                           (prev_ch == ' '  || prev_ch == '\t' ||
                            prev_ch == '\n' || prev_ch == '\r' ||
                            prev_ch == '='  || prev_ch == '('  ||
                            prev_ch == ','  || prev_ch == '['  ||
                            prev_ch == '{'  || prev_ch == '+'  ||
                            prev_ch == '-'  || prev_ch == '*'  ||
                            prev_ch == '/');

        // Если не комментарий и не строка - ищем числа
        if (position == 0 && (isdigit(ch) || ch == '.' || minusIsSign)) {
            char numBuffer[128];
            int bufIdx = 0;

            // Считываем минус
            if (minusIsSign) {
                numBuffer[bufIdx++] = ch;
                ch = getc(fin);
            }

            // Жадный сбор всех символов, которые могут быть частью числа 
            // (цифры, буквы для hex и экспонент, точки, знаки после экспоненты)
            while (bufIdx < 127 && (isalnum(ch) || ch == '.' || ch == '+' || ch == '-')) {
                
                // Знаки + и - допустимы только сразу после e, E, p, P
                if ((ch == '+' || ch == '-') && bufIdx > 0) {
                    char prev = numBuffer[bufIdx - 1];
                    if (prev != 'e' && prev != 'E' && prev != 'p' && prev != 'P') {
                        break; // Это оператор, а не часть числа
                    }
                }
                
                numBuffer[bufIdx++] = ch;
                ch = getc(fin);
            }
            numBuffer[bufIdx] = '\0';

            // Конвертируем строку с помощью встроенного мощного парсера
            char* end;
            double value = strtod(numBuffer, &end);

            // Если strtod хоть что-то распознал
            if (end != numBuffer) {
                
                // Очистка от суффиксов (f, F, l, L)
                if (*end == 'f' || *end == 'F' || *end == 'l' || *end == 'L') {
                    end++;
                }

                // Возвращаем в поток всё, что strtod посчитал "лишним"
                ungetc(ch, fin); // Возвращаем символ, на котором прервался while
                for (int i = bufIdx - 1; i >= (end - numBuffer); i--) {
                    ungetc(numBuffer[i], fin);
                }
                ch = getc(fin); // Читаем обратно первый валидный символ для следующего шага
                
                *end = '\0'; // Обрезаем буфер для правильного анализа

                // Отличаем вещественные от целых
                bool is_hex = false;
                bool is_float = false;
                
                // Проверяем начало на 0x или -0x
                int start_idx = (numBuffer[0] == '-') ? 1 : 0;
                if (numBuffer[start_idx] == '0' && 
                   (numBuffer[start_idx+1] == 'x' || numBuffer[start_idx+1] == 'X')) {
                    is_hex = true;
                }

                // Сканируем распознанную часть числа
                for (char* ptr = numBuffer; *ptr; ptr++) {
                    if (is_hex) {
                        // Для HEX вещественного ОБЯЗАТЕЛЕН символ p или P
                        if (*ptr == 'p' || *ptr == 'P') is_float = true;
                    } else {
                        // Для десятичного вещественного нужна точка ИЛИ e/E
                        if (*ptr == '.' || *ptr == 'e' || *ptr == 'E') is_float = true;
                    }
                }

                // Если это действительно вещественное число — добавляем в дерево
                if (is_float) {
                    insert(root, value);
                }
                
            } else {
                // Ничего не распозналось (например, был просто знак '-')
                ungetc(ch, fin);
                prev_ch = numBuffer[0];
                ch = getc(fin);
            }
            continue;
        }

        prev_ch = ch; 
        ch = getc(fin);
    }

    fclose(fin);
    return 0;
}

// Ввод имени файла
void input(char filename[256]) {
    FILE* file = NULL;
    while (1) {
        printf("Enter filepath: ");
        if (scanf("%255s", filename) != 1) {
            printf("Incorrect input! Try again.\n");
            while (getchar() != '\n');
            continue;
        }
        
        file = fopen(filename, "r");
        if (file == NULL) {
            printf("File not founded or can't be opened!\n");
        } else {
            fclose(file);
            break;
        }
    }
}

int main() {
    // Инициализация глобального NIL узла
    NIL = createNilNode();
    BlackRedTree* root = NIL;
    char filename[256];

    while (1) {
        printf("\nCommands:\n0 - exit\n1 - scan file\n2 - delete element\n3 - print tree\n\nEnter number: ");
        int command;
        while (scanf("%d", &command) != 1 && (command < 0 || command > 3)) printf("Incorrect input! Enter decimal number.\n");
        if (command == 0) {
            break;
        } else if (command == 1) {
            input(filename); // Чтение пути до файла
            finder(filename, &root); // Поиск вещественных чисел
            printf("\nFounded numbers:\n");
            inorderTraversal(root); // Вывод дерева
        } else if (command == 2) {
            printf("Enter number you want to delete: ");
            double del_el;
            while (scanf("%lf", &del_el) != 1) printf("Incorrect input! Enter float number.\n");
            removeNode(&root, del_el);
        } else {
            inorderTraversal(root); // Вывод дерева
        }
    }
    
    // Очистка памяти
    freeTree(root);
    free(NIL);
    
    return 0;
}