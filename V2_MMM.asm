
V2_branchless:     file format elf32-littlearm


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000648 <MMM>:
 648:	b5f0      	push	{r4, r5, r6, r7, lr}
 64a:	1e1e      	subs	r6, r3, #0
 64c:	dd23      	ble.n	696 <MMM+0x4e>
 64e:	f04f 0c00 	mov.w	ip, #0
 652:	f001 0701 	and.w	r7, r1, #1
 656:	4663      	mov	r3, ip
 658:	fa20 fe03 	lsr.w	lr, r0, r3
 65c:	f00c 0501 	and.w	r5, ip, #1
 660:	f00e 0401 	and.w	r4, lr, #1
 664:	ea0e 0e07 	and.w	lr, lr, r7
 668:	ea8e 0e05 	eor.w	lr, lr, r5
 66c:	3301      	adds	r3, #1
 66e:	429e      	cmp	r6, r3
 670:	fb01 cc04 	mla	ip, r1, r4, ip
 674:	fb02 cc0e 	mla	ip, r2, lr, ip
 678:	ea4f 0c5c 	mov.w	ip, ip, lsr #1
 67c:	d1ec      	bne.n	658 <MMM+0x10>
 67e:	4594      	cmp	ip, r2
 680:	bf2c      	ite	cs
 682:	4613      	movcs	r3, r2
 684:	2300      	movcc	r3, #0
 686:	ebac 0c03 	sub.w	ip, ip, r3
 68a:	4594      	cmp	ip, r2
 68c:	bf38      	it	cc
 68e:	2200      	movcc	r2, #0
 690:	ebac 0002 	sub.w	r0, ip, r2
 694:	bdf0      	pop	{r4, r5, r6, r7, pc}
 696:	f04f 0c00 	mov.w	ip, #0
 69a:	e7f0      	b.n	67e <MMM+0x36>

Disassembly of section .fini:
