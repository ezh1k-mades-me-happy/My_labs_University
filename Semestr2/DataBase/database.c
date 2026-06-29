#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Основная структура записи в БД
struct Record {
    char from[40];
    char to[40];
    char company[40];
    int length;
    double duration;
    char date[11];
    enum { OPEN, CLOSED } registration;
    struct Record* next;  // указатель на следующий элемент
};

// Структура базы данных
struct Database {
    struct Record* head;  // указатель на первый элемент
    struct Record* tail;  // указатель на последний элемент
    int count;            // количество записей
};

// Прототипы функций
struct Database* create_database();
void insert_record(struct Database* db);
void delete_record(struct Database* db);
void print_record(struct Record* record);
void show_record(struct Database* db);
void show_table(struct Database* db);
void save_to_file(struct Database* db);
void load_from_file(struct Database* db);
void free_database(struct Database* db);
void clear_input_buffer();
char* status_of_registration(int registration);

int main() {
    struct Database* db = create_database(); // Инициализация БД
    while (1) {
        int choice;
        printf("\n0) Выход\n1) Добавить запись\n2) Удалить запись\n3) Вывести запись\n4) Вывести базу данных\n");
        printf("5) Сохранить в файл\n6) Загрузить из файла\n7) Очистить базу данных\nВыберите команду: ");
        int n_enter = scanf("%d", &choice);
        if (n_enter == 1) {
            if (choice == 0) { break; }
            else if (choice == 1) { insert_record(db); }
            else if (choice == 2) { delete_record(db); }
            else if (choice == 3) { show_record(db); }
            else if (choice == 4) { show_table(db); }
            else if (choice == 5) { save_to_file(db); }
            else if (choice == 6) { load_from_file(db); }
            else if (choice == 7) { free_database(db); }
            else {
                printf("Некорректный ввод!\n");
                clear_input_buffer();
            }
        } else {
            printf("Некорректный ввод!\n");
            clear_input_buffer();
        }
    }
    free_database(db);
    return 0;
}

// Создание новой пустой базы данных
struct Database* create_database() {
    struct Database* db = (struct Database*)malloc(sizeof(struct Database));
    if (db) {
        db->head = NULL;
        db->tail = NULL;
        db->count = 0;
    }
    return db;
}

// Вставка записи в конец списка
void insert_record(struct Database* db) {
    if (!db) return;
    
    char from[40], to[40], company[40];
    char date[11];
    int length;
    double duration;
    int registration;
    
    while (1) {
        printf("Введите поля для записи (через пробел):\n");
        printf("откуда / куда / компания / длина (км) / длительность полета (в часах) / ");
        printf("дата вылета (YYYY-MM-DD) / регистрация (1 - открыта, 0 - закрыта)\n");
        int n_enter = scanf("%39s %39s %39s %d %lf %10s %d", from, to, company, &length, &duration, date, &registration);
        if (n_enter == 7) { break; }
        else {
            printf("Некорректный ввод!\n");
            clear_input_buffer();
        }
    }
    
    struct Record* record = (struct Record*)malloc(sizeof(struct Record));
    if (db) {
        strcpy(record->from, from);
        strcpy(record->to, to);
        strcpy(record->company, company);
        record->length = length;
        record->duration = duration;
        strcpy(record->date, date);
        record->registration = (registration) ? OPEN : CLOSED;
    }

    record->next = NULL;
    if (!db->head) {
        // Если список пуст, новый элемент становится и головой, и хвостом
        db->head = record;
        db->tail = record;
    } else {
        // Иначе добавляем в конец и обновляем хвост
        db->tail->next = record;
        db->tail = record;
    }
    db->count++;
    printf("Запись успешно добавлена!\n");
}

// Удаление записи по индексу (с 1)
void delete_record(struct Database* db) {
    if (db->count == 0) {
        printf("База данных пуста\n");
        return;
    }

    int index;
    while (1) {
        printf("Введите индекс строки, которую хотите удалить (1-%d): ", db->count);
        int n_enter = scanf("%d", &index);
        if (n_enter == 1 && 1 <= index && index <= db->count) { break; }
        else {
            printf("Некорректный ввод!\n");
            clear_input_buffer();
        }
    }
    
    struct Record* current = db->head;
    struct Record* prev = NULL;
    int current_index = 1;
    
    // Поиск записи для удаления
    while (current && current_index < index) {
        prev = current;
        current = current->next;
        current_index++;
    }
    
    // Если удаляем первый элемент
    if (prev == NULL) {
        db->head = current->next;
        // Если это был единственный элемент, обновляем хвост
        if (db->head == NULL) {
            db->tail = NULL;
        }
    } 
    // Если удаляем последний элемент
    else if (current->next == NULL) {
        db->tail = prev;
        prev->next = NULL;
    }
    // Удаляем из середины
    else {
        prev->next = current->next;
    }
    
    free(current);  // Освобождаем память удаленной записи
    db->count--;
}

// Вспомогательная функция для вывода одной записи
void print_record(struct Record* record) {
    printf("%.39s | %.39s | %.39s | %7d km | %4.1lf hours | %-10s | %6s\n",
           record->from, record->to, record->company,
           record->length, record->duration, record->date,
           status_of_registration(record->registration));
}

