#!/bin/bash
set -e

VERSIONS="baseline V1_bounded_reduction V2_branchless V3_loop_unrolling V4_final"

echo "=========================================="
echo " STATIC INSTRUCTION COUNTS (per MMM, -O2)"
echo "=========================================="
for v in $VERSIONS; do
    gcc -O2 -o ${v}_bin ${v}.c
    count=$(objdump -d ${v}_bin --disassemble=MMM | grep -cE '^\s+[0-9a-f]+:')
    echo "${v}: ${count} instructions"
done

echo ""
echo "=========================================="
echo " DYNAMIC INSTRUCTION COUNTS (perf, whole run)"
echo "=========================================="
for v in $VERSIONS; do
    echo "--- ${v} ---"
    perf stat -e instructions,branches,branch-misses ./${v}_bin || echo "perf failed for ${v}, skipping"
done

echo ""
echo "=========================================="
echo " REGISTER SPILL EVIDENCE (V2 vs V3, -O0)"
echo "=========================================="
gcc -O0 -S -fverbose-asm V2_branchless.c -o V2_branchless.s
gcc -O0 -S -fverbose-asm V3_loop_unrolling.c -o V3_loop_unrolling.s
echo "-- V2 stack accesses in MMM --"
sed -n '/^MMM:/,/^[a-zA-Z_][a-zA-Z0-9_]*:/p' V2_branchless.s | grep -c '\[sp'
echo "-- V3 stack accesses in MMM --"
sed -n '/^MMM:/,/^[a-zA-Z_][a-zA-Z0-9_]*:/p' V3_loop_unrolling.s | grep -c '\[sp'

echo ""
echo "=========================================="
echo " -funroll-loops UNROLL FACTOR VERIFICATION"
echo "=========================================="
gcc -O2 -S V4_final.c -o V4_O2.s
gcc -O2 -funroll-loops -S V4_final.c -o V4_O2_unroll.s
echo "-- V4 instruction lines in MMM, -O2 --"
awk '/^MMM:/{f=1} f{print} /\.size\tMMM/{exit}' V4_O2.s | grep -cE '^\s+[a-z]+\s'
echo "-- V4 instruction lines in MMM, -O2 -funroll-loops --"
awk '/^MMM:/{f=1} f{print} /\.size\tMMM/{exit}' V4_O2_unroll.s | grep -cE '^\s+[a-z]+\s'
echo "-- V4 branch instructions in MMM, -O2 --"
awk '/^MMM:/{f=1} f{print} /\.size\tMMM/{exit}' V4_O2.s | grep -cE '^\s+b[a-z]*\s'
echo "-- V4 branch instructions in MMM, -O2 -funroll-loops --"
awk '/^MMM:/{f=1} f{print} /\.size\tMMM/{exit}' V4_O2_unroll.s | grep -cE '^\s+b[a-z]*\s'

echo ""
echo "=== DONE ==="
