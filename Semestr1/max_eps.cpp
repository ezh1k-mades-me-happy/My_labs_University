#include <stdio.h>
#include <math.h>


long double preciseSum(long double sum, long double f) {
    long double s = sum + f;
    long double err = (sum - (s - f)) + (f - (s - sum));
    return s + err;
}

double Summer(double x) {
    long double sum = 0.0;
    long double f;
    long double znak;
    long double x_3;
    long double koren;
    long double del;
    long double prev_sum;
    long i = 1;
    do {
        znak = pow(-1, i);
        x_3 = powl(x, (3 * i + 3));
        koren = sqrtl(i - x);
        del = (long double) i * (long double) (i+2) * (long double) (i+5);
        f = (znak*x_3*koren)/del;
        prev_sum = sum;
        sum = preciseSum(sum, f);
        printf("%d %.15lf\n", i, (double)f);
        i++;
    } while (sum != prev_sum);
    return sum;
}

int main() {
    double x;
    // scanf("%lf", &x);
    x = 0.9999;
    double res = Summer(x);
    printf("\nResult: %.15f\n", res);
    return 0;
}