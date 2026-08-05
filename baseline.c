/*******************************************************************************
 * File:        main.c
 *
 * Description: Benchmark application for baseline Montgomery Modular
 *              Multiplication (MMM). Computes bit-by-bit modular multiplication
 *              using a standard iterative loop reduction.
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*******************************************************************************
 * Function:    MMM
 *
 * Description: Computes Montgomery Modular Multiplication: (X * Y * 2^-m) mod M.
 *              Uses standard conditional expressions and a baseline while-loop
 *              for final modular reduction.
 *
 * Parameters:  X - First operand, bounded by 0 <= X < 2^m.
 *              Y - Second operand, bounded by 0 <= Y < 2^m.
 *              M - Modulus (must be an odd positive integer).
 *              m - Bit length of the modulus M.
 *
 * Returns:     Result of the Montgomery modular multiplication in range [0, M-1].
 ******************************************************************************/
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

    /* Process operands bit-by-bit from least significant to most significant bit. */
    for (i = 0; i < m; i++) {
        Xi = (X >> i) & 1;
        T0 = T & 1;
        eta = T0 ^ (Xi & Y0);
        Xi_Y = Xi ? Y : 0;
        eta_M = eta ? M : 0;
        T = (T + Xi_Y + eta_M) >> 1;
    }

    /* Reduce intermediate accumulator to the range [0, M-1]. */
    while (T >= M) {
        T -= M;
    }

    return T;
}

/*******************************************************************************
 * Function:    main
 *
 * Description: Entry point. Measures execution performance of baseline MMM
 *              calls across a fixed number of iterations.
 *
 * Parameters:  void
 *
 * Returns:     0 on successful completion.
 ******************************************************************************/
int main(void)
{
    const int M = 3233;
    const int m = 12;
    const long N = 20000000L;
    volatile long acc = 0;

    struct timespec t0, t1;

    /* Record start timestamp. */
    clock_gettime(CLOCK_MONOTONIC, &t0);

    /* Benchmark loop executing pseudo-random inputs. */
    for (long i = 0; i < N; i++) {
        int X = (int)((i * 2654435761U) % 4096U);
        int Y = (int)((i * 40503U + 1) % 4096U);
        acc += MMM(X, Y, M, m);
    }

    /* Record end timestamp and calculate elapsed runtime. */
    clock_gettime(CLOCK_MONOTONIC, &t1);
    double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;

    printf("v0_baseline: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
           N, secs, secs * 1e9 / N, acc);

    return 0;
}
