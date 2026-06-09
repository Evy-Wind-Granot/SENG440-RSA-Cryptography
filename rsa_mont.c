#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>

/* ============================================================
 * Utility: GCD (Euclidean algorithm)
 * ============================================================ */
static uint64_t gcd(uint64_t a, uint64_t b) {
    while (b) { uint64_t t = b; b = a % b; a = t; }
    return a;
}

/* ============================================================
 * Utility: Simple primality check (trial division)
 * ============================================================ */
static int is_prime(uint64_t n) {
    if (n < 2) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;
    for (uint64_t i = 3; i * i <= n; i += 2)
        if (n % i == 0) return 0;
    return 1;
}

/* ============================================================
 * Utility: Print an integer in binary (MSB first, 'bits' wide)
 * ============================================================ */
static void print_binary(uint64_t val, int bits) {
    for (int i = bits - 1; i >= 0; i--)
        printf("%d", (int)((val >> i) & 1ULL));
}

/* ============================================================
 * Montgomery Modular Multiplication (MMM)
 * Returns Z = (X * Y * R^-1) mod M,  R = 2^m, m = bit-length of M
 * Algorithm from the SENG 440 lecture slides (bit-wise version).
 * ============================================================ */
uint64_t MMM(uint64_t X, uint64_t Y, uint64_t M) {
    if (M <= 1) return 0;

    /* Determine m = bit-length of M */
    int m = 0;
    uint64_t tmp = M;
    while (tmp) { m++; tmp >>= 1; }

    uint64_t Y0 = Y & 1ULL;
    uint64_t T  = 0ULL;

    for (int i = 0; i < m; i++) {
        uint64_t Xi  = (X >> i) & 1ULL;
        uint64_t T0  = T & 1ULL;
        uint64_t eta = T0 ^ (Xi & Y0);    /* eta = T[0] XOR (X[i] AND Y[0]) */
        if (Xi)  T += Y;
        if (eta) T += M;
        T >>= 1;
    }
    if (T >= M) T -= M;
    return T;
}

/* ============================================================
 * Montgomery Modular Exponentiation (MME)
 * Computes Base^Exp mod M using left-to-right square-and-multiply,
 * operating entirely in the Montgomery domain.
 * ============================================================ */
