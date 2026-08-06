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
	.file	"V3_loop_unrolling.c"
@ GNU C17 (Debian 14.2.0-19) version 14.2.0 (arm-linux-gnueabihf)
@	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

@ warning: MPFR header version 4.2.1 differs from library version 4.2.2.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed: -mfloat-abi=hard -mtls-dialect=gnu -mthumb -march=armv7-a+fp -O0
	.text
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	mmm_step, %function
mmm_step:
	@ args = 4, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}	@
	sub	sp, sp, #36	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ T, T
	str	r1, [r7, #8]	@ Xi, Xi
	str	r2, [r7, #4]	@ Y0, Y0
	str	r3, [r7]	@ Y, Y
@ V3_loop_unrolling.c:31:     unsigned int T0   = T & 1U;
	ldr	r3, [r7, #12]	@ tmp122, T
	and	r3, r3, #1	@ T0_7, tmp122,
	str	r3, [r7, #28]	@ T0_7, T0
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	ldr	r2, [r7, #8]	@ tmp123, Xi
	ldr	r3, [r7, #4]	@ tmp124, Y0
	ands	r3, r3, r2	@, _1, tmp124, tmp123
@ V3_loop_unrolling.c:32:     unsigned int eta  = T0 ^ (Xi & Y0);
	ldr	r2, [r7, #28]	@ tmp126, T0
	eors	r3, r3, r2	@, eta_10, _1, tmp126
	str	r3, [r7, #24]	@ eta_10, eta
@ V3_loop_unrolling.c:33:     unsigned int maskX   = 0U - Xi;
	ldr	r3, [r7, #8]	@ tmp128, Xi
	rsbs	r3, r3, #0	@ maskX_11, tmp128
	str	r3, [r7, #20]	@ maskX_11, maskX
@ V3_loop_unrolling.c:34:     unsigned int maskEta = 0U - eta;
	ldr	r3, [r7, #24]	@ tmp130, eta
	rsbs	r3, r3, #0	@ maskEta_12, tmp130
	str	r3, [r7, #16]	@ maskEta_12, maskEta
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	ldr	r2, [r7, #20]	@ tmp131, maskX
	ldr	r3, [r7]	@ tmp132, Y
	ands	r2, r2, r3	@, _2, tmp131, tmp132
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	ldr	r3, [r7, #12]	@ tmp133, T
	add	r2, r2, r3	@ _3, tmp133
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	ldr	r1, [r7, #16]	@ tmp134, maskEta
	ldr	r3, [r7, #40]	@ tmp135, M
	ands	r3, r3, r1	@, _4, tmp135, tmp134
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	add	r3, r3, r2	@ _5, _3
@ V3_loop_unrolling.c:36:     return (T + (maskX & Y) + (maskEta & M)) >> 1;
	lsrs	r3, r3, #1	@ _15, _5,
@ V3_loop_unrolling.c:37: }
	mov	r0, r3	@, <retval>
	adds	r7, r7, #36	@,,
	mov	sp, r7	@,
	@ sp needed	@
	ldr	r7, [sp], #4	@,
	bx	lr	@
	.size	mmm_step, .-mmm_step
	.align	1
	.global	MMM
	.syntax unified
	.thumb
	.thumb_func
	.type	MMM, %function
MMM:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #56	@,,
	add	r7, sp, #8	@,,
	str	r0, [r7, #12]	@ X, X
	str	r1, [r7, #8]	@ Y, Y
	str	r2, [r7, #4]	@ M, M
	str	r3, [r7]	@ m, m
@ V3_loop_unrolling.c:55:     unsigned int T = 0;
	movs	r3, #0	@ tmp136,
	str	r3, [r7, #44]	@ tmp136, T
@ V3_loop_unrolling.c:56:     unsigned int UX = (unsigned int)X;
	ldr	r3, [r7, #12]	@ tmp137, X
	str	r3, [r7, #36]	@ tmp137, UX
@ V3_loop_unrolling.c:57:     unsigned int UY = (unsigned int)Y;
	ldr	r3, [r7, #8]	@ tmp138, Y
	str	r3, [r7, #32]	@ tmp138, UY
@ V3_loop_unrolling.c:58:     unsigned int UM = (unsigned int)M;
	ldr	r3, [r7, #4]	@ tmp139, M
	str	r3, [r7, #28]	@ tmp139, UM
@ V3_loop_unrolling.c:59:     unsigned int Y0 = UY & 1U;
	ldr	r3, [r7, #32]	@ tmp141, UY
	and	r3, r3, #1	@ Y0_34, tmp141,
	str	r3, [r7, #24]	@ Y0_34, Y0
@ V3_loop_unrolling.c:62:     int i = 0;
	movs	r3, #0	@ tmp142,
	str	r3, [r7, #40]	@ tmp142, i
@ V3_loop_unrolling.c:63:     int limit = m - (m % 4);
	ldr	r3, [r7]	@ tmp143, m
	rsbs	r2, r3, #0	@ tmp144, tmp143,
	and	r3, r3, #3	@ _1, tmp143,
	and	r2, r2, #3	@ tmp145, tmp144,
	it	pl
	rsbpl	r3, r2, #0	@ _1, tmp145
@ V3_loop_unrolling.c:63:     int limit = m - (m % 4);
	ldr	r2, [r7]	@ tmp147, m
	subs	r3, r2, r3	@ limit_37, tmp147, _1
	str	r3, [r7, #20]	@ limit_37, limit
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	b	.L4		@
.L5:
@ V3_loop_unrolling.c:67:         T = mmm_step(T, (UX >> i)       & 1U, Y0, UY, UM);
	ldr	r2, [r7, #36]	@ tmp148, UX
	ldr	r3, [r7, #40]	@ tmp149, i
	lsr	r3, r2, r3	@ _2, tmp148, tmp149
@ V3_loop_unrolling.c:67:         T = mmm_step(T, (UX >> i)       & 1U, Y0, UY, UM);
	and	r1, r3, #1	@ _3, _2,
	ldr	r3, [r7, #28]	@ tmp150, UM
	str	r3, [sp]	@ tmp150,
	ldr	r3, [r7, #32]	@, UY
	ldr	r2, [r7, #24]	@, Y0
	ldr	r0, [r7, #44]	@, T
	bl	mmm_step(PLT)	@
	str	r0, [r7, #44]	@, T
@ V3_loop_unrolling.c:68:         T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
	ldr	r3, [r7, #40]	@ tmp151, i
	adds	r3, r3, #1	@ _4, tmp151,
@ V3_loop_unrolling.c:68:         T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
	ldr	r2, [r7, #36]	@ tmp152, UX
	lsr	r3, r2, r3	@ _5, tmp152, _4
@ V3_loop_unrolling.c:68:         T = mmm_step(T, (UX >> (i + 1)) & 1U, Y0, UY, UM);
	and	r1, r3, #1	@ _6, _5,
	ldr	r3, [r7, #28]	@ tmp153, UM
	str	r3, [sp]	@ tmp153,
	ldr	r3, [r7, #32]	@, UY
	ldr	r2, [r7, #24]	@, Y0
	ldr	r0, [r7, #44]	@, T
	bl	mmm_step(PLT)	@
	str	r0, [r7, #44]	@, T
@ V3_loop_unrolling.c:69:         T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
	ldr	r3, [r7, #40]	@ tmp154, i
	adds	r3, r3, #2	@ _7, tmp154,
@ V3_loop_unrolling.c:69:         T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
	ldr	r2, [r7, #36]	@ tmp155, UX
	lsr	r3, r2, r3	@ _8, tmp155, _7
@ V3_loop_unrolling.c:69:         T = mmm_step(T, (UX >> (i + 2)) & 1U, Y0, UY, UM);
	and	r1, r3, #1	@ _9, _8,
	ldr	r3, [r7, #28]	@ tmp156, UM
	str	r3, [sp]	@ tmp156,
	ldr	r3, [r7, #32]	@, UY
	ldr	r2, [r7, #24]	@, Y0
	ldr	r0, [r7, #44]	@, T
	bl	mmm_step(PLT)	@
	str	r0, [r7, #44]	@, T
@ V3_loop_unrolling.c:70:         T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
	ldr	r3, [r7, #40]	@ tmp157, i
	adds	r3, r3, #3	@ _10, tmp157,
@ V3_loop_unrolling.c:70:         T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
	ldr	r2, [r7, #36]	@ tmp158, UX
	lsr	r3, r2, r3	@ _11, tmp158, _10
@ V3_loop_unrolling.c:70:         T = mmm_step(T, (UX >> (i + 3)) & 1U, Y0, UY, UM);
	and	r1, r3, #1	@ _12, _11,
	ldr	r3, [r7, #28]	@ tmp159, UM
	str	r3, [sp]	@ tmp159,
	ldr	r3, [r7, #32]	@, UY
	ldr	r2, [r7, #24]	@, Y0
	ldr	r0, [r7, #44]	@, T
	bl	mmm_step(PLT)	@
	str	r0, [r7, #44]	@, T
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	ldr	r3, [r7, #40]	@ tmp161, i
	adds	r3, r3, #4	@ i_55, tmp161,
	str	r3, [r7, #40]	@ i_55, i
.L4:
@ V3_loop_unrolling.c:66:     for (; i < limit; i += 4) {
	ldr	r2, [r7, #40]	@ tmp162, i
	ldr	r3, [r7, #20]	@ tmp163, limit
	cmp	r2, r3	@ tmp162, tmp163
	blt	.L5		@,
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	b	.L6		@
.L7:
@ V3_loop_unrolling.c:75:         T = mmm_step(T, (UX >> i) & 1U, Y0, UY, UM);
	ldr	r2, [r7, #36]	@ tmp164, UX
	ldr	r3, [r7, #40]	@ tmp165, i
	lsr	r3, r2, r3	@ _13, tmp164, tmp165
@ V3_loop_unrolling.c:75:         T = mmm_step(T, (UX >> i) & 1U, Y0, UY, UM);
	and	r1, r3, #1	@ _14, _13,
	ldr	r3, [r7, #28]	@ tmp166, UM
	str	r3, [sp]	@ tmp166,
	ldr	r3, [r7, #32]	@, UY
	ldr	r2, [r7, #24]	@, Y0
	ldr	r0, [r7, #44]	@, T
	bl	mmm_step(PLT)	@
	str	r0, [r7, #44]	@, T
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	ldr	r3, [r7, #40]	@ tmp168, i
	adds	r3, r3, #1	@ i_46, tmp168,
	str	r3, [r7, #40]	@ i_46, i
.L6:
@ V3_loop_unrolling.c:74:     for (; i < m; i++) {
	ldr	r2, [r7, #40]	@ tmp169, i
	ldr	r3, [r7]	@ tmp170, m
	cmp	r2, r3	@ tmp169, tmp170
	blt	.L7		@,
@ V3_loop_unrolling.c:79:     maskGE = 0U - (unsigned int)(T >= UM);
	ldr	r2, [r7, #44]	@ tmp172, T
	ldr	r3, [r7, #28]	@ tmp173, UM
	cmp	r2, r3	@ tmp172, tmp173
	ite	cs
	movcs	r3, #1	@ tmp174,
	movcc	r3, #0	@ tmp174,
	uxtb	r3, r3	@ _15, _15
@ V3_loop_unrolling.c:79:     maskGE = 0U - (unsigned int)(T >= UM);
	rsbs	r3, r3, #0	@ maskGE_39, _16
	str	r3, [r7, #16]	@ maskGE_39, maskGE
@ V3_loop_unrolling.c:80:     T -= maskGE & UM;
	ldr	r2, [r7, #16]	@ tmp176, maskGE
	ldr	r3, [r7, #28]	@ tmp177, UM
	ands	r3, r3, r2	@, _17, tmp177, tmp176
@ V3_loop_unrolling.c:80:     T -= maskGE & UM;
	ldr	r2, [r7, #44]	@ tmp179, T
	subs	r3, r2, r3	@ T_40, tmp179, _17
	str	r3, [r7, #44]	@ T_40, T
@ V3_loop_unrolling.c:81:     maskGE = 0U - (unsigned int)(T >= UM);
	ldr	r2, [r7, #44]	@ tmp181, T
	ldr	r3, [r7, #28]	@ tmp182, UM
	cmp	r2, r3	@ tmp181, tmp182
	ite	cs
	movcs	r3, #1	@ tmp183,
	movcc	r3, #0	@ tmp183,
	uxtb	r3, r3	@ _18, _18
@ V3_loop_unrolling.c:81:     maskGE = 0U - (unsigned int)(T >= UM);
	rsbs	r3, r3, #0	@ maskGE_41, _19
	str	r3, [r7, #16]	@ maskGE_41, maskGE
@ V3_loop_unrolling.c:82:     T -= maskGE & UM;
	ldr	r2, [r7, #16]	@ tmp185, maskGE
	ldr	r3, [r7, #28]	@ tmp186, UM
	ands	r3, r3, r2	@, _20, tmp186, tmp185
@ V3_loop_unrolling.c:82:     T -= maskGE & UM;
	ldr	r2, [r7, #44]	@ tmp188, T
	subs	r3, r2, r3	@ T_42, tmp188, _20
	str	r3, [r7, #44]	@ T_42, T
@ V3_loop_unrolling.c:84:     return (int)T;
	ldr	r3, [r7, #44]	@ _43, T
@ V3_loop_unrolling.c:85: }
	mov	r0, r3	@, <retval>
	adds	r7, r7, #48	@,,
	mov	sp, r7	@,
	@ sp needed	@
	pop	{r7, pc}	@
	.size	MMM, .-MMM
	.section	.rodata
	.align	2
.LC0:
	.ascii	"v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call) "
	.ascii	" acc=%ld\012\000"
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
@ V3_loop_unrolling.c:99:     const int M = 3233;
	movw	r3, #3233	@ tmp139,
	str	r3, [r7, #64]	@ tmp139, M
@ V3_loop_unrolling.c:100:     const int m = 12;
	movs	r3, #12	@ tmp140,
	str	r3, [r7, #60]	@ tmp140, m
@ V3_loop_unrolling.c:101:     const long N = 20000000L;
	mov	r3, #11520	@ tmp141,
	movt	r3, 305	@ tmp141,
	str	r3, [r7, #56]	@ tmp141, N
@ V3_loop_unrolling.c:102:     volatile long acc = 0;
	movs	r3, #0	@ tmp142,
	str	r3, [r7, #36]	@ tmp142, acc
@ V3_loop_unrolling.c:107:     clock_gettime(CLOCK_MONOTONIC, &t0);
	add	r3, r7, #16	@ tmp143,,
	mov	r1, r3	@, tmp143
	movs	r0, #1	@,
	bl	__clock_gettime64(PLT)	@
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	movs	r3, #0	@ tmp144,
	str	r3, [r7, #68]	@ tmp144, i
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	b	.L10		@
.L11:
@ V3_loop_unrolling.c:111:         int X = (int)((i * 2654435761U) % 4096U);
	ldr	r2, [r7, #68]	@ i.0_1, i
	movw	r3, #31153	@ tmp145,
	movt	r3, 40503	@ tmp145,
	mul	r3, r2, r3	@ _2, i.0_1, tmp145
@ V3_loop_unrolling.c:111:         int X = (int)((i * 2654435761U) % 4096U);
	ubfx	r3, r3, #0, #12	@ X_38, _3,,
	str	r3, [r7, #44]	@ X_38, X
@ V3_loop_unrolling.c:112:         int Y = (int)((i * 40503U + 1) % 4096U);
	ldr	r3, [r7, #68]	@ i.1_4, i
	movw	r2, #40503	@ tmp147,
	mul	r3, r2, r3	@ _5, tmp147, i.1_4
@ V3_loop_unrolling.c:112:         int Y = (int)((i * 40503U + 1) % 4096U);
	adds	r3, r3, #1	@ _6, _5,
@ V3_loop_unrolling.c:112:         int Y = (int)((i * 40503U + 1) % 4096U);
	ubfx	r3, r3, #0, #12	@ Y_39, _7,,
	str	r3, [r7, #40]	@ Y_39, Y
@ V3_loop_unrolling.c:113:         acc += MMM(X, Y, M, m);
	ldr	r3, [r7, #60]	@, m
	ldr	r2, [r7, #64]	@, M
	ldr	r1, [r7, #40]	@, Y
	ldr	r0, [r7, #44]	@, X
	bl	MMM(PLT)	@
	mov	r2, r0	@ _41,
@ V3_loop_unrolling.c:113:         acc += MMM(X, Y, M, m);
	ldr	r3, [r7, #36]	@ acc.2_8, acc
	add	r3, r3, r2	@ _9, _41
	str	r3, [r7, #36]	@ _9, acc
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	ldr	r3, [r7, #68]	@ tmp150, i
	adds	r3, r3, #1	@ i_43, tmp150,
	str	r3, [r7, #68]	@ i_43, i
.L10:
@ V3_loop_unrolling.c:110:     for (long i = 0; i < N; i++) {
	ldr	r2, [r7, #68]	@ tmp151, i
	ldr	r3, [r7, #56]	@ tmp152, N
	cmp	r2, r3	@ tmp151, tmp152
	blt	.L11		@,
@ V3_loop_unrolling.c:117:     clock_gettime(CLOCK_MONOTONIC, &t1);
	mov	r3, r7	@ tmp153,
	mov	r1, r3	@, tmp153
	movs	r0, #1	@,
	bl	__clock_gettime64(PLT)	@
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldrd	r0, [r7]	@ _10, t1.tv_sec
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldrd	r2, [r7, #16]	@ _11,,
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	subs	r4, r0, r2	@ _12, _10, _11
	sbc	r5, r1, r3	@ _12, _10, _11
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	mov	r0, r4	@, _12
	mov	r1, r5	@, _12
	bl	__aeabi_l2d(PLT)	@
	vmov	d4, r0, r1	@ _13,
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r2, [r7, #8]	@ _14, t1.tv_nsec
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	ldr	r3, [r7, #24]	@ _15, t0.tv_nsec
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	subs	r3, r2, r3	@ _16, _14, _15
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vmov	s15, r3	@ int	@ _16, _16
	vcvt.f64.s32	d6, s15	@ _17, _16
	vldr.64	d5, .L13	@ tmp154,
	vdiv.f64	d7, d6, d5	@ _18, _17, tmp154
@ V3_loop_unrolling.c:118:     double secs = (t1.tv_sec - t0.tv_sec) + (t1.tv_nsec - t0.tv_nsec) / 1e9;
	vadd.f64	d7, d4, d7	@ secs_33, _13, _18
	vstr.64	d7, [r7, #48]	@ secs_33, secs
@ V3_loop_unrolling.c:121:            N, secs, secs * 1e9 / N, acc);
	vldr.64	d7, [r7, #48]	@ tmp156, secs
	vldr.64	d6, .L13	@ tmp157,
	vmul.f64	d5, d7, d6	@ _19, tmp156, tmp157
@ V3_loop_unrolling.c:120:     printf("v3_unroll: %ld MMM calls in %.4f s  (%.1f ns/call)  acc=%ld\n",
	ldr	r3, [r7, #56]	@ tmp158, N
	vmov	s15, r3	@ int	@ tmp158, tmp158
	vcvt.f64.s32	d6, s15	@ _20, tmp158
	vdiv.f64	d7, d5, d6	@ _21, _19, _20
	ldr	r3, [r7, #36]	@ acc.3_22, acc
	str	r3, [sp, #8]	@ acc.3_22,
	vstr.64	d7, [sp]	@ _21,
	ldrd	r2, [r7, #48]	@,,
	ldr	r1, [r7, #56]	@, N
	ldr	r0, .L13+8	@ tmp159,
.LPIC0:
	add	r0, pc	@ tmp159
	bl	printf(PLT)	@
@ V3_loop_unrolling.c:123:     return 0;
	movs	r3, #0	@ _35,
@ V3_loop_unrolling.c:124: }
	mov	r0, r3	@, <retval>
	adds	r7, r7, #72	@,,
	mov	sp, r7	@,
	@ sp needed	@
	pop	{r4, r5, r7, pc}	@
.L14:
	.align	3
.L13:
	.word	0
	.word	1104006501
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.global	__aeabi_l2d
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
