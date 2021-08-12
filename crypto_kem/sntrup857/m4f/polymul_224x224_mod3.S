
// void gf_polymul_224x224_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_224x224_mod3
	.type	gf_polymul_224x224_mod3, %function
gf_polymul_224x224_mod3:
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
	// ([44-47], 0) blocks
	ldr	r4, [r12]
	ldr	r3, [r14, #188]
	ldr	r2, [r14, #184]
	ldr	r1, [r14, #180]
	ldr	r5, [r14, #176]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([43-46], 1) blocks
	ldr	r3, [r12, #4]
	ldr	r4, [r14, #172]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([42-45], 2) blocks
	ldr	r2, [r12, #8]
	ldr	r3, [r14, #168]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([41-44], 3) blocks
	ldr	r1, [r12, #12]
	ldr	r2, [r14, #164]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([40-43], 4) blocks
	ldr	r5, [r12, #16]
	ldr	r1, [r14, #160]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([39-42], 5) blocks
	ldr	r4, [r12, #20]
	ldr	r5, [r14, #156]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([38-41], 6) blocks
	ldr	r3, [r12, #24]
	ldr	r4, [r14, #152]
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
	// ([37-40], 7) blocks
	ldr	r2, [r12, #28]
	ldr	r3, [r14, #148]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([36-39], 8) blocks
	ldr	r1, [r12, #32]
	ldr	r2, [r14, #144]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([35-38], 9) blocks
	ldr	r5, [r12, #36]
	ldr	r1, [r14, #140]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([34-37], 10) blocks
	ldr	r4, [r12, #40]
	ldr	r5, [r14, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([33-36], 11) blocks
	ldr	r3, [r12, #44]
	ldr	r4, [r14, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([32-35], 12) blocks
	ldr	r2, [r12, #48]
	ldr	r3, [r14, #128]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([31-34], 13) blocks
	ldr	r1, [r12, #52]
	ldr	r2, [r14, #124]
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
	// ([30-33], 14) blocks
	ldr	r5, [r12, #56]
	ldr	r1, [r14, #120]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([29-32], 15) blocks
	ldr	r4, [r12, #60]
	ldr	r5, [r14, #116]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([28-31], 16) blocks
	ldr	r3, [r12, #64]
	ldr	r4, [r14, #112]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([27-30], 17) blocks
	ldr	r2, [r12, #68]
	ldr	r3, [r14, #108]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([26-29], 18) blocks
	ldr	r1, [r12, #72]
	ldr	r2, [r14, #104]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([25-28], 19) blocks
	ldr	r5, [r12, #76]
	ldr	r1, [r14, #100]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([24-27], 20) blocks
	ldr	r4, [r12, #80]
	ldr	r5, [r14, #96]
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
	// ([23-26], 21) blocks
	ldr	r3, [r12, #84]
	ldr	r4, [r14, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([22-25], 22) blocks
	ldr	r2, [r12, #88]
	ldr	r3, [r14, #88]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([21-24], 23) blocks
	ldr	r1, [r12, #92]
	ldr	r2, [r14, #84]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([20-23], 24) blocks
	ldr	r5, [r12, #96]
	ldr	r1, [r14, #80]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([19-22], 25) blocks
	ldr	r4, [r12, #100]
	ldr	r5, [r14, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([18-21], 26) blocks
	ldr	r3, [r12, #104]
	ldr	r4, [r14, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([17-20], 27) blocks
	ldr	r2, [r12, #108]
	ldr	r3, [r14, #68]
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
	// ([16-19], 28) blocks
	ldr	r1, [r12, #112]
	ldr	r2, [r14, #64]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([15-18], 29) blocks
	ldr	r5, [r12, #116]
	ldr	r1, [r14, #60]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([14-17], 30) blocks
	ldr	r4, [r12, #120]
	ldr	r5, [r14, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([13-16], 31) blocks
	ldr	r3, [r12, #124]
	ldr	r4, [r14, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([12-15], 32) blocks
	ldr	r2, [r12, #128]
	ldr	r3, [r14, #48]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([11-14], 33) blocks
	ldr	r1, [r12, #132]
	ldr	r2, [r14, #44]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([10-13], 34) blocks
	ldr	r5, [r12, #136]
	ldr	r1, [r14, #40]
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
	// ([9-12], 35) blocks
	ldr	r4, [r12, #140]
	ldr	r5, [r14, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([8-11], 36) blocks
	ldr	r3, [r12, #144]
	ldr	r4, [r14, #32]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([7-10], 37) blocks
	ldr	r2, [r12, #148]
	ldr	r3, [r14, #28]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([6-9], 38) blocks
	ldr	r1, [r12, #152]
	ldr	r2, [r14, #24]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([5-8], 39) blocks
	ldr	r5, [r12, #156]
	ldr	r1, [r14, #20]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([4-7], 40) blocks
	ldr	r4, [r12, #160]
	ldr	r5, [r14, #16]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([3-6], 41) blocks
	ldr	r3, [r12, #164]
	ldr	r4, [r14, #12]
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
	// ([2-5], 42) blocks
	ldr	r2, [r12, #168]
	ldr	r3, [r14, #8]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([1-4], 43) blocks
	ldr	r1, [r12, #172]
	ldr	r2, [r14, #4]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([0-3], 44) blocks
	ldr	r5, [r12, #176]
	ldr	r1, [r14, #0]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],45), ([0-1],46), (0,47) blocks
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
	ldr	r5, [r12, #180]
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
	ldr	r5, [r12, #184]
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
	ldr	r5, [r12, #188]
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
	// ([48-51], 0) blocks
	ldr	r3, [r12]
	ldr	r2, [r14, #204]
	ldr	r1, [r14, #200]
	ldr	r5, [r14, #196]
	ldr	r4, [r14, #192]
	umull	r10, r6, r5, r3
	umull	r7, r8, r2, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r1, r3
	// ([47-50], 1) blocks
	ldr	r2, [r12, #4]
	ldr	r3, [r14, #188]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([46-49], 2) blocks
	ldr	r1, [r12, #8]
	ldr	r2, [r14, #184]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([45-48], 3) blocks
	ldr	r5, [r12, #12]
	ldr	r1, [r14, #180]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([44-47], 4) blocks
	ldr	r4, [r12, #16]
	ldr	r5, [r14, #176]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([43-46], 5) blocks
	ldr	r3, [r12, #20]
	ldr	r4, [r14, #172]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([42-45], 6) blocks
	ldr	r2, [r12, #24]
	ldr	r3, [r14, #168]
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
	// ([41-44], 7) blocks
	ldr	r1, [r12, #28]
	ldr	r2, [r14, #164]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([40-43], 8) blocks
	ldr	r5, [r12, #32]
	ldr	r1, [r14, #160]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([39-42], 9) blocks
	ldr	r4, [r12, #36]
	ldr	r5, [r14, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([38-41], 10) blocks
	ldr	r3, [r12, #40]
	ldr	r4, [r14, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([37-40], 11) blocks
	ldr	r2, [r12, #44]
	ldr	r3, [r14, #148]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([36-39], 12) blocks
	ldr	r1, [r12, #48]
	ldr	r2, [r14, #144]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([35-38], 13) blocks
	ldr	r5, [r12, #52]
	ldr	r1, [r14, #140]
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
	// ([34-37], 14) blocks
	ldr	r4, [r12, #56]
	ldr	r5, [r14, #136]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([33-36], 15) blocks
	ldr	r3, [r12, #60]
	ldr	r4, [r14, #132]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([32-35], 16) blocks
	ldr	r2, [r12, #64]
	ldr	r3, [r14, #128]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([31-34], 17) blocks
	ldr	r1, [r12, #68]
	ldr	r2, [r14, #124]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([30-33], 18) blocks
	ldr	r5, [r12, #72]
	ldr	r1, [r14, #120]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([29-32], 19) blocks
	ldr	r4, [r12, #76]
	ldr	r5, [r14, #116]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([28-31], 20) blocks
	ldr	r3, [r12, #80]
	ldr	r4, [r14, #112]
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
	// ([27-30], 21) blocks
	ldr	r2, [r12, #84]
	ldr	r3, [r14, #108]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([26-29], 22) blocks
	ldr	r1, [r12, #88]
	ldr	r2, [r14, #104]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([25-28], 23) blocks
	ldr	r5, [r12, #92]
	ldr	r1, [r14, #100]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([24-27], 24) blocks
	ldr	r4, [r12, #96]
	ldr	r5, [r14, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([23-26], 25) blocks
	ldr	r3, [r12, #100]
	ldr	r4, [r14, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([22-25], 26) blocks
	ldr	r2, [r12, #104]
	ldr	r3, [r14, #88]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([21-24], 27) blocks
	ldr	r1, [r12, #108]
	ldr	r2, [r14, #84]
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
	// ([20-23], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r1, [r14, #80]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([19-22], 29) blocks
	ldr	r4, [r12, #116]
	ldr	r5, [r14, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([18-21], 30) blocks
	ldr	r3, [r12, #120]
	ldr	r4, [r14, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([17-20], 31) blocks
	ldr	r2, [r12, #124]
	ldr	r3, [r14, #68]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([16-19], 32) blocks
	ldr	r1, [r12, #128]
	ldr	r2, [r14, #64]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([15-18], 33) blocks
	ldr	r5, [r12, #132]
	ldr	r1, [r14, #60]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([14-17], 34) blocks
	ldr	r4, [r12, #136]
	ldr	r5, [r14, #56]
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
	// ([13-16], 35) blocks
	ldr	r3, [r12, #140]
	ldr	r4, [r14, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([12-15], 36) blocks
	ldr	r2, [r12, #144]
	ldr	r3, [r14, #48]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([11-14], 37) blocks
	ldr	r1, [r12, #148]
	ldr	r2, [r14, #44]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([10-13], 38) blocks
	ldr	r5, [r12, #152]
	ldr	r1, [r14, #40]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([9-12], 39) blocks
	ldr	r4, [r12, #156]
	ldr	r5, [r14, #36]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([8-11], 40) blocks
	ldr	r3, [r12, #160]
	ldr	r4, [r14, #32]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([7-10], 41) blocks
	ldr	r2, [r12, #164]
	ldr	r3, [r14, #28]
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
	// ([6-9], 42) blocks
	ldr	r1, [r12, #168]
	ldr	r2, [r14, #24]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([5-8], 43) blocks
	ldr	r5, [r12, #172]
	ldr	r1, [r14, #20]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([4-7], 44) blocks
	ldr	r4, [r12, #176]
	ldr	r5, [r14, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([3-6], 45) blocks
	ldr	r3, [r12, #180]
	ldr	r4, [r14, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([2-5], 46) blocks
	ldr	r2, [r12, #184]
	ldr	r3, [r14, #8]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([1-4], 47) blocks
	ldr	r1, [r12, #188]
	ldr	r2, [r14, #4]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([0-3], 48) blocks
	ldr	r5, [r12, #192]
	ldr	r1, [r14, #0]
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
	// ([0-2],49), ([0-1],50), (0,51) blocks
	bic	r5, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	bic	r5, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	ldr	r5, [r12, #196]
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
	ldr	r5, [r12, #200]
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
	ldr	r5, [r12, #204]
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
	// ([52-55], 0) blocks
	ldr	r2, [r12]
	ldr	r1, [r14, #220]
	ldr	r5, [r14, #216]
	ldr	r4, [r14, #212]
	ldr	r3, [r14, #208]
	umull	r9, r10, r4, r2
	umull	r6, r7, r1, r2
	umlal	r8, r9, r3, r2
	umlal	r10, r6, r5, r2
	// ([51-54], 1) blocks
	ldr	r1, [r12, #4]
	ldr	r2, [r14, #204]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([50-53], 2) blocks
	ldr	r5, [r12, #8]
	ldr	r1, [r14, #200]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([49-52], 3) blocks
	ldr	r4, [r12, #12]
	ldr	r5, [r14, #196]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([48-51], 4) blocks
	ldr	r3, [r12, #16]
	ldr	r4, [r14, #192]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([47-50], 5) blocks
	ldr	r2, [r12, #20]
	ldr	r3, [r14, #188]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([46-49], 6) blocks
	ldr	r1, [r12, #24]
	ldr	r2, [r14, #184]
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
	// ([45-48], 7) blocks
	ldr	r5, [r12, #28]
	ldr	r1, [r14, #180]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([44-47], 8) blocks
	ldr	r4, [r12, #32]
	ldr	r5, [r14, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([43-46], 9) blocks
	ldr	r3, [r12, #36]
	ldr	r4, [r14, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([42-45], 10) blocks
	ldr	r2, [r12, #40]
	ldr	r3, [r14, #168]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([41-44], 11) blocks
	ldr	r1, [r12, #44]
	ldr	r2, [r14, #164]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([40-43], 12) blocks
	ldr	r5, [r12, #48]
	ldr	r1, [r14, #160]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([39-42], 13) blocks
	ldr	r4, [r12, #52]
	ldr	r5, [r14, #156]
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
	// ([38-41], 14) blocks
	ldr	r3, [r12, #56]
	ldr	r4, [r14, #152]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([37-40], 15) blocks
	ldr	r2, [r12, #60]
	ldr	r3, [r14, #148]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([36-39], 16) blocks
	ldr	r1, [r12, #64]
	ldr	r2, [r14, #144]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([35-38], 17) blocks
	ldr	r5, [r12, #68]
	ldr	r1, [r14, #140]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([34-37], 18) blocks
	ldr	r4, [r12, #72]
	ldr	r5, [r14, #136]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([33-36], 19) blocks
	ldr	r3, [r12, #76]
	ldr	r4, [r14, #132]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([32-35], 20) blocks
	ldr	r2, [r12, #80]
	ldr	r3, [r14, #128]
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
	// ([31-34], 21) blocks
	ldr	r1, [r12, #84]
	ldr	r2, [r14, #124]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([30-33], 22) blocks
	ldr	r5, [r12, #88]
	ldr	r1, [r14, #120]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([29-32], 23) blocks
	ldr	r4, [r12, #92]
	ldr	r5, [r14, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([28-31], 24) blocks
	ldr	r3, [r12, #96]
	ldr	r4, [r14, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([27-30], 25) blocks
	ldr	r2, [r12, #100]
	ldr	r3, [r14, #108]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([26-29], 26) blocks
	ldr	r1, [r12, #104]
	ldr	r2, [r14, #104]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([25-28], 27) blocks
	ldr	r5, [r12, #108]
	ldr	r1, [r14, #100]
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
	// ([24-27], 28) blocks
	ldr	r4, [r12, #112]
	ldr	r5, [r14, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([23-26], 29) blocks
	ldr	r3, [r12, #116]
	ldr	r4, [r14, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([22-25], 30) blocks
	ldr	r2, [r12, #120]
	ldr	r3, [r14, #88]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([21-24], 31) blocks
	ldr	r1, [r12, #124]
	ldr	r2, [r14, #84]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([20-23], 32) blocks
	ldr	r5, [r12, #128]
	ldr	r1, [r14, #80]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([19-22], 33) blocks
	ldr	r4, [r12, #132]
	ldr	r5, [r14, #76]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([18-21], 34) blocks
	ldr	r3, [r12, #136]
	ldr	r4, [r14, #72]
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
	// ([17-20], 35) blocks
	ldr	r2, [r12, #140]
	ldr	r3, [r14, #68]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([16-19], 36) blocks
	ldr	r1, [r12, #144]
	ldr	r2, [r14, #64]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([15-18], 37) blocks
	ldr	r5, [r12, #148]
	ldr	r1, [r14, #60]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([14-17], 38) blocks
	ldr	r4, [r12, #152]
	ldr	r5, [r14, #56]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([13-16], 39) blocks
	ldr	r3, [r12, #156]
	ldr	r4, [r14, #52]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([12-15], 40) blocks
	ldr	r2, [r12, #160]
	ldr	r3, [r14, #48]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([11-14], 41) blocks
	ldr	r1, [r12, #164]
	ldr	r2, [r14, #44]
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
	// ([10-13], 42) blocks
	ldr	r5, [r12, #168]
	ldr	r1, [r14, #40]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([9-12], 43) blocks
	ldr	r4, [r12, #172]
	ldr	r5, [r14, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([8-11], 44) blocks
	ldr	r3, [r12, #176]
	ldr	r4, [r14, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([7-10], 45) blocks
	ldr	r2, [r12, #180]
	ldr	r3, [r14, #28]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([6-9], 46) blocks
	ldr	r1, [r12, #184]
	ldr	r2, [r14, #24]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([5-8], 47) blocks
	ldr	r5, [r12, #188]
	ldr	r1, [r14, #20]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([4-7], 48) blocks
	ldr	r4, [r12, #192]
	ldr	r5, [r14, #16]
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
	// ([3-6], 49) blocks
	ldr	r3, [r12, #196]
	ldr	r4, [r14, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([2-5], 50) blocks
	ldr	r2, [r12, #200]
	ldr	r3, [r14, #8]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([1-4], 51) blocks
	ldr	r1, [r12, #204]
	ldr	r2, [r14, #4]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([0-3], 52) blocks
	ldr	r5, [r12, #208]
	ldr	r1, [r14, #0]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([0-2],53), ([0-1],54), (0,55) blocks
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
	ldr	r5, [r12, #212]
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
	ldr	r5, [r12, #216]
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
	ldr	r5, [r12, #220]
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
sch3_10:			// decreasing thread length
	// ([1-4], 55) blocks
	ldr	r1, [r12, #220]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([2-5], 54) blocks
	ldr	r2, [r12, #216]
	ldr	r1, [r14, #20]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([3-6], 53) blocks
	ldr	r3, [r12, #212]
	ldr	r2, [r14, #24]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([4-7], 52) blocks
	ldr	r4, [r12, #208]
	ldr	r3, [r14, #28]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([5-8], 51) blocks
	ldr	r5, [r12, #204]
	ldr	r4, [r14, #32]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([6-9], 50) blocks
	ldr	r1, [r12, #200]
	ldr	r5, [r14, #36]
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
	// ([7-10], 49) blocks
	ldr	r2, [r12, #196]
	ldr	r1, [r14, #40]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([8-11], 48) blocks
	ldr	r3, [r12, #192]
	ldr	r2, [r14, #44]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([9-12], 47) blocks
	ldr	r4, [r12, #188]
	ldr	r3, [r14, #48]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([10-13], 46) blocks
	ldr	r5, [r12, #184]
	ldr	r4, [r14, #52]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([11-14], 45) blocks
	ldr	r1, [r12, #180]
	ldr	r5, [r14, #56]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([12-15], 44) blocks
	ldr	r2, [r12, #176]
	ldr	r1, [r14, #60]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([13-16], 43) blocks
	ldr	r3, [r12, #172]
	ldr	r2, [r14, #64]
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
	// ([40-43], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r4, [r14, #172]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([41-44], 15) blocks
	ldr	r1, [r12, #60]
	ldr	r5, [r14, #176]
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
	// ([42-45], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r1, [r14, #180]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([43-46], 13) blocks
	ldr	r3, [r12, #52]
	ldr	r2, [r14, #184]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([44-47], 12) blocks
	ldr	r4, [r12, #48]
	ldr	r3, [r14, #188]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([45-48], 11) blocks
	ldr	r5, [r12, #44]
	ldr	r4, [r14, #192]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([46-49], 10) blocks
	ldr	r1, [r12, #40]
	ldr	r5, [r14, #196]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([47-50], 9) blocks
	ldr	r2, [r12, #36]
	ldr	r1, [r14, #200]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([48-51], 8) blocks
	ldr	r3, [r12, #32]
	ldr	r2, [r14, #204]
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
	// ([49-52], 7) blocks
	ldr	r4, [r12, #28]
	ldr	r3, [r14, #208]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([50-53], 6) blocks
	ldr	r5, [r12, #24]
	ldr	r4, [r14, #212]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([51-54], 5) blocks
	ldr	r1, [r12, #20]
	ldr	r5, [r14, #216]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([52-55], 4) blocks
	ldr	r2, [r12, #16]
	ldr	r1, [r14, #220]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([53-55],3),([54-55],2),(55,1) blocks
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
	ldr	r2, [r12, #12]
	umlal	r9, r10, r1, r2
	umlal	r8, r9, r5, r2
	umlal	r7, r8, r4, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	ldr	r2, [r12, #8]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #4]
	umlal	r7, r8, r1, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([5-8], 55) blocks
	ldr	r5, [r12, #220]
	ldr	r4, [r14, #32]
	ldr	r3, [r14, #28]
	ldr	r2, [r14, #24]
	ldr	r1, [r14, #20]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([6-9], 54) blocks
	ldr	r1, [r12, #216]
	ldr	r5, [r14, #36]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([7-10], 53) blocks
	ldr	r2, [r12, #212]
	ldr	r1, [r14, #40]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([8-11], 52) blocks
	ldr	r3, [r12, #208]
	ldr	r2, [r14, #44]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([9-12], 51) blocks
	ldr	r4, [r12, #204]
	ldr	r3, [r14, #48]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([10-13], 50) blocks
	ldr	r5, [r12, #200]
	ldr	r4, [r14, #52]
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
	// ([11-14], 49) blocks
	ldr	r1, [r12, #196]
	ldr	r5, [r14, #56]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([12-15], 48) blocks
	ldr	r2, [r12, #192]
	ldr	r1, [r14, #60]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([13-16], 47) blocks
	ldr	r3, [r12, #188]
	ldr	r2, [r14, #64]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([14-17], 46) blocks
	ldr	r4, [r12, #184]
	ldr	r3, [r14, #68]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([15-18], 45) blocks
	ldr	r5, [r12, #180]
	ldr	r4, [r14, #72]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([16-19], 44) blocks
	ldr	r1, [r12, #176]
	ldr	r5, [r14, #76]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([17-20], 43) blocks
	ldr	r2, [r12, #172]
	ldr	r1, [r14, #80]
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
	// ([41-44], 19) blocks
	ldr	r1, [r12, #76]
	ldr	r5, [r14, #176]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([42-45], 18) blocks
	ldr	r2, [r12, #72]
	ldr	r1, [r14, #180]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([43-46], 17) blocks
	ldr	r3, [r12, #68]
	ldr	r2, [r14, #184]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([44-47], 16) blocks
	ldr	r4, [r12, #64]
	ldr	r3, [r14, #188]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([45-48], 15) blocks
	ldr	r5, [r12, #60]
	ldr	r4, [r14, #192]
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
	// ([46-49], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r5, [r14, #196]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([47-50], 13) blocks
	ldr	r2, [r12, #52]
	ldr	r1, [r14, #200]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([48-51], 12) blocks
	ldr	r3, [r12, #48]
	ldr	r2, [r14, #204]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([49-52], 11) blocks
	ldr	r4, [r12, #44]
	ldr	r3, [r14, #208]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([50-53], 10) blocks
	ldr	r5, [r12, #40]
	ldr	r4, [r14, #212]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([51-54], 9) blocks
	ldr	r1, [r12, #36]
	ldr	r5, [r14, #216]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([52-55], 8) blocks
	ldr	r2, [r12, #32]
	ldr	r1, [r14, #220]
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
	// ([53-55],7),([54-55],6),(55,5) blocks
	ldr	r2, [r12, #28]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
	umlal	r6, r7, r4, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #24]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #20]
	umlal	r6, r7, r1, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([9-12], 55) blocks
	ldr	r4, [r12, #220]
	ldr	r3, [r14, #48]
	ldr	r2, [r14, #44]
	ldr	r1, [r14, #40]
	ldr	r5, [r14, #36]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([10-13], 54) blocks
	ldr	r5, [r12, #216]
	ldr	r4, [r14, #52]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([11-14], 53) blocks
	ldr	r1, [r12, #212]
	ldr	r5, [r14, #56]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([12-15], 52) blocks
	ldr	r2, [r12, #208]
	ldr	r1, [r14, #60]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([13-16], 51) blocks
	ldr	r3, [r12, #204]
	ldr	r2, [r14, #64]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([14-17], 50) blocks
	ldr	r4, [r12, #200]
	ldr	r3, [r14, #68]
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
	// ([15-18], 49) blocks
	ldr	r5, [r12, #196]
	ldr	r4, [r14, #72]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([16-19], 48) blocks
	ldr	r1, [r12, #192]
	ldr	r5, [r14, #76]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([17-20], 47) blocks
	ldr	r2, [r12, #188]
	ldr	r1, [r14, #80]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([18-21], 46) blocks
	ldr	r3, [r12, #184]
	ldr	r2, [r14, #84]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([19-22], 45) blocks
	ldr	r4, [r12, #180]
	ldr	r3, [r14, #88]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([20-23], 44) blocks
	ldr	r5, [r12, #176]
	ldr	r4, [r14, #92]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([21-24], 43) blocks
	ldr	r1, [r12, #172]
	ldr	r5, [r14, #96]
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
	// ([41-44], 23) blocks
	ldr	r1, [r12, #92]
	ldr	r5, [r14, #176]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([42-45], 22) blocks
	ldr	r2, [r12, #88]
	ldr	r1, [r14, #180]
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
	// ([43-46], 21) blocks
	ldr	r3, [r12, #84]
	ldr	r2, [r14, #184]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([44-47], 20) blocks
	ldr	r4, [r12, #80]
	ldr	r3, [r14, #188]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([45-48], 19) blocks
	ldr	r5, [r12, #76]
	ldr	r4, [r14, #192]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([46-49], 18) blocks
	ldr	r1, [r12, #72]
	ldr	r5, [r14, #196]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([47-50], 17) blocks
	ldr	r2, [r12, #68]
	ldr	r1, [r14, #200]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([48-51], 16) blocks
	ldr	r3, [r12, #64]
	ldr	r2, [r14, #204]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([49-52], 15) blocks
	ldr	r4, [r12, #60]
	ldr	r3, [r14, #208]
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
	// ([50-53], 14) blocks
	ldr	r5, [r12, #56]
	ldr	r4, [r14, #212]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([51-54], 13) blocks
	ldr	r1, [r12, #52]
	ldr	r5, [r14, #216]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([52-55], 12) blocks
	ldr	r2, [r12, #48]
	ldr	r1, [r14, #220]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([53-55],11),([54-55],10),(55,9) blocks
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
	ldr	r2, [r12, #44]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
	umlal	r10, r6, r4, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #40]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	ldr	r2, [r12, #36]
	umlal	r10, r6, r1, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	// ([13-16], 55) blocks
	ldr	r3, [r12, #220]
	ldr	r2, [r14, #64]
	ldr	r1, [r14, #60]
	ldr	r5, [r14, #56]
	ldr	r4, [r14, #52]
	umull	r10, r6, r5, r3
	umull	r7, r8, r2, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r1, r3
	// ([14-17], 54) blocks
	ldr	r4, [r12, #216]
	ldr	r3, [r14, #68]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([15-18], 53) blocks
	ldr	r5, [r12, #212]
	ldr	r4, [r14, #72]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([16-19], 52) blocks
	ldr	r1, [r12, #208]
	ldr	r5, [r14, #76]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([17-20], 51) blocks
	ldr	r2, [r12, #204]
	ldr	r1, [r14, #80]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([18-21], 50) blocks
	ldr	r3, [r12, #200]
	ldr	r2, [r14, #84]
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
	// ([19-22], 49) blocks
	ldr	r4, [r12, #196]
	ldr	r3, [r14, #88]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([20-23], 48) blocks
	ldr	r5, [r12, #192]
	ldr	r4, [r14, #92]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([21-24], 47) blocks
	ldr	r1, [r12, #188]
	ldr	r5, [r14, #96]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([22-25], 46) blocks
	ldr	r2, [r12, #184]
	ldr	r1, [r14, #100]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([23-26], 45) blocks
	ldr	r3, [r12, #180]
	ldr	r2, [r14, #104]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([24-27], 44) blocks
	ldr	r4, [r12, #176]
	ldr	r3, [r14, #108]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([25-28], 43) blocks
	ldr	r5, [r12, #172]
	ldr	r4, [r14, #112]
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
	// ([40-43], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r4, [r14, #172]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([41-44], 27) blocks
	ldr	r1, [r12, #108]
	ldr	r5, [r14, #176]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([42-45], 26) blocks
	ldr	r2, [r12, #104]
	ldr	r1, [r14, #180]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([43-46], 25) blocks
	ldr	r3, [r12, #100]
	ldr	r2, [r14, #184]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([44-47], 24) blocks
	ldr	r4, [r12, #96]
	ldr	r3, [r14, #188]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([45-48], 23) blocks
	ldr	r5, [r12, #92]
	ldr	r4, [r14, #192]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([46-49], 22) blocks
	ldr	r1, [r12, #88]
	ldr	r5, [r14, #196]
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
	// ([47-50], 21) blocks
	ldr	r2, [r12, #84]
	ldr	r1, [r14, #200]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([48-51], 20) blocks
	ldr	r3, [r12, #80]
	ldr	r2, [r14, #204]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([49-52], 19) blocks
	ldr	r4, [r12, #76]
	ldr	r3, [r14, #208]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([50-53], 18) blocks
	ldr	r5, [r12, #72]
	ldr	r4, [r14, #212]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([51-54], 17) blocks
	ldr	r1, [r12, #68]
	ldr	r5, [r14, #216]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([52-55], 16) blocks
	ldr	r2, [r12, #64]
	ldr	r1, [r14, #220]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([53-55],15),([54-55],14),(55,13) blocks
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
	ldr	r2, [r12, #60]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
	umlal	r9, r10, r4, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
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
	ldr	r2, [r12, #56]
	umlal	r10, r6, r1, r2
	umlal	r9, r10, r5, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	ldr	r2, [r12, #52]
	umlal	r9, r10, r1, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([17-20], 55) blocks
	ldr	r2, [r12, #220]
	ldr	r1, [r14, #80]
	ldr	r5, [r14, #76]
	ldr	r4, [r14, #72]
	ldr	r3, [r14, #68]
	umull	r9, r10, r4, r2
	umull	r6, r7, r1, r2
	umlal	r8, r9, r3, r2
	umlal	r10, r6, r5, r2
	// ([18-21], 54) blocks
	ldr	r3, [r12, #216]
	ldr	r2, [r14, #84]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([19-22], 53) blocks
	ldr	r4, [r12, #212]
	ldr	r3, [r14, #88]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([20-23], 52) blocks
	ldr	r5, [r12, #208]
	ldr	r4, [r14, #92]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([21-24], 51) blocks
	ldr	r1, [r12, #204]
	ldr	r5, [r14, #96]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([22-25], 50) blocks
	ldr	r2, [r12, #200]
	ldr	r1, [r14, #100]
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
	// ([23-26], 49) blocks
	ldr	r3, [r12, #196]
	ldr	r2, [r14, #104]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([24-27], 48) blocks
	ldr	r4, [r12, #192]
	ldr	r3, [r14, #108]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([25-28], 47) blocks
	ldr	r5, [r12, #188]
	ldr	r4, [r14, #112]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([26-29], 46) blocks
	ldr	r1, [r12, #184]
	ldr	r5, [r14, #116]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([27-30], 45) blocks
	ldr	r2, [r12, #180]
	ldr	r1, [r14, #120]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([28-31], 44) blocks
	ldr	r3, [r12, #176]
	ldr	r2, [r14, #124]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([29-32], 43) blocks
	ldr	r4, [r12, #172]
	ldr	r3, [r14, #128]
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
	// ([41-44], 31) blocks
	ldr	r1, [r12, #124]
	ldr	r5, [r14, #176]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([42-45], 30) blocks
	ldr	r2, [r12, #120]
	ldr	r1, [r14, #180]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([43-46], 29) blocks
	ldr	r3, [r12, #116]
	ldr	r2, [r14, #184]
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
	// ([44-47], 28) blocks
	ldr	r4, [r12, #112]
	ldr	r3, [r14, #188]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([45-48], 27) blocks
	ldr	r5, [r12, #108]
	ldr	r4, [r14, #192]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([46-49], 26) blocks
	ldr	r1, [r12, #104]
	ldr	r5, [r14, #196]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([47-50], 25) blocks
	ldr	r2, [r12, #100]
	ldr	r1, [r14, #200]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([48-51], 24) blocks
	ldr	r3, [r12, #96]
	ldr	r2, [r14, #204]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([49-52], 23) blocks
	ldr	r4, [r12, #92]
	ldr	r3, [r14, #208]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([50-53], 22) blocks
	ldr	r5, [r12, #88]
	ldr	r4, [r14, #212]
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
	// ([51-54], 21) blocks
	ldr	r1, [r12, #84]
	ldr	r5, [r14, #216]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([52-55], 20) blocks
	ldr	r2, [r12, #80]
	ldr	r1, [r14, #220]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([53-55],19),([54-55],18),(55,17) blocks
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
	ldr	r2, [r12, #76]
	umlal	r10, r6, r1, r2
	umlal	r9, r10, r5, r2
	umlal	r8, r9, r4, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	ldr	r2, [r12, #72]
	umlal	r9, r10, r1, r2
	umlal	r8, r9, r5, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	ldr	r2, [r12, #68]
	umlal	r8, r9, r1, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([21-24], 55) blocks
	ldr	r1, [r12, #220]
	ldr	r5, [r14, #96]
	ldr	r4, [r14, #92]
	ldr	r3, [r14, #88]
	ldr	r2, [r14, #84]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([22-25], 54) blocks
	ldr	r2, [r12, #216]
	ldr	r1, [r14, #100]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([23-26], 53) blocks
	ldr	r3, [r12, #212]
	ldr	r2, [r14, #104]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([24-27], 52) blocks
	ldr	r4, [r12, #208]
	ldr	r3, [r14, #108]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([25-28], 51) blocks
	ldr	r5, [r12, #204]
	ldr	r4, [r14, #112]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([26-29], 50) blocks
	ldr	r1, [r12, #200]
	ldr	r5, [r14, #116]
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
	// ([27-30], 49) blocks
	ldr	r2, [r12, #196]
	ldr	r1, [r14, #120]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([28-31], 48) blocks
	ldr	r3, [r12, #192]
	ldr	r2, [r14, #124]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([29-32], 47) blocks
	ldr	r4, [r12, #188]
	ldr	r3, [r14, #128]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([30-33], 46) blocks
	ldr	r5, [r12, #184]
	ldr	r4, [r14, #132]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([31-34], 45) blocks
	ldr	r1, [r12, #180]
	ldr	r5, [r14, #136]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([32-35], 44) blocks
	ldr	r2, [r12, #176]
	ldr	r1, [r14, #140]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([33-36], 43) blocks
	ldr	r3, [r12, #172]
	ldr	r2, [r14, #144]
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
	// ([41-44], 35) blocks
	ldr	r1, [r12, #140]
	ldr	r5, [r14, #176]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([42-45], 34) blocks
	ldr	r2, [r12, #136]
	ldr	r1, [r14, #180]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([43-46], 33) blocks
	ldr	r3, [r12, #132]
	ldr	r2, [r14, #184]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([44-47], 32) blocks
	ldr	r4, [r12, #128]
	ldr	r3, [r14, #188]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([45-48], 31) blocks
	ldr	r5, [r12, #124]
	ldr	r4, [r14, #192]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([46-49], 30) blocks
	ldr	r1, [r12, #120]
	ldr	r5, [r14, #196]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([47-50], 29) blocks
	ldr	r2, [r12, #116]
	ldr	r1, [r14, #200]
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
	// ([48-51], 28) blocks
	ldr	r3, [r12, #112]
	ldr	r2, [r14, #204]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([49-52], 27) blocks
	ldr	r4, [r12, #108]
	ldr	r3, [r14, #208]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([50-53], 26) blocks
	ldr	r5, [r12, #104]
	ldr	r4, [r14, #212]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([51-54], 25) blocks
	ldr	r1, [r12, #100]
	ldr	r5, [r14, #216]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([52-55], 24) blocks
	ldr	r2, [r12, #96]
	ldr	r1, [r14, #220]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([53-55],23),([54-55],22),(55,21) blocks
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
	ldr	r2, [r12, #92]
	umlal	r9, r10, r1, r2
	umlal	r8, r9, r5, r2
	umlal	r7, r8, r4, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	ldr	r2, [r12, #88]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
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
	ldr	r2, [r12, #84]
	umlal	r7, r8, r1, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([25-28], 55) blocks
	ldr	r5, [r12, #220]
	ldr	r4, [r14, #112]
	ldr	r3, [r14, #108]
	ldr	r2, [r14, #104]
	ldr	r1, [r14, #100]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([26-29], 54) blocks
	ldr	r1, [r12, #216]
	ldr	r5, [r14, #116]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([27-30], 53) blocks
	ldr	r2, [r12, #212]
	ldr	r1, [r14, #120]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([28-31], 52) blocks
	ldr	r3, [r12, #208]
	ldr	r2, [r14, #124]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([29-32], 51) blocks
	ldr	r4, [r12, #204]
	ldr	r3, [r14, #128]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([30-33], 50) blocks
	ldr	r5, [r12, #200]
	ldr	r4, [r14, #132]
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
	// ([31-34], 49) blocks
	ldr	r1, [r12, #196]
	ldr	r5, [r14, #136]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([32-35], 48) blocks
	ldr	r2, [r12, #192]
	ldr	r1, [r14, #140]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([33-36], 47) blocks
	ldr	r3, [r12, #188]
	ldr	r2, [r14, #144]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([34-37], 46) blocks
	ldr	r4, [r12, #184]
	ldr	r3, [r14, #148]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([35-38], 45) blocks
	ldr	r5, [r12, #180]
	ldr	r4, [r14, #152]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([36-39], 44) blocks
	ldr	r1, [r12, #176]
	ldr	r5, [r14, #156]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([37-40], 43) blocks
	ldr	r2, [r12, #172]
	ldr	r1, [r14, #160]
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
	// ([41-44], 39) blocks
	ldr	r1, [r12, #156]
	ldr	r5, [r14, #176]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([42-45], 38) blocks
	ldr	r2, [r12, #152]
	ldr	r1, [r14, #180]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([43-46], 37) blocks
	ldr	r3, [r12, #148]
	ldr	r2, [r14, #184]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([44-47], 36) blocks
	ldr	r4, [r12, #144]
	ldr	r3, [r14, #188]
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
	// ([45-48], 35) blocks
	ldr	r5, [r12, #140]
	ldr	r4, [r14, #192]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([46-49], 34) blocks
	ldr	r1, [r12, #136]
	ldr	r5, [r14, #196]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([47-50], 33) blocks
	ldr	r2, [r12, #132]
	ldr	r1, [r14, #200]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([48-51], 32) blocks
	ldr	r3, [r12, #128]
	ldr	r2, [r14, #204]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([49-52], 31) blocks
	ldr	r4, [r12, #124]
	ldr	r3, [r14, #208]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([50-53], 30) blocks
	ldr	r5, [r12, #120]
	ldr	r4, [r14, #212]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([51-54], 29) blocks
	ldr	r1, [r12, #116]
	ldr	r5, [r14, #216]
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
	// ([52-55], 28) blocks
	ldr	r2, [r12, #112]
	ldr	r1, [r14, #220]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([53-55],27),([54-55],26),(55,25) blocks
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
	ldr	r2, [r12, #108]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
	umlal	r6, r7, r4, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #104]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #100]
	umlal	r6, r7, r1, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([29-32], 55) blocks
	ldr	r4, [r12, #220]
	ldr	r3, [r14, #128]
	ldr	r2, [r14, #124]
	ldr	r1, [r14, #120]
	ldr	r5, [r14, #116]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([30-33], 54) blocks
	ldr	r5, [r12, #216]
	ldr	r4, [r14, #132]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([31-34], 53) blocks
	ldr	r1, [r12, #212]
	ldr	r5, [r14, #136]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([32-35], 52) blocks
	ldr	r2, [r12, #208]
	ldr	r1, [r14, #140]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([33-36], 51) blocks
	ldr	r3, [r12, #204]
	ldr	r2, [r14, #144]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([34-37], 50) blocks
	ldr	r4, [r12, #200]
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
	// ([35-38], 49) blocks
	ldr	r5, [r12, #196]
	ldr	r4, [r14, #152]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([36-39], 48) blocks
	ldr	r1, [r12, #192]
	ldr	r5, [r14, #156]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([37-40], 47) blocks
	ldr	r2, [r12, #188]
	ldr	r1, [r14, #160]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([38-41], 46) blocks
	ldr	r3, [r12, #184]
	ldr	r2, [r14, #164]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([39-42], 45) blocks
	ldr	r4, [r12, #180]
	ldr	r3, [r14, #168]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([40-43], 44) blocks
	ldr	r5, [r12, #176]
	ldr	r4, [r14, #172]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([41-44], 43) blocks
	ldr	r1, [r12, #172]
	ldr	r5, [r14, #176]
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
	// ([42-45], 42) blocks
	ldr	r2, [r12, #168]
	ldr	r1, [r14, #180]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([43-46], 41) blocks
	ldr	r3, [r12, #164]
	ldr	r2, [r14, #184]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([44-47], 40) blocks
	ldr	r4, [r12, #160]
	ldr	r3, [r14, #188]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([45-48], 39) blocks
	ldr	r5, [r12, #156]
	ldr	r4, [r14, #192]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([46-49], 38) blocks
	ldr	r1, [r12, #152]
	ldr	r5, [r14, #196]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([47-50], 37) blocks
	ldr	r2, [r12, #148]
	ldr	r1, [r14, #200]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([48-51], 36) blocks
	ldr	r3, [r12, #144]
	ldr	r2, [r14, #204]
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
	// ([49-52], 35) blocks
	ldr	r4, [r12, #140]
	ldr	r3, [r14, #208]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([50-53], 34) blocks
	ldr	r5, [r12, #136]
	ldr	r4, [r14, #212]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([51-54], 33) blocks
	ldr	r1, [r12, #132]
	ldr	r5, [r14, #216]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([52-55], 32) blocks
	ldr	r2, [r12, #128]
	ldr	r1, [r14, #220]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([53-55],31),([54-55],30),(55,29) blocks
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
	ldr	r2, [r12, #124]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
	umlal	r10, r6, r4, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #120]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	ldr	r2, [r12, #116]
	umlal	r10, r6, r1, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	// ([33-36], 55) blocks
	ldr	r3, [r12, #220]
	ldr	r2, [r14, #144]
	ldr	r1, [r14, #140]
	ldr	r5, [r14, #136]
	ldr	r4, [r14, #132]
	umull	r10, r6, r5, r3
	umull	r7, r8, r2, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r1, r3
	// ([34-37], 54) blocks
	ldr	r4, [r12, #216]
	ldr	r3, [r14, #148]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([35-38], 53) blocks
	ldr	r5, [r12, #212]
	ldr	r4, [r14, #152]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([36-39], 52) blocks
	ldr	r1, [r12, #208]
	ldr	r5, [r14, #156]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([37-40], 51) blocks
	ldr	r2, [r12, #204]
	ldr	r1, [r14, #160]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([38-41], 50) blocks
	ldr	r3, [r12, #200]
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
	// ([39-42], 49) blocks
	ldr	r4, [r12, #196]
	ldr	r3, [r14, #168]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([40-43], 48) blocks
	ldr	r5, [r12, #192]
	ldr	r4, [r14, #172]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([41-44], 47) blocks
	ldr	r1, [r12, #188]
	ldr	r5, [r14, #176]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([42-45], 46) blocks
	ldr	r2, [r12, #184]
	ldr	r1, [r14, #180]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([43-46], 45) blocks
	ldr	r3, [r12, #180]
	ldr	r2, [r14, #184]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([44-47], 44) blocks
	ldr	r4, [r12, #176]
	ldr	r3, [r14, #188]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([45-48], 43) blocks
	ldr	r5, [r12, #172]
	ldr	r4, [r14, #192]
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
	// ([46-49], 42) blocks
	ldr	r1, [r12, #168]
	ldr	r5, [r14, #196]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([47-50], 41) blocks
	ldr	r2, [r12, #164]
	ldr	r1, [r14, #200]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([48-51], 40) blocks
	ldr	r3, [r12, #160]
	ldr	r2, [r14, #204]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([49-52], 39) blocks
	ldr	r4, [r12, #156]
	ldr	r3, [r14, #208]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([50-53], 38) blocks
	ldr	r5, [r12, #152]
	ldr	r4, [r14, #212]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([51-54], 37) blocks
	ldr	r1, [r12, #148]
	ldr	r5, [r14, #216]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([52-55], 36) blocks
	ldr	r2, [r12, #144]
	ldr	r1, [r14, #220]
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
	// ([53-55],35),([54-55],34),(55,33) blocks
	ldr	r2, [r12, #140]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
	umlal	r9, r10, r4, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	ldr	r2, [r12, #136]
	umlal	r10, r6, r1, r2
	umlal	r9, r10, r5, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	ldr	r2, [r12, #132]
	umlal	r9, r10, r1, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([37-40], 55) blocks
	ldr	r2, [r12, #220]
	ldr	r1, [r14, #160]
	ldr	r5, [r14, #156]
	ldr	r4, [r14, #152]
	ldr	r3, [r14, #148]
	umull	r9, r10, r4, r2
	umull	r6, r7, r1, r2
	umlal	r8, r9, r3, r2
	umlal	r10, r6, r5, r2
	// ([38-41], 54) blocks
	ldr	r3, [r12, #216]
	ldr	r2, [r14, #164]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([39-42], 53) blocks
	ldr	r4, [r12, #212]
	ldr	r3, [r14, #168]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([40-43], 52) blocks
	ldr	r5, [r12, #208]
	ldr	r4, [r14, #172]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([41-44], 51) blocks
	ldr	r1, [r12, #204]
	ldr	r5, [r14, #176]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([42-45], 50) blocks
	ldr	r2, [r12, #200]
	ldr	r1, [r14, #180]
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
	// ([43-46], 49) blocks
	ldr	r3, [r12, #196]
	ldr	r2, [r14, #184]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([44-47], 48) blocks
	ldr	r4, [r12, #192]
	ldr	r3, [r14, #188]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([45-48], 47) blocks
	ldr	r5, [r12, #188]
	ldr	r4, [r14, #192]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([46-49], 46) blocks
	ldr	r1, [r12, #184]
	ldr	r5, [r14, #196]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([47-50], 45) blocks
	ldr	r2, [r12, #180]
	ldr	r1, [r14, #200]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([48-51], 44) blocks
	ldr	r3, [r12, #176]
	ldr	r2, [r14, #204]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([49-52], 43) blocks
	ldr	r4, [r12, #172]
	ldr	r3, [r14, #208]
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
	// ([50-53], 42) blocks
	ldr	r5, [r12, #168]
	ldr	r4, [r14, #212]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([51-54], 41) blocks
	ldr	r1, [r12, #164]
	ldr	r5, [r14, #216]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([52-55], 40) blocks
	ldr	r2, [r12, #160]
	ldr	r1, [r14, #220]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([53-55],39),([54-55],38),(55,37) blocks
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
	ldr	r2, [r12, #156]
	umlal	r10, r6, r1, r2
	umlal	r9, r10, r5, r2
	umlal	r8, r9, r4, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	ldr	r2, [r12, #152]
	umlal	r9, r10, r1, r2
	umlal	r8, r9, r5, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	ldr	r2, [r12, #148]
	umlal	r8, r9, r1, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([41-44], 55) blocks
	ldr	r1, [r12, #220]
	ldr	r5, [r14, #176]
	ldr	r4, [r14, #172]
	ldr	r3, [r14, #168]
	ldr	r2, [r14, #164]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([42-45], 54) blocks
	ldr	r2, [r12, #216]
	ldr	r1, [r14, #180]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([43-46], 53) blocks
	ldr	r3, [r12, #212]
	ldr	r2, [r14, #184]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([44-47], 52) blocks
	ldr	r4, [r12, #208]
	ldr	r3, [r14, #188]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([45-48], 51) blocks
	ldr	r5, [r12, #204]
	ldr	r4, [r14, #192]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([46-49], 50) blocks
	ldr	r1, [r12, #200]
	ldr	r5, [r14, #196]
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
	// ([47-50], 49) blocks
	ldr	r2, [r12, #196]
	ldr	r1, [r14, #200]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([48-51], 48) blocks
	ldr	r3, [r12, #192]
	ldr	r2, [r14, #204]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([49-52], 47) blocks
	ldr	r4, [r12, #188]
	ldr	r3, [r14, #208]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([50-53], 46) blocks
	ldr	r5, [r12, #184]
	ldr	r4, [r14, #212]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([51-54], 45) blocks
	ldr	r1, [r12, #180]
	ldr	r5, [r14, #216]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([52-55], 44) blocks
	ldr	r2, [r12, #176]
	ldr	r1, [r14, #220]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([53-55],43),([54-55],42),(55,41) blocks
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
	ldr	r2, [r12, #172]
	umlal	r9, r10, r1, r2
	umlal	r8, r9, r5, r2
	umlal	r7, r8, r4, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
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
	ldr	r2, [r12, #168]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #164]
	umlal	r7, r8, r1, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([45-48], 55) blocks
	ldr	r5, [r12, #220]
	ldr	r4, [r14, #192]
	ldr	r3, [r14, #188]
	ldr	r2, [r14, #184]
	ldr	r1, [r14, #180]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([46-49], 54) blocks
	ldr	r1, [r12, #216]
	ldr	r5, [r14, #196]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([47-50], 53) blocks
	ldr	r2, [r12, #212]
	ldr	r1, [r14, #200]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([48-51], 52) blocks
	ldr	r3, [r12, #208]
	ldr	r2, [r14, #204]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([49-52], 51) blocks
	ldr	r4, [r12, #204]
	ldr	r3, [r14, #208]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([50-53], 50) blocks
	ldr	r5, [r12, #200]
	ldr	r4, [r14, #212]
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
	// ([51-54], 49) blocks
	ldr	r1, [r12, #196]
	ldr	r5, [r14, #216]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([52-55], 48) blocks
	ldr	r2, [r12, #192]
	ldr	r1, [r14, #220]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([53-55],47),([54-55],46),(55,45) blocks
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
	ldr	r2, [r12, #188]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
	umlal	r6, r7, r4, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #184]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #180]
	umlal	r6, r7, r1, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([49-52], 55) blocks
	ldr	r4, [r12, #220]
	ldr	r3, [r14, #208]
	ldr	r2, [r14, #204]
	ldr	r1, [r14, #200]
	ldr	r5, [r14, #196]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([50-53], 54) blocks
	ldr	r5, [r12, #216]
	ldr	r4, [r14, #212]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([51-54], 53) blocks
	ldr	r1, [r12, #212]
	ldr	r5, [r14, #216]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([52-55], 52) blocks
	ldr	r2, [r12, #208]
	ldr	r1, [r14, #220]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([53-55],51),([54-55],50),(55,49) blocks
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
	ldr	r2, [r12, #204]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
	umlal	r10, r6, r4, r2
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
	bic	r2, r8, r11		// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	bic	r2, r8, r11		// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #200]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
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
	ldr	r2, [r12, #196]
	umlal	r10, r6, r1, r2
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
sch3_20:			// mv hh back to h
	mov	r10, #0
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	ldr	r4, [r14, #212]
	ldr	r5, [r14, #216]
	ldr	r1, [r14, #220]
	// ([53-55],55),([54-55],54),(55,53) blocks
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
	ldr	r2, [r12, #220]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
	umlal	r9, r10, r4, r2
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
	bic	r2, r7, r11		// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	bic	r2, r7, r11		// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	ldr	r2, [r12, #216]
	umlal	r10, r6, r1, r2
	umlal	r9, r10, r5, r2
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
	bic	r2, r6, r11		// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	bic	r2, r6, r11		// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	ldr	r2, [r12, #212]
	umlal	r9, r10, r1, r2
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
	bic	r2, r9, r11		// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	bic	r2, r9, r11		// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
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
	bic	r2, r10, r11		// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	bic	r2, r10, r11		// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	pop	{r4-r11,lr}
	bx	lr
