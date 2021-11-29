.p2align 2,,3
.syntax unified
.text
mul_head_last:
	push.w {lr}
	ldr	r5, [r1, #0]
	ldr	r6, [r1, #4]
	ldr.w	r7, [r1, #8]
	ldr	r8, [r1, #12]
	ldr	r12, [r2, #12]
	ldr	r14, [r2, #8]
	ldr	r3, [r2, #4]
	ldr	r4, [r2, #0]
	umull	r9, r10, r5, r12
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	umlal	r9, r10, r6, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	umlal	r9, r10, r7, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	umlal	r9, r10, r8, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	str.w r9, [r0], #4
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
	pop.w {pc}
mul_32:
 // decreasing thread length
 // mv hh back to h
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0
	ldr.w	r14, [r2, #4]
	ldr.w	r3, [r2, #8]
	ldr.w	r4, [r2, #12]
	// ([1-3],3),([2-3],2),(3,1) blocks
	ldr.w	r5, [r1, #12]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	ldr.w	r5, [r1, #8]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	ldr.w	r5, [r1, #4]
	umlal	r10, r6, r4, r5
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	pop.w {pc}
.p2align 2,,3
.syntax unified
.text
.global __polymul_32x32_mod2_jump_head
.type  __polymul_32x32_mod2_jump_head, %function
__polymul_32x32_mod2_jump_head:
	push.w {lr}
	bl.w mul_head_last
	b.w mul_32
.p2align 2,,3
.syntax unified
.text
.global __polymul_32x704_mod2
.type  __polymul_32x704_mod2, %function
__polymul_32x704_mod2:
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
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	pop.w {pc}
