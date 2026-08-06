	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"V3_loop_unrolling.c"
@ GNU C17 (Debian 14.2.0-19) version 14.2.0 (arm-linux-gnueabihf)
@	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

@ warning: MPFR header version 4.2.1 differs from library version 4.2.2.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mfloat-abi=hard -mtls-dialect=gnu -mthumb -march=armv7-a+fp -O2
	.text
	.align	1
	.p2align 2,,3
	.global	MMM
	.syntax unified
	.thumb
	.thumb_func
	.type	MMM, %function
MMM:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}	@
@ V3_loop_unrolling.c:63:     int limit = m - (m % 4);
	rsbs	r6, r3, #0	@ tmp196, m,
	and	r6, r6, #3	@ tmp197, tmp196,
	and	r4, r3, #3	@ _1, m,
	it	pl
	rsbpl	r4, r6, #0	@ _1, tmp197
@ V3_loop_unrolling.c:63:     int limit = m - (m % 4);
	subs	r4, r3, r4	@ limit, m, _1
@ V3_loop_unrolling.c:59:     unsigned int Y0 = UY & 1U;
	and	r5, r1, #1	@ Y0, Y,
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	cmp	r4, #0	@ limit,
	ble	.L6		@,
@ V3_loop_unrolling.c:62:     int i = 0;
	mov	lr, #0	@ i,
@ V3_loop_unrolling.c:55:     unsigned int T = 0;
	mov	r6, lr	@ _80, i
.L3:
@ V3_loop_unrolling.c:67:         T = mmm_step(T, (UX >> i)       & 1U, Y0, UY, UM);
	lsr	r7, r0, lr	@ _2, X, i
@ V3_loop_unrolling.c:31:     unsigned int T0   = T & 1U;
	and	r8, r6, #1	@ T0_65, _80,
@ V3_loop_unrolling.c:67:         T = mmm_step(T, (UX >> i)       & 1U, Y0, UY, UM);
	and	ip, r7, #1	@ _3, _2,
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	ands	r7, r7, r5	@, _66, _2, Y0
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	eor	r8, r8, r7	@ eta_67, T0_65, _66
@ V3_loop_unrolling.c:68:         T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
	add	r7, lr, #1	@ _189, i,
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r1, ip, r6	@ _69, Y, _3, _80
@ V3_loop_unrolling.c:68:         T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
	lsr	r6, r0, r7	@ _5, X, _189
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r2, r8, ip	@ _71, M, eta_67, _69
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	and	r9, r6, r5	@ _58, _5, Y0
@ V3_loop_unrolling.c:68:         T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
	and	r8, r6, #1	@ _6, _5,
@ V3_loop_unrolling.c:69:         T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
	add	r7, lr, #2	@ _191, i,
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	lsr	ip, ip, #1	@ _72, _71,
@ V3_loop_unrolling.c:69:         T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
	lsr	r7, r0, r7	@ _8, X, _191
@ V3_loop_unrolling.c:31:     unsigned int T0   = T & 1U;
	and	r10, ip, #1	@ T0_57, _72,
