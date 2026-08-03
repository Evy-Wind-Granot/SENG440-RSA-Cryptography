#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int MMM(int X, int Y, int M, int m)
{
    int i;
    int T;
    int Xi, T0, Y0;
    int eta;
    int Xi_Y;
    int eta_M;

    T = 0;
    Y0 = Y & 1;
    for (i = 0; i < m; i++) {
        Xi = (X >> i) & 1;
        T0 = T & 1;
        eta = T0 ^ (Xi & Y0);
        Xi_Y = Xi ? Y : 0;
        eta_M = eta ? M : 0;
        T = (T + Xi_Y + eta_M) >> 1;
    }
    /* proven bound: at most 2 subtractions needed for m<=12, X,Y<2^m */
    if (T >= M) T -= M;
    if (T >= M) T -= M;
    return T;
}

int main(void)
{
    const int M = 3233;
    const int m = 12;
    const long N = 20000000L;
    volatile long acc = 0;

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);

    for (long i = 0; i < N; i++) {
        int X = (int)((i * 2654435761U) % 4096U);
        int Y = (int)((i * 40503U + 1) % 4096U);
        acc += MMM(X, Y, M, m);
    }

    clock_gettime(CLOCK_MONOTONIC, &t1);
    double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;

    printf("v1_bounded_reduction: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
           N, secs, secs * 1e9 / N, acc);
    return 0;
}