// Вывод одной записи по индексу на экран
void show_record(struct Database* db) {
    if (db->count == 0) {
        printf("База данных пуста\n");
        return;
    }
    int index;
    while (1) {
        printf("Введите индекс строки, которую хотите вывести (1-%d): ", db->count);
        int n_enter = scanf("%d", &index);
        if (n_enter == 1 && 1 <= index && index <= db->count) { break; }
        else {
            printf("Некорректный ввод!\n");
            clear_input_buffer();
        }
    }

    struct Record* current = db->head;
    int current_index = 1;
    
    while (current && current_index < index) {
        current = current->next;
        current_index++;
    }
    printf(" ID |          from                |           to         |");
    printf("           company          | length(km) |  duration  |    date    | registration\n");
    printf("%3d | ", index);
    print_record(current);
}

// Вывод всех записей на экран
void show_table(struct Database* db) {
    if (db->count == 0) {
        printf("База данных пуста\n");
        return;
    }
    
    printf("\n=== База данных содержит %d записей ===\n", db->count);
    printf("--------------------------------------------------------------------------------------------------------------------------------------------\n");
    printf(" ID |          from                |           to         |");
    printf("           company          | length(km) |  duration  |    date    | registration\n");
    struct Record* current = db->head;
    int index = 1;
    while (current) {
        printf("%3d | ", index++);
        print_record(current);
        current = current->next;
    }
    printf("--------------------------------------------------------------------------------------------------------------------------------------------\n");
}

// Сохранение базы данных в текстовый файл
void save_to_file(struct Database* db) {
    if (!db || db->count == 0) {
        printf("База данных пуста, нечего сохранять\n");
        return;
    }
    
    const char* filename;
    printf("Введите путь до файла: ");
    while (scanf("%s", filename) != 1) {
        printf("Ошибка: некорректный ввод!\n");
    }
    FILE* file = fopen(filename, "w");
    if (!file) {
        printf("Ошибка открытия файла %s для записи\n", filename);
        return;
    }
    
    struct Record* current = db->head;
    int saved_count = 0;
    
    while (current) {
        fprintf(file, "%s %s %s %d %.1lf %s %d\n",
                current->from,
                current->to,
                current->company,
                current->length,
                current->duration,
                current->date,
                current->registration);
        current = current->next;
        saved_count++;
    }
    
    fclose(file);
    printf("Сохранено %d записей в файл %s\n", saved_count, filename);
}

// Загрузка базы данных из текстового файла
void load_from_file(struct Database* db) {
    if (!db) {
        db = create_database();
        if (!db) {
            printf("Ошибка создания базы данных\n");
            return;
        }
    }
    
    // Очищаем текущую базу данных перед загрузкой
    if (db->head) {
        printf("Текущая база данных не пуста. Очистить перед загрузкой? (y/n): ");
        char answer;
        scanf(" %c", &answer);
        if (answer == 'y' || answer == 'Y') {
            free_database(db);
            if (!db) {
                printf("Ошибка создания базы данных\n");
                return;
            }
        } else {
            printf("Загрузка отменена\n");
            return;
        }
        clear_input_buffer();
    }
    
    const char* filename;
    printf("Введите путь до файла: ");
    while (scanf("%s", filename) != 1) {
        printf("Ошибка: некорректный ввод!\n");
        return;
    }

    FILE* file = fopen(filename, "r");
    if (!file) {
        printf("Ошибка открытия файла %s для чтения\n", filename);
        return;
    }
    
    char from[40], to[40], company[40], date[11];
    int length, registration;
    double duration;
    int loaded_count = 0;
    
    while (fscanf(file, "%39s %39s %39s %d %lf %10s %d",
                  from, to, company, &length, &duration, date, &registration) == 7) {
        
        struct Record* record = (struct Record*)malloc(sizeof(struct Record));
        if (!record) {
            printf("Ошибка выделения памяти для записи\n");
            break;
        }
        
        strcpy(record->from, from);
        strcpy(record->to, to);
        strcpy(record->company, company);
        record->length = length;
        record->duration = duration;
        strcpy(record->date, date);
        record->registration = (registration) ? OPEN : CLOSED;
        record->next = NULL;
        
        // Добавляем запись в конец списка
        if (!db->head) {
            db->head = record;
            db->tail = record;
        } else {
            db->tail->next = record;
            db->tail = record;
        }
        db->count++;
        loaded_count++;
    }
    
    fclose(file);
    printf("Загружено %d записей из файла %s\n", loaded_count, filename);
}

// Освобождение всей памяти, занятой базой данных
void free_database(struct Database* db) {
    if (!db) return;
    
    // Освобождаем все записи
    struct Record* current = db->head;
    struct Record* next;
    
    while (current) {
        next = current->next;
        free(current);
        current = next;
    }
    free(db);
    printf("Память текущей базы данных освобождена!\n");
    db = create_database();
}

void clear_input_buffer() {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

char* status_of_registration(int registration) {
    switch (registration) {
        case OPEN:
            return "OPEN";
        case CLOSED:
            return "CLOSED";
        default:
            return "UNKNOWN";
    }
}