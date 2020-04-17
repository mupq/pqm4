//	 void gf_polymul_4x4_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_4x4_mod3
	.type	gf_polymul_4x4_mod3, %function
gf_polymul_4x4_mod3:
	ldr	r1, [r1]
	ldr	r2, [r2]
	umull	r2, r3, r1, r2
	mov	r1, #0x03030303
	and	r12, r2, #0x3c3c3c3c	// top 3b < 3
	and	r2, r2, r1		// bot 2b < 4
	add	r2, r2, r12, LSR #2	// range <=5
	usub8	r12, r2, r1		// >= 3 ?
	sel	r2, r12, r2		// select
	and	r12, r3, #0x3c3c3c3c	// top 3b < 3
	and	r3, r3, r1		// bot 2b < 4
	add	r3, r3, r12, LSR #2	// range <=5
	usub8	r12, r3, r1		// >= 3 ?
	sel	r3, r12, r3		// select
	//strd	r2, r3, [r0]
	str	r2, [r0]
	str	r3, [r0, #4]
	bx	lr
//	 void gf_polymul_8x8_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_8x8_mod3
	.type	gf_polymul_8x8_mod3, %function
gf_polymul_8x8_mod3:
	push	{r4-r9}
	ldr	r4, [r2]
	ldr	r5, [r2, #4]
	ldr	r2, [r1]
	ldr	r3, [r1, #4]
	umull	r6, r7, r2, r4
	umull	r8, r9, r3, r5
	umlal	r7, r8, r3, r4
	umlal	r7, r8, r2, r5
	mov	r1, #0x03030303
	and	r2, r6, #0x3c3c3c3c	// top 3b < 8
	and	r6, r6, r1		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	and	r2, r6, #0x3c3c3c3c	// top 3b < 3
	and	r6, r6, r1		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r1		// >= 3 ?
	sel	r6, r2, r6		// select
	and	r2, r7, #0x3c3c3c3c	// top 3b < 8
	and	r7, r7, r1		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	and	r2, r7, #0x3c3c3c3c	// top 3b < 3
	and	r7, r7, r1		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r1		// >= 3 ?
	sel	r7, r2, r7		// select
	and	r2, r8, #0x3c3c3c3c	// top 3b < 8
	and	r8, r8, r1		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	and	r2, r8, #0x3c3c3c3c	// top 3b < 3
	and	r8, r8, r1		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r1		// >= 3 ?
	sel	r8, r2, r8		// select
	and	r2, r9, #0x3c3c3c3c	// top 3b < 8
	and	r9, r9, r1		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	and	r2, r9, #0x3c3c3c3c	// top 3b < 3
	and	r9, r9, r1		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r1		// >= 3 ?
	sel	r9, r2, r9		// select
	//stm	r0, {r6-r9}
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	pop	{r4-r9}
	bx	lr
