	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"V4_final.c"
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
	push	{r4, r5, r6, r7, lr}
	subs	r6, r3, #0
	ble	.L4
	mov	ip, #0
	and	r5, r1, #1
	mov	r4, ip
	ands	r3, r6, #3
	beq	.L3
	cmp	r3, #1
	beq	.L15
	cmp	r3, #2
	beq	.L16
	and	r4, r0, #1
	and	ip, r0, r5
	mul	r7, r1, r4
	movs	r4, #1
	mla	r3, r2, ip, r7
	lsr	ip, r3, #1
.L16:
	lsr	r3, r0, r4
	and	lr, ip, #1
	and	r7, r3, #1
	ands	r3, r3, r5
	eor	r3, r3, lr
	adds	r4, r4, #1
	mla	ip, r1, r7, ip
	mla	r7, r2, r3, ip
	lsr	ip, r7, #1
.L15:
	lsr	r3, r0, r4
	and	lr, ip, #1
	and	r7, r3, #1
	ands	r3, r3, r5
	eor	r3, r3, lr
	adds	r4, r4, #1
	cmp	r6, r4
	mla	ip, r1, r7, ip
	mla	r7, r2, r3, ip
	lsr	ip, r7, #1
	beq	.L2
.L3:
	lsr	r3, r0, r4
	and	lr, ip, #1
	and	r7, r3, #1
	ands	r3, r3, r5
	eor	r3, r3, lr
	mla	r7, r1, r7, ip
	add	ip, r4, #1
	mla	r7, r2, r3, r7
	adds	r3, r4, #2
	lsr	lr, r7, #1
	lsr	r7, r0, ip
	lsr	ip, r0, r3
	and	r3, r7, #1
	ands	r7, r7, r5
	mla	r3, r1, r3, lr
	and	lr, lr, #1
	eor	r7, r7, lr
	mla	r3, r2, r7, r3
	lsrs	r7, r3, #1
	and	r3, ip, #1
	and	ip, ip, r5
	mla	lr, r1, r3, r7
	and	r7, r7, #1
	eor	r7, ip, r7
	adds	r3, r4, #3
	adds	r4, r4, #4
	lsr	r3, r0, r3
	cmp	r6, r4
	mla	r7, r2, r7, lr
	and	ip, r3, #1
	and	r3, r3, r5
	lsr	r7, r7, #1
	and	lr, r7, #1
	eor	r3, r3, lr
	mla	ip, r1, ip, r7
	mla	r7, r2, r3, ip
	lsr	ip, r7, #1
	bne	.L3
.L2:
	cmp	ip, r2
	ite	cs
	movcs	r0, r2
	movcc	r0, #0
	sub	r1, ip, r0
	cmp	r1, r2
	it	cc
	movcc	r2, #0
	subs	r0, r1, r2
	pop	{r4, r5, r6, r7, pc}