@ V3_loop_unrolling.c:69:         T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
	and	r6, r7, #1	@ _9, _8,
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	eor	r9, r10, r9	@ eta_59, T0_57, _58
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	ands	r7, r7, r5	@, _50, _8, Y0
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r1, r8, ip	@ _61, Y, _6, _72
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r2, r9, ip	@ _63, M, eta_59, _61
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	lsr	ip, ip, #1	@ _64, _63,
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	r6, r1, r6, ip	@ _53, Y, _9, _64
@ V3_loop_unrolling.c:31:     unsigned int T0   = T & 1U;
	and	ip, ip, #1	@ T0_49, _64,
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	eor	ip, ip, r7	@ eta_51, T0_49, _50
@ V3_loop_unrolling.c:70:         T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
	add	r7, lr, #3	@ _193, i,
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	add	lr, lr, #4	@ i, i,
@ V3_loop_unrolling.c:70:         T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
	lsr	r7, r0, r7	@ _11, X, _193
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	cmp	r4, lr	@ limit, i
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r2, ip, r6	@ _55, M, eta_51, _53
@ V3_loop_unrolling.c:70:         T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
	and	r8, r7, #1	@ _12, _11,
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	and	r7, r7, r5	@ _42, _11, Y0
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	lsr	ip, ip, #1	@ _56, _55,
@ V3_loop_unrolling.c:31:     unsigned int T0   = T & 1U;
	and	r6, ip, #1	@ T0_39, _56,
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	eor	r6, r6, r7	@ eta_41, T0_39, _42
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r1, r8, ip	@ _45, Y, _12, _56
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r2, r6, ip	@ _47, M, eta_41, _45
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	lsr	r6, ip, #1	@ _80, _47,
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	bgt	.L3		@,
	subs	r4, r4, #1	@ _208, limit,
	bic	r4, r4, #3	@ _207, _208,
	adds	r4, r4, #4	@ i, _207,
.L2:
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	cmp	r3, r4	@ m, i
	ble	.L4		@,
.L5:
@ V3_loop_unrolling.c:75:         T = mmm_step(T, (UX >> i) & 1U, Y0, UY, UM);
	lsr	r7, r0, r4	@ _13, X, i
@ V3_loop_unrolling.c:31:     unsigned int T0   = T & 1U;
	and	lr, r6, #1	@ T0_73, _80,
@ V3_loop_unrolling.c:75:         T = mmm_step(T, (UX >> i) & 1U, Y0, UY, UM);
	and	ip, r7, #1	@ _14, _13,
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	ands	r7, r7, r5	@, _74, _13, Y0
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	eor	r7, lr, r7	@ eta_75, T0_73, _74
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	adds	r4, r4, #1	@ i, i,
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	cmp	r3, r4	@ m, i
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r1, ip, r6	@ _77, Y, _14, _80
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	mla	ip, r2, r7, ip	@ _79, M, eta_75, _77
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	lsr	r6, ip, #1	@ _80, _79,
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	bne	.L5		@,
.L4:
@ V3_loop_unrolling.c:80:     T -= maskGE & UM;
	cmp	r2, r6	@ M, _80
	ite	ls		@
	movls	r3, r2	@, _17, M
	movhi	r3, #0	@, _17,
@ V3_loop_unrolling.c:80:     T -= maskGE & UM;
	subs	r3, r6, r3	@ T, _80, _17
@ V3_loop_unrolling.c:82:     T -= maskGE & UM;
	cmp	r2, r3	@ M, T
	it	hi		@
	movhi	r2, #0	@, _20,
@ V3_loop_unrolling.c:85: }
	subs	r0, r3, r2	@, T, _20
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}	@
.L6:
@ V3_loop_unrolling.c:62:     int i = 0;
	movs	r4, #0	@ i,
@ V3_loop_unrolling.c:55:     unsigned int T = 0;
	mov	r6, r4	@ _80, i
	b	.L2		@
	.size	MMM, .-MMM
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call) "
	.ascii	" acc=%ld\012\000"
	.section	.text.startup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}	@
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	movw	r7, #31153	@ tmp145,
	movt	r7, 40503	@ tmp145,
