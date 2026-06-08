/******************************************************************************************
 *  rsa_mont.c
 *  Montgomery‑based RSA demo for the SENG440 lesson.
 *
 *  - Implements bit‑wise Montgomery multiplication (MMM)
 *  - Provides a modular‑exponentiation function that uses MMM
 *  - Shows the RSA example: P=61, Q=53, N=PQ=3233, E=17, D=2753
 *    Encrypts M=123 → C=855, then decrypts back to 123.
 *
 *  The code is written for a 32‑bit word size (the VM is ARM HF 32‑bit) but works
 *  for any modulus that fits in an unsigned int (≤ 32 bits).  For larger moduli
 *  you would need a multi‑precision version – not required for the lesson.
 *
 *  Compile (on the VM):
 *      gcc -Wall -Wextra -O2 -o rsa_mont rsa_mont.c
 *
 *  Run:
 *      ./rsa_mont
 *
 *  No external libraries are needed.
 ******************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

/*------------------------------ Montgomery Multiplication ------------------------------*/
/*
 * Compute  (X * Y * R^-1) mod M
 * where R = 2^m  and  m = bit‑length of M.
 * The function assumes:
 *   - M is odd and > 1
 *   - 0 ≤ X, Y < M
 *   - The result also lies in [0, M-1].
 *
 * The algorithm follows the bit‑wise description given in the lesson:
 *   T = 0
 *   for i = 0 … m‑1
 *       η = T0 XOR (Xi AND Y0)
 *       T = (T + Xi·Y + η·M) >> 1
 *       if T ≥ M: T = T − M
 *   return T
 */
static unsigned int montgomery_mul(unsigned int X,
                                   unsigned int Y,
                                   unsigned int M,
                                   unsigned int m_bits)
{
    if (M == 0 || M == 1)               /* degenerate cases */
        return 0;

    unsigned int Y0 = Y & 1U;           /* least‑significant bit of Y */
    unsigned long long T = 0ULL;        /* need up to ~3×M bits */

    for (unsigned int i = 0; i < m_bits; ++i)
    {
        unsigned int Xi = (X >> i) & 1U;            /* i‑th bit of X (LSB=0) */
        unsigned int T0 = (unsigned int)(T & 1ULL);/* LSB of T */
        unsigned int eta = T0 ^ (Xi & Y0);          /* η = T0 xor (Xi & Y0) */

        if (Xi) T += (unsigned long long)Y;         /* add Y if Xi=1 */
        if (eta) T += (unsigned long long)M;       /* add M if η=1 */

        T >>= 1ULL;                                 /* divide by 2 */

        if (T >= (unsigned long long)M)            /* reduce if needed */
            T -= (unsigned long long)M;
    }
    return (unsigned int)T;
}

/*------------------------------ Modular Exponentiation -------------------------------*/
/*
 * Compute base^exp mod M using Montgomery multiplication.
 * Steps:
 *   1. Determine m = bit‑length of M.
 *   2. Pre‑compute R = 2^m mod M   and   R2 = R^2 mod M.
 *   3. Convert base to Montgomery domain:  x̄ = base * R2 mod M   (via MMM)
 *   4. Initialise result in Montgomery domain: r̄ = R mod M   (i.e. 1·R mod M)
 *   5. Square‑and‑multiply loop using MMM.
 *   6. Convert result back from Montgomery domain:  result = r̄ * 1 mod M   (via MMM with Y=1)
 */
static unsigned int mod_exp_mont(unsigned int base,
                                 unsigned int exp,
                                 unsigned int M)
{
    if (M == 0) return 0;
    if (M == 1) return 0;               /* everything ≡ 0 (mod 1) */

    /* Determine bit‑length of M */
    unsigned int m_bits = 0;
    unsigned int mm = M;
    while (mm) {
        ++m_bits;
        mm >>= 1;
    }
    if (m_bits == 0) return 0;          /* should not happen for M≥2 */

    /* R = 2^m mod M */
    unsigned int R = 1U;
    for (unsigned int i = 0; i < m_bits; ++i)
        R = (R << 1) % M;

    /* R2 = R^2 mod M */
    unsigned int R2 = (R * R) % M;

    /* Convert base to Montgomery domain: base * R2 mod M */
    unsigned int base_mont = montgomery_mul(base, R2, M, m_bits);

    /* Montgomery representation of 1 is R mod M */
    unsigned int result_mont = R;   /* because 1 * R mod M = R */

    /* Square‑and‑multiply */
    unsigned int e = exp;
    while (e) {
        if (e & 1U)
            result_mont = montgomery_mul(result_mont, base_mont, M, m_bits);
        base_mont = montgomery_mul(base_mont, base_mont, M, m_bits);
        e >>= 1;
    }

    /* Convert back from Montgomery domain: result * 1 mod M */
    unsigned int result = montgomery_mul(result_mont, 1U, M, m_bits);
    return result;
}

/*------------------------------ Demo / Test ----------------------------------------*/
int main(void)
{
    /* RSA parameters from the lesson */
    const unsigned int P = 61U;
    const unsigned int Q = 53U;
    const unsigned int N = P * Q;        /* modulus */
    const unsigned int E = 17U;          /* public exponent */
    const unsigned int D = 2753U;        /* private exponent */
    const unsigned int M = 123U;         /* plaintext message */

    printf("=== RSA demo using Montgomery multiplication ===\n");
    printf("P = %u\n", P);
    printf("Q = %u\n", Q);
    printf("N = P·Q = %u\n", N);
    printf("Public exponent  E = %u\n", E);
    printf("Private exponent D = %u\n", D);
    printf("Plaintext  M = %u\n\n", M);

    /* Encrypt: C = M^E mod N */
    unsigned int C = mod_exp_mont(M, E, N);
    printf("Ciphertext C = M^E mod N = %u\n", C);

    /* Decrypt: M' = C^D mod N */
    unsigned int Mp = mod_exp_mont(C, D, N);
    printf("Decrypted  M' = C^D mod N = %u\n", Mp);

    /* Verify */
    if (Mp == M)
        printf("\nSUCCESS: Decryption recovered the original plaintext.\n");
    else
        printf("\nERROR: Decryption failed.\n");

    /* Optional: Show that MMM really computes (X·Y·R⁻¹) mod N */
    printf("\n--- Quick sanity check of MMM ---\n");
    unsigned int X = 123U, Y = 1U;          /* trivial test */
    unsigned int mN = 0U;                   /* bit‑length of N */
    {
        unsigned int tmp = N;
        while (tmp) { ++mN; tmp >>= 1; }
    }
    unsigned int R = 1U;
    for (unsigned int i = 0; i < mN; ++i) R = (R << 1) % N;
    unsigned int Rinv = 0U;                 /* we could compute it with extended Euclid,
                                            but for the demo we just trust the lesson */
    /* Using the known Rinv from the lesson: 1742 */
    Rinv = 1742U;
    unsigned int mmm_res = montgomery_mul(X, Y, N, mN);
    unsigned int brute = (X * Y * Rinv) % N;
    printf("MMM(%u,%u,%u,%u) = %u\n", X, Y, N, mN, mmm_res);
    printf("(X·Y·R⁻¹) %% N = %u\n", brute);
    if (mmm_res == brute)
        printf("MMM matches the brute‑force computation.\n");
    else
        printf("MMM mismatch!\n");

    return EXIT_SUCCESS;
}