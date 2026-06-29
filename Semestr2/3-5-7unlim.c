#include <ctype.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_REQUESTS 10000
#define BIGINT_BASE 1000000000U

typedef struct {
    uint32_t *d;   // цифры в base 1e9, младшая впереди
    int size;      // сколько цифр реально используется
    int capacity;  // сколько выделено
} BigInt;

void input(int *requests, int *cnt);
int solve(const int *requests, int cnt);

static void bigint_init(BigInt *x);
static void bigint_destroy(BigInt *x);
static int bigint_reserve(BigInt *x, int need);
static int bigint_from_u32(BigInt *x, uint32_t value);
static int bigint_copy(BigInt *dst, const BigInt *src);
static int bigint_mul_small(BigInt *dst, const BigInt *src, uint32_t m);
static int bigint_cmp(const BigInt *a, const BigInt *b);
static void bigint_print(const BigInt *x);

static int reserve_nums(BigInt **nums, int *capacity, int need);
static void shrink_left(BigInt **nums, int *capacity, int *start, int generated, int new_start);
static void shrink_right(BigInt **nums, int *capacity, int start, int *generated, int new_generated);
static void free_nums(BigInt *nums, int capacity);

int main(void) {
    int *requests = (int *)calloc(MAX_REQUESTS, sizeof(int));
    int cnt = 0;

    if (requests == NULL) return 1;

    input(requests, &cnt);
    solve(requests, cnt);

    free(requests);
    return 0;
}

void input(int *requests, int *cnt) {
    char line[256];
    int i = 0;

    while (i < MAX_REQUESTS && fgets(line, sizeof(line), stdin) != NULL) {
        char *p = line;
        char *end;
        long value;

        while (isspace((unsigned char)*p)) p++;
        if (*p == '\0' || *p == '\n') continue;

        value = strtol(p, &end, 10);
        while (isspace((unsigned char)*end)) end++;

        if (p == end || *end != '\0' || value < 1 || value > INT_MAX) {
            requests[i++] = -1;
        } else {
            requests[i++] = (int)value;
        }
    }

    *cnt = i;
}

