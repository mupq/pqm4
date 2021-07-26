
// void gf_polymul_176x176_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_176x176_mod3
	.type	gf_polymul_176x176_mod3, %function
gf_polymul_176x176_mod3:
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
	// ([8-11], 0) blocks
	ldr	r3, [r12]
	ldr	r2, [r14, #44]
	ldr	r1, [r14, #40]
	ldr	r5, [r14, #36]
	ldr	r4, [r14, #32]
	umull	r10, r6, r5, r3
	umull	r7, r8, r2, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r1, r3
	// ([7-10], 1) blocks
	ldr	r2, [r12, #4]
	ldr	r3, [r14, #28]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([6-9], 2) blocks
	ldr	r1, [r12, #8]
	ldr	r2, [r14, #24]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([5-8], 3) blocks
	ldr	r5, [r12, #12]
	ldr	r1, [r14, #20]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([4-7], 4) blocks
	ldr	r4, [r12, #16]
	ldr	r5, [r14, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([3-6], 5) blocks
	ldr	r3, [r12, #20]
	ldr	r4, [r14, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([2-5], 6) blocks
	ldr	r2, [r12, #24]
	ldr	r3, [r14, #8]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([1-4], 7) blocks
	ldr	r1, [r12, #28]
	ldr	r2, [r14, #4]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([0-3], 8) blocks
	ldr	r5, [r12, #32]
	ldr	r1, [r14, #0]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([0-2],9), ([0-1],10), (0,11) blocks
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
	ldr	r5, [r12, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
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
	ldr	r5, [r12, #40]
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
	ldr	r5, [r12, #44]
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
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([12-15], 0) blocks
	ldr	r2, [r12]
	ldr	r1, [r14, #60]
	ldr	r5, [r14, #56]
	ldr	r4, [r14, #52]
	ldr	r3, [r14, #48]
	umull	r9, r10, r4, r2
	umull	r6, r7, r1, r2
	umlal	r8, r9, r3, r2
	umlal	r10, r6, r5, r2
	// ([11-14], 1) blocks
	ldr	r1, [r12, #4]
	ldr	r2, [r14, #44]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([10-13], 2) blocks
	ldr	r5, [r12, #8]
	ldr	r1, [r14, #40]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([9-12], 3) blocks
	ldr	r4, [r12, #12]
	ldr	r5, [r14, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([8-11], 4) blocks
	ldr	r3, [r12, #16]
	ldr	r4, [r14, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([7-10], 5) blocks
	ldr	r2, [r12, #20]
	ldr	r3, [r14, #28]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([6-9], 6) blocks
	ldr	r1, [r12, #24]
	ldr	r2, [r14, #24]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([5-8], 7) blocks
	ldr	r5, [r12, #28]
	ldr	r1, [r14, #20]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([4-7], 8) blocks
	ldr	r4, [r12, #32]
	ldr	r5, [r14, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([3-6], 9) blocks
	ldr	r3, [r12, #36]
	ldr	r4, [r14, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([2-5], 10) blocks
	ldr	r2, [r12, #40]
	ldr	r3, [r14, #8]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([1-4], 11) blocks
	ldr	r1, [r12, #44]
	ldr	r2, [r14, #4]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([0-3], 12) blocks
	ldr	r5, [r12, #48]
	ldr	r1, [r14, #0]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([0-2],13), ([0-1],14), (0,15) blocks
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
	ldr	r5, [r12, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #56]
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
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
	ldr	r5, [r12, #60]
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
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([16-19], 0) blocks
	ldr	r1, [r12]
	ldr	r5, [r14, #76]
	ldr	r4, [r14, #72]
	ldr	r3, [r14, #68]
	ldr	r2, [r14, #64]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([15-18], 1) blocks
	ldr	r5, [r12, #4]
	ldr	r1, [r14, #60]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([14-17], 2) blocks
	ldr	r4, [r12, #8]
	ldr	r5, [r14, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([13-16], 3) blocks
	ldr	r3, [r12, #12]
	ldr	r4, [r14, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([12-15], 4) blocks
	ldr	r2, [r12, #16]
	ldr	r3, [r14, #48]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([11-14], 5) blocks
	ldr	r1, [r12, #20]
	ldr	r2, [r14, #44]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([10-13], 6) blocks
	ldr	r5, [r12, #24]
	ldr	r1, [r14, #40]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([9-12], 7) blocks
	ldr	r4, [r12, #28]
	ldr	r5, [r14, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([8-11], 8) blocks
	ldr	r3, [r12, #32]
	ldr	r4, [r14, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([7-10], 9) blocks
	ldr	r2, [r12, #36]
	ldr	r3, [r14, #28]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([6-9], 10) blocks
	ldr	r1, [r12, #40]
	ldr	r2, [r14, #24]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([5-8], 11) blocks
	ldr	r5, [r12, #44]
	ldr	r1, [r14, #20]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([4-7], 12) blocks
	ldr	r4, [r12, #48]
	ldr	r5, [r14, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([3-6], 13) blocks
	ldr	r3, [r12, #52]
	ldr	r4, [r14, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([2-5], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r3, [r14, #8]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([1-4], 15) blocks
	ldr	r1, [r12, #60]
	ldr	r2, [r14, #4]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([0-3], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r1, [r14, #0]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([0-2],17), ([0-1],18), (0,19) blocks
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
	ldr	r5, [r12, #68]
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #72]
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #76]
	umlal	r10, r6, r1, r5
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
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([20-23], 0) blocks
	ldr	r5, [r12]
	ldr	r4, [r14, #92]
	ldr	r3, [r14, #88]
	ldr	r2, [r14, #84]
	ldr	r1, [r14, #80]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([19-22], 1) blocks
	ldr	r4, [r12, #4]
	ldr	r5, [r14, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([18-21], 2) blocks
	ldr	r3, [r12, #8]
	ldr	r4, [r14, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([17-20], 3) blocks
	ldr	r2, [r12, #12]
	ldr	r3, [r14, #68]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([16-19], 4) blocks
	ldr	r1, [r12, #16]
	ldr	r2, [r14, #64]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([15-18], 5) blocks
	ldr	r5, [r12, #20]
	ldr	r1, [r14, #60]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([14-17], 6) blocks
	ldr	r4, [r12, #24]
	ldr	r5, [r14, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
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
	// ([13-16], 7) blocks
	ldr	r3, [r12, #28]
	ldr	r4, [r14, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([12-15], 8) blocks
	ldr	r2, [r12, #32]
	ldr	r3, [r14, #48]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([11-14], 9) blocks
	ldr	r1, [r12, #36]
	ldr	r2, [r14, #44]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([10-13], 10) blocks
	ldr	r5, [r12, #40]
	ldr	r1, [r14, #40]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 11) blocks
	ldr	r4, [r12, #44]
	ldr	r5, [r14, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([8-11], 12) blocks
	ldr	r3, [r12, #48]
	ldr	r4, [r14, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([7-10], 13) blocks
	ldr	r2, [r12, #52]
	ldr	r3, [r14, #28]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([6-9], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r2, [r14, #24]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([5-8], 15) blocks
	ldr	r5, [r12, #60]
	ldr	r1, [r14, #20]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([4-7], 16) blocks
	ldr	r4, [r12, #64]
	ldr	r5, [r14, #16]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([3-6], 17) blocks
	ldr	r3, [r12, #68]
	ldr	r4, [r14, #12]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([2-5], 18) blocks
	ldr	r2, [r12, #72]
	ldr	r3, [r14, #8]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([1-4], 19) blocks
	ldr	r1, [r12, #76]
	ldr	r2, [r14, #4]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([0-3], 20) blocks
	ldr	r5, [r12, #80]
	ldr	r1, [r14, #0]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
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
	// ([0-2],21), ([0-1],22), (0,23) blocks
	bic	r5, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	bic	r5, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	ldr	r5, [r12, #84]
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
	ldr	r5, [r12, #88]
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
	ldr	r5, [r12, #92]
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
	// ([24-27], 0) blocks
	ldr	r4, [r12]
	ldr	r3, [r14, #108]
	ldr	r2, [r14, #104]
	ldr	r1, [r14, #100]
	ldr	r5, [r14, #96]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([23-26], 1) blocks
	ldr	r3, [r12, #4]
	ldr	r4, [r14, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([22-25], 2) blocks
	ldr	r2, [r12, #8]
	ldr	r3, [r14, #88]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([21-24], 3) blocks
	ldr	r1, [r12, #12]
	ldr	r2, [r14, #84]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([20-23], 4) blocks
	ldr	r5, [r12, #16]
	ldr	r1, [r14, #80]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([19-22], 5) blocks
	ldr	r4, [r12, #20]
	ldr	r5, [r14, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([18-21], 6) blocks
	ldr	r3, [r12, #24]
	ldr	r4, [r14, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([17-20], 7) blocks
	ldr	r2, [r12, #28]
	ldr	r3, [r14, #68]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([16-19], 8) blocks
	ldr	r1, [r12, #32]
	ldr	r2, [r14, #64]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([15-18], 9) blocks
	ldr	r5, [r12, #36]
	ldr	r1, [r14, #60]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([14-17], 10) blocks
	ldr	r4, [r12, #40]
	ldr	r5, [r14, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([13-16], 11) blocks
	ldr	r3, [r12, #44]
	ldr	r4, [r14, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([12-15], 12) blocks
	ldr	r2, [r12, #48]
	ldr	r3, [r14, #48]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([11-14], 13) blocks
	ldr	r1, [r12, #52]
	ldr	r2, [r14, #44]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([10-13], 14) blocks
	ldr	r5, [r12, #56]
	ldr	r1, [r14, #40]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([9-12], 15) blocks
	ldr	r4, [r12, #60]
	ldr	r5, [r14, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([8-11], 16) blocks
	ldr	r3, [r12, #64]
	ldr	r4, [r14, #32]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([7-10], 17) blocks
	ldr	r2, [r12, #68]
	ldr	r3, [r14, #28]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([6-9], 18) blocks
	ldr	r1, [r12, #72]
	ldr	r2, [r14, #24]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([5-8], 19) blocks
	ldr	r5, [r12, #76]
	ldr	r1, [r14, #20]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([4-7], 20) blocks
	ldr	r4, [r12, #80]
	ldr	r5, [r14, #16]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	// ([3-6], 21) blocks
	ldr	r3, [r12, #84]
	ldr	r4, [r14, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([2-5], 22) blocks
	ldr	r2, [r12, #88]
	ldr	r3, [r14, #8]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([1-4], 23) blocks
	ldr	r1, [r12, #92]
	ldr	r2, [r14, #4]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([0-3], 24) blocks
	ldr	r5, [r12, #96]
	ldr	r1, [r14, #0]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],25), ([0-1],26), (0,27) blocks
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
	ldr	r5, [r12, #100]
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
	ldr	r5, [r12, #104]
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
	ldr	r5, [r12, #108]
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
	// ([28-31], 0) blocks
	ldr	r3, [r12]
	ldr	r2, [r14, #124]
	ldr	r1, [r14, #120]
	ldr	r5, [r14, #116]
	ldr	r4, [r14, #112]
	umull	r10, r6, r5, r3
	umull	r7, r8, r2, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r1, r3
	// ([27-30], 1) blocks
	ldr	r2, [r12, #4]
	ldr	r3, [r14, #108]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([26-29], 2) blocks
	ldr	r1, [r12, #8]
	ldr	r2, [r14, #104]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([25-28], 3) blocks
	ldr	r5, [r12, #12]
	ldr	r1, [r14, #100]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([24-27], 4) blocks
	ldr	r4, [r12, #16]
	ldr	r5, [r14, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([23-26], 5) blocks
	ldr	r3, [r12, #20]
	ldr	r4, [r14, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([22-25], 6) blocks
	ldr	r2, [r12, #24]
	ldr	r3, [r14, #88]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([21-24], 7) blocks
	ldr	r1, [r12, #28]
	ldr	r2, [r14, #84]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([20-23], 8) blocks
	ldr	r5, [r12, #32]
	ldr	r1, [r14, #80]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([19-22], 9) blocks
	ldr	r4, [r12, #36]
	ldr	r5, [r14, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([18-21], 10) blocks
	ldr	r3, [r12, #40]
	ldr	r4, [r14, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([17-20], 11) blocks
	ldr	r2, [r12, #44]
	ldr	r3, [r14, #68]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([16-19], 12) blocks
	ldr	r1, [r12, #48]
	ldr	r2, [r14, #64]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([15-18], 13) blocks
	ldr	r5, [r12, #52]
	ldr	r1, [r14, #60]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
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
	// ([14-17], 14) blocks
	ldr	r4, [r12, #56]
	ldr	r5, [r14, #56]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([13-16], 15) blocks
	ldr	r3, [r12, #60]
	ldr	r4, [r14, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([12-15], 16) blocks
	ldr	r2, [r12, #64]
	ldr	r3, [r14, #48]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([11-14], 17) blocks
	ldr	r1, [r12, #68]
	ldr	r2, [r14, #44]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([10-13], 18) blocks
	ldr	r5, [r12, #72]
	ldr	r1, [r14, #40]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([9-12], 19) blocks
	ldr	r4, [r12, #76]
	ldr	r5, [r14, #36]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([8-11], 20) blocks
	ldr	r3, [r12, #80]
	ldr	r4, [r14, #32]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([7-10], 21) blocks
	ldr	r2, [r12, #84]
	ldr	r3, [r14, #28]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([6-9], 22) blocks
	ldr	r1, [r12, #88]
	ldr	r2, [r14, #24]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([5-8], 23) blocks
	ldr	r5, [r12, #92]
	ldr	r1, [r14, #20]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([4-7], 24) blocks
	ldr	r4, [r12, #96]
	ldr	r5, [r14, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([3-6], 25) blocks
	ldr	r3, [r12, #100]
	ldr	r4, [r14, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([2-5], 26) blocks
	ldr	r2, [r12, #104]
	ldr	r3, [r14, #8]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([1-4], 27) blocks
	ldr	r1, [r12, #108]
	ldr	r2, [r14, #4]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([0-3], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r1, [r14, #0]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([0-2],29), ([0-1],30), (0,31) blocks
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
	ldr	r5, [r12, #116]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
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
	ldr	r5, [r12, #120]
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
	ldr	r5, [r12, #124]
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
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([32-35], 0) blocks
	ldr	r2, [r12]
	ldr	r1, [r14, #140]
	ldr	r5, [r14, #136]
	ldr	r4, [r14, #132]
	ldr	r3, [r14, #128]
	umull	r9, r10, r4, r2
	umull	r6, r7, r1, r2
	umlal	r8, r9, r3, r2
	umlal	r10, r6, r5, r2
	// ([31-34], 1) blocks
	ldr	r1, [r12, #4]
	ldr	r2, [r14, #124]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([30-33], 2) blocks
	ldr	r5, [r12, #8]
	ldr	r1, [r14, #120]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([29-32], 3) blocks
	ldr	r4, [r12, #12]
	ldr	r5, [r14, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([28-31], 4) blocks
	ldr	r3, [r12, #16]
	ldr	r4, [r14, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([27-30], 5) blocks
	ldr	r2, [r12, #20]
	ldr	r3, [r14, #108]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([26-29], 6) blocks
	ldr	r1, [r12, #24]
	ldr	r2, [r14, #104]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([25-28], 7) blocks
	ldr	r5, [r12, #28]
	ldr	r1, [r14, #100]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([24-27], 8) blocks
	ldr	r4, [r12, #32]
	ldr	r5, [r14, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([23-26], 9) blocks
	ldr	r3, [r12, #36]
	ldr	r4, [r14, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([22-25], 10) blocks
	ldr	r2, [r12, #40]
	ldr	r3, [r14, #88]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([21-24], 11) blocks
	ldr	r1, [r12, #44]
	ldr	r2, [r14, #84]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([20-23], 12) blocks
	ldr	r5, [r12, #48]
	ldr	r1, [r14, #80]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([19-22], 13) blocks
	ldr	r4, [r12, #52]
	ldr	r5, [r14, #76]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
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
	// ([18-21], 14) blocks
	ldr	r3, [r12, #56]
	ldr	r4, [r14, #72]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([17-20], 15) blocks
	ldr	r2, [r12, #60]
	ldr	r3, [r14, #68]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([16-19], 16) blocks
	ldr	r1, [r12, #64]
	ldr	r2, [r14, #64]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([15-18], 17) blocks
	ldr	r5, [r12, #68]
	ldr	r1, [r14, #60]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([14-17], 18) blocks
	ldr	r4, [r12, #72]
	ldr	r5, [r14, #56]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([13-16], 19) blocks
	ldr	r3, [r12, #76]
	ldr	r4, [r14, #52]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([12-15], 20) blocks
	ldr	r2, [r12, #80]
	ldr	r3, [r14, #48]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([11-14], 21) blocks
	ldr	r1, [r12, #84]
	ldr	r2, [r14, #44]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([10-13], 22) blocks
	ldr	r5, [r12, #88]
	ldr	r1, [r14, #40]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([9-12], 23) blocks
	ldr	r4, [r12, #92]
	ldr	r5, [r14, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([8-11], 24) blocks
	ldr	r3, [r12, #96]
	ldr	r4, [r14, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([7-10], 25) blocks
	ldr	r2, [r12, #100]
	ldr	r3, [r14, #28]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([6-9], 26) blocks
	ldr	r1, [r12, #104]
	ldr	r2, [r14, #24]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([5-8], 27) blocks
	ldr	r5, [r12, #108]
	ldr	r1, [r14, #20]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
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
	// ([4-7], 28) blocks
	ldr	r4, [r12, #112]
	ldr	r5, [r14, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([3-6], 29) blocks
	ldr	r3, [r12, #116]
	ldr	r4, [r14, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([2-5], 30) blocks
	ldr	r2, [r12, #120]
	ldr	r3, [r14, #8]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([1-4], 31) blocks
	ldr	r1, [r12, #124]
	ldr	r2, [r14, #4]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([0-3], 32) blocks
	ldr	r5, [r12, #128]
	ldr	r1, [r14, #0]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([0-2],33), ([0-1],34), (0,35) blocks
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
	ldr	r5, [r12, #132]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #136]
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
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
	ldr	r5, [r12, #140]
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
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([36-39], 0) blocks
	ldr	r1, [r12]
	ldr	r5, [r14, #156]
	ldr	r4, [r14, #152]
	ldr	r3, [r14, #148]
	ldr	r2, [r14, #144]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([35-38], 1) blocks
	ldr	r5, [r12, #4]
	ldr	r1, [r14, #140]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([34-37], 2) blocks
	ldr	r4, [r12, #8]
	ldr	r5, [r14, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([33-36], 3) blocks
	ldr	r3, [r12, #12]
	ldr	r4, [r14, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([32-35], 4) blocks
	ldr	r2, [r12, #16]
	ldr	r3, [r14, #128]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([31-34], 5) blocks
	ldr	r1, [r12, #20]
	ldr	r2, [r14, #124]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([30-33], 6) blocks
	ldr	r5, [r12, #24]
	ldr	r1, [r14, #120]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([29-32], 7) blocks
	ldr	r4, [r12, #28]
	ldr	r5, [r14, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([28-31], 8) blocks
	ldr	r3, [r12, #32]
	ldr	r4, [r14, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([27-30], 9) blocks
	ldr	r2, [r12, #36]
	ldr	r3, [r14, #108]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([26-29], 10) blocks
	ldr	r1, [r12, #40]
	ldr	r2, [r14, #104]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([25-28], 11) blocks
	ldr	r5, [r12, #44]
	ldr	r1, [r14, #100]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([24-27], 12) blocks
	ldr	r4, [r12, #48]
	ldr	r5, [r14, #96]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([23-26], 13) blocks
	ldr	r3, [r12, #52]
	ldr	r4, [r14, #92]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([22-25], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r3, [r14, #88]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([21-24], 15) blocks
	ldr	r1, [r12, #60]
	ldr	r2, [r14, #84]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([20-23], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r1, [r14, #80]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([19-22], 17) blocks
	ldr	r4, [r12, #68]
	ldr	r5, [r14, #76]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([18-21], 18) blocks
	ldr	r3, [r12, #72]
	ldr	r4, [r14, #72]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([17-20], 19) blocks
	ldr	r2, [r12, #76]
	ldr	r3, [r14, #68]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([16-19], 20) blocks
	ldr	r1, [r12, #80]
	ldr	r2, [r14, #64]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([15-18], 21) blocks
	ldr	r5, [r12, #84]
	ldr	r1, [r14, #60]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([14-17], 22) blocks
	ldr	r4, [r12, #88]
	ldr	r5, [r14, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([13-16], 23) blocks
	ldr	r3, [r12, #92]
	ldr	r4, [r14, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([12-15], 24) blocks
	ldr	r2, [r12, #96]
	ldr	r3, [r14, #48]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([11-14], 25) blocks
	ldr	r1, [r12, #100]
	ldr	r2, [r14, #44]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([10-13], 26) blocks
	ldr	r5, [r12, #104]
	ldr	r1, [r14, #40]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([9-12], 27) blocks
	ldr	r4, [r12, #108]
	ldr	r5, [r14, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
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
	// ([8-11], 28) blocks
	ldr	r3, [r12, #112]
	ldr	r4, [r14, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([7-10], 29) blocks
	ldr	r2, [r12, #116]
	ldr	r3, [r14, #28]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([6-9], 30) blocks
	ldr	r1, [r12, #120]
	ldr	r2, [r14, #24]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([5-8], 31) blocks
	ldr	r5, [r12, #124]
	ldr	r1, [r14, #20]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([4-7], 32) blocks
	ldr	r4, [r12, #128]
	ldr	r5, [r14, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([3-6], 33) blocks
	ldr	r3, [r12, #132]
	ldr	r4, [r14, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([2-5], 34) blocks
	ldr	r2, [r12, #136]
	ldr	r3, [r14, #8]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([1-4], 35) blocks
	ldr	r1, [r12, #140]
	ldr	r2, [r14, #4]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([0-3], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r1, [r14, #0]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([0-2],37), ([0-1],38), (0,39) blocks
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
	ldr	r5, [r12, #148]
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #152]
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #156]
	umlal	r10, r6, r1, r5
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
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([40-43], 0) blocks
	ldr	r5, [r12]
	ldr	r4, [r14, #172]
	ldr	r3, [r14, #168]
	ldr	r2, [r14, #164]
	ldr	r1, [r14, #160]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([39-42], 1) blocks
	ldr	r4, [r12, #4]
	ldr	r5, [r14, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([38-41], 2) blocks
	ldr	r3, [r12, #8]
	ldr	r4, [r14, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([37-40], 3) blocks
	ldr	r2, [r12, #12]
	ldr	r3, [r14, #148]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([36-39], 4) blocks
	ldr	r1, [r12, #16]
	ldr	r2, [r14, #144]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([35-38], 5) blocks
	ldr	r5, [r12, #20]
	ldr	r1, [r14, #140]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([34-37], 6) blocks
	ldr	r4, [r12, #24]
	ldr	r5, [r14, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
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
	// ([33-36], 7) blocks
	ldr	r3, [r12, #28]
	ldr	r4, [r14, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([32-35], 8) blocks
	ldr	r2, [r12, #32]
	ldr	r3, [r14, #128]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([31-34], 9) blocks
	ldr	r1, [r12, #36]
	ldr	r2, [r14, #124]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([30-33], 10) blocks
	ldr	r5, [r12, #40]
	ldr	r1, [r14, #120]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([29-32], 11) blocks
	ldr	r4, [r12, #44]
	ldr	r5, [r14, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([28-31], 12) blocks
	ldr	r3, [r12, #48]
	ldr	r4, [r14, #112]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([27-30], 13) blocks
	ldr	r2, [r12, #52]
	ldr	r3, [r14, #108]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([26-29], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r2, [r14, #104]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([25-28], 15) blocks
	ldr	r5, [r12, #60]
	ldr	r1, [r14, #100]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([24-27], 16) blocks
	ldr	r4, [r12, #64]
	ldr	r5, [r14, #96]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([23-26], 17) blocks
	ldr	r3, [r12, #68]
	ldr	r4, [r14, #92]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([22-25], 18) blocks
	ldr	r2, [r12, #72]
	ldr	r3, [r14, #88]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([21-24], 19) blocks
	ldr	r1, [r12, #76]
	ldr	r2, [r14, #84]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([20-23], 20) blocks
	ldr	r5, [r12, #80]
	ldr	r1, [r14, #80]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
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
	// ([19-22], 21) blocks
	ldr	r4, [r12, #84]
	ldr	r5, [r14, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([18-21], 22) blocks
	ldr	r3, [r12, #88]
	ldr	r4, [r14, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([17-20], 23) blocks
	ldr	r2, [r12, #92]
	ldr	r3, [r14, #68]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([16-19], 24) blocks
	ldr	r1, [r12, #96]
	ldr	r2, [r14, #64]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([15-18], 25) blocks
	ldr	r5, [r12, #100]
	ldr	r1, [r14, #60]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([14-17], 26) blocks
	ldr	r4, [r12, #104]
	ldr	r5, [r14, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([13-16], 27) blocks
	ldr	r3, [r12, #108]
	ldr	r4, [r14, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([12-15], 28) blocks
	ldr	r2, [r12, #112]
	ldr	r3, [r14, #48]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([11-14], 29) blocks
	ldr	r1, [r12, #116]
	ldr	r2, [r14, #44]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([10-13], 30) blocks
	ldr	r5, [r12, #120]
	ldr	r1, [r14, #40]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 31) blocks
	ldr	r4, [r12, #124]
	ldr	r5, [r14, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([8-11], 32) blocks
	ldr	r3, [r12, #128]
	ldr	r4, [r14, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([7-10], 33) blocks
	ldr	r2, [r12, #132]
	ldr	r3, [r14, #28]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([6-9], 34) blocks
	ldr	r1, [r12, #136]
	ldr	r2, [r14, #24]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([5-8], 35) blocks
	ldr	r5, [r12, #140]
	ldr	r1, [r14, #20]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([4-7], 36) blocks
	ldr	r4, [r12, #144]
	ldr	r5, [r14, #16]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([3-6], 37) blocks
	ldr	r3, [r12, #148]
	ldr	r4, [r14, #12]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([2-5], 38) blocks
	ldr	r2, [r12, #152]
	ldr	r3, [r14, #8]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([1-4], 39) blocks
	ldr	r1, [r12, #156]
	ldr	r2, [r14, #4]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([0-3], 40) blocks
	ldr	r5, [r12, #160]
	ldr	r1, [r14, #0]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([0-2],41), ([0-1],42), (0,43) blocks
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
	ldr	r5, [r12, #164]
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
	ldr	r5, [r12, #168]
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
	ldr	r5, [r12, #172]
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
	// ([1-4], 43) blocks
	ldr	r1, [r12, #172]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r6, r7, r3, r1
	umull	r8, r9, r5, r1
	umlal	r10, r6, r2, r1
	umlal	r7, r8, r4, r1
	// ([2-5], 42) blocks
	ldr	r2, [r12, #168]
	ldr	r1, [r14, #20]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([3-6], 41) blocks
	ldr	r3, [r12, #164]
	ldr	r2, [r14, #24]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([4-7], 40) blocks
	ldr	r4, [r12, #160]
	ldr	r3, [r14, #28]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([5-8], 39) blocks
	ldr	r5, [r12, #156]
	ldr	r4, [r14, #32]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([6-9], 38) blocks
	ldr	r1, [r12, #152]
	ldr	r5, [r14, #36]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([7-10], 37) blocks
	ldr	r2, [r12, #148]
	ldr	r1, [r14, #40]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([8-11], 36) blocks
	ldr	r3, [r12, #144]
	ldr	r2, [r14, #44]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([9-12], 35) blocks
	ldr	r4, [r12, #140]
	ldr	r3, [r14, #48]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([10-13], 34) blocks
	ldr	r5, [r12, #136]
	ldr	r4, [r14, #52]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([11-14], 33) blocks
	ldr	r1, [r12, #132]
	ldr	r5, [r14, #56]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([12-15], 32) blocks
	ldr	r2, [r12, #128]
	ldr	r1, [r14, #60]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([13-16], 31) blocks
	ldr	r3, [r12, #124]
	ldr	r2, [r14, #64]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([14-17], 30) blocks
	ldr	r4, [r12, #120]
	ldr	r3, [r14, #68]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([15-18], 29) blocks
	ldr	r5, [r12, #116]
	ldr	r4, [r14, #72]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([16-19], 28) blocks
	ldr	r1, [r12, #112]
	ldr	r5, [r14, #76]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([17-20], 27) blocks
	ldr	r2, [r12, #108]
	ldr	r1, [r14, #80]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([18-21], 26) blocks
	ldr	r3, [r12, #104]
	ldr	r2, [r14, #84]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([19-22], 25) blocks
	ldr	r4, [r12, #100]
	ldr	r3, [r14, #88]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([20-23], 24) blocks
	ldr	r5, [r12, #96]
	ldr	r4, [r14, #92]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
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
	// ([21-24], 23) blocks
	ldr	r1, [r12, #92]
	ldr	r5, [r14, #96]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([22-25], 22) blocks
	ldr	r2, [r12, #88]
	ldr	r1, [r14, #100]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([23-26], 21) blocks
	ldr	r3, [r12, #84]
	ldr	r2, [r14, #104]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([24-27], 20) blocks
	ldr	r4, [r12, #80]
	ldr	r3, [r14, #108]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([25-28], 19) blocks
	ldr	r5, [r12, #76]
	ldr	r4, [r14, #112]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([26-29], 18) blocks
	ldr	r1, [r12, #72]
	ldr	r5, [r14, #116]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([27-30], 17) blocks
	ldr	r2, [r12, #68]
	ldr	r1, [r14, #120]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([28-31], 16) blocks
	ldr	r3, [r12, #64]
	ldr	r2, [r14, #124]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([29-32], 15) blocks
	ldr	r4, [r12, #60]
	ldr	r3, [r14, #128]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([30-33], 14) blocks
	ldr	r5, [r12, #56]
	ldr	r4, [r14, #132]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([31-34], 13) blocks
	ldr	r1, [r12, #52]
	ldr	r5, [r14, #136]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([32-35], 12) blocks
	ldr	r2, [r12, #48]
	ldr	r1, [r14, #140]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([33-36], 11) blocks
	ldr	r3, [r12, #44]
	ldr	r2, [r14, #144]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([34-37], 10) blocks
	ldr	r4, [r12, #40]
	ldr	r3, [r14, #148]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	// ([35-38], 9) blocks
	ldr	r5, [r12, #36]
	ldr	r4, [r14, #152]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([36-39], 8) blocks
	ldr	r1, [r12, #32]
	ldr	r5, [r14, #156]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([37-40], 7) blocks
	ldr	r2, [r12, #28]
	ldr	r1, [r14, #160]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([38-41], 6) blocks
	ldr	r3, [r12, #24]
	ldr	r2, [r14, #164]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([39-42], 5) blocks
	ldr	r4, [r12, #20]
	ldr	r3, [r14, #168]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([40-43], 4) blocks
	ldr	r5, [r12, #16]
	ldr	r4, [r14, #172]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([41-43],3),([42-43],2),(43,1) blocks
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
	// ([5-8], 43) blocks
	ldr	r5, [r12, #172]
	ldr	r4, [r14, #32]
	ldr	r3, [r14, #28]
	ldr	r2, [r14, #24]
	ldr	r1, [r14, #20]
	umull	r10, r6, r2, r5
	umull	r7, r8, r4, r5
	umlal	r9, r10, r1, r5
	umlal	r6, r7, r3, r5
	// ([6-9], 42) blocks
	ldr	r1, [r12, #168]
	ldr	r5, [r14, #36]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([7-10], 41) blocks
	ldr	r2, [r12, #164]
	ldr	r1, [r14, #40]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([8-11], 40) blocks
	ldr	r3, [r12, #160]
	ldr	r2, [r14, #44]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([9-12], 39) blocks
	ldr	r4, [r12, #156]
	ldr	r3, [r14, #48]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([10-13], 38) blocks
	ldr	r5, [r12, #152]
	ldr	r4, [r14, #52]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
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
	// ([11-14], 37) blocks
	ldr	r1, [r12, #148]
	ldr	r5, [r14, #56]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([12-15], 36) blocks
	ldr	r2, [r12, #144]
	ldr	r1, [r14, #60]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([13-16], 35) blocks
	ldr	r3, [r12, #140]
	ldr	r2, [r14, #64]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([14-17], 34) blocks
	ldr	r4, [r12, #136]
	ldr	r3, [r14, #68]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([15-18], 33) blocks
	ldr	r5, [r12, #132]
	ldr	r4, [r14, #72]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([16-19], 32) blocks
	ldr	r1, [r12, #128]
	ldr	r5, [r14, #76]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([17-20], 31) blocks
	ldr	r2, [r12, #124]
	ldr	r1, [r14, #80]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([18-21], 30) blocks
	ldr	r3, [r12, #120]
	ldr	r2, [r14, #84]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([19-22], 29) blocks
	ldr	r4, [r12, #116]
	ldr	r3, [r14, #88]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([20-23], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r4, [r14, #92]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([21-24], 27) blocks
	ldr	r1, [r12, #108]
	ldr	r5, [r14, #96]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([22-25], 26) blocks
	ldr	r2, [r12, #104]
	ldr	r1, [r14, #100]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([23-26], 25) blocks
	ldr	r3, [r12, #100]
	ldr	r2, [r14, #104]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([24-27], 24) blocks
	ldr	r4, [r12, #96]
	ldr	r3, [r14, #108]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
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
	// ([25-28], 23) blocks
	ldr	r5, [r12, #92]
	ldr	r4, [r14, #112]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([26-29], 22) blocks
	ldr	r1, [r12, #88]
	ldr	r5, [r14, #116]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([27-30], 21) blocks
	ldr	r2, [r12, #84]
	ldr	r1, [r14, #120]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([28-31], 20) blocks
	ldr	r3, [r12, #80]
	ldr	r2, [r14, #124]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([29-32], 19) blocks
	ldr	r4, [r12, #76]
	ldr	r3, [r14, #128]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([30-33], 18) blocks
	ldr	r5, [r12, #72]
	ldr	r4, [r14, #132]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([31-34], 17) blocks
	ldr	r1, [r12, #68]
	ldr	r5, [r14, #136]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([32-35], 16) blocks
	ldr	r2, [r12, #64]
	ldr	r1, [r14, #140]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([33-36], 15) blocks
	ldr	r3, [r12, #60]
	ldr	r2, [r14, #144]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([34-37], 14) blocks
	ldr	r4, [r12, #56]
	ldr	r3, [r14, #148]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([35-38], 13) blocks
	ldr	r5, [r12, #52]
	ldr	r4, [r14, #152]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([36-39], 12) blocks
	ldr	r1, [r12, #48]
	ldr	r5, [r14, #156]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([37-40], 11) blocks
	ldr	r2, [r12, #44]
	ldr	r1, [r14, #160]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([38-41], 10) blocks
	ldr	r3, [r12, #40]
	ldr	r2, [r14, #164]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([39-42], 9) blocks
	ldr	r4, [r12, #36]
	ldr	r3, [r14, #168]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([40-43], 8) blocks
	ldr	r5, [r12, #32]
	ldr	r4, [r14, #172]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([41-43],7),([42-43],6),(43,5) blocks
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
	ldr	r5, [r12, #28]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r2, r5
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
	ldr	r5, [r12, #24]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
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
	ldr	r5, [r12, #20]
	umlal	r9, r10, r4, r5
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
	bic	r5, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	bic	r5, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([9-12], 43) blocks
	ldr	r4, [r12, #172]
	ldr	r3, [r14, #48]
	ldr	r2, [r14, #44]
	ldr	r1, [r14, #40]
	ldr	r5, [r14, #36]
	umull	r9, r10, r1, r4
	umull	r6, r7, r3, r4
	umlal	r8, r9, r5, r4
	umlal	r10, r6, r2, r4
	// ([10-13], 42) blocks
	ldr	r5, [r12, #168]
	ldr	r4, [r14, #52]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([11-14], 41) blocks
	ldr	r1, [r12, #164]
	ldr	r5, [r14, #56]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([12-15], 40) blocks
	ldr	r2, [r12, #160]
	ldr	r1, [r14, #60]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([13-16], 39) blocks
	ldr	r3, [r12, #156]
	ldr	r2, [r14, #64]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([14-17], 38) blocks
	ldr	r4, [r12, #152]
	ldr	r3, [r14, #68]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
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
	// ([15-18], 37) blocks
	ldr	r5, [r12, #148]
	ldr	r4, [r14, #72]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([16-19], 36) blocks
	ldr	r1, [r12, #144]
	ldr	r5, [r14, #76]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([17-20], 35) blocks
	ldr	r2, [r12, #140]
	ldr	r1, [r14, #80]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([18-21], 34) blocks
	ldr	r3, [r12, #136]
	ldr	r2, [r14, #84]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([19-22], 33) blocks
	ldr	r4, [r12, #132]
	ldr	r3, [r14, #88]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([20-23], 32) blocks
	ldr	r5, [r12, #128]
	ldr	r4, [r14, #92]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([21-24], 31) blocks
	ldr	r1, [r12, #124]
	ldr	r5, [r14, #96]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([22-25], 30) blocks
	ldr	r2, [r12, #120]
	ldr	r1, [r14, #100]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([23-26], 29) blocks
	ldr	r3, [r12, #116]
	ldr	r2, [r14, #104]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([24-27], 28) blocks
	ldr	r4, [r12, #112]
	ldr	r3, [r14, #108]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([25-28], 27) blocks
	ldr	r5, [r12, #108]
	ldr	r4, [r14, #112]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([26-29], 26) blocks
	ldr	r1, [r12, #104]
	ldr	r5, [r14, #116]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([27-30], 25) blocks
	ldr	r2, [r12, #100]
	ldr	r1, [r14, #120]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([28-31], 24) blocks
	ldr	r3, [r12, #96]
	ldr	r2, [r14, #124]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([29-32], 23) blocks
	ldr	r4, [r12, #92]
	ldr	r3, [r14, #128]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([30-33], 22) blocks
	ldr	r5, [r12, #88]
	ldr	r4, [r14, #132]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([31-34], 21) blocks
	ldr	r1, [r12, #84]
	ldr	r5, [r14, #136]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([32-35], 20) blocks
	ldr	r2, [r12, #80]
	ldr	r1, [r14, #140]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([33-36], 19) blocks
	ldr	r3, [r12, #76]
	ldr	r2, [r14, #144]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([34-37], 18) blocks
	ldr	r4, [r12, #72]
	ldr	r3, [r14, #148]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([35-38], 17) blocks
	ldr	r5, [r12, #68]
	ldr	r4, [r14, #152]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
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
	// ([36-39], 16) blocks
	ldr	r1, [r12, #64]
	ldr	r5, [r14, #156]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([37-40], 15) blocks
	ldr	r2, [r12, #60]
	ldr	r1, [r14, #160]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([38-41], 14) blocks
	ldr	r3, [r12, #56]
	ldr	r2, [r14, #164]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([39-42], 13) blocks
	ldr	r4, [r12, #52]
	ldr	r3, [r14, #168]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([40-43], 12) blocks
	ldr	r5, [r12, #48]
	ldr	r4, [r14, #172]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([41-43],11),([42-43],10),(43,9) blocks
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
	ldr	r5, [r12, #44]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
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
	ldr	r5, [r12, #40]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
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
	ldr	r5, [r12, #36]
	umlal	r8, r9, r4, r5
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
	bic	r5, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	bic	r5, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([13-16], 43) blocks
	ldr	r3, [r12, #172]
	ldr	r2, [r14, #64]
	ldr	r1, [r14, #60]
	ldr	r5, [r14, #56]
	ldr	r4, [r14, #52]
	umull	r8, r9, r5, r3
	umull	r10, r6, r2, r3
	umlal	r7, r8, r4, r3
	umlal	r9, r10, r1, r3
	// ([14-17], 42) blocks
	ldr	r4, [r12, #168]
	ldr	r3, [r14, #68]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([15-18], 41) blocks
	ldr	r5, [r12, #164]
	ldr	r4, [r14, #72]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([16-19], 40) blocks
	ldr	r1, [r12, #160]
	ldr	r5, [r14, #76]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([17-20], 39) blocks
	ldr	r2, [r12, #156]
	ldr	r1, [r14, #80]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([18-21], 38) blocks
	ldr	r3, [r12, #152]
	ldr	r2, [r14, #84]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([19-22], 37) blocks
	ldr	r4, [r12, #148]
	ldr	r3, [r14, #88]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([20-23], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r4, [r14, #92]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([21-24], 35) blocks
	ldr	r1, [r12, #140]
	ldr	r5, [r14, #96]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([22-25], 34) blocks
	ldr	r2, [r12, #136]
	ldr	r1, [r14, #100]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([23-26], 33) blocks
	ldr	r3, [r12, #132]
	ldr	r2, [r14, #104]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([24-27], 32) blocks
	ldr	r4, [r12, #128]
	ldr	r3, [r14, #108]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([25-28], 31) blocks
	ldr	r5, [r12, #124]
	ldr	r4, [r14, #112]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([26-29], 30) blocks
	ldr	r1, [r12, #120]
	ldr	r5, [r14, #116]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([27-30], 29) blocks
	ldr	r2, [r12, #116]
	ldr	r1, [r14, #120]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([28-31], 28) blocks
	ldr	r3, [r12, #112]
	ldr	r2, [r14, #124]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([29-32], 27) blocks
	ldr	r4, [r12, #108]
	ldr	r3, [r14, #128]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([30-33], 26) blocks
	ldr	r5, [r12, #104]
	ldr	r4, [r14, #132]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([31-34], 25) blocks
	ldr	r1, [r12, #100]
	ldr	r5, [r14, #136]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([32-35], 24) blocks
	ldr	r2, [r12, #96]
	ldr	r1, [r14, #140]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([33-36], 23) blocks
	ldr	r3, [r12, #92]
	ldr	r2, [r14, #144]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([34-37], 22) blocks
	ldr	r4, [r12, #88]
	ldr	r3, [r14, #148]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([35-38], 21) blocks
	ldr	r5, [r12, #84]
	ldr	r4, [r14, #152]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([36-39], 20) blocks
	ldr	r1, [r12, #80]
	ldr	r5, [r14, #156]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([37-40], 19) blocks
	ldr	r2, [r12, #76]
	ldr	r1, [r14, #160]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([38-41], 18) blocks
	ldr	r3, [r12, #72]
	ldr	r2, [r14, #164]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([39-42], 17) blocks
	ldr	r4, [r12, #68]
	ldr	r3, [r14, #168]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
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
	// ([40-43], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r4, [r14, #172]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([41-43],15),([42-43],14),(43,13) blocks
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
	ldr	r5, [r12, #60]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
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
	ldr	r5, [r12, #56]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
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
	ldr	r5, [r12, #52]
	umlal	r7, r8, r4, r5
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
	bic	r5, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	bic	r5, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([17-20], 43) blocks
	ldr	r2, [r12, #172]
	ldr	r1, [r14, #80]
	ldr	r5, [r14, #76]
	ldr	r4, [r14, #72]
	ldr	r3, [r14, #68]
	umull	r7, r8, r4, r2
	umull	r9, r10, r1, r2
	umlal	r6, r7, r3, r2
	umlal	r8, r9, r5, r2
	// ([18-21], 42) blocks
	ldr	r3, [r12, #168]
	ldr	r2, [r14, #84]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([19-22], 41) blocks
	ldr	r4, [r12, #164]
	ldr	r3, [r14, #88]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([20-23], 40) blocks
	ldr	r5, [r12, #160]
	ldr	r4, [r14, #92]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([21-24], 39) blocks
	ldr	r1, [r12, #156]
	ldr	r5, [r14, #96]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([22-25], 38) blocks
	ldr	r2, [r12, #152]
	ldr	r1, [r14, #100]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([23-26], 37) blocks
	ldr	r3, [r12, #148]
	ldr	r2, [r14, #104]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([24-27], 36) blocks
	ldr	r4, [r12, #144]
	ldr	r3, [r14, #108]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([25-28], 35) blocks
	ldr	r5, [r12, #140]
	ldr	r4, [r14, #112]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([26-29], 34) blocks
	ldr	r1, [r12, #136]
	ldr	r5, [r14, #116]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([27-30], 33) blocks
	ldr	r2, [r12, #132]
	ldr	r1, [r14, #120]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([28-31], 32) blocks
	ldr	r3, [r12, #128]
	ldr	r2, [r14, #124]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([29-32], 31) blocks
	ldr	r4, [r12, #124]
	ldr	r3, [r14, #128]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
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
	// ([30-33], 30) blocks
	ldr	r5, [r12, #120]
	ldr	r4, [r14, #132]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([31-34], 29) blocks
	ldr	r1, [r12, #116]
	ldr	r5, [r14, #136]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([32-35], 28) blocks
	ldr	r2, [r12, #112]
	ldr	r1, [r14, #140]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([33-36], 27) blocks
	ldr	r3, [r12, #108]
	ldr	r2, [r14, #144]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([34-37], 26) blocks
	ldr	r4, [r12, #104]
	ldr	r3, [r14, #148]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([35-38], 25) blocks
	ldr	r5, [r12, #100]
	ldr	r4, [r14, #152]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([36-39], 24) blocks
	ldr	r1, [r12, #96]
	ldr	r5, [r14, #156]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([37-40], 23) blocks
	ldr	r2, [r12, #92]
	ldr	r1, [r14, #160]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([38-41], 22) blocks
	ldr	r3, [r12, #88]
	ldr	r2, [r14, #164]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([39-42], 21) blocks
	ldr	r4, [r12, #84]
	ldr	r3, [r14, #168]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([40-43], 20) blocks
	ldr	r5, [r12, #80]
	ldr	r4, [r14, #172]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([41-43],19),([42-43],18),(43,17) blocks
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
	ldr	r5, [r12, #76]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
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
	ldr	r5, [r12, #72]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
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
	ldr	r5, [r12, #68]
	umlal	r6, r7, r4, r5
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
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([21-24], 43) blocks
	ldr	r1, [r12, #172]
	ldr	r5, [r14, #96]
	ldr	r4, [r14, #92]
	ldr	r3, [r14, #88]
	ldr	r2, [r14, #84]
	umull	r6, r7, r3, r1
	umull	r8, r9, r5, r1
	umlal	r10, r6, r2, r1
	umlal	r7, r8, r4, r1
	// ([22-25], 42) blocks
	ldr	r2, [r12, #168]
	ldr	r1, [r14, #100]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([23-26], 41) blocks
	ldr	r3, [r12, #164]
	ldr	r2, [r14, #104]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([24-27], 40) blocks
	ldr	r4, [r12, #160]
	ldr	r3, [r14, #108]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([25-28], 39) blocks
	ldr	r5, [r12, #156]
	ldr	r4, [r14, #112]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([26-29], 38) blocks
	ldr	r1, [r12, #152]
	ldr	r5, [r14, #116]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
#ifdef __thumb2__
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r1, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([27-30], 37) blocks
	ldr	r2, [r12, #148]
	ldr	r1, [r14, #120]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([28-31], 36) blocks
	ldr	r3, [r12, #144]
	ldr	r2, [r14, #124]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([29-32], 35) blocks
	ldr	r4, [r12, #140]
	ldr	r3, [r14, #128]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([30-33], 34) blocks
	ldr	r5, [r12, #136]
	ldr	r4, [r14, #132]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([31-34], 33) blocks
	ldr	r1, [r12, #132]
	ldr	r5, [r14, #136]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([32-35], 32) blocks
	ldr	r2, [r12, #128]
	ldr	r1, [r14, #140]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([33-36], 31) blocks
	ldr	r3, [r12, #124]
	ldr	r2, [r14, #144]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([34-37], 30) blocks
	ldr	r4, [r12, #120]
	ldr	r3, [r14, #148]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([35-38], 29) blocks
	ldr	r5, [r12, #116]
	ldr	r4, [r14, #152]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([36-39], 28) blocks
	ldr	r1, [r12, #112]
	ldr	r5, [r14, #156]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([37-40], 27) blocks
	ldr	r2, [r12, #108]
	ldr	r1, [r14, #160]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([38-41], 26) blocks
	ldr	r3, [r12, #104]
	ldr	r2, [r14, #164]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([39-42], 25) blocks
	ldr	r4, [r12, #100]
	ldr	r3, [r14, #168]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([40-43], 24) blocks
	ldr	r5, [r12, #96]
	ldr	r4, [r14, #172]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
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
	// ([41-43],23),([42-43],22),(43,21) blocks
	ldr	r5, [r12, #92]
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
	ldr	r5, [r12, #88]
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
	ldr	r5, [r12, #84]
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
	// ([25-28], 43) blocks
	ldr	r5, [r12, #172]
	ldr	r4, [r14, #112]
	ldr	r3, [r14, #108]
	ldr	r2, [r14, #104]
	ldr	r1, [r14, #100]
	umull	r10, r6, r2, r5
	umull	r7, r8, r4, r5
	umlal	r9, r10, r1, r5
	umlal	r6, r7, r3, r5
	// ([26-29], 42) blocks
	ldr	r1, [r12, #168]
	ldr	r5, [r14, #116]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([27-30], 41) blocks
	ldr	r2, [r12, #164]
	ldr	r1, [r14, #120]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([28-31], 40) blocks
	ldr	r3, [r12, #160]
	ldr	r2, [r14, #124]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([29-32], 39) blocks
	ldr	r4, [r12, #156]
	ldr	r3, [r14, #128]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([30-33], 38) blocks
	ldr	r5, [r12, #152]
	ldr	r4, [r14, #132]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
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
	// ([31-34], 37) blocks
	ldr	r1, [r12, #148]
	ldr	r5, [r14, #136]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([32-35], 36) blocks
	ldr	r2, [r12, #144]
	ldr	r1, [r14, #140]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([33-36], 35) blocks
	ldr	r3, [r12, #140]
	ldr	r2, [r14, #144]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([34-37], 34) blocks
	ldr	r4, [r12, #136]
	ldr	r3, [r14, #148]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([35-38], 33) blocks
	ldr	r5, [r12, #132]
	ldr	r4, [r14, #152]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([36-39], 32) blocks
	ldr	r1, [r12, #128]
	ldr	r5, [r14, #156]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([37-40], 31) blocks
	ldr	r2, [r12, #124]
	ldr	r1, [r14, #160]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
#ifdef __thumb2__
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r2, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([38-41], 30) blocks
	ldr	r3, [r12, #120]
	ldr	r2, [r14, #164]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([39-42], 29) blocks
	ldr	r4, [r12, #116]
	ldr	r3, [r14, #168]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([40-43], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r4, [r14, #172]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([41-43],27),([42-43],26),(43,25) blocks
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
	ldr	r5, [r12, #108]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r2, r5
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
	ldr	r5, [r12, #104]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
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
	ldr	r5, [r12, #100]
	umlal	r9, r10, r4, r5
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
	bic	r5, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	bic	r5, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([29-32], 43) blocks
	ldr	r4, [r12, #172]
	ldr	r3, [r14, #128]
	ldr	r2, [r14, #124]
	ldr	r1, [r14, #120]
	ldr	r5, [r14, #116]
	umull	r9, r10, r1, r4
	umull	r6, r7, r3, r4
	umlal	r8, r9, r5, r4
	umlal	r10, r6, r2, r4
	// ([30-33], 42) blocks
	ldr	r5, [r12, #168]
	ldr	r4, [r14, #132]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([31-34], 41) blocks
	ldr	r1, [r12, #164]
	ldr	r5, [r14, #136]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([32-35], 40) blocks
	ldr	r2, [r12, #160]
	ldr	r1, [r14, #140]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([33-36], 39) blocks
	ldr	r3, [r12, #156]
	ldr	r2, [r14, #144]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([34-37], 38) blocks
	ldr	r4, [r12, #152]
	ldr	r3, [r14, #148]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
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
	// ([35-38], 37) blocks
	ldr	r5, [r12, #148]
	ldr	r4, [r14, #152]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([36-39], 36) blocks
	ldr	r1, [r12, #144]
	ldr	r5, [r14, #156]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([37-40], 35) blocks
	ldr	r2, [r12, #140]
	ldr	r1, [r14, #160]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([38-41], 34) blocks
	ldr	r3, [r12, #136]
	ldr	r2, [r14, #164]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([39-42], 33) blocks
	ldr	r4, [r12, #132]
	ldr	r3, [r14, #168]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([40-43], 32) blocks
	ldr	r5, [r12, #128]
	ldr	r4, [r14, #172]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([41-43],31),([42-43],30),(43,29) blocks
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
	ldr	r5, [r12, #124]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
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
	ldr	r5, [r12, #120]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
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
	ldr	r5, [r12, #116]
	umlal	r8, r9, r4, r5
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
	bic	r5, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	bic	r5, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([33-36], 43) blocks
	ldr	r3, [r12, #172]
	ldr	r2, [r14, #144]
	ldr	r1, [r14, #140]
	ldr	r5, [r14, #136]
	ldr	r4, [r14, #132]
	umull	r8, r9, r5, r3
	umull	r10, r6, r2, r3
	umlal	r7, r8, r4, r3
	umlal	r9, r10, r1, r3
	// ([34-37], 42) blocks
	ldr	r4, [r12, #168]
	ldr	r3, [r14, #148]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([35-38], 41) blocks
	ldr	r5, [r12, #164]
	ldr	r4, [r14, #152]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([36-39], 40) blocks
	ldr	r1, [r12, #160]
	ldr	r5, [r14, #156]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([37-40], 39) blocks
	ldr	r2, [r12, #156]
	ldr	r1, [r14, #160]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([38-41], 38) blocks
	ldr	r3, [r12, #152]
	ldr	r2, [r14, #164]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
#ifdef __thumb2__
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r7, r11	// top 4b < 16
	and	r7, r7, r11	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r8, r11	// top 4b < 16
	and	r8, r8, r11	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r9, r11	// top 4b < 16
	and	r9, r9, r11	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r10, r11	// top 4b < 16
	and	r10, r10, r11	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
#ifdef __thumb2__
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
#else
	vmov	r11, s5		// reload #0x0F0F0F0F
	bic	r3, r6, r11	// top 4b < 16
	and	r6, r6, r11	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	vmov	r11, s4		// reload #0x03030303
#endif
	// ([39-42], 37) blocks
	ldr	r4, [r12, #148]
	ldr	r3, [r14, #168]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([40-43], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r4, [r14, #172]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([41-43],35),([42-43],34),(43,33) blocks
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
	ldr	r5, [r12, #140]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
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
	ldr	r5, [r12, #136]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
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
	ldr	r5, [r12, #132]
	umlal	r7, r8, r4, r5
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
	bic	r5, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	bic	r5, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([37-40], 43) blocks
	ldr	r2, [r12, #172]
	ldr	r1, [r14, #160]
	ldr	r5, [r14, #156]
	ldr	r4, [r14, #152]
	ldr	r3, [r14, #148]
	umull	r7, r8, r4, r2
	umull	r9, r10, r1, r2
	umlal	r6, r7, r3, r2
	umlal	r8, r9, r5, r2
	// ([38-41], 42) blocks
	ldr	r3, [r12, #168]
	ldr	r2, [r14, #164]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([39-42], 41) blocks
	ldr	r4, [r12, #164]
	ldr	r3, [r14, #168]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([40-43], 40) blocks
	ldr	r5, [r12, #160]
	ldr	r4, [r14, #172]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([41-43],39),([42-43],38),(43,37) blocks
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
	ldr	r5, [r12, #156]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
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
	ldr	r5, [r12, #152]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
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
	ldr	r5, [r12, #148]
	umlal	r6, r7, r4, r5
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
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
sch3_20:			// mv hh back to h
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0
	ldr	r2, [r14, #164]
	ldr	r3, [r14, #168]
	ldr	r4, [r14, #172]
	// ([41-43],43),([42-43],42),(43,41) blocks
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
	ldr	r5, [r12, #172]
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
	ldr	r5, [r12, #168]
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
	ldr	r5, [r12, #164]
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