.L4:
	mov	ip, #0
	b	.L2
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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	movs	r0, #1
	movs	r4, #0
	sub	sp, sp, #56
	add	r1, sp, #24
	str	r4, [sp, #20]
	bl	__clock_gettime64(PLT)
	movw	lr, #31153
	movt	lr, 40503
	movw	ip, #43777
	movt	ip, 39766
	movs	r2, #1
	mov	r1, r4
	movw	r0, #3233
	movw	r4, #40503
.L24:
	and	r5, r1, #1
	ubfx	r7, r2, #0, #12
	and	r6, r5, r2
	ubfx	r10, r1, #1, #1
	rsbs	r6, r6, #0
	and	r8, r10, r2
	ands	r6, r6, r0
	ubfx	r9, r1, #2, #1
	and	r3, r9, r2
	mla	r5, r5, r7, r6
	lsrs	r6, r5, #1
	and	r5, r6, #1
	eor	r8, r8, r5
	ubfx	r5, r1, #3, #1
	mla	r10, r10, r7, r6
	rsb	r6, r8, #0
	and	r8, r6, r0
	add	r8, r8, r10
	lsr	r10, r8, #1
	and	r6, r10, #1
	eors	r3, r3, r6
	and	r6, r5, r2
	mla	r9, r9, r7, r10
	rsbs	r3, r3, #0
	ands	r3, r3, r0
	ubfx	r10, r1, #4, #1
	add	r3, r3, r9
	ubfx	r9, r1, #5, #1
	lsrs	r3, r3, #1
	and	r8, r3, #1
	eor	r6, r8, r6
	mla	r3, r5, r7, r3
	rsbs	r6, r6, #0
	ands	r6, r6, r0
	and	r5, r10, r2
	add	r3, r3, r6
	and	r6, r9, r2
	lsrs	r3, r3, #1
	and	r8, r3, #1
	eor	r8, r8, r5
	ubfx	r5, r1, #6, #1
	mla	r10, r10, r7, r3
	rsb	r3, r8, #0
	and	r8, r3, r0
	add	r8, r8, r10
	lsr	r10, r8, #1
	and	r3, r10, #1
	eors	r3, r3, r6
	and	r6, r5, r2
	mla	r9, r9, r7, r10
	rsbs	r3, r3, #0
	ands	r3, r3, r0
	ubfx	r10, r1, #7, #1
	add	r3, r3, r9
	ubfx	r9, r1, #8, #1
	lsrs	r3, r3, #1
	and	r8, r3, #1
	eor	r6, r8, r6
	mla	r3, r5, r7, r3
	rsbs	r6, r6, #0
	ands	r6, r6, r0
	and	r5, r10, r2
	add	r3, r3, r6
	and	r6, r9, r2
	lsrs	r3, r3, #1
	and	r8, r3, #1
	eor	r8, r8, r5
	ubfx	r5, r1, #9, #1
	mla	r10, r10, r7, r3
	rsb	r3, r8, #0
	and	r8, r3, r0
	add	r8, r8, r10
	lsr	r10, r8, #1
	and	r3, r10, #1
	eors	r3, r3, r6
	and	r6, r5, r2
	mla	r9, r9, r7, r10
	rsbs	r3, r3, #0
	ands	r3, r3, r0
	ubfx	r10, r1, #10, #1
	add	r3, r3, r9
	lsrs	r3, r3, #1
	and	r8, r3, #1
	eor	r6, r8, r6
	ubfx	r8, r1, #11, #1
	mla	r3, r5, r7, r3
	rsbs	r6, r6, #0
	ands	r6, r6, r0
	and	r5, r10, r2
	add	r3, r3, r6
	and	r9, r8, r2
	add	r2, r2, r4
	add	r1, r1, lr
	lsrs	r3, r3, #1
	and	r6, r3, #1
	eors	r6, r6, r5
	ldr	r5, [sp, #20]
	mla	r10, r10, r7, r3
	rsbs	r3, r6, #0
	ands	r3, r3, r0
	add	r3, r3, r10
	lsrs	r6, r3, #1
	and	r10, r6, #1
	eor	r3, r10, r9
	mla	r7, r8, r7, r6
	rsbs	r6, r3, #0
	ands	r6, r6, r0
	add	r6, r6, r7
	lsrs	r3, r6, #1
	cmp	r3, #3232
	ite	hi
	movhi	r7, r0
	movls	r7, #0
	subs	r6, r3, r7
	cmp	r6, #3232
	ite	hi
	movhi	r7, r0
	movls	r7, #0
	subs	r7, r6, r7
	cmp	r2, ip
	add	r7, r7, r5
	str	r7, [sp, #20]
	bne	.L24
	add	r1, sp, #40
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldr	r1, [sp, #24]
	ldr	r0, [sp, #40]
	ldr	r2, [sp, #44]
	ldr	r4, [sp, #28]
	subs	r0, r0, r1
	sbc	r1, r2, r4
	bl	__aeabi_l2d(PLT)
	ldr	r3, [sp, #32]
	ldr	r5, [sp, #48]
	vmov	d5, r0, r1
	vldr.64	d6, .L27
	mov	r1, #11520
	movt	r1, 305
	subs	r6, r5, r3
	vmov	s15, r6	@ int
	vldr.64	d4, .L27+8
	ldr	r0, .L27+16
	vcvt.f64.s32	d7, s15
	ldr	r7, [sp, #20]
	str	r7, [sp, #8]
.LPIC0:
	add	r0, pc
	vdiv.f64	d3, d7, d6
	vadd.f64	d0, d5, d3
	vmul.f64	d1, d0, d6
	vmov	r2, r3, d0
	vdiv.f64	d2, d1, d4
	vstr.64	d2, [sp]
	bl	printf(PLT)
	movs	r0, #0
	add	sp, sp, #56
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L28:
	.align	3
.L27:
	.word	0
	.word	1104006501
	.word	0
	.word	1098060496
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.global	__aeabi_l2d
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
