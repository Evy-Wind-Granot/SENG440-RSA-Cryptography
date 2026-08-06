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
	and	r7, r1, #1
	mov	r3, ip
.L3:
	lsr	lr, r0, r3
	and	r5, ip, #1
	and	r4, lr, #1
	and	lr, lr, r7
	eor	lr, lr, r5
	adds	r3, r3, #1
	cmp	r6, r3
	mla	ip, r1, r4, ip
	mla	ip, r2, lr, ip
	lsr	ip, ip, #1
	bne	.L3
.L2:
	cmp	ip, r2
	ite	cs
	movcs	r3, r2
	movcc	r3, #0
	sub	ip, ip, r3
	cmp	ip, r2
	it	cc
	movcc	r2, #0
	sub	r0, ip, r2
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
	movw	r6, #31153
	movt	r6, 40503
	add	r1, sp, #24
	movw	r5, #43777
	movt	r5, 39766
	str	r4, [sp, #20]
	bl	__clock_gettime64(PLT)
	movs	r1, #1
	movw	r0, #3233
	movw	r7, #40503
.L10:
	mov	r9, #0
	ubfx	lr, r4, #0, #12
	ubfx	ip, r1, #0, #12
	mov	r2, r9
.L9:
	lsr	r8, lr, r2
	and	r3, r9, #1
	and	r8, r8, #1
	adds	r2, r2, #1
	and	r10, r8, r1
	cmp	r2, #12
	eor	r3, r3, r10
	mla	r8, r8, ip, r9
	rsb	r3, r3, #0
	and	r3, r3, r0
	add	r3, r3, r8
	lsr	r9, r3, #1
	bne	.L9
	cmp	r9, #3232
	ldr	r3, [sp, #20]
	ite	hi
	movhi	r2, r0
	movls	r2, #0
	sub	r9, r9, r2
	add	r1, r1, r7
	cmp	r9, #3232
	add	r4, r4, r6
	ite	hi
	movhi	r2, r0
	movls	r2, #0
	sub	r9, r9, r2
	cmp	r1, r5
	add	r3, r3, r9
	str	r3, [sp, #20]
	bne	.L10
	add	r1, sp, #40
	movs	r0, #1
	bl	__clock_gettime64(PLT)
	ldr	r3, [sp, #40]
	ldr	r1, [sp, #24]
	ldr	r2, [sp, #44]
	ldr	r4, [sp, #28]
	subs	r0, r3, r1
	sbc	r1, r2, r4
	bl	__aeabi_l2d(PLT)
	ldr	r2, [sp, #32]
	ldr	r3, [sp, #48]
	vmov	d5, r0, r1
	vldr.64	d6, .L14
	mov	r1, #11520
	movt	r1, 305
	subs	r3, r3, r2
	vmov	s15, r3	@ int
	vldr.64	d4, .L14+8
	ldr	r2, [sp, #20]
	vcvt.f64.s32	d7, s15
	str	r2, [sp, #8]
	ldr	r0, .L14+16
.LPIC0:
	add	r0, pc
	vdiv.f64	d3, d7, d6
	vadd.f64	d5, d5, d3
	vmul.f64	d6, d5, d6
	vmov	r2, r3, d5
	vdiv.f64	d7, d6, d4
	vstr.64	d7, [sp]
	bl	printf(PLT)
	movs	r0, #0
	add	sp, sp, #56
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
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
