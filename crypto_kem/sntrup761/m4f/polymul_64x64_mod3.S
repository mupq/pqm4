
// void gf_polymul_64x64_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_64x64_mod3
	.type	gf_polymul_64x64_mod3, %function
gf_polymul_64x64_mod3:
	push	{r4-r11,lr}
sch3_0:			// increasing thread length
	mov	r6, #0
	mov	r12, r1
	mov	r14, r2
	mov	r11, #0x03030303
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
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	and	r5, r6, #0x1C1C1C1C	// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	ldr	r5, [r12, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	and	r5, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	ldr	r5, [r12, #8]
	umlal	r9, r10, r2, r5
	umlal	r8, r9, r1, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	and	r5, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	ldr	r5, [r12, #12]
	umlal	r9, r10, r1, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	and	r5, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
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
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	and	r5, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	ldr	r5, [r12, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	and	r5, r6, #0x1C1C1C1C	// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	ldr	r5, [r12, #24]
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	and	r5, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	ldr	r5, [r12, #28]
	umlal	r8, r9, r1, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	and	r5, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
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
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	and	r5, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	ldr	r5, [r12, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	and	r5, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	ldr	r5, [r12, #40]
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	and	r5, r6, #0x1C1C1C1C	// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	ldr	r5, [r12, #44]
	umlal	r7, r8, r1, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	and	r5, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	and	r5, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	ldr	r5, [r12, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
	umlal	r9, r10, r1, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	and	r5, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr	r5, [r12, #56]
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	and	r5, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	ldr	r5, [r12, #60]
	umlal	r6, r7, r1, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=10
	and	r5, r6, #0x1C1C1C1C	// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r5, LSR #2	// range <=5
	usub8	r5, r6, r11		// >= 3 ?
	sel	r6, r5, r6		// select
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
sch3_10:			// decreasing thread length
	// ([1-4], 15) blocks
	ldr	r1, [r12, #60]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([2-5], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r1, [r14, #20]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([3-6], 13) blocks
	ldr	r3, [r12, #52]
	ldr	r2, [r14, #24]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([4-7], 12) blocks
	ldr	r4, [r12, #48]
	ldr	r3, [r14, #28]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([5-8], 11) blocks
	ldr	r5, [r12, #44]
	ldr	r4, [r14, #32]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([6-9], 10) blocks
	ldr	r1, [r12, #40]
	ldr	r5, [r14, #36]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([7-10], 9) blocks
	ldr	r2, [r12, #36]
	ldr	r1, [r14, #40]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([8-11], 8) blocks
	ldr	r3, [r12, #32]
	ldr	r2, [r14, #44]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([9-12], 7) blocks
	ldr	r4, [r12, #28]
	ldr	r3, [r14, #48]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([10-13], 6) blocks
	ldr	r5, [r12, #24]
	ldr	r4, [r14, #52]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([11-14], 5) blocks
	ldr	r1, [r12, #20]
	ldr	r5, [r14, #56]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([12-15], 4) blocks
	ldr	r2, [r12, #16]
	ldr	r1, [r14, #60]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([13-15],3),([14-15],2),(15,1) blocks
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	ldr	r2, [r12, #12]
	umlal	r9, r10, r1, r2
	umlal	r8, r9, r5, r2
	umlal	r7, r8, r4, r2
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	and	r2, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	ldr	r2, [r12, #8]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	and	r2, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #4]
	umlal	r7, r8, r1, r2
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	and	r2, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	and	r2, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([5-8], 15) blocks
	ldr	r5, [r12, #60]
	ldr	r4, [r14, #32]
	ldr	r3, [r14, #28]
	ldr	r2, [r14, #24]
	ldr	r1, [r14, #20]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([6-9], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r5, [r14, #36]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([7-10], 13) blocks
	ldr	r2, [r12, #52]
	ldr	r1, [r14, #40]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([8-11], 12) blocks
	ldr	r3, [r12, #48]
	ldr	r2, [r14, #44]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([9-12], 11) blocks
	ldr	r4, [r12, #44]
	ldr	r3, [r14, #48]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([10-13], 10) blocks
	ldr	r5, [r12, #40]
	ldr	r4, [r14, #52]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([11-14], 9) blocks
	ldr	r1, [r12, #36]
	ldr	r5, [r14, #56]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([12-15], 8) blocks
	ldr	r2, [r12, #32]
	ldr	r1, [r14, #60]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([13-15],7),([14-15],6),(15,5) blocks
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	ldr	r2, [r12, #28]
	umlal	r8, r9, r1, r2
	umlal	r7, r8, r5, r2
	umlal	r6, r7, r4, r2
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	and	r2, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	ldr	r2, [r12, #24]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	and	r2, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #20]
	umlal	r6, r7, r1, r2
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	and	r2, r6, #0x1C1C1C1C	// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	and	r2, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([9-12], 15) blocks
	ldr	r4, [r12, #60]
	ldr	r3, [r14, #48]
	ldr	r2, [r14, #44]
	ldr	r1, [r14, #40]
	ldr	r5, [r14, #36]
	umull	r6, r7, r1, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r2, r4
	// ([10-13], 14) blocks
	ldr	r5, [r12, #56]
	ldr	r4, [r14, #52]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([11-14], 13) blocks
	ldr	r1, [r12, #52]
	ldr	r5, [r14, #56]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([12-15], 12) blocks
	ldr	r2, [r12, #48]
	ldr	r1, [r14, #60]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([13-15],11),([14-15],10),(15,9) blocks
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	ldr	r2, [r12, #44]
	umlal	r7, r8, r1, r2
	umlal	r6, r7, r5, r2
	umlal	r10, r6, r4, r2
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=10
	and	r2, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r2, LSR #2	// range <=5
	usub8	r2, r8, r11		// >= 3 ?
	sel	r8, r2, r8		// select
	ldr	r2, [r12, #40]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	and	r2, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	ldr	r2, [r12, #36]
	umlal	r10, r6, r1, r2
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	and	r2, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=5
	usub8	r2, r10, r11		// >= 3 ?
	sel	r10, r2, r10		// select
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	and	r2, r6, #0x1C1C1C1C	// top 3b < 3
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
	ldr	r4, [r14, #52]
	ldr	r5, [r14, #56]
	ldr	r1, [r14, #60]
	// ([13-15],15),([14-15],14),(15,13) blocks
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	ldr	r2, [r12, #60]
	umlal	r6, r7, r1, r2
	umlal	r10, r6, r5, r2
	umlal	r9, r10, r4, r2
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=10
	and	r2, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r2, LSR #2	// range <=5
	usub8	r2, r7, r11		// >= 3 ?
	sel	r7, r2, r7		// select
	ldr	r2, [r12, #56]
	umlal	r10, r6, r1, r2
	umlal	r9, r10, r5, r2
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r6, #0x1C1C1C1C	// top 3b < 8
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=10
	and	r2, r6, #0x1C1C1C1C	// top 3b < 3
	and	r6, r6, r11		// bot 2b < 4
	add	r6, r6, r2, LSR #2	// range <=5
	usub8	r2, r6, r11		// >= 3 ?
	sel	r6, r2, r6		// select
	ldr	r2, [r12, #52]
	umlal	r9, r10, r1, r2
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=10
	and	r2, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r2, LSR #2	// range <=5
	usub8	r2, r9, r11		// >= 3 ?
	sel	r9, r2, r9		// select
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r2, LSR #2	// range <=10
	and	r2, r10, #0x1C1C1C1C	// top 3b < 3
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
