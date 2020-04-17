
// void gf_polymul_256x256_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_256x256_mod3
	.type	gf_polymul_256x256_mod3, %function
gf_polymul_256x256_mod3:
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
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
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
	ldr	r5, [r12, #68]
	umlal	r10, r6, r3, r5
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
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr	r5, [r12, #72]
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
	ldr	r5, [r12, #76]
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
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
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
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
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
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
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
	// ([0-2],21), ([0-1],22), (0,23) blocks
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
	ldr	r5, [r12, #84]
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
	ldr	r5, [r12, #88]
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
	ldr	r5, [r12, #92]
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
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
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
	ldr	r5, [r12, #100]
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
	ldr	r5, [r12, #104]
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
	ldr	r5, [r12, #108]
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
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
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
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	// ([0-3], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r1, [r14, #0]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([0-2],29), ([0-1],30), (0,31) blocks
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
	ldr	r5, [r12, #116]
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
	ldr	r5, [r12, #120]
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
	ldr	r5, [r12, #124]
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
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
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
	ldr	r5, [r12, #132]
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
	ldr	r5, [r12, #136]
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
	ldr	r5, [r12, #140]
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
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
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
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
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
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
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
	// ([1-4], 35) blocks
	ldr	r1, [r12, #140]
	ldr	r2, [r14, #4]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	// ([0-3], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r1, [r14, #0]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([0-2],37), ([0-1],38), (0,39) blocks
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
	ldr	r5, [r12, #148]
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #152]
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
	ldr	r5, [r12, #156]
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
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
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
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
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
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
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
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
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
	// ([5-8], 35) blocks
	ldr	r5, [r12, #140]
	ldr	r1, [r14, #20]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
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
	ldr	r5, [r12, #164]
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr	r5, [r12, #168]
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
	ldr	r5, [r12, #172]
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
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
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
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
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
	// ([9-12], 35) blocks
	ldr	r4, [r12, #140]
	ldr	r5, [r14, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
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
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
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
	ldr	r5, [r12, #180]
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
	ldr	r5, [r12, #184]
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
	ldr	r5, [r12, #188]
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
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
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
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
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
	// ([13-16], 35) blocks
	ldr	r3, [r12, #140]
	ldr	r4, [r14, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
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
	// ([0-2],49), ([0-1],50), (0,51) blocks
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
	ldr	r5, [r12, #196]
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
	ldr	r5, [r12, #200]
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
	ldr	r5, [r12, #204]
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
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
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
	// ([17-20], 35) blocks
	ldr	r2, [r12, #140]
	ldr	r3, [r14, #68]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
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
	ldr	r5, [r12, #212]
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr	r5, [r12, #216]
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
	ldr	r5, [r12, #220]
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
	// ([56-59], 0) blocks
	ldr	r1, [r12]
	ldr	r5, [r14, #236]
	ldr	r4, [r14, #232]
	ldr	r3, [r14, #228]
	ldr	r2, [r14, #224]
	umull	r8, r9, r3, r1
	umull	r10, r6, r5, r1
	umlal	r7, r8, r2, r1
	umlal	r9, r10, r4, r1
	// ([55-58], 1) blocks
	ldr	r5, [r12, #4]
	ldr	r1, [r14, #220]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([54-57], 2) blocks
	ldr	r4, [r12, #8]
	ldr	r5, [r14, #216]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([53-56], 3) blocks
	ldr	r3, [r12, #12]
	ldr	r4, [r14, #212]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([52-55], 4) blocks
	ldr	r2, [r12, #16]
	ldr	r3, [r14, #208]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([51-54], 5) blocks
	ldr	r1, [r12, #20]
	ldr	r2, [r14, #204]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([50-53], 6) blocks
	ldr	r5, [r12, #24]
	ldr	r1, [r14, #200]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([49-52], 7) blocks
	ldr	r4, [r12, #28]
	ldr	r5, [r14, #196]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([48-51], 8) blocks
	ldr	r3, [r12, #32]
	ldr	r4, [r14, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([47-50], 9) blocks
	ldr	r2, [r12, #36]
	ldr	r3, [r14, #188]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([46-49], 10) blocks
	ldr	r1, [r12, #40]
	ldr	r2, [r14, #184]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([45-48], 11) blocks
	ldr	r5, [r12, #44]
	ldr	r1, [r14, #180]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([44-47], 12) blocks
	ldr	r4, [r12, #48]
	ldr	r5, [r14, #176]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([43-46], 13) blocks
	ldr	r3, [r12, #52]
	ldr	r4, [r14, #172]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	// ([42-45], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r3, [r14, #168]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([41-44], 15) blocks
	ldr	r1, [r12, #60]
	ldr	r2, [r14, #164]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([40-43], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r1, [r14, #160]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([39-42], 17) blocks
	ldr	r4, [r12, #68]
	ldr	r5, [r14, #156]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	// ([38-41], 18) blocks
	ldr	r3, [r12, #72]
	ldr	r4, [r14, #152]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([37-40], 19) blocks
	ldr	r2, [r12, #76]
	ldr	r3, [r14, #148]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([36-39], 20) blocks
	ldr	r1, [r12, #80]
	ldr	r2, [r14, #144]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([35-38], 21) blocks
	ldr	r5, [r12, #84]
	ldr	r1, [r14, #140]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([34-37], 22) blocks
	ldr	r4, [r12, #88]
	ldr	r5, [r14, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([33-36], 23) blocks
	ldr	r3, [r12, #92]
	ldr	r4, [r14, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([32-35], 24) blocks
	ldr	r2, [r12, #96]
	ldr	r3, [r14, #128]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([31-34], 25) blocks
	ldr	r1, [r12, #100]
	ldr	r2, [r14, #124]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([30-33], 26) blocks
	ldr	r5, [r12, #104]
	ldr	r1, [r14, #120]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([29-32], 27) blocks
	ldr	r4, [r12, #108]
	ldr	r5, [r14, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	// ([28-31], 28) blocks
	ldr	r3, [r12, #112]
	ldr	r4, [r14, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([27-30], 29) blocks
	ldr	r2, [r12, #116]
	ldr	r3, [r14, #108]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([26-29], 30) blocks
	ldr	r1, [r12, #120]
	ldr	r2, [r14, #104]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([25-28], 31) blocks
	ldr	r5, [r12, #124]
	ldr	r1, [r14, #100]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([24-27], 32) blocks
	ldr	r4, [r12, #128]
	ldr	r5, [r14, #96]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([23-26], 33) blocks
	ldr	r3, [r12, #132]
	ldr	r4, [r14, #92]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([22-25], 34) blocks
	ldr	r2, [r12, #136]
	ldr	r3, [r14, #88]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([21-24], 35) blocks
	ldr	r1, [r12, #140]
	ldr	r2, [r14, #84]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	// ([20-23], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r1, [r14, #80]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([19-22], 37) blocks
	ldr	r4, [r12, #148]
	ldr	r5, [r14, #76]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([18-21], 38) blocks
	ldr	r3, [r12, #152]
	ldr	r4, [r14, #72]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([17-20], 39) blocks
	ldr	r2, [r12, #156]
	ldr	r3, [r14, #68]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([16-19], 40) blocks
	ldr	r1, [r12, #160]
	ldr	r2, [r14, #64]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([15-18], 41) blocks
	ldr	r5, [r12, #164]
	ldr	r1, [r14, #60]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([14-17], 42) blocks
	ldr	r4, [r12, #168]
	ldr	r5, [r14, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([13-16], 43) blocks
	ldr	r3, [r12, #172]
	ldr	r4, [r14, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([12-15], 44) blocks
	ldr	r2, [r12, #176]
	ldr	r3, [r14, #48]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([11-14], 45) blocks
	ldr	r1, [r12, #180]
	ldr	r2, [r14, #44]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([10-13], 46) blocks
	ldr	r5, [r12, #184]
	ldr	r1, [r14, #40]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([9-12], 47) blocks
	ldr	r4, [r12, #188]
	ldr	r5, [r14, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([8-11], 48) blocks
	ldr	r3, [r12, #192]
	ldr	r4, [r14, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([7-10], 49) blocks
	ldr	r2, [r12, #196]
	ldr	r3, [r14, #28]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([6-9], 50) blocks
	ldr	r1, [r12, #200]
	ldr	r2, [r14, #24]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([5-8], 51) blocks
	ldr	r5, [r12, #204]
	ldr	r1, [r14, #20]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([4-7], 52) blocks
	ldr	r4, [r12, #208]
	ldr	r5, [r14, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([3-6], 53) blocks
	ldr	r3, [r12, #212]
	ldr	r4, [r14, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([2-5], 54) blocks
	ldr	r2, [r12, #216]
	ldr	r3, [r14, #8]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([1-4], 55) blocks
	ldr	r1, [r12, #220]
	ldr	r2, [r14, #4]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	// ([0-3], 56) blocks
	ldr	r5, [r12, #224]
	ldr	r1, [r14, #0]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([0-2],57), ([0-1],58), (0,59) blocks
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
	ldr	r5, [r12, #228]
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #232]
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
	ldr	r5, [r12, #236]
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
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([60-63], 0) blocks
	ldr	r5, [r12]
	ldr	r4, [r14, #252]
	ldr	r3, [r14, #248]
	ldr	r2, [r14, #244]
	ldr	r1, [r14, #240]
	umull	r7, r8, r2, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r1, r5
	umlal	r8, r9, r3, r5
	// ([59-62], 1) blocks
	ldr	r4, [r12, #4]
	ldr	r5, [r14, #236]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([58-61], 2) blocks
	ldr	r3, [r12, #8]
	ldr	r4, [r14, #232]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([57-60], 3) blocks
	ldr	r2, [r12, #12]
	ldr	r3, [r14, #228]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([56-59], 4) blocks
	ldr	r1, [r12, #16]
	ldr	r2, [r14, #224]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([55-58], 5) blocks
	ldr	r5, [r12, #20]
	ldr	r1, [r14, #220]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([54-57], 6) blocks
	ldr	r4, [r12, #24]
	ldr	r5, [r14, #216]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([53-56], 7) blocks
	ldr	r3, [r12, #28]
	ldr	r4, [r14, #212]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([52-55], 8) blocks
	ldr	r2, [r12, #32]
	ldr	r3, [r14, #208]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([51-54], 9) blocks
	ldr	r1, [r12, #36]
	ldr	r2, [r14, #204]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([50-53], 10) blocks
	ldr	r5, [r12, #40]
	ldr	r1, [r14, #200]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([49-52], 11) blocks
	ldr	r4, [r12, #44]
	ldr	r5, [r14, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([48-51], 12) blocks
	ldr	r3, [r12, #48]
	ldr	r4, [r14, #192]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([47-50], 13) blocks
	ldr	r2, [r12, #52]
	ldr	r3, [r14, #188]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	// ([46-49], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r2, [r14, #184]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([45-48], 15) blocks
	ldr	r5, [r12, #60]
	ldr	r1, [r14, #180]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([44-47], 16) blocks
	ldr	r4, [r12, #64]
	ldr	r5, [r14, #176]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([43-46], 17) blocks
	ldr	r3, [r12, #68]
	ldr	r4, [r14, #172]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	// ([42-45], 18) blocks
	ldr	r2, [r12, #72]
	ldr	r3, [r14, #168]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([41-44], 19) blocks
	ldr	r1, [r12, #76]
	ldr	r2, [r14, #164]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([40-43], 20) blocks
	ldr	r5, [r12, #80]
	ldr	r1, [r14, #160]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([39-42], 21) blocks
	ldr	r4, [r12, #84]
	ldr	r5, [r14, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([38-41], 22) blocks
	ldr	r3, [r12, #88]
	ldr	r4, [r14, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([37-40], 23) blocks
	ldr	r2, [r12, #92]
	ldr	r3, [r14, #148]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([36-39], 24) blocks
	ldr	r1, [r12, #96]
	ldr	r2, [r14, #144]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([35-38], 25) blocks
	ldr	r5, [r12, #100]
	ldr	r1, [r14, #140]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([34-37], 26) blocks
	ldr	r4, [r12, #104]
	ldr	r5, [r14, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([33-36], 27) blocks
	ldr	r3, [r12, #108]
	ldr	r4, [r14, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	// ([32-35], 28) blocks
	ldr	r2, [r12, #112]
	ldr	r3, [r14, #128]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([31-34], 29) blocks
	ldr	r1, [r12, #116]
	ldr	r2, [r14, #124]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([30-33], 30) blocks
	ldr	r5, [r12, #120]
	ldr	r1, [r14, #120]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([29-32], 31) blocks
	ldr	r4, [r12, #124]
	ldr	r5, [r14, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([28-31], 32) blocks
	ldr	r3, [r12, #128]
	ldr	r4, [r14, #112]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([27-30], 33) blocks
	ldr	r2, [r12, #132]
	ldr	r3, [r14, #108]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([26-29], 34) blocks
	ldr	r1, [r12, #136]
	ldr	r2, [r14, #104]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([25-28], 35) blocks
	ldr	r5, [r12, #140]
	ldr	r1, [r14, #100]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([24-27], 36) blocks
	ldr	r4, [r12, #144]
	ldr	r5, [r14, #96]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([23-26], 37) blocks
	ldr	r3, [r12, #148]
	ldr	r4, [r14, #92]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([22-25], 38) blocks
	ldr	r2, [r12, #152]
	ldr	r3, [r14, #88]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([21-24], 39) blocks
	ldr	r1, [r12, #156]
	ldr	r2, [r14, #84]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([20-23], 40) blocks
	ldr	r5, [r12, #160]
	ldr	r1, [r14, #80]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([19-22], 41) blocks
	ldr	r4, [r12, #164]
	ldr	r5, [r14, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([18-21], 42) blocks
	ldr	r3, [r12, #168]
	ldr	r4, [r14, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([17-20], 43) blocks
	ldr	r2, [r12, #172]
	ldr	r3, [r14, #68]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([16-19], 44) blocks
	ldr	r1, [r12, #176]
	ldr	r2, [r14, #64]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([15-18], 45) blocks
	ldr	r5, [r12, #180]
	ldr	r1, [r14, #60]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([14-17], 46) blocks
	ldr	r4, [r12, #184]
	ldr	r5, [r14, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([13-16], 47) blocks
	ldr	r3, [r12, #188]
	ldr	r4, [r14, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([12-15], 48) blocks
	ldr	r2, [r12, #192]
	ldr	r3, [r14, #48]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([11-14], 49) blocks
	ldr	r1, [r12, #196]
	ldr	r2, [r14, #44]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([10-13], 50) blocks
	ldr	r5, [r12, #200]
	ldr	r1, [r14, #40]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 51) blocks
	ldr	r4, [r12, #204]
	ldr	r5, [r14, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([8-11], 52) blocks
	ldr	r3, [r12, #208]
	ldr	r4, [r14, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([7-10], 53) blocks
	ldr	r2, [r12, #212]
	ldr	r3, [r14, #28]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	// ([6-9], 54) blocks
	ldr	r1, [r12, #216]
	ldr	r2, [r14, #24]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([5-8], 55) blocks
	ldr	r5, [r12, #220]
	ldr	r1, [r14, #20]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	// ([4-7], 56) blocks
	ldr	r4, [r12, #224]
	ldr	r5, [r14, #16]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([3-6], 57) blocks
	ldr	r3, [r12, #228]
	ldr	r4, [r14, #12]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([2-5], 58) blocks
	ldr	r2, [r12, #232]
	ldr	r3, [r14, #8]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([1-4], 59) blocks
	ldr	r1, [r12, #236]
	ldr	r2, [r14, #4]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([0-3], 60) blocks
	ldr	r5, [r12, #240]
	ldr	r1, [r14, #0]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([0-2],61), ([0-1],62), (0,63) blocks
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
	ldr	r5, [r12, #244]
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
	ldr	r5, [r12, #248]
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
	ldr	r5, [r12, #252]
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
sch3_10:			// decreasing thread length
	// ([1-4], 63) blocks
	ldr	r1, [r12, #252]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r6, r7, r3, r1
	umull	r8, r9, r5, r1
	umlal	r10, r6, r2, r1
	umlal	r7, r8, r4, r1
	// ([2-5], 62) blocks
	ldr	r2, [r12, #248]
	ldr	r1, [r14, #20]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([3-6], 61) blocks
	ldr	r3, [r12, #244]
	ldr	r2, [r14, #24]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([4-7], 60) blocks
	ldr	r4, [r12, #240]
	ldr	r3, [r14, #28]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([5-8], 59) blocks
	ldr	r5, [r12, #236]
	ldr	r4, [r14, #32]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([6-9], 58) blocks
	ldr	r1, [r12, #232]
	ldr	r5, [r14, #36]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([7-10], 57) blocks
	ldr	r2, [r12, #228]
	ldr	r1, [r14, #40]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([8-11], 56) blocks
	ldr	r3, [r12, #224]
	ldr	r2, [r14, #44]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([9-12], 55) blocks
	ldr	r4, [r12, #220]
	ldr	r3, [r14, #48]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([14-17], 50) blocks
	ldr	r4, [r12, #200]
	ldr	r3, [r14, #68]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
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
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
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
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
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
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	// ([42-45], 22) blocks
	ldr	r2, [r12, #88]
	ldr	r1, [r14, #180]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
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
	// ([53-56], 11) blocks
	ldr	r3, [r12, #44]
	ldr	r2, [r14, #224]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	// ([54-57], 10) blocks
	ldr	r4, [r12, #40]
	ldr	r3, [r14, #228]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([55-58], 9) blocks
	ldr	r5, [r12, #36]
	ldr	r4, [r14, #232]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	// ([56-59], 8) blocks
	ldr	r1, [r12, #32]
	ldr	r5, [r14, #236]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([57-60], 7) blocks
	ldr	r2, [r12, #28]
	ldr	r1, [r14, #240]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([58-61], 6) blocks
	ldr	r3, [r12, #24]
	ldr	r2, [r14, #244]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([59-62], 5) blocks
	ldr	r4, [r12, #20]
	ldr	r3, [r14, #248]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([60-63], 4) blocks
	ldr	r5, [r12, #16]
	ldr	r4, [r14, #252]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([61-63],3),([62-63],2),(63,1) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr	r5, [r12, #12]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #8]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #4]
	umlal	r10, r6, r4, r5
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
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	// ([5-8], 63) blocks
	ldr	r5, [r12, #252]
	ldr	r4, [r14, #32]
	ldr	r3, [r14, #28]
	ldr	r2, [r14, #24]
	ldr	r1, [r14, #20]
	umull	r10, r6, r2, r5
	umull	r7, r8, r4, r5
	umlal	r9, r10, r1, r5
	umlal	r6, r7, r3, r5
	// ([6-9], 62) blocks
	ldr	r1, [r12, #248]
	ldr	r5, [r14, #36]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([7-10], 61) blocks
	ldr	r2, [r12, #244]
	ldr	r1, [r14, #40]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([8-11], 60) blocks
	ldr	r3, [r12, #240]
	ldr	r2, [r14, #44]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([9-12], 59) blocks
	ldr	r4, [r12, #236]
	ldr	r3, [r14, #48]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([10-13], 58) blocks
	ldr	r5, [r12, #232]
	ldr	r4, [r14, #52]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([11-14], 57) blocks
	ldr	r1, [r12, #228]
	ldr	r5, [r14, #56]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([12-15], 56) blocks
	ldr	r2, [r12, #224]
	ldr	r1, [r14, #60]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([13-16], 55) blocks
	ldr	r3, [r12, #220]
	ldr	r2, [r14, #64]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	// ([18-21], 50) blocks
	ldr	r3, [r12, #200]
	ldr	r2, [r14, #84]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
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
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
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
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
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
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	// ([46-49], 22) blocks
	ldr	r1, [r12, #88]
	ldr	r5, [r14, #196]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
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
	// ([53-56], 15) blocks
	ldr	r3, [r12, #60]
	ldr	r2, [r14, #224]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([54-57], 14) blocks
	ldr	r4, [r12, #56]
	ldr	r3, [r14, #228]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([55-58], 13) blocks
	ldr	r5, [r12, #52]
	ldr	r4, [r14, #232]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([56-59], 12) blocks
	ldr	r1, [r12, #48]
	ldr	r5, [r14, #236]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([57-60], 11) blocks
	ldr	r2, [r12, #44]
	ldr	r1, [r14, #240]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	// ([58-61], 10) blocks
	ldr	r3, [r12, #40]
	ldr	r2, [r14, #244]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([59-62], 9) blocks
	ldr	r4, [r12, #36]
	ldr	r3, [r14, #248]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	// ([60-63], 8) blocks
	ldr	r5, [r12, #32]
	ldr	r4, [r14, #252]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([61-63],7),([62-63],6),(63,5) blocks
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr	r5, [r12, #28]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r2, r5
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
	ldr	r5, [r12, #24]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
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
	ldr	r5, [r12, #20]
	umlal	r9, r10, r4, r5
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
	and	r5, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	and	r5, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([9-12], 63) blocks
	ldr	r4, [r12, #252]
	ldr	r3, [r14, #48]
	ldr	r2, [r14, #44]
	ldr	r1, [r14, #40]
	ldr	r5, [r14, #36]
	umull	r9, r10, r1, r4
	umull	r6, r7, r3, r4
	umlal	r8, r9, r5, r4
	umlal	r10, r6, r2, r4
	// ([10-13], 62) blocks
	ldr	r5, [r12, #248]
	ldr	r4, [r14, #52]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([11-14], 61) blocks
	ldr	r1, [r12, #244]
	ldr	r5, [r14, #56]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([12-15], 60) blocks
	ldr	r2, [r12, #240]
	ldr	r1, [r14, #60]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([13-16], 59) blocks
	ldr	r3, [r12, #236]
	ldr	r2, [r14, #64]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([14-17], 58) blocks
	ldr	r4, [r12, #232]
	ldr	r3, [r14, #68]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([15-18], 57) blocks
	ldr	r5, [r12, #228]
	ldr	r4, [r14, #72]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([16-19], 56) blocks
	ldr	r1, [r12, #224]
	ldr	r5, [r14, #76]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([17-20], 55) blocks
	ldr	r2, [r12, #220]
	ldr	r1, [r14, #80]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	// ([22-25], 50) blocks
	ldr	r2, [r12, #200]
	ldr	r1, [r14, #100]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
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
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
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
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	// ([50-53], 22) blocks
	ldr	r5, [r12, #88]
	ldr	r4, [r14, #212]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
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
	// ([53-56], 19) blocks
	ldr	r3, [r12, #76]
	ldr	r2, [r14, #224]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([54-57], 18) blocks
	ldr	r4, [r12, #72]
	ldr	r3, [r14, #228]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([55-58], 17) blocks
	ldr	r5, [r12, #68]
	ldr	r4, [r14, #232]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([56-59], 16) blocks
	ldr	r1, [r12, #64]
	ldr	r5, [r14, #236]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([57-60], 15) blocks
	ldr	r2, [r12, #60]
	ldr	r1, [r14, #240]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([58-61], 14) blocks
	ldr	r3, [r12, #56]
	ldr	r2, [r14, #244]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([59-62], 13) blocks
	ldr	r4, [r12, #52]
	ldr	r3, [r14, #248]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([60-63], 12) blocks
	ldr	r5, [r12, #48]
	ldr	r4, [r14, #252]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([61-63],11),([62-63],10),(63,9) blocks
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr	r5, [r12, #44]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
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
	ldr	r5, [r12, #40]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
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
	ldr	r5, [r12, #36]
	umlal	r8, r9, r4, r5
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
	and	r5, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	and	r5, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([13-16], 63) blocks
	ldr	r3, [r12, #252]
	ldr	r2, [r14, #64]
	ldr	r1, [r14, #60]
	ldr	r5, [r14, #56]
	ldr	r4, [r14, #52]
	umull	r8, r9, r5, r3
	umull	r10, r6, r2, r3
	umlal	r7, r8, r4, r3
	umlal	r9, r10, r1, r3
	// ([14-17], 62) blocks
	ldr	r4, [r12, #248]
	ldr	r3, [r14, #68]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([15-18], 61) blocks
	ldr	r5, [r12, #244]
	ldr	r4, [r14, #72]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([16-19], 60) blocks
	ldr	r1, [r12, #240]
	ldr	r5, [r14, #76]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([17-20], 59) blocks
	ldr	r2, [r12, #236]
	ldr	r1, [r14, #80]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([18-21], 58) blocks
	ldr	r3, [r12, #232]
	ldr	r2, [r14, #84]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([19-22], 57) blocks
	ldr	r4, [r12, #228]
	ldr	r3, [r14, #88]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([20-23], 56) blocks
	ldr	r5, [r12, #224]
	ldr	r4, [r14, #92]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([21-24], 55) blocks
	ldr	r1, [r12, #220]
	ldr	r5, [r14, #96]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([26-29], 50) blocks
	ldr	r1, [r12, #200]
	ldr	r5, [r14, #116]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
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
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
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
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	// ([40-43], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r4, [r14, #172]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
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
	// ([53-56], 23) blocks
	ldr	r3, [r12, #92]
	ldr	r2, [r14, #224]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	// ([54-57], 22) blocks
	ldr	r4, [r12, #88]
	ldr	r3, [r14, #228]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([55-58], 21) blocks
	ldr	r5, [r12, #84]
	ldr	r4, [r14, #232]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([56-59], 20) blocks
	ldr	r1, [r12, #80]
	ldr	r5, [r14, #236]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([57-60], 19) blocks
	ldr	r2, [r12, #76]
	ldr	r1, [r14, #240]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([58-61], 18) blocks
	ldr	r3, [r12, #72]
	ldr	r2, [r14, #244]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([59-62], 17) blocks
	ldr	r4, [r12, #68]
	ldr	r3, [r14, #248]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([60-63], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r4, [r14, #252]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([61-63],15),([62-63],14),(63,13) blocks
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr	r5, [r12, #60]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
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
	ldr	r5, [r12, #56]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
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
	ldr	r5, [r12, #52]
	umlal	r7, r8, r4, r5
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
	and	r5, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	and	r5, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([17-20], 63) blocks
	ldr	r2, [r12, #252]
	ldr	r1, [r14, #80]
	ldr	r5, [r14, #76]
	ldr	r4, [r14, #72]
	ldr	r3, [r14, #68]
	umull	r7, r8, r4, r2
	umull	r9, r10, r1, r2
	umlal	r6, r7, r3, r2
	umlal	r8, r9, r5, r2
	// ([18-21], 62) blocks
	ldr	r3, [r12, #248]
	ldr	r2, [r14, #84]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([19-22], 61) blocks
	ldr	r4, [r12, #244]
	ldr	r3, [r14, #88]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([20-23], 60) blocks
	ldr	r5, [r12, #240]
	ldr	r4, [r14, #92]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([21-24], 59) blocks
	ldr	r1, [r12, #236]
	ldr	r5, [r14, #96]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([22-25], 58) blocks
	ldr	r2, [r12, #232]
	ldr	r1, [r14, #100]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([23-26], 57) blocks
	ldr	r3, [r12, #228]
	ldr	r2, [r14, #104]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([24-27], 56) blocks
	ldr	r4, [r12, #224]
	ldr	r3, [r14, #108]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([25-28], 55) blocks
	ldr	r5, [r12, #220]
	ldr	r4, [r14, #112]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
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
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([30-33], 50) blocks
	ldr	r5, [r12, #200]
	ldr	r4, [r14, #132]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
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
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
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
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	// ([44-47], 36) blocks
	ldr	r4, [r12, #144]
	ldr	r3, [r14, #188]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
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
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	// ([52-55], 28) blocks
	ldr	r2, [r12, #112]
	ldr	r1, [r14, #220]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([53-56], 27) blocks
	ldr	r3, [r12, #108]
	ldr	r2, [r14, #224]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([54-57], 26) blocks
	ldr	r4, [r12, #104]
	ldr	r3, [r14, #228]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([55-58], 25) blocks
	ldr	r5, [r12, #100]
	ldr	r4, [r14, #232]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([56-59], 24) blocks
	ldr	r1, [r12, #96]
	ldr	r5, [r14, #236]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([57-60], 23) blocks
	ldr	r2, [r12, #92]
	ldr	r1, [r14, #240]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	// ([58-61], 22) blocks
	ldr	r3, [r12, #88]
	ldr	r2, [r14, #244]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([59-62], 21) blocks
	ldr	r4, [r12, #84]
	ldr	r3, [r14, #248]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([60-63], 20) blocks
	ldr	r5, [r12, #80]
	ldr	r4, [r14, #252]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([61-63],19),([62-63],18),(63,17) blocks
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr	r5, [r12, #76]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
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
	ldr	r5, [r12, #72]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
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
	ldr	r5, [r12, #68]
	umlal	r6, r7, r4, r5
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
	and	r5, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	and	r5, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([21-24], 63) blocks
	ldr	r1, [r12, #252]
	ldr	r5, [r14, #96]
	ldr	r4, [r14, #92]
	ldr	r3, [r14, #88]
	ldr	r2, [r14, #84]
	umull	r6, r7, r3, r1
	umull	r8, r9, r5, r1
	umlal	r10, r6, r2, r1
	umlal	r7, r8, r4, r1
	// ([22-25], 62) blocks
	ldr	r2, [r12, #248]
	ldr	r1, [r14, #100]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([23-26], 61) blocks
	ldr	r3, [r12, #244]
	ldr	r2, [r14, #104]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([24-27], 60) blocks
	ldr	r4, [r12, #240]
	ldr	r3, [r14, #108]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([25-28], 59) blocks
	ldr	r5, [r12, #236]
	ldr	r4, [r14, #112]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([26-29], 58) blocks
	ldr	r1, [r12, #232]
	ldr	r5, [r14, #116]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([27-30], 57) blocks
	ldr	r2, [r12, #228]
	ldr	r1, [r14, #120]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([28-31], 56) blocks
	ldr	r3, [r12, #224]
	ldr	r2, [r14, #124]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([29-32], 55) blocks
	ldr	r4, [r12, #220]
	ldr	r3, [r14, #128]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([34-37], 50) blocks
	ldr	r4, [r12, #200]
	ldr	r3, [r14, #148]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
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
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	and	r2, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r2, LSR #4	// range < 31
	// ([48-51], 36) blocks
	ldr	r3, [r12, #144]
	ldr	r2, [r14, #204]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
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
	// ([53-56], 31) blocks
	ldr	r3, [r12, #124]
	ldr	r2, [r14, #224]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([54-57], 30) blocks
	ldr	r4, [r12, #120]
	ldr	r3, [r14, #228]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([55-58], 29) blocks
	ldr	r5, [r12, #116]
	ldr	r4, [r14, #232]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	// ([56-59], 28) blocks
	ldr	r1, [r12, #112]
	ldr	r5, [r14, #236]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([57-60], 27) blocks
	ldr	r2, [r12, #108]
	ldr	r1, [r14, #240]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([58-61], 26) blocks
	ldr	r3, [r12, #104]
	ldr	r2, [r14, #244]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([59-62], 25) blocks
	ldr	r4, [r12, #100]
	ldr	r3, [r14, #248]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([60-63], 24) blocks
	ldr	r5, [r12, #96]
	ldr	r4, [r14, #252]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([61-63],23),([62-63],22),(63,21) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr	r5, [r12, #92]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
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
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr	r5, [r12, #88]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #84]
	umlal	r10, r6, r4, r5
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
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	// ([25-28], 63) blocks
	ldr	r5, [r12, #252]
	ldr	r4, [r14, #112]
	ldr	r3, [r14, #108]
	ldr	r2, [r14, #104]
	ldr	r1, [r14, #100]
	umull	r10, r6, r2, r5
	umull	r7, r8, r4, r5
	umlal	r9, r10, r1, r5
	umlal	r6, r7, r3, r5
	// ([26-29], 62) blocks
	ldr	r1, [r12, #248]
	ldr	r5, [r14, #116]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([27-30], 61) blocks
	ldr	r2, [r12, #244]
	ldr	r1, [r14, #120]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([28-31], 60) blocks
	ldr	r3, [r12, #240]
	ldr	r2, [r14, #124]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([29-32], 59) blocks
	ldr	r4, [r12, #236]
	ldr	r3, [r14, #128]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([30-33], 58) blocks
	ldr	r5, [r12, #232]
	ldr	r4, [r14, #132]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([31-34], 57) blocks
	ldr	r1, [r12, #228]
	ldr	r5, [r14, #136]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([32-35], 56) blocks
	ldr	r2, [r12, #224]
	ldr	r1, [r14, #140]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([33-36], 55) blocks
	ldr	r3, [r12, #220]
	ldr	r2, [r14, #144]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
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
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	// ([38-41], 50) blocks
	ldr	r3, [r12, #200]
	ldr	r2, [r14, #164]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
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
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	and	r1, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r1, LSR #4	// range < 31
	// ([52-55], 36) blocks
	ldr	r2, [r12, #144]
	ldr	r1, [r14, #220]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([53-56], 35) blocks
	ldr	r3, [r12, #140]
	ldr	r2, [r14, #224]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([54-57], 34) blocks
	ldr	r4, [r12, #136]
	ldr	r3, [r14, #228]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([55-58], 33) blocks
	ldr	r5, [r12, #132]
	ldr	r4, [r14, #232]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([56-59], 32) blocks
	ldr	r1, [r12, #128]
	ldr	r5, [r14, #236]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([57-60], 31) blocks
	ldr	r2, [r12, #124]
	ldr	r1, [r14, #240]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([58-61], 30) blocks
	ldr	r3, [r12, #120]
	ldr	r2, [r14, #244]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([59-62], 29) blocks
	ldr	r4, [r12, #116]
	ldr	r3, [r14, #248]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	// ([60-63], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r4, [r14, #252]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([61-63],27),([62-63],26),(63,25) blocks
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr	r5, [r12, #108]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r2, r5
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
	ldr	r5, [r12, #104]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
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
	ldr	r5, [r12, #100]
	umlal	r9, r10, r4, r5
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
	and	r5, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	and	r5, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([29-32], 63) blocks
	ldr	r4, [r12, #252]
	ldr	r3, [r14, #128]
	ldr	r2, [r14, #124]
	ldr	r1, [r14, #120]
	ldr	r5, [r14, #116]
	umull	r9, r10, r1, r4
	umull	r6, r7, r3, r4
	umlal	r8, r9, r5, r4
	umlal	r10, r6, r2, r4
	// ([30-33], 62) blocks
	ldr	r5, [r12, #248]
	ldr	r4, [r14, #132]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([31-34], 61) blocks
	ldr	r1, [r12, #244]
	ldr	r5, [r14, #136]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([32-35], 60) blocks
	ldr	r2, [r12, #240]
	ldr	r1, [r14, #140]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([33-36], 59) blocks
	ldr	r3, [r12, #236]
	ldr	r2, [r14, #144]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([34-37], 58) blocks
	ldr	r4, [r12, #232]
	ldr	r3, [r14, #148]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([35-38], 57) blocks
	ldr	r5, [r12, #228]
	ldr	r4, [r14, #152]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([36-39], 56) blocks
	ldr	r1, [r12, #224]
	ldr	r5, [r14, #156]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([37-40], 55) blocks
	ldr	r2, [r12, #220]
	ldr	r1, [r14, #160]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
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
	and	r1, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r1, LSR #4	// range < 31
	and	r1, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r1, LSR #4	// range < 31
	and	r1, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r1, LSR #4	// range < 31
	and	r1, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r1, LSR #4	// range < 31
	// ([42-45], 50) blocks
	ldr	r2, [r12, #200]
	ldr	r1, [r14, #180]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	// ([53-56], 39) blocks
	ldr	r3, [r12, #156]
	ldr	r2, [r14, #224]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([54-57], 38) blocks
	ldr	r4, [r12, #152]
	ldr	r3, [r14, #228]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([55-58], 37) blocks
	ldr	r5, [r12, #148]
	ldr	r4, [r14, #232]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	// ([56-59], 36) blocks
	ldr	r1, [r12, #144]
	ldr	r5, [r14, #236]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([57-60], 35) blocks
	ldr	r2, [r12, #140]
	ldr	r1, [r14, #240]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([58-61], 34) blocks
	ldr	r3, [r12, #136]
	ldr	r2, [r14, #244]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([59-62], 33) blocks
	ldr	r4, [r12, #132]
	ldr	r3, [r14, #248]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([60-63], 32) blocks
	ldr	r5, [r12, #128]
	ldr	r4, [r14, #252]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([61-63],31),([62-63],30),(63,29) blocks
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr	r5, [r12, #124]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
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
	ldr	r5, [r12, #120]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
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
	ldr	r5, [r12, #116]
	umlal	r8, r9, r4, r5
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
	and	r5, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	and	r5, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([33-36], 63) blocks
	ldr	r3, [r12, #252]
	ldr	r2, [r14, #144]
	ldr	r1, [r14, #140]
	ldr	r5, [r14, #136]
	ldr	r4, [r14, #132]
	umull	r8, r9, r5, r3
	umull	r10, r6, r2, r3
	umlal	r7, r8, r4, r3
	umlal	r9, r10, r1, r3
	// ([34-37], 62) blocks
	ldr	r4, [r12, #248]
	ldr	r3, [r14, #148]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([35-38], 61) blocks
	ldr	r5, [r12, #244]
	ldr	r4, [r14, #152]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([36-39], 60) blocks
	ldr	r1, [r12, #240]
	ldr	r5, [r14, #156]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([37-40], 59) blocks
	ldr	r2, [r12, #236]
	ldr	r1, [r14, #160]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([38-41], 58) blocks
	ldr	r3, [r12, #232]
	ldr	r2, [r14, #164]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([39-42], 57) blocks
	ldr	r4, [r12, #228]
	ldr	r3, [r14, #168]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([40-43], 56) blocks
	ldr	r5, [r12, #224]
	ldr	r4, [r14, #172]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([41-44], 55) blocks
	ldr	r1, [r12, #220]
	ldr	r5, [r14, #176]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
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
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([46-49], 50) blocks
	ldr	r1, [r12, #200]
	ldr	r5, [r14, #196]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
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
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
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
	// ([53-56], 43) blocks
	ldr	r3, [r12, #172]
	ldr	r2, [r14, #224]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([54-57], 42) blocks
	ldr	r4, [r12, #168]
	ldr	r3, [r14, #228]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([55-58], 41) blocks
	ldr	r5, [r12, #164]
	ldr	r4, [r14, #232]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([56-59], 40) blocks
	ldr	r1, [r12, #160]
	ldr	r5, [r14, #236]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([57-60], 39) blocks
	ldr	r2, [r12, #156]
	ldr	r1, [r14, #240]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([58-61], 38) blocks
	ldr	r3, [r12, #152]
	ldr	r2, [r14, #244]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([59-62], 37) blocks
	ldr	r4, [r12, #148]
	ldr	r3, [r14, #248]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	and	r4, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r4, LSR #4	// range < 31
	// ([60-63], 36) blocks
	ldr	r5, [r12, #144]
	ldr	r4, [r14, #252]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([61-63],35),([62-63],34),(63,33) blocks
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr	r5, [r12, #140]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
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
	ldr	r5, [r12, #136]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
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
	ldr	r5, [r12, #132]
	umlal	r7, r8, r4, r5
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
	and	r5, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	and	r5, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([37-40], 63) blocks
	ldr	r2, [r12, #252]
	ldr	r1, [r14, #160]
	ldr	r5, [r14, #156]
	ldr	r4, [r14, #152]
	ldr	r3, [r14, #148]
	umull	r7, r8, r4, r2
	umull	r9, r10, r1, r2
	umlal	r6, r7, r3, r2
	umlal	r8, r9, r5, r2
	// ([38-41], 62) blocks
	ldr	r3, [r12, #248]
	ldr	r2, [r14, #164]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([39-42], 61) blocks
	ldr	r4, [r12, #244]
	ldr	r3, [r14, #168]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([40-43], 60) blocks
	ldr	r5, [r12, #240]
	ldr	r4, [r14, #172]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([41-44], 59) blocks
	ldr	r1, [r12, #236]
	ldr	r5, [r14, #176]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([42-45], 58) blocks
	ldr	r2, [r12, #232]
	ldr	r1, [r14, #180]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([43-46], 57) blocks
	ldr	r3, [r12, #228]
	ldr	r2, [r14, #184]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([44-47], 56) blocks
	ldr	r4, [r12, #224]
	ldr	r3, [r14, #188]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([45-48], 55) blocks
	ldr	r5, [r12, #220]
	ldr	r4, [r14, #192]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
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
	and	r4, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r4, LSR #4	// range < 31
	and	r4, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r4, LSR #4	// range < 31
	and	r4, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r4, LSR #4	// range < 31
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([50-53], 50) blocks
	ldr	r5, [r12, #200]
	ldr	r4, [r14, #212]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
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
	// ([53-56], 47) blocks
	ldr	r3, [r12, #188]
	ldr	r2, [r14, #224]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	// ([54-57], 46) blocks
	ldr	r4, [r12, #184]
	ldr	r3, [r14, #228]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([55-58], 45) blocks
	ldr	r5, [r12, #180]
	ldr	r4, [r14, #232]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([56-59], 44) blocks
	ldr	r1, [r12, #176]
	ldr	r5, [r14, #236]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([57-60], 43) blocks
	ldr	r2, [r12, #172]
	ldr	r1, [r14, #240]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([58-61], 42) blocks
	ldr	r3, [r12, #168]
	ldr	r2, [r14, #244]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([59-62], 41) blocks
	ldr	r4, [r12, #164]
	ldr	r3, [r14, #248]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([60-63], 40) blocks
	ldr	r5, [r12, #160]
	ldr	r4, [r14, #252]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([61-63],39),([62-63],38),(63,37) blocks
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr	r5, [r12, #156]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
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
	ldr	r5, [r12, #152]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
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
	ldr	r5, [r12, #148]
	umlal	r6, r7, r4, r5
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
	and	r5, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	and	r5, r7, #0x1C1C1C1C	// top 3b < 3
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=5
	usub8	r5, r7, r11		// >= 3 ?
	sel	r7, r5, r7		// select
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	// ([41-44], 63) blocks
	ldr	r1, [r12, #252]
	ldr	r5, [r14, #176]
	ldr	r4, [r14, #172]
	ldr	r3, [r14, #168]
	ldr	r2, [r14, #164]
	umull	r6, r7, r3, r1
	umull	r8, r9, r5, r1
	umlal	r10, r6, r2, r1
	umlal	r7, r8, r4, r1
	// ([42-45], 62) blocks
	ldr	r2, [r12, #248]
	ldr	r1, [r14, #180]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([43-46], 61) blocks
	ldr	r3, [r12, #244]
	ldr	r2, [r14, #184]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([44-47], 60) blocks
	ldr	r4, [r12, #240]
	ldr	r3, [r14, #188]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([45-48], 59) blocks
	ldr	r5, [r12, #236]
	ldr	r4, [r14, #192]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([46-49], 58) blocks
	ldr	r1, [r12, #232]
	ldr	r5, [r14, #196]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([47-50], 57) blocks
	ldr	r2, [r12, #228]
	ldr	r1, [r14, #200]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	// ([48-51], 56) blocks
	ldr	r3, [r12, #224]
	ldr	r2, [r14, #204]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([49-52], 55) blocks
	ldr	r4, [r12, #220]
	ldr	r3, [r14, #208]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
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
	// ([53-56], 51) blocks
	ldr	r3, [r12, #204]
	ldr	r2, [r14, #224]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	and	r3, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r3, LSR #4	// range < 31
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([54-57], 50) blocks
	ldr	r4, [r12, #200]
	ldr	r3, [r14, #228]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([55-58], 49) blocks
	ldr	r5, [r12, #196]
	ldr	r4, [r14, #232]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([56-59], 48) blocks
	ldr	r1, [r12, #192]
	ldr	r5, [r14, #236]
	umlal	r10, r6, r2, r1
	umlal	r6, r7, r3, r1
	umlal	r7, r8, r4, r1
	umlal	r8, r9, r5, r1
	// ([57-60], 47) blocks
	ldr	r2, [r12, #188]
	ldr	r1, [r14, #240]
	umlal	r10, r6, r3, r2
	umlal	r6, r7, r4, r2
	umlal	r7, r8, r5, r2
	umlal	r8, r9, r1, r2
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	// ([58-61], 46) blocks
	ldr	r3, [r12, #184]
	ldr	r2, [r14, #244]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([59-62], 45) blocks
	ldr	r4, [r12, #180]
	ldr	r3, [r14, #248]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r1, r4
	umlal	r7, r8, r2, r4
	umlal	r8, r9, r3, r4
	// ([60-63], 44) blocks
	ldr	r5, [r12, #176]
	ldr	r4, [r14, #252]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([61-63],43),([62-63],42),(63,41) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr	r5, [r12, #172]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #168]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #164]
	umlal	r10, r6, r4, r5
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
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	// ([45-48], 63) blocks
	ldr	r5, [r12, #252]
	ldr	r4, [r14, #192]
	ldr	r3, [r14, #188]
	ldr	r2, [r14, #184]
	ldr	r1, [r14, #180]
	umull	r10, r6, r2, r5
	umull	r7, r8, r4, r5
	umlal	r9, r10, r1, r5
	umlal	r6, r7, r3, r5
	// ([46-49], 62) blocks
	ldr	r1, [r12, #248]
	ldr	r5, [r14, #196]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([47-50], 61) blocks
	ldr	r2, [r12, #244]
	ldr	r1, [r14, #200]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([48-51], 60) blocks
	ldr	r3, [r12, #240]
	ldr	r2, [r14, #204]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([49-52], 59) blocks
	ldr	r4, [r12, #236]
	ldr	r3, [r14, #208]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([50-53], 58) blocks
	ldr	r5, [r12, #232]
	ldr	r4, [r14, #212]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([51-54], 57) blocks
	ldr	r1, [r12, #228]
	ldr	r5, [r14, #216]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([52-55], 56) blocks
	ldr	r2, [r12, #224]
	ldr	r1, [r14, #220]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([53-56], 55) blocks
	ldr	r3, [r12, #220]
	ldr	r2, [r14, #224]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([54-57], 54) blocks
	ldr	r4, [r12, #216]
	ldr	r3, [r14, #228]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([55-58], 53) blocks
	ldr	r5, [r12, #212]
	ldr	r4, [r14, #232]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([56-59], 52) blocks
	ldr	r1, [r12, #208]
	ldr	r5, [r14, #236]
	umlal	r9, r10, r2, r1
	umlal	r10, r6, r3, r1
	umlal	r6, r7, r4, r1
	umlal	r7, r8, r5, r1
	// ([57-60], 51) blocks
	ldr	r2, [r12, #204]
	ldr	r1, [r14, #240]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	and	r2, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r2, LSR #4	// range < 31
	and	r2, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r2, LSR #4	// range < 31
	and	r2, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r2, LSR #4	// range < 31
	and	r2, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r2, LSR #4	// range < 31
	// ([58-61], 50) blocks
	ldr	r3, [r12, #200]
	ldr	r2, [r14, #244]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([59-62], 49) blocks
	ldr	r4, [r12, #196]
	ldr	r3, [r14, #248]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([60-63], 48) blocks
	ldr	r5, [r12, #192]
	ldr	r4, [r14, #252]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([61-63],47),([62-63],46),(63,45) blocks
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr	r5, [r12, #188]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r2, r5
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
	ldr	r5, [r12, #184]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
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
	ldr	r5, [r12, #180]
	umlal	r9, r10, r4, r5
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
	and	r5, r10, #0x1C1C1C1C	// top 3b < 8
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=10
	and	r5, r10, #0x1C1C1C1C	// top 3b < 3
	and	r10, r10, r11		// bot 2b < 4
	add	r10, r10, r5, LSR #2	// range <=5
	usub8	r5, r10, r11		// >= 3 ?
	sel	r10, r5, r10		// select
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	// ([49-52], 63) blocks
	ldr	r4, [r12, #252]
	ldr	r3, [r14, #208]
	ldr	r2, [r14, #204]
	ldr	r1, [r14, #200]
	ldr	r5, [r14, #196]
	umull	r9, r10, r1, r4
	umull	r6, r7, r3, r4
	umlal	r8, r9, r5, r4
	umlal	r10, r6, r2, r4
	// ([50-53], 62) blocks
	ldr	r5, [r12, #248]
	ldr	r4, [r14, #212]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([51-54], 61) blocks
	ldr	r1, [r12, #244]
	ldr	r5, [r14, #216]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([52-55], 60) blocks
	ldr	r2, [r12, #240]
	ldr	r1, [r14, #220]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([53-56], 59) blocks
	ldr	r3, [r12, #236]
	ldr	r2, [r14, #224]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([54-57], 58) blocks
	ldr	r4, [r12, #232]
	ldr	r3, [r14, #228]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([55-58], 57) blocks
	ldr	r5, [r12, #228]
	ldr	r4, [r14, #232]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([56-59], 56) blocks
	ldr	r1, [r12, #224]
	ldr	r5, [r14, #236]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([57-60], 55) blocks
	ldr	r2, [r12, #220]
	ldr	r1, [r14, #240]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([58-61], 54) blocks
	ldr	r3, [r12, #216]
	ldr	r2, [r14, #244]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([59-62], 53) blocks
	ldr	r4, [r12, #212]
	ldr	r3, [r14, #248]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([60-63], 52) blocks
	ldr	r5, [r12, #208]
	ldr	r4, [r14, #252]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([61-63],51),([62-63],50),(63,49) blocks
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr	r5, [r12, #204]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr	r5, [r12, #200]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
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
	ldr	r5, [r12, #196]
	umlal	r8, r9, r4, r5
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
	and	r5, r9, #0x1C1C1C1C	// top 3b < 8
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=10
	and	r5, r9, #0x1C1C1C1C	// top 3b < 3
	and	r9, r9, r11		// bot 2b < 4
	add	r9, r9, r5, LSR #2	// range <=5
	usub8	r5, r9, r11		// >= 3 ?
	sel	r9, r5, r9		// select
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	str	r6, [r0], #4
	// ([53-56], 63) blocks
	ldr	r3, [r12, #252]
	ldr	r2, [r14, #224]
	ldr	r1, [r14, #220]
	ldr	r5, [r14, #216]
	ldr	r4, [r14, #212]
	umull	r8, r9, r5, r3
	umull	r10, r6, r2, r3
	umlal	r7, r8, r4, r3
	umlal	r9, r10, r1, r3
	// ([54-57], 62) blocks
	ldr	r4, [r12, #248]
	ldr	r3, [r14, #228]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([55-58], 61) blocks
	ldr	r5, [r12, #244]
	ldr	r4, [r14, #232]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([56-59], 60) blocks
	ldr	r1, [r12, #240]
	ldr	r5, [r14, #236]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([57-60], 59) blocks
	ldr	r2, [r12, #236]
	ldr	r1, [r14, #240]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([58-61], 58) blocks
	ldr	r3, [r12, #232]
	ldr	r2, [r14, #244]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([59-62], 57) blocks
	ldr	r4, [r12, #228]
	ldr	r3, [r14, #248]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([60-63], 56) blocks
	ldr	r5, [r12, #224]
	ldr	r4, [r14, #252]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([61-63],55),([62-63],54),(63,53) blocks
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr	r5, [r12, #220]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
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
	ldr	r5, [r12, #216]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
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
	ldr	r5, [r12, #212]
	umlal	r7, r8, r4, r5
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
	and	r5, r8, #0x1C1C1C1C	// top 3b < 8
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=10
	and	r5, r8, #0x1C1C1C1C	// top 3b < 3
	and	r8, r8, r11		// bot 2b < 4
	add	r8, r8, r5, LSR #2	// range <=5
	usub8	r5, r8, r11		// >= 3 ?
	sel	r8, r5, r8		// select
	str	r7, [r0], #4
	str	r8, [r0], #4
	str	r9, [r0], #4
	str	r10, [r0], #4
	// ([57-60], 63) blocks
	ldr	r2, [r12, #252]
	ldr	r1, [r14, #240]
	ldr	r5, [r14, #236]
	ldr	r4, [r14, #232]
	ldr	r3, [r14, #228]
	umull	r7, r8, r4, r2
	umull	r9, r10, r1, r2
	umlal	r6, r7, r3, r2
	umlal	r8, r9, r5, r2
	// ([58-61], 62) blocks
	ldr	r3, [r12, #248]
	ldr	r2, [r14, #244]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([59-62], 61) blocks
	ldr	r4, [r12, #244]
	ldr	r3, [r14, #248]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([60-63], 60) blocks
	ldr	r5, [r12, #240]
	ldr	r4, [r14, #252]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([61-63],59),([62-63],58),(63,57) blocks
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr	r5, [r12, #236]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
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
	ldr	r5, [r12, #232]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
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
	ldr	r5, [r12, #228]
	umlal	r6, r7, r4, r5
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
	and	r5, r7, #0x1C1C1C1C	// top 3b < 8
	and	r7, r7, r11		// bot 2b < 4
	add	r7, r7, r5, LSR #2	// range <=10
	and	r5, r7, #0x1C1C1C1C	// top 3b < 3
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
	ldr	r2, [r14, #244]
	ldr	r3, [r14, #248]
	ldr	r4, [r14, #252]
	// ([61-63],63),([62-63],62),(63,61) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr	r5, [r12, #252]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
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
	ldr	r5, [r12, #248]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
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
	ldr	r5, [r12, #244]
	umlal	r10, r6, r4, r5
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
	str	r10, [r0], #4
	str	r6, [r0], #4
	str	r7, [r0], #4
	str	r8, [r0], #4
	pop	{r4-r11,lr}
	bx	lr
