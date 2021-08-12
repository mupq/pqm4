.p2align 2,,3
.syntax unified
.text
mul_head_last:
	push.w {lr}
	ldr	r4, [r1, #0]
	ldr	r10, [r1, #4]
	ldr	r6, [r1, #8]
	ldr	r7, [r1, #12]
	ldr	r5, [r2, #28]
	ldr	r12, [r2, #24]
	ldr	r14, [r2, #20]
	ldr	r3, [r2, #16]
	umull	r8, r9, r4, r5
	umlal	r8, r9, r10, r12
	umlal	r8, r9, r6, r14
	umlal	r8, r9, r7, r3
	ldr	r4, [r1, #16]
	ldr	r10, [r1, #20]
	ldr	r6, [r1, #24]
	ldr	r7, [r1, #28]
	ldr	r5, [r2, #12]
	ldr	r12, [r2, #8]
	ldr	r14, [r2, #4]
	ldr	r3, [r2, #0]
	umlal	r8, r9, r4, r5
	umlal	r8, r9, r10, r12
	umlal	r8, r9, r6, r14
	umlal	r8, r9, r7, r3
	and.w r4, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r4, LSR #4 // range < 31
	str.w r8, [r0], #4
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
	// ([0-2],1), ([0-1],2), (0,3) blocks
	ldr.w	r5, [r1, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	ldr.w	r5, [r1, #8]
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	ldr.w	r5, [r1, #12]
	umlal	r9, r10, r12, r5
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
	// ([3-6], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([2-5], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #8]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([1-4], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #4]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([0-3], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #0]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],5), ([0-1],6), (0,7) blocks
	ldr.w	r5, [r1, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	ldr.w	r5, [r1, #24]
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	ldr.w	r5, [r1, #28]
	umlal	r8, r9, r12, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	pop.w {pc}
mul_32:
 // decreasing thread length
	// ([1-4], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r5, [r2, #16]
	ldr.w	r4, [r2, #12]
	ldr.w	r3, [r2, #8]
	ldr.w	r14, [r2, #4]
	umull	r10, r6, r3, r12
	umull	r7, r8, r5, r12
	umlal	r9, r10, r14, r12
	umlal	r6, r7, r4, r12
	// ([2-5], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([3-6], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([4-7], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([5-7],3),([6-7],2),(7,1) blocks
	ldr.w	r4, [r1, #12]
	umlal	r6, r7, r3, r4
	umlal	r10, r6, r14, r4
	umlal	r9, r10, r12, r4
	ldr.w	r4, [r1, #8]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r14, r4
	ldr.w	r4, [r1, #4]
	umlal	r9, r10, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
 // mv hh back to h
	mov	r9, #0
	mov	r10, #0
	mov	r6, #0
	mov	r7, #0
	ldr.w	r12, [r2, #20]
	ldr.w	r14, [r2, #24]
	ldr.w	r3, [r2, #28]
	// ([5-7],7),([6-7],6),(7,5) blocks
	ldr.w	r4, [r1, #28]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r14, r4
	umlal	r8, r9, r12, r4
	ldr.w	r4, [r1, #24]
	umlal	r9, r10, r3, r4
	umlal	r8, r9, r14, r4
	ldr.w	r4, [r1, #20]
	umlal	r8, r9, r3, r4
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	pop.w {pc}
.p2align 2,,3
.syntax unified
.text
.global __polymul_32x32_jump_head
.type  __polymul_32x32_jump_head, %function
__polymul_32x32_jump_head:
	push.w {lr}
	bl.w mul_head_last
	b.w mul_32
.p2align 2,,3
.syntax unified
.text
.global __polymul_32x672
.type  __polymul_32x672, %function
__polymul_32x672:
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
	// ([0-2],1), ([0-1],2), (0,3) blocks
	ldr.w	r5, [r1, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	ldr.w	r5, [r1, #8]
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	ldr.w	r5, [r1, #12]
	umlal	r9, r10, r12, r5
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
	// ([3-6], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([2-5], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #8]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([1-4], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #4]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([0-3], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #0]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],5), ([0-1],6), (0,7) blocks
	ldr.w	r5, [r1, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	ldr.w	r5, [r1, #24]
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	ldr.w	r5, [r1, #28]
	umlal	r8, r9, r12, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
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
	// ([7-10], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([6-9], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([5-8], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([4-7], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([3-6], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([2-5], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #8]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([1-4], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #4]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
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
	// ([11-14], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #44]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([10-13], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #40]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([9-12], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([8-11], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([7-10], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #28]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([6-9], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #24]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([5-8], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #20]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	// ([15-18], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #60]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([14-17], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([13-16], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([12-15], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #48]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([11-14], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #44]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([10-13], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #40]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([9-12], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	// ([19-22], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([18-21], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([17-20], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #68]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([16-19], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #64]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([15-18], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #60]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([14-17], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([13-16], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	// ([23-26], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([22-25], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #88]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([21-24], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #84]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([20-23], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #80]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([19-22], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([18-21], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([17-20], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #68]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
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
	// ([27-30], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #108]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([26-29], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #104]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([25-28], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #100]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([24-27], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([23-26], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([22-25], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #88]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([21-24], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #84]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
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
	// ([31-34], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #124]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([30-33], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #120]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([29-32], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([28-31], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([27-30], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #108]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([26-29], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #104]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([25-28], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #100]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	// ([35-38], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #140]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([34-37], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([33-36], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([32-35], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #128]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([31-34], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #124]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([30-33], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #120]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([29-32], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	// ([39-42], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([38-41], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([37-40], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #148]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([36-39], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #144]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([35-38], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #140]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([34-37], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([33-36], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	// ([43-46], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #172]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([42-45], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #168]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([41-44], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #164]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([40-43], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #160]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([39-42], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #156]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([38-41], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #152]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([37-40], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #148]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
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
	// ([47-50], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #188]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([46-49], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #184]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([45-48], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #180]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([44-47], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #176]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([43-46], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #172]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([42-45], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #168]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([41-44], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #164]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
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
	// ([51-54], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #204]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([50-53], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #200]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([49-52], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #196]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([48-51], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #192]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([47-50], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #188]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([46-49], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #184]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([45-48], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #180]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	// ([55-58], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #220]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([54-57], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #216]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([53-56], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #212]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([52-55], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #208]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([51-54], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #204]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([50-53], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #200]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([49-52], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #196]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	// ([59-62], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #236]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([58-61], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #232]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([57-60], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #228]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([56-59], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #224]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([55-58], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #220]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([54-57], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #216]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([53-56], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #212]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	// ([63-66], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #252]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([62-65], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #248]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([61-64], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #244]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([60-63], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #240]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([59-62], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #236]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([58-61], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #232]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([57-60], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #228]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
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
	// ([67-70], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #268]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([66-69], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #264]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([65-68], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #260]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([64-67], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #256]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([63-66], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #252]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([62-65], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #248]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([61-64], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #244]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
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
	// ([71-74], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #284]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([70-73], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #280]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([69-72], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #276]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([68-71], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #272]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([67-70], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #268]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([66-69], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #264]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([65-68], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #260]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	// ([75-78], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #300]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([74-77], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #296]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([73-76], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #292]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([72-75], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #288]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([71-74], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #284]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([70-73], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #280]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([69-72], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #276]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	// ([79-82], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #316]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([78-81], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #312]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([77-80], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #308]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([76-79], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #304]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([75-78], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #300]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([74-77], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #296]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([73-76], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #292]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	// ([83-86], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #332]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([82-85], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #328]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([81-84], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #324]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([80-83], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #320]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([79-82], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #316]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([78-81], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #312]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([77-80], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #308]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
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
	// ([87-90], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #348]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([86-89], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #344]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([85-88], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #340]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([84-87], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #336]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([83-86], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #332]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([82-85], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #328]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([81-84], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #324]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
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
	// ([91-94], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #364]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([90-93], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #360]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([89-92], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #356]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([88-91], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #352]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([87-90], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #348]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([86-89], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #344]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([85-88], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #340]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	// ([95-98], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #380]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([94-97], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #376]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([93-96], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #372]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([92-95], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #368]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([91-94], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #364]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([90-93], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #360]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([89-92], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #356]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	// ([99-102], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #396]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([98-101], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #392]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([97-100], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #388]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([96-99], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #384]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([95-98], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #380]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([94-97], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #376]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([93-96], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #372]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	// ([103-106], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #412]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([102-105], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #408]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([101-104], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #404]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([100-103], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #400]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([99-102], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #396]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([98-101], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #392]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([97-100], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #388]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([108-111], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #444]
	ldr.w	r12, [r2, #440]
	ldr.w	r5, [r2, #436]
	ldr.w	r4, [r2, #432]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([107-110], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #428]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([106-109], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #424]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([105-108], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #420]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([104-107], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #416]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([103-106], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #412]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([102-105], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #408]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([101-104], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #404]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([112-115], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #460]
	ldr.w	r5, [r2, #456]
	ldr.w	r4, [r2, #452]
	ldr.w	r3, [r2, #448]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([111-114], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #444]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([110-113], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #440]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([109-112], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #436]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([108-111], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #432]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([107-110], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #428]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([106-109], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #424]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([105-108], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #420]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([116-119], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #476]
	ldr.w	r4, [r2, #472]
	ldr.w	r3, [r2, #468]
	ldr.w	r14, [r2, #464]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([115-118], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #460]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([114-117], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #456]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([113-116], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #452]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([112-115], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #448]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([111-114], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #444]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([110-113], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #440]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([109-112], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #436]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([120-123], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #492]
	ldr.w	r3, [r2, #488]
	ldr.w	r14, [r2, #484]
	ldr.w	r12, [r2, #480]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([119-122], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #476]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([118-121], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #472]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([117-120], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #468]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([116-119], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #464]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([115-118], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #460]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([114-117], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #456]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([113-116], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #452]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([124-127], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #508]
	ldr.w	r14, [r2, #504]
	ldr.w	r12, [r2, #500]
	ldr.w	r5, [r2, #496]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([123-126], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #492]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([122-125], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #488]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([121-124], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #484]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([120-123], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #480]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([119-122], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #476]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([118-121], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #472]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([117-120], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #468]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([128-131], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #524]
	ldr.w	r12, [r2, #520]
	ldr.w	r5, [r2, #516]
	ldr.w	r4, [r2, #512]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([127-130], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #508]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([126-129], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #504]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([125-128], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #500]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([124-127], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #496]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([123-126], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #492]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([122-125], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #488]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([121-124], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #484]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([132-135], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #540]
	ldr.w	r5, [r2, #536]
	ldr.w	r4, [r2, #532]
	ldr.w	r3, [r2, #528]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([131-134], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #524]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([130-133], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #520]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([129-132], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #516]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([128-131], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #512]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([127-130], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #508]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([126-129], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #504]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([125-128], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #500]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([136-139], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #556]
	ldr.w	r4, [r2, #552]
	ldr.w	r3, [r2, #548]
	ldr.w	r14, [r2, #544]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([135-138], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #540]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([134-137], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #536]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([133-136], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #532]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([132-135], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #528]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([131-134], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #524]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([130-133], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #520]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([129-132], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #516]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([140-143], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #572]
	ldr.w	r3, [r2, #568]
	ldr.w	r14, [r2, #564]
	ldr.w	r12, [r2, #560]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([139-142], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #556]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([138-141], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #552]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([137-140], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #548]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([136-139], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #544]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([135-138], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #540]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([134-137], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #536]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([133-136], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #532]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([144-147], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #588]
	ldr.w	r14, [r2, #584]
	ldr.w	r12, [r2, #580]
	ldr.w	r5, [r2, #576]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([143-146], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #572]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([142-145], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #568]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([141-144], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #564]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([140-143], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #560]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([139-142], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #556]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([138-141], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #552]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([137-140], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #548]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([148-151], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #604]
	ldr.w	r12, [r2, #600]
	ldr.w	r5, [r2, #596]
	ldr.w	r4, [r2, #592]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([147-150], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #588]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([146-149], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #584]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([145-148], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #580]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([144-147], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #576]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([143-146], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #572]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([142-145], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #568]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([141-144], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #564]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([152-155], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #620]
	ldr.w	r5, [r2, #616]
	ldr.w	r4, [r2, #612]
	ldr.w	r3, [r2, #608]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([151-154], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #604]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([150-153], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #600]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([149-152], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #596]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([148-151], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #592]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([147-150], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #588]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([146-149], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #584]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([145-148], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #580]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
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
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([156-159], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #636]
	ldr.w	r4, [r2, #632]
	ldr.w	r3, [r2, #628]
	ldr.w	r14, [r2, #624]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([155-158], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #620]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([154-157], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #616]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([153-156], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #612]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([152-155], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #608]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([151-154], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #604]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([150-153], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #600]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([149-152], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #596]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
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
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([160-163], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #652]
	ldr.w	r3, [r2, #648]
	ldr.w	r14, [r2, #644]
	ldr.w	r12, [r2, #640]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([159-162], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #636]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([158-161], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #632]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([157-160], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #628]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([156-159], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #624]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([155-158], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #620]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([154-157], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #616]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([153-156], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #612]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
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
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([164-167], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #668]
	ldr.w	r14, [r2, #664]
	ldr.w	r12, [r2, #660]
	ldr.w	r5, [r2, #656]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([163-166], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #652]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([162-165], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #648]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([161-164], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #644]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([160-163], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #640]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([159-162], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #636]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([158-161], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #632]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([157-160], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #628]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	pop.w {pc}