int solve(const int *requests, int cnt) {
    int max_of_request = 0;
    for (int i = 0; i < cnt; i++) {
        if (requests[i] > max_of_request) {
            max_of_request = requests[i];
        }
    }

    int *future_count = (int *)calloc((size_t)max_of_request + 1, sizeof(int));
    if (future_count == NULL) {
        for (int i = 0; i < cnt; i++) {
            printf(requests[i] < 1 ? "error\n" : "overflow\n");
        }
        return 1;
    }

    for (int i = 0; i < cnt; i++) {
        if (requests[i] > 0) {
            future_count[requests[i]]++;
        }
    }

    int capacity = 1;
    BigInt *nums = (BigInt *)calloc((size_t)capacity, sizeof(BigInt));
    if (nums == NULL) {
        free(future_count);
        for (int i = 0; i < cnt; i++) {
            printf(requests[i] < 1 ? "error\n" : "overflow\n");
        }
        return 1;
    }

    int start = 0;
    int generated = 0;

    BigInt next[3];
    bigint_init(&next[0]);
    bigint_init(&next[1]);
    bigint_init(&next[2]);

    int fatal_overflow = 0;

    if (bigint_from_u32(&nums[0], 1U) ||
        bigint_from_u32(&next[0], 3U) ||
        bigint_from_u32(&next[1], 5U) ||
        bigint_from_u32(&next[2], 7U)) {
        fatal_overflow = 1;
    }

    int a = 0, b = 0, c = 0;
    int future_max = max_of_request;

    for (int i = 0; i < cnt; i++) {
        int target = requests[i];

        if (target < 1) {
            printf("error\n");
            continue;
        }

        if (!fatal_overflow && target > generated) {
            int need = target - start + 1;
            if (reserve_nums(&nums, &capacity, need)) {
                fatal_overflow = 1;
            } else {
                while (!fatal_overflow && generated < target) {
                    int min_idx = 0;
                    if (bigint_cmp(&next[1], &next[min_idx]) < 0) min_idx = 1;
                    if (bigint_cmp(&next[2], &next[min_idx]) < 0) min_idx = 2;

                    if (bigint_copy(&nums[generated - start + 1], &next[min_idx])) {
                        fatal_overflow = 1;
                        break;
                    }

                    generated++;
                    BigInt *cur = &nums[generated - start];

                    if (bigint_cmp(cur, &next[0]) == 0) {
                        a++;
                        if (bigint_mul_small(&next[0], &nums[a - start], 3U)) {
                            fatal_overflow = 1;
                        }
                    }

                    if (!fatal_overflow && bigint_cmp(cur, &next[1]) == 0) {
                        b++;
                        if (bigint_mul_small(&next[1], &nums[b - start], 5U)) {
                            fatal_overflow = 1;
                        }
                    }

                    if (!fatal_overflow && bigint_cmp(cur, &next[2]) == 0) {
                        c++;
                        if (bigint_mul_small(&next[2], &nums[c - start], 7U)) {
                            fatal_overflow = 1;
                        }
                    }
                }
            }
        }

        if (target >= start && target <= generated) {
            bigint_print(&nums[target - start]);
        } else {
            printf("overflow\n");
        }

        if (fatal_overflow) {
            continue;
        }

        future_count[target]--;

        if (target == future_max && future_count[target] == 0) {
            while (future_max > 0 && future_count[future_max] == 0) {
                future_max--;
            }

            if (future_max == 0) {
                free_nums(nums, capacity);
                nums = NULL;
                capacity = 0;
                start = 0;
                generated = -1;
                continue;
            }

            if (generated > future_max) {
                shrink_right(&nums, &capacity, start, &generated, future_max);
            }
        }

        if (nums != NULL && generated >= start) {
            int min_abc = (a < b) ? ((a < c) ? a : c) : ((b < c) ? b : c);
            int new_start = start;

            while (new_start < min_abc &&
                   new_start <= generated &&
                   future_count[new_start] == 0) {
                new_start++;
            }

            if (new_start > start) {
                shrink_left(&nums, &capacity, &start, generated, new_start);
            }
        }
    }

    free_nums(nums, capacity);
    bigint_destroy(&next[0]);
    bigint_destroy(&next[1]);
    bigint_destroy(&next[2]);
    free(future_count);

    return fatal_overflow ? 1 : 0;
}

/* ---------------- BigInt ---------------- */

static void bigint_init(BigInt *x) {
    x->d = NULL;
    x->size = 0;
    x->capacity = 0;
}

static void bigint_destroy(BigInt *x) {
    free(x->d);
    x->d = NULL;
    x->size = 0;
    x->capacity = 0;
}

static int bigint_reserve(BigInt *x, int need) {
    if (need <= x->capacity) return 0;

    int new_capacity = (x->capacity > 0) ? x->capacity : 1;
    while (new_capacity < need) {
        if (new_capacity > INT_MAX / 2) {
            new_capacity = need;
            break;
        }
        new_capacity *= 2;
    }

    uint32_t *tmp = (uint32_t *)realloc(x->d, (size_t)new_capacity * sizeof(uint32_t));
    if (tmp == NULL) return 1;

    x->d = tmp;
    x->capacity = new_capacity;
    return 0;
}

static int bigint_from_u32(BigInt *x, uint32_t value) {
    if (bigint_reserve(x, 1)) return 1;
    x->d[0] = value;
    x->size = 1;
    return 0;
}

static int bigint_copy(BigInt *dst, const BigInt *src) {
    if (bigint_reserve(dst, src->size)) return 1;
    memcpy(dst->d, src->d, (size_t)src->size * sizeof(uint32_t));
    dst->size = src->size;
    return 0;
}

