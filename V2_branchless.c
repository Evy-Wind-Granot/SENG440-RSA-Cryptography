#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int MMM(int X, int Y, int M, int m)
{
    int i;
    unsigned int T;
    unsigned int Xi, T0, Y0;
    unsigned int eta;
    unsigned int maskX, maskEta, maskGE;

    T = 0;
    Y0 = (unsigned int)Y & 1U;

    for (i = 0; i < m; i++) {
        Xi = ((unsigned int)X >> i) & 1U;
        T0 = T & 1U;
        eta = T0 ^ (Xi & Y0);

        maskX   = 0U - Xi;   /* all-1s if Xi==1, else 0 */
        maskEta = 0U - eta;  /* all-1s if eta==1, else 0 */

        T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
    }

    /* two fixed, branchless conditional subtracts (bound proven for v1) */
    maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
    T -= maskGE & (unsigned int)M;
    maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
    T -= maskGE & (unsigned int)M;

    return (int)T;
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

    printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
           N, secs, secs * 1e9 / N, acc);
    return 0;
}