uint64_t MME(uint64_t Base, uint64_t Exp, uint64_t M, int verbose) {
    if (M <= 1) return 0;

    /* 1. Determine m and derive R = 2^m mod M, R^2 mod M */
    int m = 0;
    uint64_t tmp = M;
    while (tmp) { m++; tmp >>= 1; }

    uint64_t R  = (1ULL << m) % M;
    uint64_t R2 = (R * R) % M;

    if (verbose) {
        printf("  m (bit-length of M=%" PRIu64 ")  = %d\n", M, m);
        printf("  R  = 2^m mod M            = %" PRIu64 "\n", R);
        printf("  R^2 mod M                 = %" PRIu64 "\n", R2);
    }

    /* 2. Scale Base into the Montgomery domain: X' = Base * R mod M */
    uint64_t X_scaled = MMM(Base, R2, M);
    if (verbose)
        printf("  Base' = MMM(%" PRIu64 ", R^2, M)  = %" PRIu64
               "  [Base scaled into Montgomery domain]\n",
               Base, X_scaled);

    /* 3. Initialise accumulator as 1 in Montgomery domain: Z' = R mod M */
    uint64_t Z_scaled = R;
    if (verbose)
        printf("  Z'  initialised to R mod M = %" PRIu64
               "  [represents 1 in Montgomery domain]\n\n", Z_scaled);

    /* 4. Determine exponent bit-length */
    int exp_bits = 0;
    uint64_t te = Exp;
    while (te) { exp_bits++; te >>= 1; }

    if (verbose) {
        printf("  Exponent %" PRIu64 " in binary = ", Exp);
        print_binary(Exp, exp_bits);
        printf("  (%d bits)\n\n", exp_bits);
        printf("  %-5s  %-3s  %-12s  %-12s  %-12s\n",
               "Step", "Bit", "Z' (before)", "Z' (squared)", "Z' (x Base')");
        printf("  %-5s  %-3s  %-12s  %-12s  %-12s\n",
               "-----","---","------------","------------","------------");
    }

    /* 5. Left-to-right square-and-multiply in Montgomery domain */
    for (int i = exp_bits - 1; i >= 0; i--) {
        uint64_t ei      = (Exp >> i) & 1ULL;
        uint64_t before  = Z_scaled;

        Z_scaled         = MMM(Z_scaled, Z_scaled, M);   /* square */
        uint64_t squared = Z_scaled;

        if (ei) Z_scaled = MMM(Z_scaled, X_scaled, M);   /* multiply */

        if (verbose)
            printf("  %-5d  %-3" PRIu64 "  %-12" PRIu64 "  %-12" PRIu64
                   "  %s\n",
                   exp_bits - 1 - i, ei,
                   before, squared,
                   ei ? "yes -> " : "no  (skip)");
        if (verbose && ei)
            printf("  %38s%-12" PRIu64 "\n", "", Z_scaled);
    }

    /* 6. Scale result back from Montgomery domain: Z = Z' * 1 * R^-1 mod M */
    uint64_t Z = MMM(Z_scaled, 1ULL, M);
    if (verbose)
        printf("\n  Z' = %" PRIu64
               "  =>  Z = MMM(Z', 1, M) = %" PRIu64
               "  [scaled back from Montgomery domain]\n", Z_scaled, Z);

    return Z;
}

/* ============================================================
 * RSA parameter validation
 * Returns 1 if all checks pass, 0 otherwise.
 * Also fills in *M_out and *phi_out.
 * ============================================================ */
static int validate_rsa(uint64_t P, uint64_t Q, uint64_t E, uint64_t D,
                        uint64_t *M_out, uint64_t *phi_out) {
    int ok = 1;
    printf("\n=== RSA Parameter Validation ===\n");

    if (!is_prime(P)) {
        printf("  [FAIL] P = %" PRIu64 " is NOT prime.\n", P); ok = 0;
    } else printf("  [ OK ] P = %" PRIu64 " is prime.\n", P);

    if (!is_prime(Q)) {
        printf("  [FAIL] Q = %" PRIu64 " is NOT prime.\n", Q); ok = 0;
    } else printf("  [ OK ] Q = %" PRIu64 " is prime.\n", Q);

    if (!ok) return 0;   /* can't proceed without valid primes */

    if (P == Q) {
        printf("  [FAIL] P and Q must be distinct primes.\n"); return 0;
    } else printf("  [ OK ] P != Q.\n");

    uint64_t M   = P * Q;
    uint64_t phi = (P - 1) * (Q - 1);
    *M_out   = M;
    *phi_out = phi;
    printf("  [ OK ] M   = P * Q       = %" PRIu64 "\n", M);
    printf("  [ OK ] phi = (P-1)*(Q-1) = %" PRIu64 "\n", phi);

    if (E <= 1 || E >= phi) {
        printf("  [FAIL] E = %" PRIu64 " must satisfy 1 < E < phi (%" PRIu64 ").\n",
               E, phi); ok = 0;
    } else printf("  [ OK ] E = %" PRIu64 " is in range (1, phi).\n", E);

    if (gcd(E, phi) != 1) {
        printf("  [FAIL] gcd(E=%" PRIu64 ", phi=%" PRIu64 ") = %" PRIu64
               " != 1  (E and phi must be coprime).\n",
               E, phi, gcd(E, phi)); ok = 0;
    } else printf("  [ OK ] gcd(E=%" PRIu64 ", phi=%" PRIu64 ") = 1.\n", E, phi);

    /* D * E ≡ 1 (mod phi)
     * Computed as repeated doubling to avoid overflow on 32-bit targets
     * where __uint128_t is unavailable.  Runs in O(64) iterations. */
    uint64_t de_mod = 0;
    uint64_t base   = D % phi;
    uint64_t exp    = E;
    while (exp) {
        if (exp & 1ULL) {
            de_mod += base;
            if (de_mod >= phi) de_mod -= phi;
        }
        base += base;
        if (base >= phi) base -= phi;
        exp >>= 1;
    }
    if (de_mod != 1) {
        printf("  [FAIL] D*E mod phi = %" PRIu64
               " != 1  (D is not the multiplicative inverse of E).\n",
               de_mod); ok = 0;
    } else printf("  [ OK ] D*E mod phi = 1  (D is the multiplicative inverse of E).\n");

    return ok;
}

