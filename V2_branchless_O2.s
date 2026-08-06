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
	.file	"V2_branchless.c"
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
	push	{r4, r5, r6, r7, lr}	@
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	subs	r6, r3, #0	@ m, tmp155
	ble	.L4		@,
@ V2_branchless.c:35:     T = 0;
	mov	ip, #0	@ T,
	and	r7, r1, #1	@ Y0, Y,
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	mov	r3, ip	@ i, T
.L3:
@ V2_branchless.c:40:         Xi = ((unsigned int)X >> i) & 1U;
	lsr	lr, r0, r3	@ _2, X, i
@ V2_branchless.c:41:         T0 = T & 1U;
	and	r5, ip, #1	@ T0_30, T,
@ V2_branchless.c:40:         Xi = ((unsigned int)X >> i) & 1U;
	and	r4, lr, #1	@ Xi, _2,
@ V2_branchless.c:42:         eta = T0 ^ (Xi & Y0);
	and	lr, lr, r7	@ _3, _2, Y0
@ V2_branchless.c:42:         eta = T0 ^ (Xi & Y0);
	eor	lr, lr, r5	@ eta_31, _3, T0_30
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	adds	r3, r3, #1	@ i, i,
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	cmp	r6, r3	@ m, i
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	mla	ip, r1, r4, ip	@ _6, Y, Xi, T
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	mla	ip, r2, lr, ip	@ _9, M, eta_31, _6
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	lsr	ip, ip, #1	@ T, _9,
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	bne	.L3		@,
.L2:
@ V2_branchless.c:54:     T -= maskGE & (unsigned int)M;
	cmp	ip, r2	@ T, M
	ite	cs		@
	movcs	r3, r2	@, _13, M
	movcc	r3, #0	@, _13,
@ V2_branchless.c:54:     T -= maskGE & (unsigned int)M;
	sub	ip, ip, r3	@ T, T, _13
@ V2_branchless.c:56:     T -= maskGE & (unsigned int)M;
	cmp	ip, r2	@ T, M
	it	cc		@
	movcc	r2, #0	@, _16,
@ V2_branchless.c:59: }
	sub	r0, ip, r2	@, T, _16
	pop	{r4, r5, r6, r7, pc}	@
.L4:
@ V2_branchless.c:35:     T = 0;
	mov	ip, #0	@ T,
	b	.L2		@
	.size	MMM, .-MMM
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/ca"
	.ascii	"ll)  acc=%ld\012\000"
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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}	@
@ V2_branchless.c:81:     clock_gettime(CLOCK_MONOTONIC, &t0);
	movs	r0, #1	@,
@ V2_branchless.c:76:     volatile long acc = 0;
	movs	r4, #0	@ tmp152,
@ V2_branchless.c:72: {
	sub	sp, sp, #56	@,,
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	movw	r6, #31153	@ tmp172,
	movt	r6, 40503	@ tmp172,
@ V2_branchless.c:81:     clock_gettime(CLOCK_MONOTONIC, &t0);
	add	r1, sp, #24	@,,
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	movw	r5, #43777	@ tmp174,
	movt	r5, 39766	@ tmp174,
@ V2_branchless.c:76:     volatile long acc = 0;
	str	r4, [sp, #20]	@ tmp152, acc
@ V2_branchless.c:81:     clock_gettime(CLOCK_MONOTONIC, &t0);
	bl	__clock_gettime64(PLT)	@
	movs	r1, #1	@ ivtmp.36,
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	movw	r0, #3233	@ tmp161,
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	movw	r7, #40503	@ tmp173,
.L10:
@ V2_branchless.c:35:     T = 0;
	mov	r9, #0	@ T,
	ubfx	lr, r4, #0, #12	@ _28, ivtmp.35,,
	ubfx	ip, r1, #0, #12	@ _24, ivtmp.36,,
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	mov	r2, r9	@ i, T
.L9:
@ V2_branchless.c:40:         Xi = ((unsigned int)X >> i) & 1U;
	lsr	r8, lr, r2	@ _40, _28, i
@ V2_branchless.c:41:         T0 = T & 1U;
	and	r3, r9, #1	@ T0_43, T,
@ V2_branchless.c:40:         Xi = ((unsigned int)X >> i) & 1U;
	and	r8, r8, #1	@ Xi, _40,
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	adds	r2, r2, #1	@ i, i,
@ V2_branchless.c:42:         eta = T0 ^ (Xi & Y0);
	and	r10, r8, r1	@ _44, Xi, ivtmp.36
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	cmp	r2, #12	@ i,
@ V2_branchless.c:42:         eta = T0 ^ (Xi & Y0);
	eor	r3, r3, r10	@ eta_45, T0_43, _44
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	mla	r8, r8, ip, r9	@ _48, Xi, _24, T
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	rsb	r3, r3, #0	@ tmp160, eta_45
	and	r3, r3, r0	@ _50, tmp160, tmp161
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	add	r3, r3, r8	@ _51, _48
@ V2_branchless.c:49:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	lsr	r9, r3, #1	@ T, _51,
@ V2_branchless.c:39:     for (i = 0; i < m; i++) {
	bne	.L9		@,
@ V2_branchless.c:54:     T -= maskGE & (unsigned int)M;
	cmp	r9, #3232	@ T,
@ V2_branchless.c:87:         acc += MMM(X, Y, M, m);
	ldr	r3, [sp, #20]	@ acc.10_5, acc
@ V2_branchless.c:54:     T -= maskGE & (unsigned int)M;
	ite	hi
	movhi	r2, r0	@ _57, tmp161
	movls	r2, #0	@ _57,
@ V2_branchless.c:54:     T -= maskGE & (unsigned int)M;
	sub	r9, r9, r2	@ T, T, _57
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	add	r1, r1, r7	@ ivtmp.36, tmp173
@ V2_branchless.c:56:     T -= maskGE & (unsigned int)M;
	cmp	r9, #3232	@ T,
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	add	r4, r4, r6	@ ivtmp.35, tmp172
@ V2_branchless.c:56:     T -= maskGE & (unsigned int)M;
	ite	hi
	movhi	r2, r0	@ _61, tmp161
	movls	r2, #0	@ _61,
@ V2_branchless.c:56:     T -= maskGE & (unsigned int)M;
	sub	r9, r9, r2	@ T_62, T, _61
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	cmp	r1, r5	@ ivtmp.36, tmp174
@ V2_branchless.c:87:         acc += MMM(X, Y, M, m);
	add	r3, r3, r9	@ _6, T_62
	str	r3, [sp, #20]	@ _6, acc
@ V2_branchless.c:84:     for (long i = 0; i < N; i++) {
	bne	.L10		@,
@ V2_branchless.c:91:     clock_gettime(CLOCK_MONOTONIC, &t1);
	add	r1, sp, #40	@,,
	movs	r0, #1	@,
	bl	__clock_gettime64(PLT)	@
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r3, [sp, #40]	@ t1.tv_sec, t1.tv_sec
	ldr	r1, [sp, #24]	@ t0.tv_sec, t0.tv_sec
	ldr	r2, [sp, #44]	@ tmp197, t1.tv_sec
	ldr	r4, [sp, #28]	@ tmp199, t0.tv_sec
	subs	r0, r3, r1	@ _9, t1.tv_sec, t0.tv_sec
	sbc	r1, r2, r4	@ _9, tmp197, tmp199
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	bl	__aeabi_l2d(PLT)	@
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r2, [sp, #32]	@ t0.tv_nsec, t0.tv_nsec
	ldr	r3, [sp, #48]	@ t1.tv_nsec, t1.tv_nsec
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vmov	d5, r0, r1	@ tmp202,
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vldr.64	d6, .L14	@ tmp185,
@ V2_branchless.c:94:     printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	mov	r1, #11520	@,
	movt	r1, 305	@,
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	subs	r3, r3, r2	@ _13, t1.tv_nsec, t0.tv_nsec
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vmov	s15, r3	@ int	@ _13, _13
@ V2_branchless.c:94:     printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	vldr.64	d4, .L14+8	@ tmp192,
	ldr	r2, [sp, #20]	@ acc.11_18, acc
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vcvt.f64.s32	d7, s15	@ _14, _13
@ V2_branchless.c:94:     printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	str	r2, [sp, #8]	@ acc.11_18,
	ldr	r0, .L14+16	@,
.LPIC0:
	add	r0, pc	@
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vdiv.f64	d3, d7, d6	@ _15, _14, tmp185
@ V2_branchless.c:92:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vadd.f64	d5, d5, d3	@ secs, tmp202, _15
@ V2_branchless.c:95:            N, secs, secs * 1e9 / N, acc);
	vmul.f64	d6, d5, d6	@ _16, secs, tmp185
@ V2_branchless.c:94:     printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	vmov	r2, r3, d5	@, secs
	vdiv.f64	d7, d6, d4	@ _17, _16, tmp192
	vstr.64	d7, [sp]	@ _17,
	bl	printf(PLT)	@
@ V2_branchless.c:98: }
	movs	r0, #0	@,
	add	sp, sp, #56	@,,
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}	@
.L15:
	.align	3
.L14:
	.word	0
	.word	1104006501
	.word	0
	.word	1098060496
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.global	__aeabi_l2d
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
