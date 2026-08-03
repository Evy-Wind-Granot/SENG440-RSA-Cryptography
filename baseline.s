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
	.file	"baseline.c"
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
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}	@
	sub	sp, sp, #52	@,,
	add	r7, sp, #0	@,,
	str	r0, [r7, #12]	@ X, X
	str	r1, [r7, #8]	@ Y, Y
	str	r2, [r7, #4]	@ M, M
	str	r3, [r7]	@ m, m
@ baseline.c:12:   T = 0;
	movs	r3, #0	@ tmp122,
	str	r3, [r7, #40]	@ tmp122, T
@ baseline.c:13:   Y0 = Y & 1;
	ldr	r3, [r7, #8]	@ tmp124, Y
	and	r3, r3, #1	@ Y0_12, tmp124,
	str	r3, [r7, #36]	@ Y0_12, Y0
@ baseline.c:14:   for( i=0; i<m; i++) {
	movs	r3, #0	@ tmp125,
	str	r3, [r7, #44]	@ tmp125, i
@ baseline.c:14:   for( i=0; i<m; i++) {
	b	.L2		@
.L7:
@ baseline.c:15:     Xi = (X >> i) & 1;
	ldr	r2, [r7, #12]	@ tmp126, X
	ldr	r3, [r7, #44]	@ tmp127, i
	asr	r3, r2, r3	@ _1, tmp126, tmp127
@ baseline.c:15:     Xi = (X >> i) & 1;
	and	r3, r3, #1	@ Xi_20, _1,
	str	r3, [r7, #32]	@ Xi_20, Xi
@ baseline.c:17:     T0 = T & 1;
	ldr	r3, [r7, #40]	@ tmp130, T
	and	r3, r3, #1	@ T0_21, tmp130,
	str	r3, [r7, #28]	@ T0_21, T0
@ baseline.c:19:     eta = T0 ^ (Xi & Y0);
	ldr	r2, [r7, #32]	@ tmp131, Xi
	ldr	r3, [r7, #36]	@ tmp132, Y0
	ands	r3, r3, r2	@, _2, tmp132, tmp131
@ baseline.c:19:     eta = T0 ^ (Xi & Y0);
	ldr	r2, [r7, #28]	@ tmp134, T0
	eors	r3, r3, r2	@, eta_22, _2, tmp134
	str	r3, [r7, #24]	@ eta_22, eta
@ baseline.c:21:     Xi_Y = Xi ? Y : 0;
	ldr	r3, [r7, #32]	@ tmp135, Xi
	cmp	r3, #0	@ tmp135,
	beq	.L3		@,
@ baseline.c:21:     Xi_Y = Xi ? Y : 0;
	ldr	r3, [r7, #8]	@ iftmp.0_8, Y
	b	.L4		@
.L3:
@ baseline.c:21:     Xi_Y = Xi ? Y : 0;
	movs	r3, #0	@ iftmp.0_8,
.L4:
@ baseline.c:21:     Xi_Y = Xi ? Y : 0;
	str	r3, [r7, #20]	@ iftmp.0_8, Xi_Y
@ baseline.c:23:     eta_M = eta ? M : 0;
	ldr	r3, [r7, #24]	@ tmp136, eta
	cmp	r3, #0	@ tmp136,
	beq	.L5		@,
@ baseline.c:23:     eta_M = eta ? M : 0;
	ldr	r3, [r7, #4]	@ iftmp.1_9, M
	b	.L6		@
.L5:
@ baseline.c:23:     eta_M = eta ? M : 0;
	movs	r3, #0	@ iftmp.1_9,
.L6:
@ baseline.c:23:     eta_M = eta ? M : 0;
	str	r3, [r7, #16]	@ iftmp.1_9, eta_M
@ baseline.c:25:     T = (T + Xi_Y + eta_M) >> 1;
	ldr	r2, [r7, #40]	@ tmp137, T
	ldr	r3, [r7, #20]	@ tmp138, Xi_Y
	add	r2, r2, r3	@ _3, tmp138
@ baseline.c:25:     T = (T + Xi_Y + eta_M) >> 1;
	ldr	r3, [r7, #16]	@ tmp139, eta_M
	add	r3, r3, r2	@ _4, _3
@ baseline.c:25:     T = (T + Xi_Y + eta_M) >> 1;
	asrs	r3, r3, #1	@ T_29, _4,
	str	r3, [r7, #40]	@ T_29, T
@ baseline.c:14:   for( i=0; i<m; i++) {
	ldr	r3, [r7, #44]	@ tmp142, i
	adds	r3, r3, #1	@ i_30, tmp142,
	str	r3, [r7, #44]	@ i_30, i
.L2:
@ baseline.c:14:   for( i=0; i<m; i++) {
	ldr	r2, [r7, #44]	@ tmp143, i
	ldr	r3, [r7]	@ tmp144, m
	cmp	r2, r3	@ tmp143, tmp144
	blt	.L7		@,
@ baseline.c:28:   while ( T >= M)
	b	.L8		@
.L9:
@ baseline.c:29:     T -= M;
	ldr	r2, [r7, #40]	@ tmp146, T
	ldr	r3, [r7, #4]	@ tmp147, M
	subs	r3, r2, r3	@ T_18, tmp146, tmp147
	str	r3, [r7, #40]	@ T_18, T
.L8:
@ baseline.c:28:   while ( T >= M)
	ldr	r2, [r7, #40]	@ tmp148, T
	ldr	r3, [r7, #4]	@ tmp149, M
	cmp	r2, r3	@ tmp148, tmp149
	bge	.L9		@,
@ baseline.c:31:   return T;
	ldr	r3, [r7, #40]	@ _16, T
@ baseline.c:32: }
	mov	r0, r3	@, <retval>
	adds	r7, r7, #52	@,,
	mov	sp, r7	@,
	@ sp needed	@
	ldr	r7, [sp], #4	@,
	bx	lr	@
	.size	MMM, .-MMM
	.section	.rodata
	.align	2
.LC0:
	.ascii	"The algorithm configuration is:\000"
	.align	2
.LC1:
	.ascii	"Bitwidth (m) = %i\012\000"
	.align	2
.LC2:
	.ascii	"Modulus (M) = %i\012\000"
	.align	2
.LC3:
	.ascii	"R = %i\011\011[R mod M = (1 << m) mod M = 4096 mod "
	.ascii	"3233 = 863]\012\000"
	.align	2
.LC4:
	.ascii	"R^2 = %i\011[R * R mod M = 863 * 863 mod 3233 = 744"
	.ascii	"769 mod 3233 = 1179]\012\000"
	.align	2
.LC5:
	.ascii	"R^-1 = %i\011[since R * R^-1 mod M = 863 * 1742 mod"
	.ascii	" 3233 = 1]\012\012\000"
	.align	2
.LC6:
	.ascii	"Recall that MMM calculates (X * Y * R^-1) mod M.  L"
	.ascii	"et's check that!\000"
	.align	2
.LC7:
	.ascii	"The range for X and Y is 0...%i. Introduce X and Y "
	.ascii	"below:\012\000"
	.align	2
.LC8:
	.ascii	"\011X = \000"
	.align	2
.LC9:
	.ascii	"%i\000"
	.align	2
.LC10:
	.ascii	"\011Y = \000"
	.align	2
.LC11:
	.ascii	"\011Z = (X * Y * R^-1) mod M = %i\012\000"
	.align	2
.LC12:
	.ascii	"Reminder calculated with the brute force in C:\012\011"
	.ascii	"(X * Y * R^-1) % M = %i\012\012\000"
	.align	2
.LC13:
	.ascii	"Verify the Identity Operation!\000"
	.align	2
.LC14:
	.ascii	"\011R = MMM( R, R, M, m) = (R * R * R^-1) mod M = %"
	.ascii	"i\012\012\000"
	.align	2
.LC15:
	.ascii	"Calculate R_inv.  The easiest way is to use MMM!\000"
	.align	2
.LC16:
	.ascii	"\011R_inv = MMM( 1, 1, M, m) = (1 * 1 * R^-1) mod M"
	.ascii	" = %i\012\012\000"
	.align	2
.LC17:
	.ascii	"Calculate Z = (X * Y) mod M\000"
	.align	2
.LC18:
	.ascii	"First, X is scaled up:\012\011X_scaled = MMM( X, R^"
	.ascii	"2, M, m) = %i\012\000"
	.align	2
.LC19:
	.ascii	"Second, Y is scaled up:\012\011Y_scaled = MMM( Y, R"
	.ascii	"^2, M, m) = %i\012\000"
	.align	2
.LC20:
	.ascii	"Third, the scaled up product is calculated:\012\011"
	.ascii	"Z_scaled = MMM( X_scaled, Y_scaled, M, m) = %i\012\000"
	.align	2
.LC21:
	.ascii	"Finally, the scaled up product is scaled down:\012\011"
	.ascii	"Z = MMM( Z_scaled, 1, M, m) = %i\012\000"
	.align	2
.LC22:
	.ascii	"Reminder calculated with the brute force in C:\012\011"
	.ascii	"(X * Y) % M = %i\012\012\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}	@
	sub	sp, sp, #48	@,,
	add	r7, sp, #0	@,,
@ baseline.c:38:   int M = 3233;
	movw	r3, #3233	@ tmp130,
	str	r3, [r7, #44]	@ tmp130, M
@ baseline.c:39:   int m = 12;
	movs	r3, #12	@ tmp131,
	str	r3, [r7, #40]	@ tmp131, m
@ baseline.c:40:   int R = 863;      // 1 << m = 4096, and 4096 mod 3233 = 863
	movw	r3, #863	@ tmp132,
	str	r3, [r7, #36]	@ tmp132, R
@ baseline.c:41:   int R2 = 1179;    // 863 * 863 mod 3233 = 744769 mod 3233 = 1179
	movw	r3, #1179	@ tmp133,
	str	r3, [r7, #32]	@ tmp133, R2
@ baseline.c:42:   int R_inv = 1742; // 863 * 1742 mod 3233 = 1
	movw	r3, #1742	@ tmp134,
	str	r3, [r7, #28]	@ tmp134, R_inv
@ baseline.c:46:   printf( "The algorithm configuration is:\n");
	ldr	r3, .L16	@ tmp135,
.LPIC0:
	add	r3, pc	@ tmp135
	mov	r0, r3	@, tmp135
	bl	puts(PLT)	@
@ baseline.c:47:   printf( "Bitwidth (m) = %i\n", m);
	ldr	r1, [r7, #40]	@, m
	ldr	r3, .L16+4	@ tmp136,
.LPIC1:
	add	r3, pc	@ tmp136
	mov	r0, r3	@, tmp136
	bl	printf(PLT)	@
@ baseline.c:48:   printf( "Modulus (M) = %i\n", M);
	ldr	r1, [r7, #44]	@, M
	ldr	r3, .L16+8	@ tmp137,
.LPIC2:
	add	r3, pc	@ tmp137
	mov	r0, r3	@, tmp137
	bl	printf(PLT)	@
@ baseline.c:49:   printf( "R = %i\t\t[R mod M = (1 << m) mod M = 4096 mod 3233 = 863]\n", R);
	ldr	r1, [r7, #36]	@, R
	ldr	r3, .L16+12	@ tmp138,
.LPIC3:
	add	r3, pc	@ tmp138
	mov	r0, r3	@, tmp138
	bl	printf(PLT)	@
@ baseline.c:50:   printf( "R^2 = %i\t[R * R mod M = 863 * 863 mod 3233 = 744769 mod 3233 = 1179]\n", R2);
	ldr	r1, [r7, #32]	@, R2
	ldr	r3, .L16+16	@ tmp139,
.LPIC4:
	add	r3, pc	@ tmp139
	mov	r0, r3	@, tmp139
	bl	printf(PLT)	@
@ baseline.c:51:   printf( "R^-1 = %i\t[since R * R^-1 mod M = 863 * 1742 mod 3233 = 1]\n\n", R_inv);
	ldr	r1, [r7, #28]	@, R_inv
	ldr	r3, .L16+20	@ tmp140,
.LPIC5:
	add	r3, pc	@ tmp140
	mov	r0, r3	@, tmp140
	bl	printf(PLT)	@
@ baseline.c:53:   printf( "Recall that MMM calculates (X * Y * R^-1) mod M.  Let's check that!\n");
	ldr	r3, .L16+24	@ tmp141,
.LPIC6:
	add	r3, pc	@ tmp141
	mov	r0, r3	@, tmp141
	bl	puts(PLT)	@
@ baseline.c:54:   printf( "The range for X and Y is 0...%i. Introduce X and Y below:\n", (1<<m)-1);
	movs	r2, #1	@ tmp142,
	ldr	r3, [r7, #40]	@ tmp143, m
	lsl	r3, r2, r3	@ _1, tmp142, tmp143
@ baseline.c:54:   printf( "The range for X and Y is 0...%i. Introduce X and Y below:\n", (1<<m)-1);
	subs	r3, r3, #1	@ _2, _1,
	mov	r1, r3	@, _2
	ldr	r3, .L16+28	@ tmp144,
.LPIC7:
	add	r3, pc	@ tmp144
	mov	r0, r3	@, tmp144
	bl	printf(PLT)	@
@ baseline.c:55:   printf( "\tX = ");
	ldr	r3, .L16+32	@ tmp145,
.LPIC8:
	add	r3, pc	@ tmp145
	mov	r0, r3	@, tmp145
	bl	printf(PLT)	@
@ baseline.c:56:   scanf( "%i", &X);
	adds	r3, r7, #4	@ tmp146,,
	mov	r1, r3	@, tmp146
	ldr	r3, .L16+36	@ tmp147,
.LPIC9:
	add	r3, pc	@ tmp147
	mov	r0, r3	@, tmp147
	bl	__isoc99_scanf(PLT)	@
@ baseline.c:57:   printf( "\tY = ");
	ldr	r3, .L16+40	@ tmp148,
.LPIC10:
	add	r3, pc	@ tmp148
	mov	r0, r3	@, tmp148
	bl	printf(PLT)	@
@ baseline.c:58:   scanf( "%i", &Y);
	mov	r3, r7	@ tmp149,
	mov	r1, r3	@, tmp149
	ldr	r3, .L16+44	@ tmp150,
.LPIC11:
	add	r3, pc	@ tmp150
	mov	r0, r3	@, tmp150
	bl	__isoc99_scanf(PLT)	@
@ baseline.c:59:   Z = MMM( X, Y, M, m);
	ldr	r0, [r7, #4]	@ X.2_3, X
	ldr	r1, [r7]	@ Y.3_4, Y
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	bl	MMM(PLT)	@
	str	r0, [r7, #24]	@, Z
@ baseline.c:60:   printf( "\tZ = (X * Y * R^-1) mod M = %i\n", Z);
	ldr	r1, [r7, #24]	@, Z
	ldr	r3, .L16+48	@ tmp151,
.LPIC12:
	add	r3, pc	@ tmp151
	mov	r0, r3	@, tmp151
	bl	printf(PLT)	@
@ baseline.c:61:   reminder_in_C = (X * Y * R_inv) % M;
	ldr	r3, [r7, #4]	@ X.4_5, X
	ldr	r2, [r7]	@ Y.5_6, Y
	mul	r3, r2, r3	@ _7, Y.5_6, X.4_5
@ baseline.c:61:   reminder_in_C = (X * Y * R_inv) % M;
	ldr	r2, [r7, #28]	@ tmp152, R_inv
	mul	r3, r2, r3	@ _8, tmp152, _7
@ baseline.c:61:   reminder_in_C = (X * Y * R_inv) % M;
	ldr	r1, [r7, #44]	@, M
	mov	r0, r3	@, _8
	bl	__aeabi_idivmod(PLT)	@
	mov	r3, r1	@ reminder_in_C_37,
	str	r3, [r7, #20]	@ reminder_in_C_37, reminder_in_C
@ baseline.c:62:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	ldr	r3, [r7, #20]	@ tmp163, reminder_in_C
	cmp	r3, #0	@ tmp163,
	bge	.L12		@,
@ baseline.c:62:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	ldr	r2, [r7, #20]	@ tmp164, reminder_in_C
	ldr	r3, [r7, #44]	@ tmp165, M
	add	r3, r3, r2	@ iftmp.6_14, tmp164
	b	.L13		@
.L12:
@ baseline.c:62:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	ldr	r3, [r7, #20]	@ iftmp.6_14, reminder_in_C
.L13:
@ baseline.c:62:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	str	r3, [r7, #20]	@ iftmp.6_14, reminder_in_C
@ baseline.c:63:   printf( "Reminder calculated with the brute force in C:\n\t(X * Y * R^-1) % M = %i\n\n", reminder_in_C);
	ldr	r1, [r7, #20]	@, reminder_in_C
	ldr	r3, .L16+52	@ tmp166,
.LPIC13:
	add	r3, pc	@ tmp166
	mov	r0, r3	@, tmp166
	bl	printf(PLT)	@
@ baseline.c:65:   printf( "Verify the Identity Operation!\n");
	ldr	r3, .L16+56	@ tmp167,
.LPIC14:
	add	r3, pc	@ tmp167
	mov	r0, r3	@, tmp167
	bl	puts(PLT)	@
@ baseline.c:66:   Z = MMM( R, R, M, m);
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	ldr	r1, [r7, #36]	@, R
	ldr	r0, [r7, #36]	@, R
	bl	MMM(PLT)	@
	str	r0, [r7, #24]	@, Z
@ baseline.c:67:   printf( "\tR = MMM( R, R, M, m) = (R * R * R^-1) mod M = %i\n\n", Z);
	ldr	r1, [r7, #24]	@, Z
	ldr	r3, .L16+60	@ tmp168,
.LPIC15:
	add	r3, pc	@ tmp168
	mov	r0, r3	@, tmp168
	bl	printf(PLT)	@
@ baseline.c:69:   printf( "Calculate R_inv.  The easiest way is to use MMM!\n");
	ldr	r3, .L16+64	@ tmp169,
.LPIC16:
	add	r3, pc	@ tmp169
	mov	r0, r3	@, tmp169
	bl	puts(PLT)	@
@ baseline.c:70:   Z = MMM( 1, 1, M, m);
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	movs	r1, #1	@,
	movs	r0, #1	@,
	bl	MMM(PLT)	@
	str	r0, [r7, #24]	@, Z
@ baseline.c:71:   printf( "\tR_inv = MMM( 1, 1, M, m) = (1 * 1 * R^-1) mod M = %i\n\n", Z);
	ldr	r1, [r7, #24]	@, Z
	ldr	r3, .L16+68	@ tmp170,
.LPIC17:
	add	r3, pc	@ tmp170
	mov	r0, r3	@, tmp170
	bl	printf(PLT)	@
@ baseline.c:73:   printf( "Calculate Z = (X * Y) mod M\n");
	ldr	r3, .L16+72	@ tmp171,
.LPIC18:
	add	r3, pc	@ tmp171
	mov	r0, r3	@, tmp171
	bl	puts(PLT)	@
@ baseline.c:74:   X_scaled = MMM( X, R2, M, m);
	ldr	r0, [r7, #4]	@ X.7_9, X
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	ldr	r1, [r7, #32]	@, R2
	bl	MMM(PLT)	@
	str	r0, [r7, #16]	@, X_scaled
@ baseline.c:75:   printf( "First, X is scaled up:\n\tX_scaled = MMM( X, R^2, M, m) = %i\n", X_scaled);
	ldr	r1, [r7, #16]	@, X_scaled
	ldr	r3, .L16+76	@ tmp172,
.LPIC19:
	add	r3, pc	@ tmp172
	mov	r0, r3	@, tmp172
	bl	printf(PLT)	@
@ baseline.c:76:   Y_scaled = MMM( Y, R2, M, m);
	ldr	r0, [r7]	@ Y.8_10, Y
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	ldr	r1, [r7, #32]	@, R2
	bl	MMM(PLT)	@
	str	r0, [r7, #12]	@, Y_scaled
@ baseline.c:77:   printf( "Second, Y is scaled up:\n\tY_scaled = MMM( Y, R^2, M, m) = %i\n", Y_scaled);
	ldr	r1, [r7, #12]	@, Y_scaled
	ldr	r3, .L16+80	@ tmp173,
.LPIC20:
	add	r3, pc	@ tmp173
	mov	r0, r3	@, tmp173
	bl	printf(PLT)	@
@ baseline.c:78:   Z_scaled = MMM( X_scaled, Y_scaled, M, m);
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	ldr	r1, [r7, #12]	@, Y_scaled
	ldr	r0, [r7, #16]	@, X_scaled
	bl	MMM(PLT)	@
	str	r0, [r7, #8]	@, Z_scaled
@ baseline.c:79:   printf( "Third, the scaled up product is calculated:\n\tZ_scaled = MMM( X_scaled, Y_scaled, M, m) = %i\n", Z_scaled);
	ldr	r1, [r7, #8]	@, Z_scaled
	ldr	r3, .L16+84	@ tmp174,
.LPIC21:
	add	r3, pc	@ tmp174
	mov	r0, r3	@, tmp174
	bl	printf(PLT)	@
@ baseline.c:80:   Z = MMM( Z_scaled, 1, M, m);
	ldr	r3, [r7, #40]	@, m
	ldr	r2, [r7, #44]	@, M
	movs	r1, #1	@,
	ldr	r0, [r7, #8]	@, Z_scaled
	bl	MMM(PLT)	@
	str	r0, [r7, #24]	@, Z
@ baseline.c:81:   printf( "Finally, the scaled up product is scaled down:\n\tZ = MMM( Z_scaled, 1, M, m) = %i\n", Z);
	ldr	r1, [r7, #24]	@, Z
	ldr	r3, .L16+88	@ tmp175,
.LPIC22:
	add	r3, pc	@ tmp175
	mov	r0, r3	@, tmp175
	bl	printf(PLT)	@
@ baseline.c:82:   reminder_in_C = (X * Y) % M;
	ldr	r3, [r7, #4]	@ X.9_11, X
	ldr	r2, [r7]	@ Y.10_12, Y
	mul	r3, r2, r3	@ _13, Y.10_12, X.9_11
@ baseline.c:82:   reminder_in_C = (X * Y) % M;
	ldr	r1, [r7, #44]	@, M
	mov	r0, r3	@, _13
	bl	__aeabi_idivmod(PLT)	@
	mov	r3, r1	@ reminder_in_C_63,
	str	r3, [r7, #20]	@ reminder_in_C_63, reminder_in_C
@ baseline.c:83:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	ldr	r3, [r7, #20]	@ tmp186, reminder_in_C
	cmp	r3, #0	@ tmp186,
	bge	.L14		@,
@ baseline.c:83:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	ldr	r2, [r7, #20]	@ tmp187, reminder_in_C
	ldr	r3, [r7, #44]	@ tmp188, M
	add	r3, r3, r2	@ iftmp.11_15, tmp187
	b	.L15		@
.L14:
@ baseline.c:83:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	ldr	r3, [r7, #20]	@ iftmp.11_15, reminder_in_C
.L15:
@ baseline.c:83:   reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
	str	r3, [r7, #20]	@ iftmp.11_15, reminder_in_C
@ baseline.c:84:   printf( "Reminder calculated with the brute force in C:\n\t(X * Y) % M = %i\n\n", reminder_in_C);
	ldr	r1, [r7, #20]	@, reminder_in_C
	ldr	r3, .L16+92	@ tmp189,
.LPIC23:
	add	r3, pc	@ tmp189
	mov	r0, r3	@, tmp189
	bl	printf(PLT)	@
@ baseline.c:86:   exit( 0);
	movs	r0, #0	@,
	bl	exit(PLT)	@
.L17:
	.align	2
.L16:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC4-(.LPIC4+4)
	.word	.LC5-(.LPIC5+4)
	.word	.LC6-(.LPIC6+4)
	.word	.LC7-(.LPIC7+4)
	.word	.LC8-(.LPIC8+4)
	.word	.LC9-(.LPIC9+4)
	.word	.LC10-(.LPIC10+4)
	.word	.LC9-(.LPIC11+4)
	.word	.LC11-(.LPIC12+4)
	.word	.LC12-(.LPIC13+4)
	.word	.LC13-(.LPIC14+4)
	.word	.LC14-(.LPIC15+4)
	.word	.LC15-(.LPIC16+4)
	.word	.LC16-(.LPIC17+4)
	.word	.LC17-(.LPIC18+4)
	.word	.LC18-(.LPIC19+4)
	.word	.LC19-(.LPIC20+4)
	.word	.LC20-(.LPIC21+4)
	.word	.LC21-(.LPIC22+4)
	.word	.LC22-(.LPIC23+4)
	.size	main, .-main
	.global	__aeabi_idivmod
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