/* ============================================================
 * main
 * ============================================================ */
int main(void) {
    uint64_t P, Q, E, D, M = 0, phi = 0;

    printf("========================================\n");
    printf("  RSA Cryptography Demo (Montgomery MMM)\n");
    printf("========================================\n\n");

    printf("Enter Prime P            (e.g.   61): "); scanf("%" SCNu64, &P);
    printf("Enter Prime Q            (e.g.   53): "); scanf("%" SCNu64, &Q);
    printf("Enter Public Exponent E  (e.g.   17): "); scanf("%" SCNu64, &E);
    printf("Enter Private Exponent D (e.g. 2753): "); scanf("%" SCNu64, &D);

    if (!validate_rsa(P, Q, E, D, &M, &phi)) {
        printf("\n[ABORT] Invalid RSA parameters — please correct and retry.\n");
        return 1;
    }

    printf("\n  All RSA parameters are VALID.\n");
    printf("  Public  key : (E=%" PRIu64 ", M=%" PRIu64 ")\n", E, M);
    printf("  Private key :  D=%" PRIu64 "\n\n", D);

    uint64_t T;
    printf("Enter plaintext T (integer, 0 < T < %" PRIu64 "): ", M);
    scanf("%" SCNu64, &T);
    if (T == 0 || T >= M) {
        printf("[ABORT] Plaintext must satisfy 0 < T < %" PRIu64 ".\n", M);
        return 1;
    }

    /* ---- ENCRYPTION --------------------------------------- */
    printf("\n========================================\n");
    printf("  ENCRYPTION:  C = T^E mod M\n");
    printf("  T=%" PRIu64 ",  E=%" PRIu64 ",  M=%" PRIu64 "\n", T, E, M);
    printf("========================================\n");
    uint64_t C = MME(T, E, M, /*verbose=*/1);
    printf("\n  >> Ciphertext  C = %" PRIu64 "\n", C);

    /* ---- DECRYPTION --------------------------------------- */
    printf("\n========================================\n");
    printf("  DECRYPTION:  T' = C^D mod M\n");
    printf("  C=%" PRIu64 ",  D=%" PRIu64 ",  M=%" PRIu64 "\n", C, D, M);
    printf("========================================\n");
    uint64_t T_dec = MME(C, D, M, /*verbose=*/1);
    printf("\n  >> Recovered plaintext  T' = %" PRIu64 "\n", T_dec);

    /* ---- VERIFICATION ------------------------------------- */
    printf("\n========================================\n");
    printf("  VERIFICATION\n");
    printf("========================================\n");
    printf("  Original  plaintext  T  = %" PRIu64 "\n", T);
    printf("  Encrypted ciphertext C  = %" PRIu64 "\n", C);
    printf("  Recovered plaintext  T' = %" PRIu64 "\n", T_dec);
    if (T_dec == T)
        printf("\n  [SUCCESS] T' == T.  RSA encrypt -> decrypt round-trip is correct!\n\n");
    else
        printf("\n  [FAILURE] T' != T.  Something went wrong.\n\n");

    return 0;
}
