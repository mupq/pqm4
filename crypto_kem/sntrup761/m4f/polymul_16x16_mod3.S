
// void gf_polymul_16x16_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_16x16_mod3
	.type	gf_polymul_16x16_mod3, %function
gf_polymul_16x16_mod3:
	push	{r4-r11,lr}
sch3_0:			// increasing thread length
	mov	r6, #0
	mov	r12, r1
	mov	r14, r2
	ldr	r11, =0x03030303
#ifndef __thumb2__
	vmov	s4, r11		// save #0x03030303
	ldr	r11, =0x0f0f0f0f
	vmov	s5, r11		// save #0x0F0F0F0F
	vmov	r11, s4		// reload #0x03030303
#endif
sch3_1:			// later blocks
	// ([0-3], 0) blocks
	ldr	r5, [r12]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	ldr	r1, [r14, #0]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([0-2],1), ([0-1],2), (0,3) blocks
#ifdef __thumb2__
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	bic	r5, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	ldr	r5, [r12, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
#ifdef __thumb2__
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	bic	r5, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	ldr	r5, [r12, #8]
	umlal	r9, r10, r2, r5
	umlal	r8, r9, r1, r5
#ifdef __thumb2__
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	bic	r5, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	ldr	r5, [r12, #12]
	umlal	r9, r10, r1, r5
#ifdef __thumb2__
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	bic	r5, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
#ifdef __thumb2__
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
sch3_10:			// decreasing thread length
sch3_20:			// mv hh back to h
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0
	ldr	r2, [r14, #4]
	ldr	r3, [r14, #8]
	ldr	r4, [r14, #12]
	// ([1-3],3),([2-3],2),(3,1) blocks
#ifdef __thumb2__
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	ldr	r5, [r12, #12]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
#ifdef __thumb2__
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	bic	r5, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	ldr	r5, [r12, #8]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
#ifdef __thumb2__
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	bic	r5, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	ldr	r5, [r12, #4]
	umlal	r10, r6, r4, r5
#ifdef __thumb2__
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	bic	r5, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
#ifdef __thumb2__
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r5, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r5, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	bic	r5, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	pop	{r4-r11,lr}
	bx	lr
