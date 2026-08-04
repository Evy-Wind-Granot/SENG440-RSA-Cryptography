#!/bin/bash
set -e

echo "=== 1. CORRECTNESS CHECK (baseline) ==="
gcc -O2 -o v0_check baseline.c
./v0_check

echo "=== 2. BASELINE ==="
gcc -O0 -o baseline_O0 baseline.c
./baseline_O0
gcc -O2 -o baseline_O2 baseline.c
./baseline_O2

echo "=== 3. V1 BOUNDED REDUCTION ==="
gcc -O0 -o V1_bounded_reduction_O0 V1_bounded_reduction.c
./V1_bounded_reduction_O0
gcc -O2 -o V1_bounded_reduction_O2 V1_bounded_reduction.c
./V1_bounded_reduction_O2

echo "=== 4. V2 BRANCHLESS ==="
gcc -O0 -o V2_branchless_O0 V2_branchless.c
./V2_branchless_O0
gcc -O2 -o V2_branchless_O2 V2_branchless.c
./V2_branchless_O2

echo "=== 5. V3 LOOP UNROLLING (regression) ==="
gcc -O0 -o V3_loop_unrolling_O0 V3_loop_unrolling.c
./V3_loop_unrolling_O0
gcc -O2 -o V3_loop_unrolling_O2 V3_loop_unrolling.c
./V3_loop_unrolling_O2

echo "=== 6. REGISTER SPILL EVIDENCE ==="
gcc -O0 -S -fverbose-asm V2_branchless.c -o V2_branchless.s
gcc -O0 -S -fverbose-asm V3_loop_unrolling.c -o V3_loop_unrolling.s
echo "-- V2 stack accesses in MMM --"
sed -n '/^MMM:/,/^[a-zA-Z_][a-zA-Z0-9_]*:/p' V2_branchless.s | grep -c '\[sp'
echo "-- V3 stack accesses in MMM --"
sed -n '/^MMM:/,/^[a-zA-Z_][a-zA-Z0-9_]*:/p' V3_loop_unrolling.s | grep -c '\[sp'

echo "=== 7. V4 FINAL (bounded reduction + branchless, no manual unrolling) ==="
gcc -O0 -o V4_final_O0 V4_final.c
./V4_final_O0
gcc -O2 -o V4_final_O2 V4_final.c
./V4_final_O2

echo "=== 8. COMPILER-FLAGS-ONLY COMPARISON ==="
gcc -O2 -funroll-loops -o V4_final_O2_unroll V4_final.c
./V4_final_O2_unroll
gcc -O2 -funroll-loops -mthumb -o V4_thumb_test V4_final.c
./V4_thumb_test

echo "=== 9. TARGET / TOOLCHAIN INFO ==="
cat /proc/cpuinfo | grep -i model
gcc --version

echo "=== 10. GIT LOG ==="
git log --oneline -15

echo "=== DONE ==="
