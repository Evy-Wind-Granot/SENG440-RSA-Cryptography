	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 6	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"V2_branchless.c"
@ GNU C17 (Debian 14.2.0-19) version 14.2.0 (arm-linux-gnueabihf)
@	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

@ warning: MPFR header version 4.2.1 differs from library version 4.2.2.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mfloat-abi=hard -mtls-dialect=gnu -mthumb -march=armv7-a+fp -O0
	.text
	.align	1
	.global	MMM
	.syntax unified
	.thumb
	.thumb_func
	.type	MMM, %function
MMM:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}	@
	sub	sp, sp, #60	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ X, X
	str	r1, [r7, #8]	@ Y, Y
	str	r2, [r7, #4]	@ M, M
	str	r3, [r7]	@ m, m
@ V2_branchless.c:13:     T = 0;
	movs	r3, #0	@ tmp136,
	str	r3, [r7, #48]	@ tmp136, T
@ V2_branchless.c:14:     Y0 = (unsigned int)Y & 1U;
	ldr	r3, [r7, #8]	@ Y.0_1, Y
@ V2_branchless.c:14:     Y0 = (unsigned int)Y & 1U;
	and	r3, r3, #1	@ Y0_25, Y.0_1,
	str	r3, [r7, #44]	@ Y0_25, Y0
@ V2_branchless.c:16:     for (i = 0; i < m; i++) {
	movs	r3, #0	@ tmp138,
	str	r3, [r7, #52]	@ tmp138, i
@ V2_branchless.c:16:     for (i = 0; i < m; i++) {
	b	.L2		@
.L3:
@ V2_branchless.c:17:         Xi = ((unsigned int)X >> i) & 1U;
	ldr	r2, [r7, #12]	@ X.1_2, X
@ V2_branchless.c:17:         Xi = ((unsigned int)X >> i) & 1U;
	ldr	r3, [r7, #52]	@ tmp139, i
	lsr	r3, r2, r3	@ _3, X.1_2, tmp139
@ V2_branchless.c:17:         Xi = ((unsigned int)X >> i) & 1U;
	and	r3, r3, #1	@ Xi_36, _3,
	str	r3, [r7, #36]	@ Xi_36, Xi
@ V2_branchless.c:18:         T0 = T & 1U;
	ldr	r3, [r7, #48]	@ tmp142, T
	and	r3, r3, #1	@ T0_37, tmp142,
	str	r3, [r7, #32]	@ T0_37, T0
@ V2_branchless.c:19:         eta = T0 ^ (Xi & Y0);
	ldr	r2, [r7, #36]	@ tmp143, Xi
	ldr	r3, [r7, #44]	@ tmp144, Y0
	ands	r3, r3, r2	@, _4, tmp144, tmp143
@ V2_branchless.c:19:         eta = T0 ^ (Xi & Y0);
	ldr	r2, [r7, #32]	@ tmp146, T0
	eors	r3, r3, r2	@, eta_38, _4, tmp146
	str	r3, [r7, #28]	@ eta_38, eta
@ V2_branchless.c:21:         maskX   = 0U - Xi;   /* all-1s if Xi==1, else 0 */
	ldr	r3, [r7, #36]	@ tmp148, Xi
	rsbs	r3, r3, #0	@ maskX_39, tmp148
	str	r3, [r7, #24]	@ maskX_39, maskX
@ V2_branchless.c:22:         maskEta = 0U - eta;  /* all-1s if eta==1, else 0 */
	ldr	r3, [r7, #28]	@ tmp150, eta
	rsbs	r3, r3, #0	@ maskEta_40, tmp150
	str	r3, [r7, #20]	@ maskEta_40, maskEta
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	ldr	r2, [r7, #8]	@ Y.2_5, Y
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	ldr	r3, [r7, #24]	@ tmp151, maskX
	ands	r2, r2, r3	@, _6, Y.2_5, tmp151
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	ldr	r3, [r7, #48]	@ tmp152, T
	add	r2, r2, r3	@ _7, tmp152
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	ldr	r1, [r7, #4]	@ M.3_8, M
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	ldr	r3, [r7, #20]	@ tmp153, maskEta
	ands	r3, r3, r1	@, _9, tmp153, M.3_8
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	add	r3, r3, r2	@ _10, _7
@ V2_branchless.c:24:         T = (T + (maskX & (unsigned int)Y) + (maskEta & (unsigned int)M)) >> 1;
	lsrs	r3, r3, #1	@ T_41, _10,
	str	r3, [r7, #48]	@ T_41, T
@ V2_branchless.c:16:     for (i = 0; i < m; i++) {
	ldr	r3, [r7, #52]	@ tmp156, i
	adds	r3, r3, #1	@ i_42, tmp156,
	str	r3, [r7, #52]	@ i_42, i
.L2:
@ V2_branchless.c:16:     for (i = 0; i < m; i++) {
	ldr	r2, [r7, #52]	@ tmp157, i
	ldr	r3, [r7]	@ tmp158, m
	cmp	r2, r3	@ tmp157, tmp158
	blt	.L3		@,
@ V2_branchless.c:28:     maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
	ldr	r3, [r7, #4]	@ M.4_11, M
@ V2_branchless.c:28:     maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
	ldr	r2, [r7, #48]	@ tmp160, T
	cmp	r2, r3	@ tmp160, M.4_11
	ite	cs
	movcs	r3, #1	@ tmp161,
	movcc	r3, #0	@ tmp161,
	uxtb	r3, r3	@ _12, _12
@ V2_branchless.c:28:     maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
	rsbs	r3, r3, #0	@ maskGE_29, _13
	str	r3, [r7, #40]	@ maskGE_29, maskGE
@ V2_branchless.c:29:     T -= maskGE & (unsigned int)M;
	ldr	r2, [r7, #4]	@ M.5_14, M
@ V2_branchless.c:29:     T -= maskGE & (unsigned int)M;
	ldr	r3, [r7, #40]	@ tmp163, maskGE
	ands	r3, r3, r2	@, _15, tmp163, M.5_14
@ V2_branchless.c:29:     T -= maskGE & (unsigned int)M;
	ldr	r2, [r7, #48]	@ tmp165, T
	subs	r3, r2, r3	@ T_30, tmp165, _15
	str	r3, [r7, #48]	@ T_30, T
@ V2_branchless.c:30:     maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
	ldr	r3, [r7, #4]	@ M.6_16, M
@ V2_branchless.c:30:     maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
	ldr	r2, [r7, #48]	@ tmp167, T
	cmp	r2, r3	@ tmp167, M.6_16
	ite	cs
	movcs	r3, #1	@ tmp168,
	movcc	r3, #0	@ tmp168,
	uxtb	r3, r3	@ _17, _17
@ V2_branchless.c:30:     maskGE = 0U - (unsigned int)(T >= (unsigned int)M);
	rsbs	r3, r3, #0	@ maskGE_31, _18
	str	r3, [r7, #40]	@ maskGE_31, maskGE
@ V2_branchless.c:31:     T -= maskGE & (unsigned int)M;
	ldr	r2, [r7, #4]	@ M.7_19, M
@ V2_branchless.c:31:     T -= maskGE & (unsigned int)M;
	ldr	r3, [r7, #40]	@ tmp170, maskGE
	ands	r3, r3, r2	@, _20, tmp170, M.7_19
@ V2_branchless.c:31:     T -= maskGE & (unsigned int)M;
	ldr	r2, [r7, #48]	@ tmp172, T
	subs	r3, r2, r3	@ T_32, tmp172, _20
	str	r3, [r7, #48]	@ T_32, T
@ V2_branchless.c:33:     return (int)T;
	ldr	r3, [r7, #48]	@ _33, T
@ V2_branchless.c:34: }
	mov	r0, r3	@, <retval>
	adds	r7, r7, #60	@,,
	mov	sp, r7	@,
	@ sp needed	@
	ldr	r7, [sp], #4	@,
	bx	lr	@
	.size	MMM, .-MMM
	.section	.rodata
	.align	2
.LC0:
	.ascii	"v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/ca"
	.ascii	"ll)  acc=%ld\012\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r7, lr}	@
	sub	sp, sp, #88	@,,
	add	r7, sp, #16	@,,
@ V2_branchless.c:38:     const int M = 3233;
	movw	r3, #3233	@ tmp139,
	str	r3, [r7, #64]	@ tmp139, M
@ V2_branchless.c:39:     const int m = 12;
	movs	r3, #12	@ tmp140,
	str	r3, [r7, #60]	@ tmp140, m
@ V2_branchless.c:40:     const long N = 20000000L;
	mov	r3, #11520	@ tmp141,
	movt	r3, 305	@ tmp141,
	str	r3, [r7, #56]	@ tmp141, N
@ V2_branchless.c:41:     volatile long acc = 0;
	movs	r3, #0	@ tmp142,
	str	r3, [r7, #36]	@ tmp142, acc
@ V2_branchless.c:44:     clock_gettime(CLOCK_MONOTONIC, &t0);
	add	r3, r7, #16	@ tmp143,,
	mov	r1, r3	@, tmp143
	movs	r0, #1	@,
	bl	__clock_gettime64(PLT)	@
@ V2_branchless.c:46:     for (long i = 0; i < N; i++) {
	movs	r3, #0	@ tmp144,
	str	r3, [r7, #68]	@ tmp144, i
@ V2_branchless.c:46:     for (long i = 0; i < N; i++) {
	b	.L6		@
.L7:
@ V2_branchless.c:47:         int X = (int)((i * 2654435761U) % 4096U);
	ldr	r2, [r7, #68]	@ i.8_1, i
	movw	r3, #31153	@ tmp145,
	movt	r3, 40503	@ tmp145,
	mul	r3, r2, r3	@ _2, i.8_1, tmp145
@ V2_branchless.c:47:         int X = (int)((i * 2654435761U) % 4096U);
	ubfx	r3, r3, #0, #12	@ X_38, _3,,
	str	r3, [r7, #44]	@ X_38, X
@ V2_branchless.c:48:         int Y = (int)((i * 40503U + 1) % 4096U);
	ldr	r3, [r7, #68]	@ i.9_4, i
	movw	r2, #40503	@ tmp147,
	mul	r3, r2, r3	@ _5, tmp147, i.9_4
@ V2_branchless.c:48:         int Y = (int)((i * 40503U + 1) % 4096U);
	adds	r3, r3, #1	@ _6, _5,
@ V2_branchless.c:48:         int Y = (int)((i * 40503U + 1) % 4096U);
	ubfx	r3, r3, #0, #12	@ Y_39, _7,,
	str	r3, [r7, #40]	@ Y_39, Y
@ V2_branchless.c:49:         acc += MMM(X, Y, M, m);
	ldr	r3, [r7, #60]	@, m
	ldr	r2, [r7, #64]	@, M
	ldr	r1, [r7, #40]	@, Y
	ldr	r0, [r7, #44]	@, X
	bl	MMM(PLT)	@
	mov	r2, r0	@ _41,
@ V2_branchless.c:49:         acc += MMM(X, Y, M, m);
	ldr	r3, [r7, #36]	@ acc.10_8, acc
	add	r3, r3, r2	@ _9, _41
	str	r3, [r7, #36]	@ _9, acc
@ V2_branchless.c:46:     for (long i = 0; i < N; i++) {
	ldr	r3, [r7, #68]	@ tmp150, i
	adds	r3, r3, #1	@ i_43, tmp150,
	str	r3, [r7, #68]	@ i_43, i
.L6:
@ V2_branchless.c:46:     for (long i = 0; i < N; i++) {
	ldr	r2, [r7, #68]	@ tmp151, i
	ldr	r3, [r7, #56]	@ tmp152, N
	cmp	r2, r3	@ tmp151, tmp152
	blt	.L7		@,
@ V2_branchless.c:52:     clock_gettime(CLOCK_MONOTONIC, &t1);
	mov	r3, r7	@ tmp153,
	mov	r1, r3	@, tmp153
	movs	r0, #1	@,
	bl	__clock_gettime64(PLT)	@
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldrd	r0, [r7]	@ _10, t1.tv_sec
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldrd	r2, [r7, #16]	@ _11,,
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	subs	r4, r0, r2	@ _12, _10, _11
	sbc	r5, r1, r3	@ _12, _10, _11
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	mov	r0, r4	@, _12
	mov	r1, r5	@, _12
	bl	__aeabi_l2d(PLT)	@
	vmov	d4, r0, r1	@ _13,
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r2, [r7, #8]	@ _14, t1.tv_nsec
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r3, [r7, #24]	@ _15, t0.tv_nsec
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	subs	r3, r2, r3	@ _16, _14, _15
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vmov	s15, r3	@ int	@ _16, _16
	vcvt.f64.s32	d6, s15	@ _17, _16
	vldr.64	d5, .L9	@ tmp154,
	vdiv.f64	d7, d6, d5	@ _18, _17, tmp154
@ V2_branchless.c:53:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vadd.f64	d7, d4, d7	@ secs_33, _13, _18
	vstr.64	d7, [r7, #48]	@ secs_33, secs
@ V2_branchless.c:56:            N, secs, secs * 1e9 / N, acc);
	vldr.64	d7, [r7, #48]	@ tmp156, secs
	vldr.64	d6, .L9	@ tmp157,
	vmul.f64	d5, d7, d6	@ _19, tmp156, tmp157
@ V2_branchless.c:55:     printf("v2_branchless: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	ldr	r3, [r7, #56]	@ tmp158, N
	vmov	s15, r3	@ int	@ tmp158, tmp158
	vcvt.f64.s32	d6, s15	@ _20, tmp158
	vdiv.f64	d7, d5, d6	@ _21, _19, _20
	ldr	r3, [r7, #36]	@ acc.11_22, acc
	str	r3, [sp, #8]	@ acc.11_22,
	vstr.64	d7, [sp]	@ _21,
	ldrd	r2, [r7, #48]	@,,
	ldr	r1, [r7, #56]	@, N
	ldr	r0, .L9+8	@ tmp159,
.LPIC0:
	add	r0, pc	@ tmp159
	bl	printf(PLT)	@
@ V2_branchless.c:57:     return 0;
	movs	r3, #0	@ _35,
@ V2_branchless.c:58: }
	mov	r0, r3	@, <retval>
	adds	r7, r7, #72	@,,
	mov	sp, r7	@,
	@ sp needed	@
	pop	{r4, r5, r7, pc}	@
.L10:
	.align	3
.L9:
	.word	0
	.word	1104006501
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.global	__aeabi_l2d
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