@ V3_loop_unrolling.c:98: {
	sub	sp, sp, #56	@,,
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	movw	r6, #43777	@ tmp147,
	movt	r6, 39766	@ tmp147,
@ V3_loop_unrolling.c:107:     clock_gettime(CLOCK_MONOTONIC, &t0);
	movs	r4, #1	@ ivtmp.31,
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	movw	r8, #40503	@ tmp146,
@ V3_loop_unrolling.c:107:     clock_gettime(CLOCK_MONOTONIC, &t0);
	add	r1, sp, #24	@,,
	movs	r0, #1	@,
@ V3_loop_unrolling.c:102:     volatile long acc = 0;
	movs	r5, #0	@ tmp137,
	str	r5, [sp, #20]	@ tmp137, acc
@ V3_loop_unrolling.c:107:     clock_gettime(CLOCK_MONOTONIC, &t0);
	bl	__clock_gettime64(PLT)	@
.L12:
@ V3_loop_unrolling.c:113:         acc += MMM(X, Y, M, m);
	movs	r3, #12	@,
	ubfx	r1, r4, #0, #12	@, ivtmp.31,,
	ubfx	r0, r5, #0, #12	@, ivtmp.30,,
	movw	r2, #3233	@,
	bl	MMM(PLT)	@
@ V3_loop_unrolling.c:113:         acc += MMM(X, Y, M, m);
	ldr	r3, [sp, #20]	@ acc.2_5, acc
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	add	r4, r4, r8	@ ivtmp.31, tmp146
	add	r5, r5, r7	@ ivtmp.30, tmp145
@ V3_loop_unrolling.c:113:         acc += MMM(X, Y, M, m);
	add	r3, r3, r0	@ _6, tmp175
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	cmp	r4, r6	@ ivtmp.31, tmp147
@ V3_loop_unrolling.c:113:         acc += MMM(X, Y, M, m);
	str	r3, [sp, #20]	@ _6, acc
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	bne	.L12		@,
@ V3_loop_unrolling.c:117:     clock_gettime(CLOCK_MONOTONIC, &t1);
	add	r1, sp, #40	@,,
	movs	r0, #1	@,
	bl	__clock_gettime64(PLT)	@
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r3, [sp, #40]	@ t1.tv_sec, t1.tv_sec
	ldr	r1, [sp, #24]	@ t0.tv_sec, t0.tv_sec
	ldr	r2, [sp, #44]	@ tmp170, t1.tv_sec
	ldr	r4, [sp, #28]	@ tmp172, t0.tv_sec
	subs	r0, r3, r1	@ _9, t1.tv_sec, t0.tv_sec
	sbc	r1, r2, r4	@ _9, tmp170, tmp172
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	bl	__aeabi_l2d(PLT)	@
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r2, [sp, #32]	@ t0.tv_nsec, t0.tv_nsec
	ldr	r3, [sp, #48]	@ t1.tv_nsec, t1.tv_nsec
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vmov	d5, r0, r1	@ tmp176,
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vldr.64	d6, .L15	@ tmp158,
@ V3_loop_unrolling.c:120:     printf("v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	mov	r1, #11520	@,
	movt	r1, 305	@,
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	subs	r3, r3, r2	@ _13, t1.tv_nsec, t0.tv_nsec
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vmov	s15, r3	@ int	@ _13, _13
@ V3_loop_unrolling.c:120:     printf("v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	vldr.64	d4, .L15+8	@ tmp165,
	ldr	r2, [sp, #20]	@ acc.3_18, acc
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vcvt.f64.s32	d7, s15	@ _14, _13
@ V3_loop_unrolling.c:120:     printf("v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	str	r2, [sp, #8]	@ acc.3_18,
	ldr	r0, .L15+16	@,
.LPIC0:
	add	r0, pc	@
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vdiv.f64	d3, d7, d6	@ _15, _14, tmp158
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vadd.f64	d5, d5, d3	@ secs, tmp176, _15
@ V3_loop_unrolling.c:121:            N, secs, secs * 1e9 / N, acc);
	vmul.f64	d6, d5, d6	@ _16, secs, tmp158
@ V3_loop_unrolling.c:120:     printf("v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	vmov	r2, r3, d5	@, secs
	vdiv.f64	d7, d6, d4	@ _17, _16, tmp165
	vstr.64	d7, [sp]	@ _17,
	bl	printf(PLT)	@
@ V3_loop_unrolling.c:124: }
	movs	r0, #0	@,
	add	sp, sp, #56	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, pc}	@
.L16:
	.align	3
.L15:
	.word	0
	.word	1104006501
	.word	0
	.word	1098060496
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.global	__aeabi_l2d
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
