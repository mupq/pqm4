.p2align 2,,3
.syntax unified
.text
mul_head_last:
	push.w {lr}
	ldr	r14, [r1, #0]
	ldr	r8, [r1, #4]
	ldr	r9, [r1, #8]
	ldr	r10, [r1, #12]
	ldr	r3, [r2, #60]
	ldr	r4, [r2, #56]
	ldr	r5, [r2, #52]
	ldr	r12, [r2, #48]
	umull	r6, r7, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r8, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r9, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r10, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr	r14, [r1, #16]
	ldr	r8, [r1, #20]
	ldr	r9, [r1, #24]
	ldr	r10, [r1, #28]
	ldr	r3, [r2, #44]
	ldr	r4, [r2, #40]
	ldr	r5, [r2, #36]
	ldr	r12, [r2, #32]
	umlal	r6, r7, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r8, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r9, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r10, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr	r14, [r1, #32]
	ldr	r8, [r1, #36]
	ldr	r9, [r1, #40]
	ldr	r10, [r1, #44]
	ldr	r3, [r2, #28]
	ldr	r4, [r2, #24]
	ldr	r5, [r2, #20]
	ldr	r12, [r2, #16]
	umlal	r6, r7, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r8, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r9, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r10, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr	r14, [r1, #48]
	ldr	r8, [r1, #52]
	ldr	r9, [r1, #56]
	ldr	r10, [r1, #60]
	ldr	r3, [r2, #12]
	ldr	r4, [r2, #8]
	ldr	r5, [r2, #4]
	ldr	r12, [r2, #0]
	umlal	r6, r7, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r8, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r9, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	umlal	r6, r7, r10, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r6, [r0], #4
	pop.w {pc}
mul_head:
 // increasing thread length
	push.w {lr}
	mov	r6, #0
 // later blocks
	// ([0-3], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #12]
	ldr.w	r3, [r2, #8]
	ldr.w	r14, [r2, #4]
	ldr.w	r12, [r2, #0]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([0-2],1), ([0-1],2), (0,3) blocks
	ldr.w	r5, [r1, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	ldr.w	r5, [r1, #8]
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	ldr.w	r5, [r1, #12]
	umlal	r9, r10, r12, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([4-7], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #28]
	ldr.w	r14, [r2, #24]
	ldr.w	r12, [r2, #20]
	ldr.w	r5, [r2, #16]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([3-6], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([2-5], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #8]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([1-4], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #4]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([0-3], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #0]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([0-2],5), ([0-1],6), (0,7) blocks
	ldr.w	r5, [r1, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	ldr.w	r5, [r1, #24]
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	ldr.w	r5, [r1, #28]
	umlal	r8, r9, r12, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([8-11], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #44]
	ldr.w	r12, [r2, #40]
	ldr.w	r5, [r2, #36]
	ldr.w	r4, [r2, #32]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([7-10], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([6-9], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([5-8], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([4-7], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([3-6], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([2-5], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #8]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([1-4], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #4]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([0-3], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #0]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([0-2],9), ([0-1],10), (0,11) blocks
	ldr.w	r5, [r1, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	ldr.w	r5, [r1, #40]
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	ldr.w	r5, [r1, #44]
	umlal	r7, r8, r12, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([12-15], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #60]
	ldr.w	r5, [r2, #56]
	ldr.w	r4, [r2, #52]
	ldr.w	r3, [r2, #48]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([11-14], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #44]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([10-13], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #40]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([9-12], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([8-11], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([7-10], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #28]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([6-9], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #24]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([5-8], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #20]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([4-7], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([3-6], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([2-5], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #8]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([1-4], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #4]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([0-3], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #0]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([0-2],13), ([0-1],14), (0,15) blocks
	ldr.w	r5, [r1, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	umlal	r9, r10, r12, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr.w	r5, [r1, #56]
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr.w	r5, [r1, #60]
	umlal	r6, r7, r12, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	pop.w {pc}
mul_864:
	// ([16-19], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #76]
	ldr.w	r4, [r2, #72]
	ldr.w	r3, [r2, #68]
	ldr.w	r14, [r2, #64]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([15-18], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #60]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([14-17], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([13-16], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([12-15], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #48]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([11-14], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #44]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([10-13], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #40]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([9-12], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([8-11], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([7-10], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #28]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([6-9], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #24]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([5-8], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #20]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([4-7], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([3-6], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([2-5], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #8]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([1-4], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #4]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
mul_832:
	// ([20-23], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #92]
	ldr.w	r3, [r2, #88]
	ldr.w	r14, [r2, #84]
	ldr.w	r12, [r2, #80]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([19-22], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([18-21], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([17-20], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #68]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([16-19], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #64]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([15-18], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #60]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([14-17], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([13-16], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([12-15], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #48]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([11-14], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #44]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([10-13], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #40]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([9-12], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([8-11], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([7-10], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #28]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([6-9], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #24]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([5-8], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #20]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([24-27], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #108]
	ldr.w	r14, [r2, #104]
	ldr.w	r12, [r2, #100]
	ldr.w	r5, [r2, #96]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([23-26], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([22-25], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #88]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([21-24], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #84]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([20-23], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #80]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([19-22], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([18-21], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([17-20], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #68]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([16-19], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #64]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([15-18], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #60]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([14-17], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([13-16], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([12-15], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #48]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([11-14], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #44]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([10-13], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #40]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([9-12], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
mul_768:
	// ([28-31], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #124]
	ldr.w	r12, [r2, #120]
	ldr.w	r5, [r2, #116]
	ldr.w	r4, [r2, #112]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([27-30], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #108]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([26-29], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #104]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([25-28], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #100]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([24-27], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([23-26], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([22-25], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #88]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([21-24], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #84]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([20-23], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #80]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([19-22], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([18-21], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([17-20], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #68]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([16-19], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #64]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([15-18], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #60]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([14-17], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #56]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([13-16], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([32-35], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #140]
	ldr.w	r5, [r2, #136]
	ldr.w	r4, [r2, #132]
	ldr.w	r3, [r2, #128]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([31-34], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #124]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([30-33], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #120]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([29-32], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([28-31], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([27-30], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #108]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([26-29], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #104]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([25-28], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #100]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([24-27], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([23-26], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([22-25], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #88]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([21-24], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #84]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([20-23], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #80]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([19-22], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #76]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([18-21], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #72]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([17-20], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #68]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([36-39], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #156]
	ldr.w	r4, [r2, #152]
	ldr.w	r3, [r2, #148]
	ldr.w	r14, [r2, #144]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([35-38], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #140]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([34-37], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([33-36], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([32-35], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #128]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([31-34], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #124]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([30-33], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #120]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([29-32], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([28-31], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([27-30], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #108]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([26-29], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #104]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([25-28], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #100]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([24-27], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #96]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([23-26], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #92]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([22-25], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #88]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([21-24], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #84]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([40-43], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #172]
	ldr.w	r3, [r2, #168]
	ldr.w	r14, [r2, #164]
	ldr.w	r12, [r2, #160]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([39-42], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([38-41], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([37-40], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #148]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([36-39], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #144]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([35-38], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #140]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([34-37], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([33-36], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([32-35], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #128]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([31-34], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #124]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([30-33], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #120]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([29-32], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([28-31], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #112]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([27-30], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #108]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([26-29], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #104]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([25-28], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #100]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
mul_640:
	// ([44-47], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #188]
	ldr.w	r14, [r2, #184]
	ldr.w	r12, [r2, #180]
	ldr.w	r5, [r2, #176]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([43-46], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #172]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([42-45], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #168]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([41-44], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #164]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([40-43], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #160]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([39-42], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #156]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([38-41], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #152]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([37-40], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #148]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([36-39], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #144]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([35-38], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #140]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([34-37], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([33-36], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([32-35], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #128]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([31-34], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #124]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([30-33], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #120]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([29-32], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #116]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([48-51], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #204]
	ldr.w	r12, [r2, #200]
	ldr.w	r5, [r2, #196]
	ldr.w	r4, [r2, #192]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([47-50], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #188]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([46-49], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #184]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([45-48], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #180]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([44-47], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #176]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([43-46], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #172]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([42-45], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #168]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([41-44], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #164]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([40-43], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #160]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([39-42], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([38-41], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([37-40], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #148]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([36-39], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #144]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([35-38], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #140]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([34-37], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #136]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([33-36], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #132]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([52-55], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #220]
	ldr.w	r5, [r2, #216]
	ldr.w	r4, [r2, #212]
	ldr.w	r3, [r2, #208]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([51-54], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #204]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([50-53], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #200]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([49-52], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #196]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([48-51], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #192]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([47-50], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #188]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([46-49], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #184]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([45-48], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #180]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([44-47], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([43-46], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([42-45], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #168]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([41-44], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #164]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([40-43], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #160]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([39-42], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #156]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([38-41], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #152]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([37-40], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #148]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([56-59], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #236]
	ldr.w	r4, [r2, #232]
	ldr.w	r3, [r2, #228]
	ldr.w	r14, [r2, #224]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([55-58], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #220]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([54-57], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #216]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([53-56], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #212]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([52-55], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #208]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([51-54], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #204]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([50-53], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #200]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([49-52], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #196]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([48-51], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([47-50], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #188]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([46-49], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #184]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([45-48], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #180]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([44-47], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #176]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([43-46], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #172]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([42-45], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #168]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([41-44], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #164]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
mul_512:
	// ([60-63], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #252]
	ldr.w	r3, [r2, #248]
	ldr.w	r14, [r2, #244]
	ldr.w	r12, [r2, #240]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([59-62], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #236]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([58-61], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #232]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([57-60], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #228]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([56-59], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #224]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([55-58], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #220]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([54-57], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #216]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([53-56], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #212]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([52-55], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #208]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([51-54], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #204]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([50-53], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #200]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([49-52], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([48-51], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #192]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([47-50], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #188]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([46-49], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #184]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([45-48], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #180]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([64-67], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #268]
	ldr.w	r14, [r2, #264]
	ldr.w	r12, [r2, #260]
	ldr.w	r5, [r2, #256]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([63-66], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #252]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([62-65], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #248]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([61-64], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #244]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([60-63], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #240]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([59-62], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #236]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([58-61], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #232]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([57-60], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #228]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([56-59], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #224]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([55-58], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #220]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([54-57], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #216]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([53-56], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #212]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([52-55], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #208]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([51-54], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #204]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([50-53], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #200]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([49-52], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #196]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([68-71], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #284]
	ldr.w	r12, [r2, #280]
	ldr.w	r5, [r2, #276]
	ldr.w	r4, [r2, #272]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([67-70], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #268]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([66-69], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #264]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([65-68], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #260]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([64-67], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #256]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([63-66], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #252]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([62-65], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #248]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([61-64], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #244]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([60-63], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #240]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([59-62], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #236]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([58-61], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #232]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([57-60], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #228]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([56-59], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #224]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([55-58], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #220]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([54-57], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #216]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([53-56], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #212]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([72-75], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #300]
	ldr.w	r5, [r2, #296]
	ldr.w	r4, [r2, #292]
	ldr.w	r3, [r2, #288]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([71-74], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #284]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([70-73], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #280]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([69-72], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #276]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([68-71], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #272]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([67-70], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #268]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([66-69], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #264]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([65-68], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #260]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([64-67], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #256]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([63-66], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #252]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([62-65], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #248]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([61-64], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #244]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([60-63], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #240]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([59-62], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #236]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([58-61], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #232]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([57-60], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #228]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
mul_384:
	// ([76-79], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #316]
	ldr.w	r4, [r2, #312]
	ldr.w	r3, [r2, #308]
	ldr.w	r14, [r2, #304]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([75-78], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #300]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([74-77], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #296]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([73-76], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #292]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([72-75], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #288]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([71-74], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #284]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([70-73], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #280]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([69-72], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #276]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([68-71], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #272]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([67-70], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #268]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([66-69], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #264]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([65-68], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #260]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([64-67], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #256]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([63-66], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #252]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([62-65], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #248]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([61-64], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #244]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([80-83], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #332]
	ldr.w	r3, [r2, #328]
	ldr.w	r14, [r2, #324]
	ldr.w	r12, [r2, #320]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([79-82], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #316]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([78-81], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #312]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([77-80], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #308]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([76-79], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #304]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([75-78], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #300]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([74-77], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #296]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([73-76], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #292]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([72-75], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #288]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([71-74], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #284]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([70-73], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #280]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([69-72], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #276]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([68-71], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #272]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([67-70], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #268]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([66-69], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #264]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([65-68], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #260]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([84-87], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #348]
	ldr.w	r14, [r2, #344]
	ldr.w	r12, [r2, #340]
	ldr.w	r5, [r2, #336]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([83-86], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #332]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([82-85], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #328]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([81-84], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #324]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([80-83], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #320]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([79-82], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #316]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([78-81], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #312]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([77-80], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #308]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([76-79], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #304]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([75-78], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #300]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([74-77], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #296]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([73-76], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #292]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([72-75], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #288]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([71-74], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #284]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([70-73], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #280]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([69-72], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #276]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([88-91], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #364]
	ldr.w	r12, [r2, #360]
	ldr.w	r5, [r2, #356]
	ldr.w	r4, [r2, #352]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([87-90], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #348]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([86-89], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #344]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([85-88], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #340]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([84-87], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #336]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([83-86], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #332]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([82-85], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #328]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([81-84], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #324]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([80-83], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #320]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([79-82], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #316]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([78-81], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #312]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([77-80], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #308]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([76-79], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #304]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([75-78], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #300]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([74-77], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #296]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([73-76], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #292]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
mul_256:
	// ([92-95], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #380]
	ldr.w	r5, [r2, #376]
	ldr.w	r4, [r2, #372]
	ldr.w	r3, [r2, #368]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([91-94], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #364]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([90-93], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #360]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([89-92], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #356]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([88-91], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #352]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([87-90], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #348]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([86-89], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #344]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([85-88], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #340]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([84-87], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #336]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([83-86], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #332]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([82-85], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #328]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([81-84], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #324]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([80-83], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #320]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([79-82], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #316]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([78-81], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #312]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([77-80], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #308]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([96-99], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #396]
	ldr.w	r4, [r2, #392]
	ldr.w	r3, [r2, #388]
	ldr.w	r14, [r2, #384]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([95-98], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #380]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([94-97], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #376]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([93-96], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #372]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([92-95], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #368]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([91-94], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #364]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([90-93], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #360]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([89-92], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #356]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([88-91], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #352]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([87-90], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #348]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([86-89], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #344]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([85-88], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #340]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([84-87], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #336]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([83-86], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #332]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([82-85], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #328]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([81-84], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #324]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([100-103], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #412]
	ldr.w	r3, [r2, #408]
	ldr.w	r14, [r2, #404]
	ldr.w	r12, [r2, #400]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([99-102], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #396]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([98-101], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #392]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([97-100], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #388]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([96-99], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #384]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([95-98], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #380]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([94-97], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #376]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([93-96], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #372]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([92-95], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #368]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([91-94], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #364]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([90-93], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #360]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([89-92], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #356]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([88-91], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #352]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([87-90], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #348]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([86-89], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #344]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([85-88], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #340]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([104-107], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #428]
	ldr.w	r14, [r2, #424]
	ldr.w	r12, [r2, #420]
	ldr.w	r5, [r2, #416]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([103-106], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #412]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([102-105], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #408]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([101-104], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #404]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([100-103], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #400]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([99-102], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #396]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([98-101], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #392]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([97-100], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #388]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([96-99], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #384]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([95-98], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #380]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([94-97], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #376]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([93-96], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #372]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([92-95], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #368]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([91-94], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #364]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([90-93], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #360]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([89-92], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #356]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
mul_128:
 // decreasing thread length
	// ([93-96], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r14, [r2, #384]
	ldr.w	r12, [r2, #380]
	ldr.w	r5, [r2, #376]
	ldr.w	r4, [r2, #372]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([94-97], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r3, [r2, #388]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([95-98], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r4, [r2, #392]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([96-99], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r5, [r2, #396]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([97-100], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r12, [r2, #400]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([98-101], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r14, [r2, #404]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([99-102], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r3, [r2, #408]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([100-103], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r4, [r2, #412]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([101-104], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r5, [r2, #416]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([102-105], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r12, [r2, #420]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([103-106], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r14, [r2, #424]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([104-107], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r3, [r2, #428]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([105-107],3),([106-107],2),(107,1) blocks
	ldr.w	r4, [r1, #12]
	umlal	r6, r7, r3, r4
	umlal	r10, r6, r14, r4
	umlal	r9, r10, r12, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr.w	r4, [r1, #8]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r14, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	ldr.w	r4, [r1, #4]
	umlal	r9, r10, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([97-100], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r12, [r2, #400]
	ldr.w	r5, [r2, #396]
	ldr.w	r4, [r2, #392]
	ldr.w	r3, [r2, #388]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([98-101], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r14, [r2, #404]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([99-102], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r3, [r2, #408]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([100-103], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r4, [r2, #412]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([101-104], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r5, [r2, #416]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([102-105], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r12, [r2, #420]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([103-106], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r14, [r2, #424]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([104-107], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r3, [r2, #428]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([105-107],7),([106-107],6),(107,5) blocks
	ldr.w	r4, [r1, #28]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r14, r4
	umlal	r8, r9, r12, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	ldr.w	r4, [r1, #24]
	umlal	r9, r10, r3, r4
	umlal	r8, r9, r14, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	ldr.w	r4, [r1, #20]
	umlal	r8, r9, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([101-104], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r5, [r2, #416]
	ldr.w	r4, [r2, #412]
	ldr.w	r3, [r2, #408]
	ldr.w	r14, [r2, #404]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([102-105], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r12, [r2, #420]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([103-106], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r14, [r2, #424]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([104-107], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r3, [r2, #428]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([105-107],11),([106-107],10),(107,9) blocks
	ldr.w	r4, [r1, #44]
	umlal	r9, r10, r3, r4
	umlal	r8, r9, r14, r4
	umlal	r7, r8, r12, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	ldr.w	r4, [r1, #40]
	umlal	r8, r9, r3, r4
	umlal	r7, r8, r14, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	ldr.w	r4, [r1, #36]
	umlal	r7, r8, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
 // mv hh back to h
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0
	mov	r10, #0
	ldr.w	r12, [r2, #420]
	ldr.w	r14, [r2, #424]
	ldr.w	r3, [r2, #428]
	// ([105-107],15),([106-107],14),(107,13) blocks
	ldr.w	r4, [r1, #60]
	umlal	r8, r9, r3, r4
	umlal	r7, r8, r14, r4
	umlal	r6, r7, r12, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	ldr.w	r4, [r1, #56]
	umlal	r7, r8, r3, r4
	umlal	r6, r7, r14, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	ldr.w	r4, [r1, #52]
	umlal	r6, r7, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	pop.w {pc}
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x128_mod2_jump_head
.type  __polymul_128x128_mod2_jump_head, %function
__polymul_128x128_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	mov.w r9, r7
	sub.w r2, #368
	b.w mul_128
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x128_mod2
.type  __polymul_128x128_mod2, %function
__polymul_128x128_mod2:
	push.w {lr}
	bl.w mul_head
	mov.w r9, r7
	sub.w r2, #368
	b.w mul_128
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x256_mod2_jump_head
.type  __polymul_128x256_mod2_jump_head, %function
__polymul_128x256_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	mov.w r8, r7
	sub.w r2, #304
	b.w mul_256
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x256_mod2
.type  __polymul_128x256_mod2, %function
__polymul_128x256_mod2:
	push.w {lr}
	bl.w mul_head
	mov.w r8, r7
	sub.w r2, #304
	b.w mul_256
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x384_mod2_jump_head
.type  __polymul_128x384_mod2_jump_head, %function
__polymul_128x384_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	sub.w r2, #240
	b.w mul_384
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x384_mod2
.type  __polymul_128x384_mod2, %function
__polymul_128x384_mod2:
	push.w {lr}
	bl.w mul_head
	sub.w r2, #240
	b.w mul_384
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x512_mod2_jump_head
.type  __polymul_128x512_mod2_jump_head, %function
__polymul_128x512_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	mov.w r6, r7
	sub.w r2, #176
	b.w mul_512
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x512_mod2
.type  __polymul_128x512_mod2, %function
__polymul_128x512_mod2:
	push.w {lr}
	bl.w mul_head
	mov.w r6, r7
	sub.w r2, #176
	b.w mul_512
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x640_mod2_jump_head
.type  __polymul_128x640_mod2_jump_head, %function
__polymul_128x640_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	mov.w r10, r7
	sub.w r2, #112
	b.w mul_640
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x640_mod2
.type  __polymul_128x640_mod2, %function
__polymul_128x640_mod2:
	push.w {lr}
	bl.w mul_head
	mov.w r10, r7
	sub.w r2, #112
	b.w mul_640
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x768_mod2_jump_head
.type  __polymul_128x768_mod2_jump_head, %function
__polymul_128x768_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	mov.w r9, r7
	sub.w r2, #48
	b.w mul_768
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x768_mod2
.type  __polymul_128x768_mod2, %function
__polymul_128x768_mod2:
	push.w {lr}
	bl.w mul_head
	mov.w r9, r7
	sub.w r2, #48
	b.w mul_768
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x832_mod2_jump_head
.type  __polymul_128x832_mod2_jump_head, %function
__polymul_128x832_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	mov.w r6, r7
	sub.w r2, #16
	b.w mul_832
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x864_mod2
.type  __polymul_128x864_mod2, %function
__polymul_128x864_mod2:
	push.w {lr}
	bl.w mul_head
	b.w mul_864
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x832_mod2
.type  __polymul_128x832_mod2, %function
__polymul_128x832_mod2:
 // increasing thread length
	push.w {lr}
	mov	r6, #0
	// ([0-3], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #12]
	ldr.w	r3, [r2, #8]
	ldr.w	r14, [r2, #4]
	ldr.w	r12, [r2, #0]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([0-2],1), ([0-1],2), (0,3) blocks
	ldr.w	r5, [r1, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	ldr.w	r5, [r1, #8]
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	ldr.w	r5, [r1, #12]
	umlal	r9, r10, r12, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([4-7], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #28]
	ldr.w	r14, [r2, #24]
	ldr.w	r12, [r2, #20]
	ldr.w	r5, [r2, #16]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([3-6], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([2-5], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #8]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([1-4], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #4]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([0-3], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #0]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([0-2],5), ([0-1],6), (0,7) blocks
	ldr.w	r5, [r1, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	ldr.w	r5, [r1, #24]
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	ldr.w	r5, [r1, #28]
	umlal	r8, r9, r12, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([8-11], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #44]
	ldr.w	r12, [r2, #40]
	ldr.w	r5, [r2, #36]
	ldr.w	r4, [r2, #32]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([7-10], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([6-9], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([5-8], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([4-7], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([3-6], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([2-5], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #8]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([1-4], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #4]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([0-3], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #0]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([0-2],9), ([0-1],10), (0,11) blocks
	ldr.w	r5, [r1, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	ldr.w	r5, [r1, #40]
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	ldr.w	r5, [r1, #44]
	umlal	r7, r8, r12, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([12-15], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #60]
	ldr.w	r5, [r2, #56]
	ldr.w	r4, [r2, #52]
	ldr.w	r3, [r2, #48]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([11-14], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #44]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([10-13], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #40]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([9-12], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([8-11], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([7-10], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #28]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([6-9], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #24]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([5-8], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #20]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([4-7], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([3-6], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([2-5], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #8]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([1-4], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #4]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([0-3], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #0]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([0-2],13), ([0-1],14), (0,15) blocks
	ldr.w	r5, [r1, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	umlal	r9, r10, r12, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr.w	r5, [r1, #56]
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr.w	r5, [r1, #60]
	umlal	r6, r7, r12, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([16-19], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #76]
	ldr.w	r4, [r2, #72]
	ldr.w	r3, [r2, #68]
	ldr.w	r14, [r2, #64]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([15-18], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #60]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([14-17], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([13-16], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([12-15], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #48]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([11-14], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #44]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([10-13], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #40]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([9-12], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([8-11], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([7-10], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #28]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([6-9], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #24]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([5-8], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #20]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([4-7], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([3-6], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([2-5], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #8]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([1-4], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #4]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([20-23], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #92]
	ldr.w	r3, [r2, #88]
	ldr.w	r14, [r2, #84]
	ldr.w	r12, [r2, #80]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([19-22], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([18-21], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([17-20], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #68]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([16-19], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #64]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([15-18], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #60]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([14-17], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([13-16], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([12-15], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #48]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([11-14], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #44]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([10-13], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #40]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([9-12], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([8-11], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([7-10], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #28]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([6-9], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #24]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([5-8], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #20]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([24-27], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #108]
	ldr.w	r14, [r2, #104]
	ldr.w	r12, [r2, #100]
	ldr.w	r5, [r2, #96]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([23-26], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([22-25], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #88]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([21-24], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #84]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([20-23], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #80]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([19-22], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([18-21], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([17-20], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #68]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([16-19], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #64]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([15-18], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #60]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([14-17], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([13-16], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([12-15], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #48]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([11-14], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #44]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([10-13], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #40]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([9-12], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([28-31], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #124]
	ldr.w	r12, [r2, #120]
	ldr.w	r5, [r2, #116]
	ldr.w	r4, [r2, #112]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([27-30], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #108]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([26-29], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #104]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([25-28], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #100]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([24-27], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([23-26], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([22-25], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #88]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([21-24], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #84]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([20-23], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #80]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([19-22], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([18-21], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([17-20], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #68]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([16-19], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #64]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([15-18], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #60]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([14-17], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #56]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([13-16], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([32-35], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #140]
	ldr.w	r5, [r2, #136]
	ldr.w	r4, [r2, #132]
	ldr.w	r3, [r2, #128]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([31-34], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #124]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([30-33], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #120]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([29-32], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([28-31], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([27-30], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #108]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([26-29], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #104]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([25-28], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #100]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([24-27], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([23-26], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([22-25], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #88]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([21-24], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #84]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([20-23], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #80]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([19-22], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #76]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([18-21], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #72]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([17-20], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #68]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([36-39], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #156]
	ldr.w	r4, [r2, #152]
	ldr.w	r3, [r2, #148]
	ldr.w	r14, [r2, #144]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([35-38], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #140]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([34-37], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([33-36], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([32-35], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #128]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([31-34], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #124]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([30-33], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #120]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([29-32], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([28-31], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([27-30], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #108]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([26-29], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #104]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([25-28], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #100]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([24-27], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #96]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([23-26], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #92]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([22-25], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #88]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([21-24], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #84]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([40-43], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #172]
	ldr.w	r3, [r2, #168]
	ldr.w	r14, [r2, #164]
	ldr.w	r12, [r2, #160]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([39-42], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([38-41], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([37-40], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #148]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([36-39], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #144]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([35-38], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #140]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([34-37], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([33-36], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([32-35], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #128]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([31-34], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #124]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([30-33], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #120]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([29-32], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([28-31], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #112]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([27-30], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #108]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([26-29], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #104]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([25-28], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #100]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([44-47], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #188]
	ldr.w	r14, [r2, #184]
	ldr.w	r12, [r2, #180]
	ldr.w	r5, [r2, #176]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([43-46], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #172]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([42-45], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #168]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([41-44], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #164]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([40-43], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #160]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([39-42], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #156]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([38-41], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #152]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([37-40], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #148]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([36-39], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #144]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([35-38], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #140]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([34-37], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([33-36], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([32-35], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #128]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([31-34], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #124]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([30-33], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #120]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([29-32], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #116]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([48-51], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #204]
	ldr.w	r12, [r2, #200]
	ldr.w	r5, [r2, #196]
	ldr.w	r4, [r2, #192]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([47-50], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #188]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([46-49], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #184]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([45-48], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #180]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([44-47], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #176]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([43-46], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #172]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([42-45], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #168]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([41-44], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #164]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([40-43], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #160]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([39-42], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([38-41], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([37-40], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #148]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([36-39], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #144]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([35-38], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #140]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([34-37], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #136]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([33-36], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #132]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([52-55], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #220]
	ldr.w	r5, [r2, #216]
	ldr.w	r4, [r2, #212]
	ldr.w	r3, [r2, #208]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([51-54], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #204]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([50-53], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #200]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([49-52], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #196]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([48-51], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #192]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([47-50], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #188]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([46-49], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #184]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([45-48], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #180]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([44-47], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([43-46], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([42-45], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #168]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([41-44], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #164]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([40-43], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #160]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([39-42], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #156]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([38-41], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #152]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([37-40], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #148]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([56-59], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #236]
	ldr.w	r4, [r2, #232]
	ldr.w	r3, [r2, #228]
	ldr.w	r14, [r2, #224]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([55-58], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #220]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([54-57], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #216]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([53-56], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #212]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([52-55], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #208]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([51-54], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #204]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([50-53], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #200]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([49-52], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #196]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([48-51], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([47-50], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #188]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([46-49], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #184]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([45-48], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #180]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([44-47], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #176]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([43-46], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #172]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([42-45], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #168]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([41-44], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #164]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([60-63], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #252]
	ldr.w	r3, [r2, #248]
	ldr.w	r14, [r2, #244]
	ldr.w	r12, [r2, #240]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([59-62], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #236]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([58-61], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #232]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([57-60], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #228]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([56-59], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #224]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([55-58], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #220]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([54-57], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #216]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([53-56], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #212]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([52-55], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #208]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([51-54], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #204]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([50-53], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #200]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([49-52], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([48-51], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #192]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([47-50], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #188]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([46-49], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #184]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([45-48], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #180]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([64-67], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #268]
	ldr.w	r14, [r2, #264]
	ldr.w	r12, [r2, #260]
	ldr.w	r5, [r2, #256]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([63-66], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #252]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([62-65], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #248]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([61-64], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #244]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([60-63], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #240]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([59-62], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #236]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([58-61], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #232]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([57-60], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #228]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([56-59], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #224]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([55-58], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #220]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([54-57], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #216]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([53-56], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #212]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([52-55], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #208]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([51-54], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #204]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([50-53], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #200]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([49-52], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #196]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([68-71], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #284]
	ldr.w	r12, [r2, #280]
	ldr.w	r5, [r2, #276]
	ldr.w	r4, [r2, #272]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([67-70], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #268]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([66-69], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #264]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([65-68], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #260]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([64-67], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #256]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([63-66], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #252]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([62-65], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #248]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([61-64], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #244]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([60-63], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #240]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([59-62], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #236]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([58-61], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #232]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([57-60], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #228]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([56-59], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #224]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([55-58], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #220]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([54-57], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #216]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([53-56], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #212]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([72-75], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #300]
	ldr.w	r5, [r2, #296]
	ldr.w	r4, [r2, #292]
	ldr.w	r3, [r2, #288]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([71-74], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #284]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([70-73], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #280]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([69-72], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #276]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([68-71], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #272]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([67-70], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #268]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([66-69], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #264]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([65-68], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #260]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([64-67], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #256]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([63-66], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #252]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([62-65], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #248]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([61-64], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #244]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([60-63], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #240]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([59-62], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #236]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([58-61], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #232]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([57-60], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #228]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([76-79], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #316]
	ldr.w	r4, [r2, #312]
	ldr.w	r3, [r2, #308]
	ldr.w	r14, [r2, #304]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([75-78], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #300]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([74-77], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #296]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([73-76], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #292]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([72-75], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #288]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([71-74], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #284]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([70-73], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #280]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([69-72], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #276]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([68-71], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #272]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([67-70], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #268]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([66-69], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #264]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([65-68], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #260]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([64-67], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #256]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([63-66], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #252]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([62-65], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #248]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([61-64], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #244]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([80-83], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #332]
	ldr.w	r3, [r2, #328]
	ldr.w	r14, [r2, #324]
	ldr.w	r12, [r2, #320]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([79-82], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #316]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([78-81], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #312]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([77-80], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #308]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([76-79], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #304]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([75-78], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #300]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([74-77], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #296]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([73-76], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #292]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([72-75], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #288]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([71-74], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #284]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([70-73], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #280]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([69-72], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #276]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([68-71], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #272]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([67-70], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #268]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([66-69], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #264]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([65-68], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #260]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([84-87], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #348]
	ldr.w	r14, [r2, #344]
	ldr.w	r12, [r2, #340]
	ldr.w	r5, [r2, #336]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([83-86], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #332]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([82-85], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #328]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([81-84], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #324]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([80-83], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #320]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([79-82], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #316]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([78-81], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #312]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([77-80], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #308]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([76-79], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #304]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([75-78], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #300]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([74-77], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #296]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([73-76], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #292]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([72-75], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #288]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([71-74], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #284]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([70-73], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #280]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	// ([69-72], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #276]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([88-91], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #364]
	ldr.w	r12, [r2, #360]
	ldr.w	r5, [r2, #356]
	ldr.w	r4, [r2, #352]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([87-90], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #348]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([86-89], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #344]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([85-88], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #340]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([84-87], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #336]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([83-86], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #332]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([82-85], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #328]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([81-84], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #324]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([80-83], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #320]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([79-82], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #316]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([78-81], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #312]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([77-80], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #308]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([76-79], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #304]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([75-78], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #300]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([74-77], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #296]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([73-76], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #292]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([92-95], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #380]
	ldr.w	r5, [r2, #376]
	ldr.w	r4, [r2, #372]
	ldr.w	r3, [r2, #368]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([91-94], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #364]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([90-93], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #360]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([89-92], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #356]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([88-91], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #352]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([87-90], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #348]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([86-89], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #344]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([85-88], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #340]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([84-87], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #336]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([83-86], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #332]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([82-85], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #328]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([81-84], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #324]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([80-83], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #320]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([79-82], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #316]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([78-81], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #312]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	// ([77-80], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #308]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([96-99], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #396]
	ldr.w	r4, [r2, #392]
	ldr.w	r3, [r2, #388]
	ldr.w	r14, [r2, #384]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([95-98], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #380]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([94-97], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #376]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([93-96], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #372]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([92-95], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #368]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([91-94], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #364]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([90-93], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #360]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([89-92], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #356]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([88-91], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #352]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([87-90], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #348]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([86-89], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #344]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([85-88], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #340]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([84-87], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #336]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([83-86], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #332]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([82-85], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #328]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	// ([81-84], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #324]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([100-103], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #412]
	ldr.w	r3, [r2, #408]
	ldr.w	r14, [r2, #404]
	ldr.w	r12, [r2, #400]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([99-102], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #396]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([98-101], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #392]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([97-100], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #388]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([96-99], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #384]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([95-98], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #380]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([94-97], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #376]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([93-96], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #372]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([92-95], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #368]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([91-94], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #364]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([90-93], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #360]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([89-92], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #356]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([88-91], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #352]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([87-90], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #348]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([86-89], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #344]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	// ([85-88], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #340]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	pop.w {pc}
