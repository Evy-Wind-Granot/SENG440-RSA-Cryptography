/*******************************************************************************
 * File:        main.c
 *
 * Description: Benchmark application for loop-unrolled, branchless Montgomery
 *              Modular Multiplication (MMM). Combines constant-time bitwise
 *              masking with 4-way loop unrolling to maximize execution speed and
 *              mitigate timing side-channel leaks.
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*******************************************************************************
 * Function:    mmm_step
 *
 * Description: Performs a single radix-2 Montgomery multiplication step in
 *              constant time using bitwise masks instead of control branches.
 *
 * Parameters:  T  - Current intermediate accumulator value.
 *              Xi - Single bit extracted from operand X at iteration i.
 *              Y0 - Least significant bit of operand Y.
 *              Y  - Unsigned integer representation of operand Y.
 *              M  - Unsigned integer representation of modulus M.
 *
 * Returns:     Updated intermediate accumulator value for the next bit step.
 ******************************************************************************/
static inline unsigned int mmm_step(unsigned int T, unsigned int Xi, unsigned int Y0,
                                    unsigned int Y, unsigned int M)
{
    unsigned int T0   = T & 1U;
    unsigned int eta  = T0 ^ (Xi & Y0);
    unsigned int maskX   = 0U - Xi;
    unsigned int maskEta = 0U - eta;

    return (T + (maskX & Y) + (maskEta & M)) >> 1;
}

/*******************************************************************************
 * Function:    MMM
 *
 * Description: Computes Montgomery Modular Multiplication: (X * Y * 2^-m) mod M.
 *              Processes input bits in blocks of 4 using loop unrolling for
 *              improved instruction-level parallelism.
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
    unsigned int T = 0;
    unsigned int UX = (unsigned int)X;
    unsigned int UY = (unsigned int)Y;
    unsigned int UM = (unsigned int)M;
    unsigned int Y0 = UY & 1U;
    unsigned int maskGE;

    int i = 0;
    int limit = m - (m % 4);

    /* Unrolled loop body processing 4 bits per iteration. */
    for (; i < limit; i += 4) {
        T = mmm_step(T, (UX >> i)       & 1U, Y0, UY, UM);
        T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
        T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
        T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
    }

    /* Cleanup loop for remaining bits when m is not a multiple of 4. */
    for (; i < m; i++) {
        T = mmm_step(T, (UX >> i) & 1U, Y0, UY, UM);
    }

    /* Fixed, branchless conditional reductions (at most two subtractions needed). */
    maskGE = 0U - (unsigned int)(T >= UM);
    T -= maskGE & UM;
    maskGE = 0U - (unsigned int)(T >= UM);
    T -= maskGE & UM;

    return (int)T;
}

/*******************************************************************************
 * Function:    main
 *
 * Description: Entry point. Measures execution performance of loop-unrolled MMM
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

    printf("v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
           N, secs, secs * 1e9 / N, acc);

    return 0;
}
