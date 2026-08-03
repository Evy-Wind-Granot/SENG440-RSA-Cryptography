#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static inline unsigned int mmm_step(unsigned int T, unsigned int Xi, unsigned int Y0,
                                     unsigned int Y, unsigned int M)
{
    unsigned int T0  = T & 1U;
    unsigned int eta = T0 ^ (Xi & Y0);
    unsigned int maskX   = 0U - Xi;
    unsigned int maskEta = 0U - eta;
    return (T + (maskX & Y) + (maskEta & M)) >> 1;
}

int MMM(int X, int Y, int M, int m)
{
    unsigned int T = 0;
    unsigned int UX = (unsigned int)X;
    unsigned int UY = (unsigned int)Y;
    unsigned int UM = (unsigned int)M;
    unsigned int Y0 = UY & 1U;
    unsigned int maskGE;

    int i = 0;
    int limit = m - (m % 4);
    for (; i < limit; i += 4) {
        T = mmm_step(T, (UX >> i)       & 1U, Y0, UY, UM);
        T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
        T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
        T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
    }
    for (; i < m; i++) {
        T = mmm_step(T, (UX >> i) & 1U, Y0, UY, UM);
    }

    maskGE = 0U - (unsigned int)(T >= UM);
    T -= maskGE & UM;
    maskGE = 0U - (unsigned int)(T >= UM);
    T -= maskGE & UM;

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

    printf("v4_final: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
           N, secs, secs * 1e9 / N, acc);
    return 0;
}
