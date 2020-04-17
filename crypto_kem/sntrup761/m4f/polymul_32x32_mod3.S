
// void gf_polymul_32x32_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_32x32_mod3
	.type	gf_polymul_32x32_mod3, %function
gf_polymul_32x32_mod3:
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
	// ([4-7], 0) blocks
	ldr	r4, [r12]
	ldr	r3, [r14, #28]
	ldr	r2, [r14, #24]
	ldr	r1, [r14, #20]
	ldr	r5, [r14, #16]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([3-6], 1) blocks
	ldr	r3, [r12, #4]
	ldr	r4, [r14, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([2-5], 2) blocks
	ldr	r2, [r12, #8]
	ldr	r3, [r14, #8]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([1-4], 3) blocks
	ldr	r1, [r12, #12]
	ldr	r2, [r14, #4]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([0-3], 4) blocks
	ldr	r5, [r12, #16]
	ldr	r1, [r14, #0]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],5), ([0-1],6), (0,7) blocks
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
	ldr	r5, [r12, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
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
	ldr	r5, [r12, #24]
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
	ldr	r5, [r12, #28]
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
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
sch3_10:			// decreasing thread length
	// ([1-4], 7) blocks
	ldr	r1, [r12, #28]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r10, r6, r3, r1
	umull	r7, r8, r5, r1
	umlal	r9, r10, r2, r1
	umlal	r6, r7, r4, r1
	// ([2-5], 6) blocks
	ldr	r2, [r12, #24]
	ldr	r1, [r14, #20]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([3-6], 5) blocks
	ldr	r3, [r12, #20]
	ldr	r2, [r14, #24]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([4-7], 4) blocks
	ldr	r4, [r12, #16]
	ldr	r3, [r14, #28]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([5-7],3),([6-7],2),(7,1) blocks
#ifdef __thumb2__
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	ldr	r4, [r12, #12]
	umlal	r6, r7, r3, r4
	umlal	r10, r6, r2, r4
	umlal	r9, r10, r1, r4
#ifdef __thumb2__
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r4, LSR #2	// range <=10
	bic	r4, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r4, LSR #2	// range <=5
	usub8	r4, r7, r11		// >= 3 ?
	sel	r7, r4, r7		// select
	ldr	r4, [r12, #8]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r2, r4
#ifdef __thumb2__
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r4, LSR #2	// range <=10
	bic	r4, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r4, LSR #2	// range <=5
	usub8	r4, r6, r11		// >= 3 ?
	sel	r6, r4, r6		// select
#ifdef __thumb2__
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	ldr	r4, [r12, #4]
	umlal	r9, r10, r3, r4
#ifdef __thumb2__
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r4, LSR #2	// range <=10
	bic	r4, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r4, LSR #2	// range <=5
	usub8	r4, r9, r11		// >= 3 ?
	sel	r9, r4, r9		// select
#ifdef __thumb2__
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r4, LSR #2	// range <=10
	bic	r4, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r4, LSR #2	// range <=5
	usub8	r4, r10, r11		// >= 3 ?
	sel	r10, r4, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
sch3_20:			// mv hh back to h
	mov	r9, #0
	mov	r10, #0
	mov	r6, #0
	mov	r7, #0
	ldr	r1, [r14, #20]
	ldr	r2, [r14, #24]
	ldr	r3, [r14, #28]
	// ([5-7],7),([6-7],6),(7,5) blocks
#ifdef __thumb2__
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	ldr	r4, [r12, #28]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r2, r4
	umlal	r8, r9, r1, r4
#ifdef __thumb2__
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r4, LSR #2	// range <=10
	bic	r4, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r4, LSR #2	// range <=5
	usub8	r4, r6, r11		// >= 3 ?
	sel	r6, r4, r6		// select
	ldr	r4, [r12, #24]
	umlal	r9, r10, r3, r4
	umlal	r8, r9, r2, r4
#ifdef __thumb2__
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r4, LSR #2	// range <=10
	bic	r4, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r4, LSR #2	// range <=5
	usub8	r4, r10, r11		// >= 3 ?
	sel	r10, r4, r10		// select
	ldr	r4, [r12, #20]
	umlal	r8, r9, r3, r4
#ifdef __thumb2__
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r4, LSR #2	// range <=10
	bic	r4, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r4, LSR #2	// range <=5
	usub8	r4, r8, r11		// >= 3 ?
	sel	r8, r4, r8		// select
#ifdef __thumb2__
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r4, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	bic	r4, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r4, LSR #2	// range <=10
	bic	r4, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r4, LSR #2	// range <=5
	usub8	r4, r9, r11		// >= 3 ?
	sel	r9, r4, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	pop	{r4-r11,lr}
	bx	lr
