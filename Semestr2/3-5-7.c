#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ULL_MAX 18446744073709551615ULL
#define MAX_TARGET 5000

int validate(char *line);
void solve(int target);

int main(void) {
    char line[256];
    while (fgets(line, sizeof(line), stdin) != NULL) {
        int target = validate(line);
        if (target < 0) printf("error\n");
        else if (target == 0) continue;
        else solve(target);
    }
    return 0;
}

int validate(char *line) {
    if (strchr(line, '\n') == NULL && !feof(stdin)) {
        int ch;
        while ((ch = getchar()) != '\n' && ch != EOF) {}
        return -1;
    }
    char *p = line;
    while (isspace((unsigned char)*p)) p++;
    if (*p == '\0' || *p == '\n') return 0;

    char *end;
    long value = strtol(p, &end, 10);

    while (isspace((unsigned char)*end)) end++;

    if (p == end || *end != '\0') return -1;
    if (value < 1) return -1;
    if (value > MAX_TARGET) return MAX_TARGET;

    return (int)value;
}

void solve(int target) {
    int capacity = 1;
    unsigned long long *nums = (unsigned long long *)malloc((size_t)capacity * sizeof(unsigned long long));
    if (nums == NULL) return;

    nums[0] = 1ULL;
    int start = 0;
    int generated = 0;

    int a = 0, b = 0, c = 0;
    unsigned long long next[3] = {3ULL, 5ULL, 7ULL};
    int ok[3] = {1, 1, 1};
    int overflow = 0;

    while (generated < target) {
        unsigned long long next_num = ULL_MAX;

        for (int k = 0; k < 3; k++) {
            if (ok[k] && next[k] < next_num) {
                next_num = next[k];
            }
        }

        if (next_num == ULL_MAX) {
            overflow = 1;
            break;
        }

        generated++;

        int need = generated - start + 1;
        if (need > capacity) {
            unsigned long long *tmp = (unsigned long long *)realloc(nums, (size_t)need * sizeof(unsigned long long));
            if (tmp == NULL) {
                free(nums);
                return;
            }
            nums = tmp;
            capacity = need;
        }

        nums[generated - start] = next_num;

        if (ok[0] && next_num == next[0]) {
            a++;
            if (nums[a - start] > ULL_MAX / 3ULL) ok[0] = 0;
            else next[0] = nums[a - start] * 3ULL;
        }

        if (ok[1] && next_num == next[1]) {
            b++;
            if (nums[b - start] > ULL_MAX / 5ULL) ok[1] = 0;
            else next[1] = nums[b - start] * 5ULL;
        }

        if (ok[2] && next_num == next[2]) {
            c++;
            if (nums[c - start] > ULL_MAX / 7ULL) ok[2] = 0;
            else next[2] = nums[c - start] * 7ULL;
        }

        int min_abc = (a < b) ? ((a < c) ? a : c) : ((b < c) ? b : c);

        if (min_abc > start) {
            int shift = min_abc - start;
            int keep = generated - min_abc + 1;

            memmove(nums, nums + shift, (size_t)keep * sizeof(unsigned long long));

            unsigned long long *tmp = (unsigned long long *)realloc(nums, (size_t)keep * sizeof(unsigned long long));
            if (tmp != NULL) {
                nums = tmp;
                capacity = keep;
            }

            start = min_abc;
        }
    }

    if (overflow || target < start || target > generated) {
        printf("overflow\n");
    } else {
        printf("%llu\n", nums[target - start]);
    }

    free(nums);
}
