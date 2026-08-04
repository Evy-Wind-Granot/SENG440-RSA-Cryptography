/*******************************************************************************
 * File:        main.c
 *
 * Description: Benchmark application for branchless Montgomery Modular
 *              Multiplication (MMM). Utilizes bitwise masking and constant-time
 *              conditional operations to mitigate timing side-channel leaks.
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*******************************************************************************
 * Function:    MMM
 *
 * Description: Computes Montgomery Modular Multiplication in constant time:
 *              (X * Y * 2^-m) mod M. Replaces control flow branches with 
 *              bitwise mask operations for bit-by-bit processing and reduction.
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
    unsigned int T;
    unsigned int Xi, T0, Y0;
    unsigned int eta;
    unsigned int maskX, maskEta, maskGE;

    T = 0;
    Y0 = (unsigned int)Y & 1U;

    /* Process operands bit-by-bit from least significant to most significant bit. */
    for (i = 0; i < m; i++) {
        Xi = ((unsigned int)X >> i) & 1U;
        T0 = T & 1U;
        eta = T0 ^ (Xi & Y0);

        /* Construct bitmasks (all 1s for true, all 0s for false) without branches. */
        maskX   = 0U - Xi;  
        maskEta = 0U - eta; 

        /* Accumulate product and modular correction using masked addition. */
        T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
    }

    /* Fixed, branchless conditional reductions (at most two subtractions needed). */
    maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
    T -= maskGE & (unsigned int)M;
    maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
    T -= maskGE & (unsigned int)M;

    return (int)T;
}

/*******************************************************************************
 * Function:    main
 *
 * Description: Entry point. Measures execution performance of branchless MMM
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

    printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
           N, secs, secs * 1e9 / N, acc);

    return 0;
}