static int bigint_mul_small(BigInt *dst, const BigInt *src, uint32_t m) {
    if (m == 0) return bigint_from_u32(dst, 0);

    if (bigint_reserve(dst, src->size + 1)) return 1;

    uint64_t carry = 0;
    for (int i = 0; i < src->size; i++) {
        uint64_t cur = (uint64_t)src->d[i] * m + carry;
        dst->d[i] = (uint32_t)(cur % BIGINT_BASE);
        carry = cur / BIGINT_BASE;
    }

    dst->size = src->size;
    if (carry != 0) {
        dst->d[dst->size++] = (uint32_t)carry;
    }

    return 0;
}

static int bigint_cmp(const BigInt *a, const BigInt *b) {
    if (a->size != b->size) {
        return (a->size < b->size) ? -1 : 1;
    }

    for (int i = a->size - 1; i >= 0; i--) {
        if (a->d[i] != b->d[i]) {
            return (a->d[i] < b->d[i]) ? -1 : 1;
        }
    }

    return 0;
}

static void bigint_print(const BigInt *x) {
    if (x->size == 0) {
        printf("0\n");
        return;
    }

    printf("%u", x->d[x->size - 1]);
    for (int i = x->size - 2; i >= 0; i--) {
        printf("%09u", x->d[i]);
    }
    printf("\n");
}

/* -------------- массив BigInt -------------- */

static int reserve_nums(BigInt **nums, int *capacity, int need) {
    if (need <= *capacity) return 0;

    int old_capacity = *capacity;
    BigInt *tmp = (BigInt *)realloc(*nums, (size_t)need * sizeof(BigInt));
    if (tmp == NULL) return 1;

    *nums = tmp;
    for (int i = old_capacity; i < need; i++) {
        bigint_init(&(*nums)[i]);
    }

    *capacity = need;
    return 0;
}

static void shrink_right(BigInt **nums, int *capacity, int start, int *generated, int new_generated) {
    if (*nums == NULL || new_generated >= *generated) return;

    int old_len = *generated - start + 1;
    int keep = new_generated - start + 1;
    if (keep < 0) keep = 0;

    for (int i = keep; i < old_len; i++) {
        bigint_destroy(&(*nums)[i]);
    }

    if (keep == 0) {
        free(*nums);
        *nums = NULL;
        *capacity = 0;
        *generated = new_generated;
        return;
    }

    BigInt *tmp = (BigInt *)realloc(*nums, (size_t)keep * sizeof(BigInt));
    if (tmp != NULL) {
        *nums = tmp;
        *capacity = keep;
    }

    *generated = new_generated;
}

static void shrink_left(BigInt **nums, int *capacity, int *start, int generated, int new_start) {
    if (*nums == NULL || new_start <= *start) return;

    int old_start = *start;
    int old_len = generated - old_start + 1;
    int shift = new_start - old_start;
    int keep = old_len - shift;

    if (shift <= 0) return;

    for (int i = 0; i < shift && i < old_len; i++) {
        bigint_destroy(&(*nums)[i]);
    }

    if (keep > 0) {
        memmove(*nums, *nums + shift, (size_t)keep * sizeof(BigInt));

        for (int i = keep; i < old_len; i++) {
            (*nums)[i].d = NULL;
            (*nums)[i].size = 0;
            (*nums)[i].capacity = 0;
        }

        BigInt *tmp = (BigInt *)realloc(*nums, (size_t)keep * sizeof(BigInt));
        if (tmp != NULL) {
            *nums = tmp;
            *capacity = keep;
        }
    } else {
        free(*nums);
        *nums = NULL;
        *capacity = 0;
    }

    *start = new_start;
}

static void free_nums(BigInt *nums, int capacity) {
    if (nums == NULL) return;
    for (int i = 0; i < capacity; i++) {
        bigint_destroy(&nums[i]);
    }
    free(nums);
}
