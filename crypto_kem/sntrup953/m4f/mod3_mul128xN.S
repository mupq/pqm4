.p2align 2,,3
.syntax unified
.text
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
	// ([0-3], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #0]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([0-2],9), ([0-1],10), (0,11) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #40]
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #44]
	umlal	r7, r8, r12, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	// ([4-7], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([3-6], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([2-5], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #8]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([1-4], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #4]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([0-3], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #0]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([0-2],13), ([0-1],14), (0,15) blocks
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	umlal	r9, r10, r12, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #56]
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #60]
	umlal	r6, r7, r12, r5
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
	// ([8-11], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([7-10], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #28]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([6-9], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #24]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([5-8], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #20]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([4-7], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([3-6], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([2-5], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #8]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([1-4], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #4]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([0-3], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #0]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([0-2],17), ([0-1],18), (0,19) blocks
	ldr.w	r5, [r1, #68]
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	ldr.w	r5, [r1, #72]
	umlal	r10, r6, r14, r5
	umlal	r9, r10, r12, r5
	ldr.w	r5, [r1, #76]
	umlal	r10, r6, r12, r5
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
	// ([12-15], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #48]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([11-14], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #44]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([10-13], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #40]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([8-11], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([7-10], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #28]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([6-9], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #24]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([5-8], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #20]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([4-7], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #16]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([3-6], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #12]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([2-5], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #8]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([1-4], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #4]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([0-3], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #0]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([0-2],21), ([0-1],22), (0,23) blocks
	ldr.w	r5, [r1, #84]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #88]
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #92]
	umlal	r9, r10, r12, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
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
	// ([16-19], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #64]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([15-18], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #60]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([14-17], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([13-16], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([12-15], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #48]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([11-14], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #44]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([10-13], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #40]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([9-12], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([8-11], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #32]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([7-10], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #28]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([6-9], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #24]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([5-8], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #20]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([4-7], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #16]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([3-6], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([2-5], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #8]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([1-4], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #4]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([0-3], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #0]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],25), ([0-1],26), (0,27) blocks
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #100]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #104]
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #108]
	umlal	r8, r9, r12, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
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
	// ([20-23], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #80]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([19-22], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([18-21], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([17-20], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #68]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([16-19], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #64]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([15-18], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #60]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([14-17], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #56]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([13-16], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([12-15], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #48]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([11-14], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #44]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([10-13], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #40]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([9-12], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #36]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([8-11], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #32]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([7-10], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([6-9], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([5-8], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([4-7], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([3-6], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([2-5], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #8]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([1-4], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #4]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([0-3], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #0]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([0-2],29), ([0-1],30), (0,31) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #116]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	ldr.w	r5, [r1, #120]
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	ldr.w	r5, [r1, #124]
	umlal	r7, r8, r12, r5
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	pop.w {pc}
mul_976:
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
	// ([24-27], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([23-26], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([22-25], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #88]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([21-24], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #84]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([20-23], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #80]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([19-22], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #76]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([18-21], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #72]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([17-20], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #68]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([16-19], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #64]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([15-18], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #60]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([14-17], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #56]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([13-16], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #52]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([12-15], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #48]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([11-14], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #44]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([10-13], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #40]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([9-12], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([8-11], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([7-10], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #28]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([6-9], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #24]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([5-8], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #20]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([4-7], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([3-6], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([2-5], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #8]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([1-4], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #4]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
mul_960:
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
	// ([28-31], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([27-30], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #108]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([26-29], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #104]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([25-28], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #100]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([24-27], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #96]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([23-26], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #92]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([22-25], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #88]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([21-24], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #84]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([20-23], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #80]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([19-22], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #76]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([18-21], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #72]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([17-20], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #68]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([16-19], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #64]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([15-18], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #60]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([14-17], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([13-16], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([12-15], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #48]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([11-14], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #44]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([10-13], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #40]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([9-12], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([8-11], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([7-10], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #28]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([6-9], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #24]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([5-8], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #20]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([32-35], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #128]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([31-34], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #124]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([30-33], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #120]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([29-32], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([28-31], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #112]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([27-30], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #108]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([26-29], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #104]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([25-28], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #100]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([24-27], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #96]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([23-26], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #92]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([22-25], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #88]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([21-24], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #84]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([20-23], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #80]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([19-22], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([18-21], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([17-20], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #68]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([16-19], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #64]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([15-18], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #60]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([14-17], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([13-16], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([12-15], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #48]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([11-14], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #44]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([10-13], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #40]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([36-39], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #144]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([35-38], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #140]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([34-37], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([33-36], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([32-35], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #128]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([31-34], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #124]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([30-33], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #120]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([29-32], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #116]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([28-31], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #112]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([27-30], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #108]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([26-29], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #104]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([25-28], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #100]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([24-27], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #96]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([23-26], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([22-25], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #88]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([21-24], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #84]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([20-23], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #80]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([19-22], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([18-21], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([17-20], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #68]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([16-19], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #64]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([15-18], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #60]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([14-17], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([13-16], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([40-43], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #160]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([39-42], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([38-41], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([37-40], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #148]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([36-39], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #144]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([35-38], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #140]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([34-37], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #136]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([33-36], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #132]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([32-35], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #128]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([31-34], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #124]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([30-33], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #120]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([29-32], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #116]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([28-31], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #112]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([27-30], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #108]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([26-29], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #104]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([25-28], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #100]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([24-27], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([23-26], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([22-25], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #88]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([21-24], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #84]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([20-23], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #80]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([19-22], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([18-21], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([17-20], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #68]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
mul_896:
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
	// ([44-47], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([43-46], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([42-45], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #168]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([41-44], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #164]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([40-43], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #160]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([39-42], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #156]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([38-41], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #152]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([37-40], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #148]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([36-39], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #144]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([35-38], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #140]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([34-37], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #136]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([33-36], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #132]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([32-35], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #128]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([31-34], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #124]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([30-33], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #120]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([29-32], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([28-31], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([27-30], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #108]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([26-29], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #104]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([25-28], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #100]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([24-27], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([23-26], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([22-25], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #88]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([21-24], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #84]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([48-51], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([47-50], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #188]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([46-49], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #184]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([45-48], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #180]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([44-47], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #176]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([43-46], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #172]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([42-45], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #168]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([41-44], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #164]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([40-43], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #160]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([39-42], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #156]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([38-41], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #152]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([37-40], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #148]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([36-39], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #144]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([35-38], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #140]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([34-37], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([33-36], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([32-35], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #128]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([31-34], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #124]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([30-33], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #120]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([29-32], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([28-31], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([27-30], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #108]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([26-29], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #104]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([25-28], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #100]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([52-55], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #208]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([51-54], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #204]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([50-53], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #200]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([49-52], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([48-51], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #192]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([47-50], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #188]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([46-49], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #184]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([45-48], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #180]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([44-47], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #176]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([43-46], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #172]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([42-45], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #168]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([41-44], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #164]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([40-43], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #160]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([39-42], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([38-41], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([37-40], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #148]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([36-39], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #144]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([35-38], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #140]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([34-37], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([33-36], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([32-35], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #128]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([31-34], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #124]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([30-33], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #120]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([29-32], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([56-59], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #224]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([55-58], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #220]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([54-57], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #216]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([53-56], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #212]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([52-55], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #208]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([51-54], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #204]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([50-53], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #200]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([49-52], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #196]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([48-51], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #192]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([47-50], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #188]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([46-49], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #184]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([45-48], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #180]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([44-47], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #176]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([43-46], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #172]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([42-45], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #168]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([41-44], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #164]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([40-43], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #160]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([39-42], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #156]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([38-41], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #152]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([37-40], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #148]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([36-39], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #144]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([35-38], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #140]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([34-37], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([33-36], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([60-63], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #240]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([59-62], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #236]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([58-61], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #232]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([57-60], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #228]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([56-59], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #224]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([55-58], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #220]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([54-57], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #216]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([53-56], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #212]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([52-55], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #208]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([51-54], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #204]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([50-53], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #200]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([49-52], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #196]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([48-51], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #192]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([47-50], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #188]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([46-49], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #184]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([45-48], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #180]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([44-47], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #176]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([43-46], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #172]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([42-45], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #168]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([41-44], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #164]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([40-43], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #160]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([39-42], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([38-41], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([37-40], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #148]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([64-67], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #256]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([63-66], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #252]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([62-65], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #248]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([61-64], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #244]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([60-63], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #240]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([59-62], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #236]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([58-61], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #232]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([57-60], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #228]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([56-59], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #224]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([55-58], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #220]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([54-57], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #216]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([53-56], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #212]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([52-55], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #208]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([51-54], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #204]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([50-53], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #200]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([49-52], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #196]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([48-51], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #192]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([47-50], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #188]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([46-49], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #184]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([45-48], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #180]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([44-47], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([43-46], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([42-45], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #168]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([41-44], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #164]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([68-71], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #272]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([67-70], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #268]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([66-69], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #264]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([65-68], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #260]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([64-67], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #256]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([63-66], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #252]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([62-65], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #248]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([61-64], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #244]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([60-63], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #240]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([59-62], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #236]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([58-61], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #232]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([57-60], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #228]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([56-59], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #224]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([55-58], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #220]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([54-57], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #216]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([53-56], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #212]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([52-55], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #208]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([51-54], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #204]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([50-53], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #200]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([49-52], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #196]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([48-51], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([47-50], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #188]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([46-49], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #184]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([45-48], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #180]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([72-75], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #288]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([71-74], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #284]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([70-73], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #280]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([69-72], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #276]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([68-71], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #272]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([67-70], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #268]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([66-69], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #264]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([65-68], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #260]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([64-67], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #256]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([63-66], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #252]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([62-65], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #248]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([61-64], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #244]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([60-63], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #240]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([59-62], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #236]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([58-61], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #232]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([57-60], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #228]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([56-59], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #224]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([55-58], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #220]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([54-57], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #216]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([53-56], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #212]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([52-55], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #208]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([51-54], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #204]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([50-53], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #200]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([49-52], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
mul_768:
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
	// ([76-79], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #304]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([75-78], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #300]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([74-77], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #296]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([73-76], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #292]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([72-75], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #288]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([71-74], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #284]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([70-73], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #280]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([69-72], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #276]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([68-71], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #272]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([67-70], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #268]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([66-69], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #264]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([65-68], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #260]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([64-67], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #256]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([63-66], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #252]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([62-65], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #248]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([61-64], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #244]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([60-63], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #240]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([59-62], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #236]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([58-61], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #232]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([57-60], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #228]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([56-59], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #224]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([55-58], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #220]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([54-57], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #216]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([53-56], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #212]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([80-83], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #320]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([79-82], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #316]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([78-81], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #312]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([77-80], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #308]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([76-79], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #304]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([75-78], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #300]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([74-77], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #296]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([73-76], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #292]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([72-75], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #288]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([71-74], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #284]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([70-73], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #280]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([69-72], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #276]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([68-71], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #272]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([67-70], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #268]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([66-69], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #264]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([65-68], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #260]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([64-67], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #256]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([63-66], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #252]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([62-65], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #248]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([61-64], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #244]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([60-63], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #240]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([59-62], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #236]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([58-61], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #232]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([57-60], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #228]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([84-87], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #336]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([83-86], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #332]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([82-85], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #328]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([81-84], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #324]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([80-83], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #320]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([79-82], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #316]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([78-81], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #312]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([77-80], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #308]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([76-79], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #304]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([75-78], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #300]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([74-77], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #296]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([73-76], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #292]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([72-75], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #288]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([71-74], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #284]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([70-73], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #280]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([69-72], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #276]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([68-71], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #272]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([67-70], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #268]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([66-69], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #264]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([65-68], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #260]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([64-67], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #256]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([63-66], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #252]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([62-65], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #248]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([61-64], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #244]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([88-91], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #352]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([87-90], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #348]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([86-89], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #344]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([85-88], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #340]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([84-87], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #336]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([83-86], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #332]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([82-85], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #328]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([81-84], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #324]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([80-83], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #320]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([79-82], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #316]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([78-81], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #312]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([77-80], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #308]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([76-79], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #304]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([75-78], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #300]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([74-77], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #296]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([73-76], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #292]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([72-75], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #288]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([71-74], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #284]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([70-73], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #280]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([69-72], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #276]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([68-71], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #272]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([67-70], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #268]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([66-69], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #264]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([65-68], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #260]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([92-95], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #368]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([91-94], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #364]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([90-93], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #360]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([89-92], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #356]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([88-91], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #352]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([87-90], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #348]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([86-89], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #344]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([85-88], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #340]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([84-87], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #336]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([83-86], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #332]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([82-85], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #328]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([81-84], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #324]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([80-83], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #320]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([79-82], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #316]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([78-81], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #312]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([77-80], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #308]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([76-79], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #304]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([75-78], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #300]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([74-77], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #296]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([73-76], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #292]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([72-75], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #288]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([71-74], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #284]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([70-73], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #280]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([69-72], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #276]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([96-99], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #384]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([95-98], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #380]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([94-97], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #376]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([93-96], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #372]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([92-95], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #368]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([91-94], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #364]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([90-93], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #360]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([89-92], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #356]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([88-91], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #352]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([87-90], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #348]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([86-89], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #344]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([85-88], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #340]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([84-87], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #336]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([83-86], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #332]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([82-85], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #328]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([81-84], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #324]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([80-83], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #320]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([79-82], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #316]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([78-81], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #312]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([77-80], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #308]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([76-79], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #304]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([75-78], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #300]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([74-77], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #296]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([73-76], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #292]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([100-103], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #400]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([99-102], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #396]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([98-101], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #392]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([97-100], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #388]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([96-99], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #384]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([95-98], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #380]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([94-97], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #376]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([93-96], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #372]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([92-95], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #368]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([91-94], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #364]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([90-93], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #360]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([89-92], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #356]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([88-91], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #352]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([87-90], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #348]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([86-89], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #344]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([85-88], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #340]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([84-87], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #336]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([83-86], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #332]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([82-85], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #328]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([81-84], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #324]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([80-83], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #320]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([79-82], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #316]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([78-81], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #312]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([77-80], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #308]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([104-107], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #416]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([103-106], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #412]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([102-105], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #408]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([101-104], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #404]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([100-103], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #400]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([99-102], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #396]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([98-101], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #392]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([97-100], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #388]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([96-99], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #384]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([95-98], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #380]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([94-97], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #376]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([93-96], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #372]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([92-95], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #368]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([91-94], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #364]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([90-93], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #360]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([89-92], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #356]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([88-91], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #352]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([87-90], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #348]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([86-89], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #344]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([85-88], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #340]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([84-87], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #336]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([83-86], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #332]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([82-85], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #328]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([81-84], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #324]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
mul_640:
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
	// ([108-111], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #432]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([107-110], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #428]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([106-109], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #424]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([105-108], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #420]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([104-107], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #416]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([103-106], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #412]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([102-105], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #408]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([101-104], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #404]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([100-103], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #400]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([99-102], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #396]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([98-101], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #392]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([97-100], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #388]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([96-99], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #384]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([95-98], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #380]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([94-97], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #376]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([93-96], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #372]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([92-95], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #368]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([91-94], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #364]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([90-93], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #360]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([89-92], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #356]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([88-91], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #352]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([87-90], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #348]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([86-89], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #344]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([85-88], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #340]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([112-115], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #448]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([111-114], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #444]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([110-113], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #440]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([109-112], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #436]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([108-111], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #432]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([107-110], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #428]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([106-109], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #424]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([105-108], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #420]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([104-107], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #416]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([103-106], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #412]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([102-105], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #408]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([101-104], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #404]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([100-103], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #400]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([99-102], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #396]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([98-101], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #392]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([97-100], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #388]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([96-99], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #384]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([95-98], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #380]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([94-97], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #376]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([93-96], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #372]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([92-95], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #368]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([91-94], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #364]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([90-93], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #360]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([89-92], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #356]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([116-119], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #464]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([115-118], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #460]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([114-117], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #456]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([113-116], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #452]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([112-115], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #448]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([111-114], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #444]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([110-113], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #440]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([109-112], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #436]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([108-111], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #432]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([107-110], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #428]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([106-109], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #424]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([105-108], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #420]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([104-107], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #416]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([103-106], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #412]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([102-105], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #408]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([101-104], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #404]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([100-103], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #400]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([99-102], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #396]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([98-101], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #392]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([97-100], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #388]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([96-99], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #384]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([95-98], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #380]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([94-97], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #376]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([93-96], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #372]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([120-123], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #480]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([119-122], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #476]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([118-121], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #472]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([117-120], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #468]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([116-119], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #464]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([115-118], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #460]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([114-117], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #456]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([113-116], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #452]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([112-115], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #448]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([111-114], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #444]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([110-113], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #440]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([109-112], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #436]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([108-111], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #432]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([107-110], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #428]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([106-109], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #424]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([105-108], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #420]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([104-107], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #416]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([103-106], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #412]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([102-105], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #408]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([101-104], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #404]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([100-103], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #400]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([99-102], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #396]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([98-101], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #392]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([97-100], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #388]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([124-127], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #496]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([123-126], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #492]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([122-125], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #488]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([121-124], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #484]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([120-123], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #480]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([119-122], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #476]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([118-121], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #472]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([117-120], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #468]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([116-119], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #464]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([115-118], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #460]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([114-117], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #456]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([113-116], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #452]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([112-115], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #448]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([111-114], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #444]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([110-113], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #440]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([109-112], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #436]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([108-111], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #432]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([107-110], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #428]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([106-109], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #424]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([105-108], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #420]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([104-107], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #416]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([103-106], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #412]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([102-105], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #408]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([101-104], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #404]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([128-131], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #512]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([127-130], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #508]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([126-129], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #504]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([125-128], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #500]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([124-127], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #496]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([123-126], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #492]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([122-125], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #488]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([121-124], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #484]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([120-123], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #480]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([119-122], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #476]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([118-121], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #472]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([117-120], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #468]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([116-119], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #464]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([115-118], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #460]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([114-117], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #456]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([113-116], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #452]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([112-115], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #448]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([111-114], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #444]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([110-113], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #440]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([109-112], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #436]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([108-111], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #432]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([107-110], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #428]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([106-109], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #424]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([105-108], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #420]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([132-135], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #528]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([131-134], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #524]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([130-133], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #520]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([129-132], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #516]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([128-131], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #512]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([127-130], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #508]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([126-129], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #504]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([125-128], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #500]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([124-127], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #496]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([123-126], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #492]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([122-125], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #488]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([121-124], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #484]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([120-123], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #480]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([119-122], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #476]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([118-121], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #472]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([117-120], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #468]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([116-119], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #464]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([115-118], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #460]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([114-117], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #456]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([113-116], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #452]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([112-115], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #448]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([111-114], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #444]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([110-113], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #440]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([109-112], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #436]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([136-139], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #544]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([135-138], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #540]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([134-137], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #536]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([133-136], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #532]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([132-135], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #528]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([131-134], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #524]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([130-133], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #520]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([129-132], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #516]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([128-131], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #512]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([127-130], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #508]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([126-129], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #504]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([125-128], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #500]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([124-127], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #496]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([123-126], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #492]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([122-125], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #488]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([121-124], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #484]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([120-123], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #480]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([119-122], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #476]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([118-121], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #472]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([117-120], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #468]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([116-119], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #464]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([115-118], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #460]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([114-117], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #456]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([113-116], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #452]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
mul_512:
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
	// ([140-143], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #560]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([139-142], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #556]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([138-141], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #552]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([137-140], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #548]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([136-139], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #544]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([135-138], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #540]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([134-137], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #536]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([133-136], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #532]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([132-135], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #528]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([131-134], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #524]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([130-133], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #520]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([129-132], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #516]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([128-131], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #512]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([127-130], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #508]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([126-129], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #504]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([125-128], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #500]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([124-127], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #496]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([123-126], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #492]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([122-125], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #488]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([121-124], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #484]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([120-123], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #480]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([119-122], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #476]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([118-121], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #472]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([117-120], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #468]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([144-147], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #576]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([143-146], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #572]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([142-145], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #568]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([141-144], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #564]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([140-143], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #560]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([139-142], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #556]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([138-141], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #552]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([137-140], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #548]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([136-139], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #544]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([135-138], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #540]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([134-137], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #536]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([133-136], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #532]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([132-135], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #528]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([131-134], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #524]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([130-133], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #520]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([129-132], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #516]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([128-131], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #512]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([127-130], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #508]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([126-129], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #504]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([125-128], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #500]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([124-127], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #496]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([123-126], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #492]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([122-125], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #488]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([121-124], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #484]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([148-151], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #592]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([147-150], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #588]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([146-149], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #584]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([145-148], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #580]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([144-147], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #576]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([143-146], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #572]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([142-145], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #568]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([141-144], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #564]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([140-143], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #560]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([139-142], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #556]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([138-141], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #552]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([137-140], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #548]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([136-139], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #544]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([135-138], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #540]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([134-137], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #536]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([133-136], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #532]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([132-135], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #528]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([131-134], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #524]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([130-133], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #520]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([129-132], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #516]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([128-131], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #512]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([127-130], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #508]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([126-129], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #504]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([125-128], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #500]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([152-155], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #608]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([151-154], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #604]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([150-153], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #600]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([149-152], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #596]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([148-151], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #592]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([147-150], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #588]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([146-149], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #584]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([145-148], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #580]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([144-147], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #576]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([143-146], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #572]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([142-145], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #568]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([141-144], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #564]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([140-143], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #560]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([139-142], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #556]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([138-141], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #552]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([137-140], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #548]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([136-139], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #544]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([135-138], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #540]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([134-137], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #536]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([133-136], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #532]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([132-135], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #528]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([131-134], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #524]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([130-133], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #520]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([129-132], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #516]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([156-159], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #624]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([155-158], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #620]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([154-157], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #616]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([153-156], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #612]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([152-155], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #608]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([151-154], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #604]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([150-153], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #600]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([149-152], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #596]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([148-151], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #592]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([147-150], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #588]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([146-149], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #584]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([145-148], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #580]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([144-147], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #576]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([143-146], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #572]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([142-145], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #568]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([141-144], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #564]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([140-143], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #560]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([139-142], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #556]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([138-141], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #552]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([137-140], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #548]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([136-139], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #544]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([135-138], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #540]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([134-137], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #536]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([133-136], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #532]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([168-171], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #684]
	ldr.w	r12, [r2, #680]
	ldr.w	r5, [r2, #676]
	ldr.w	r4, [r2, #672]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([167-170], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #668]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([166-169], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #664]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([165-168], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #660]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([164-167], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #656]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([163-166], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #652]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([162-165], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #648]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([161-164], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #644]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([160-163], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #640]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([159-162], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #636]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([158-161], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #632]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([157-160], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #628]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([156-159], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #624]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([155-158], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #620]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([154-157], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #616]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([153-156], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #612]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([152-155], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #608]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([151-154], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #604]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([150-153], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #600]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([149-152], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #596]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([148-151], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #592]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([147-150], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #588]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([146-149], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #584]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([145-148], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #580]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([144-147], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #576]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([143-146], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #572]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([142-145], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #568]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([141-144], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #564]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([140-143], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #560]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([139-142], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #556]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([138-141], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #552]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([137-140], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #548]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([172-175], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #700]
	ldr.w	r5, [r2, #696]
	ldr.w	r4, [r2, #692]
	ldr.w	r3, [r2, #688]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([171-174], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #684]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([170-173], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #680]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([169-172], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #676]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([168-171], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #672]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([167-170], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #668]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([166-169], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #664]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([165-168], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #660]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([164-167], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #656]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([163-166], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #652]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([162-165], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #648]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([161-164], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #644]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([160-163], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #640]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([159-162], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #636]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([158-161], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #632]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([157-160], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #628]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([156-159], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #624]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([155-158], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #620]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([154-157], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #616]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([153-156], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #612]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([152-155], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #608]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([151-154], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #604]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([150-153], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #600]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([149-152], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #596]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([148-151], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #592]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([147-150], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #588]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([146-149], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #584]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([145-148], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #580]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([144-147], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #576]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([143-146], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #572]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([142-145], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #568]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([141-144], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #564]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([176-179], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #716]
	ldr.w	r4, [r2, #712]
	ldr.w	r3, [r2, #708]
	ldr.w	r14, [r2, #704]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([175-178], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #700]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([174-177], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #696]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([173-176], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #692]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([172-175], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #688]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([171-174], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #684]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([170-173], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #680]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([169-172], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #676]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([168-171], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #672]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([167-170], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #668]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([166-169], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #664]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([165-168], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #660]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([164-167], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #656]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([163-166], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #652]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([162-165], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #648]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([161-164], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #644]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([160-163], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #640]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([159-162], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #636]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([158-161], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #632]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([157-160], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #628]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([156-159], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #624]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([155-158], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #620]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([154-157], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #616]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([153-156], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #612]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([152-155], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #608]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([151-154], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #604]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([150-153], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #600]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([149-152], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #596]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([148-151], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #592]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([147-150], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #588]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([146-149], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #584]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([145-148], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #580]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
mul_384:
	// ([180-183], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #732]
	ldr.w	r3, [r2, #728]
	ldr.w	r14, [r2, #724]
	ldr.w	r12, [r2, #720]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([179-182], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #716]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([178-181], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #712]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([177-180], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #708]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([176-179], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #704]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([175-178], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #700]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([174-177], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #696]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([173-176], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #692]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([172-175], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #688]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([171-174], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #684]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([170-173], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #680]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([169-172], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #676]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([168-171], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #672]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([167-170], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #668]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([166-169], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #664]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([165-168], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #660]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([164-167], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #656]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([163-166], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #652]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([162-165], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #648]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([161-164], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #644]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([160-163], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #640]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([159-162], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #636]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([158-161], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #632]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([157-160], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #628]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([156-159], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #624]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([155-158], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #620]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([154-157], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #616]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([153-156], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #612]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([152-155], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #608]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([151-154], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #604]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([150-153], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #600]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([149-152], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #596]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([184-187], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #748]
	ldr.w	r14, [r2, #744]
	ldr.w	r12, [r2, #740]
	ldr.w	r5, [r2, #736]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([183-186], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #732]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([182-185], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #728]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([181-184], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #724]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([180-183], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #720]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([179-182], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #716]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([178-181], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #712]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([177-180], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #708]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([176-179], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #704]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([175-178], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #700]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([174-177], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #696]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([173-176], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #692]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([172-175], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #688]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([171-174], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #684]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([170-173], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #680]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([169-172], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #676]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([168-171], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #672]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([167-170], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #668]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([166-169], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #664]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([165-168], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #660]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([164-167], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #656]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([163-166], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #652]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([162-165], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #648]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([161-164], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #644]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([160-163], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #640]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([159-162], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #636]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([158-161], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #632]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([157-160], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #628]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([156-159], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #624]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([155-158], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #620]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([154-157], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #616]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([153-156], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #612]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([188-191], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #764]
	ldr.w	r12, [r2, #760]
	ldr.w	r5, [r2, #756]
	ldr.w	r4, [r2, #752]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([187-190], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #748]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([186-189], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #744]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([185-188], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #740]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([184-187], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #736]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([183-186], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #732]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([182-185], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #728]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([181-184], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #724]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([180-183], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #720]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([179-182], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #716]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([178-181], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #712]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([177-180], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #708]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([176-179], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #704]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([175-178], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #700]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([174-177], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #696]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([173-176], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #692]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([172-175], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #688]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([171-174], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #684]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([170-173], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #680]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([169-172], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #676]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([168-171], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #672]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([167-170], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #668]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([166-169], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #664]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([165-168], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #660]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([164-167], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #656]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([163-166], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #652]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([162-165], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #648]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([161-164], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #644]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([160-163], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #640]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([159-162], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #636]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([158-161], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #632]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([157-160], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #628]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([192-195], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #780]
	ldr.w	r5, [r2, #776]
	ldr.w	r4, [r2, #772]
	ldr.w	r3, [r2, #768]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([191-194], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #764]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([190-193], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #760]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([189-192], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #756]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([188-191], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #752]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([187-190], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #748]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([186-189], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #744]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([185-188], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #740]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([184-187], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #736]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([183-186], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #732]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([182-185], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #728]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([181-184], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #724]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([180-183], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #720]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([179-182], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #716]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([178-181], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #712]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([177-180], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #708]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([176-179], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #704]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([175-178], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #700]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([174-177], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #696]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([173-176], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #692]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([172-175], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #688]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([171-174], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #684]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([170-173], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #680]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([169-172], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #676]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([168-171], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #672]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([167-170], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #668]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([166-169], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #664]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([165-168], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #660]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([164-167], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #656]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([163-166], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #652]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([162-165], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #648]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([161-164], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #644]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([196-199], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #796]
	ldr.w	r4, [r2, #792]
	ldr.w	r3, [r2, #788]
	ldr.w	r14, [r2, #784]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([195-198], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #780]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([194-197], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #776]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([193-196], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #772]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([192-195], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #768]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([191-194], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #764]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([190-193], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #760]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([189-192], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #756]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([188-191], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #752]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([187-190], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #748]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([186-189], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #744]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([185-188], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #740]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([184-187], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #736]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([183-186], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #732]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([182-185], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #728]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([181-184], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #724]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([180-183], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #720]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([179-182], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #716]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([178-181], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #712]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([177-180], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #708]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([176-179], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #704]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([175-178], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #700]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([174-177], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #696]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([173-176], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #692]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([172-175], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #688]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([171-174], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #684]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([170-173], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #680]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([169-172], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #676]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([168-171], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #672]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([167-170], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #668]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([166-169], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #664]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([165-168], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #660]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([200-203], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #812]
	ldr.w	r3, [r2, #808]
	ldr.w	r14, [r2, #804]
	ldr.w	r12, [r2, #800]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([199-202], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #796]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([198-201], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #792]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([197-200], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #788]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([196-199], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #784]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([195-198], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #780]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([194-197], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #776]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([193-196], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #772]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([192-195], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #768]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([191-194], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #764]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([190-193], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #760]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([189-192], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #756]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([188-191], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #752]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([187-190], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #748]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([186-189], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #744]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([185-188], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #740]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([184-187], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #736]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([183-186], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #732]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([182-185], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #728]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([181-184], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #724]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([180-183], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #720]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([179-182], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #716]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([178-181], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #712]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([177-180], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #708]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([176-179], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #704]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([175-178], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #700]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([174-177], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #696]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([173-176], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #692]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([172-175], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #688]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([171-174], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #684]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([170-173], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #680]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([169-172], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #676]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([204-207], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #828]
	ldr.w	r14, [r2, #824]
	ldr.w	r12, [r2, #820]
	ldr.w	r5, [r2, #816]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([203-206], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #812]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([202-205], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #808]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([201-204], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #804]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([200-203], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #800]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([199-202], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #796]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([198-201], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #792]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([197-200], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #788]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([196-199], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #784]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([195-198], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #780]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([194-197], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #776]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([193-196], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #772]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([192-195], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #768]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([191-194], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #764]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([190-193], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #760]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([189-192], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #756]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([188-191], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #752]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([187-190], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #748]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([186-189], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #744]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([185-188], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #740]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([184-187], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #736]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([183-186], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #732]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([182-185], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #728]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([181-184], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #724]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([180-183], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #720]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([179-182], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #716]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([178-181], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #712]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([177-180], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #708]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([176-179], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #704]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([175-178], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #700]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([174-177], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #696]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([173-176], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #692]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([208-211], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #844]
	ldr.w	r12, [r2, #840]
	ldr.w	r5, [r2, #836]
	ldr.w	r4, [r2, #832]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([207-210], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #828]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([206-209], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #824]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([205-208], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #820]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([204-207], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #816]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([203-206], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #812]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([202-205], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #808]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([201-204], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #804]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([200-203], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #800]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([199-202], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #796]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([198-201], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #792]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([197-200], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #788]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([196-199], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #784]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([195-198], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #780]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([194-197], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #776]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([193-196], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #772]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([192-195], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #768]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([191-194], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #764]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([190-193], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #760]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([189-192], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #756]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([188-191], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #752]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([187-190], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #748]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([186-189], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #744]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([185-188], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #740]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([184-187], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #736]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([183-186], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #732]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([182-185], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #728]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([181-184], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #724]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([180-183], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #720]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([179-182], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #716]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([178-181], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #712]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([177-180], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #708]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
mul_256:
	// ([212-215], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #860]
	ldr.w	r5, [r2, #856]
	ldr.w	r4, [r2, #852]
	ldr.w	r3, [r2, #848]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([211-214], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #844]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([210-213], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #840]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([209-212], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #836]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([208-211], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #832]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([207-210], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #828]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([206-209], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #824]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([205-208], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #820]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([204-207], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #816]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([203-206], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #812]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([202-205], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #808]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([201-204], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #804]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([200-203], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #800]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([199-202], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #796]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([198-201], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #792]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([197-200], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #788]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([196-199], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #784]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([195-198], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #780]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([194-197], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #776]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([193-196], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #772]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([192-195], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #768]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([191-194], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #764]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([190-193], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #760]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([189-192], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #756]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([188-191], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #752]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([187-190], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #748]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([186-189], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #744]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([185-188], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #740]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([184-187], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #736]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([183-186], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #732]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([182-185], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #728]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([181-184], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #724]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([216-219], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #876]
	ldr.w	r4, [r2, #872]
	ldr.w	r3, [r2, #868]
	ldr.w	r14, [r2, #864]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([215-218], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #860]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([214-217], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #856]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([213-216], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #852]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([212-215], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #848]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([211-214], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #844]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([210-213], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #840]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([209-212], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #836]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([208-211], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #832]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([207-210], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #828]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([206-209], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #824]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([205-208], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #820]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([204-207], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #816]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([203-206], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #812]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([202-205], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #808]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([201-204], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #804]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([200-203], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #800]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([199-202], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #796]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([198-201], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #792]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([197-200], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #788]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([196-199], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #784]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([195-198], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #780]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([194-197], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #776]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([193-196], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #772]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([192-195], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #768]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([191-194], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #764]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([190-193], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #760]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([189-192], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #756]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([188-191], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #752]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([187-190], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #748]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([186-189], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #744]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([185-188], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #740]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([220-223], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #892]
	ldr.w	r3, [r2, #888]
	ldr.w	r14, [r2, #884]
	ldr.w	r12, [r2, #880]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([219-222], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #876]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([218-221], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #872]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([217-220], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #868]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([216-219], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #864]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([215-218], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #860]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([214-217], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #856]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([213-216], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #852]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([212-215], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #848]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([211-214], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #844]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([210-213], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #840]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([209-212], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #836]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([208-211], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #832]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([207-210], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #828]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([206-209], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #824]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([205-208], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #820]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([204-207], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #816]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([203-206], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #812]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([202-205], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #808]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([201-204], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #804]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([200-203], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #800]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([199-202], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #796]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([198-201], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #792]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([197-200], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #788]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([196-199], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #784]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([195-198], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #780]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([194-197], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #776]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([193-196], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #772]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([192-195], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #768]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([191-194], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #764]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([190-193], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #760]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([189-192], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #756]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([224-227], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #908]
	ldr.w	r14, [r2, #904]
	ldr.w	r12, [r2, #900]
	ldr.w	r5, [r2, #896]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([223-226], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #892]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([222-225], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #888]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([221-224], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #884]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([220-223], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #880]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([219-222], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #876]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([218-221], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #872]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([217-220], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #868]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([216-219], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #864]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([215-218], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #860]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([214-217], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #856]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([213-216], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #852]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([212-215], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #848]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([211-214], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #844]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([210-213], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #840]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([209-212], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #836]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([208-211], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #832]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([207-210], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #828]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([206-209], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #824]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([205-208], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #820]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([204-207], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #816]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([203-206], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #812]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([202-205], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #808]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([201-204], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #804]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([200-203], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #800]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([199-202], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #796]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([198-201], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #792]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([197-200], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #788]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([196-199], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #784]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([195-198], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #780]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([194-197], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #776]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([193-196], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #772]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([228-231], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #924]
	ldr.w	r12, [r2, #920]
	ldr.w	r5, [r2, #916]
	ldr.w	r4, [r2, #912]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([227-230], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #908]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([226-229], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #904]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([225-228], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #900]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([224-227], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #896]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([223-226], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #892]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([222-225], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #888]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([221-224], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #884]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([220-223], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #880]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([219-222], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #876]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([218-221], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #872]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([217-220], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #868]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([216-219], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #864]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([215-218], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #860]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([214-217], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #856]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([213-216], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #852]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([212-215], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #848]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([211-214], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #844]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([210-213], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #840]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([209-212], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #836]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([208-211], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #832]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([207-210], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #828]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([206-209], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #824]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([205-208], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #820]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([204-207], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #816]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([203-206], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #812]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([202-205], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #808]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([201-204], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #804]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([200-203], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #800]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([199-202], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #796]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([198-201], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #792]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([197-200], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #788]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([232-235], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #940]
	ldr.w	r5, [r2, #936]
	ldr.w	r4, [r2, #932]
	ldr.w	r3, [r2, #928]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([231-234], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #924]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([230-233], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #920]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([229-232], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #916]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([228-231], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #912]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([227-230], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #908]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([226-229], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #904]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([225-228], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #900]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([224-227], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #896]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([223-226], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #892]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([222-225], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #888]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([221-224], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #884]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([220-223], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #880]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([219-222], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #876]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([218-221], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #872]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([217-220], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #868]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([216-219], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #864]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([215-218], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #860]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([214-217], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #856]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([213-216], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #852]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([212-215], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #848]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([211-214], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #844]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([210-213], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #840]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([209-212], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #836]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([208-211], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #832]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([207-210], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #828]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([206-209], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #824]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([205-208], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #820]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([204-207], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #816]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([203-206], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #812]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([202-205], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #808]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([201-204], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #804]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([236-239], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #956]
	ldr.w	r4, [r2, #952]
	ldr.w	r3, [r2, #948]
	ldr.w	r14, [r2, #944]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([235-238], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #940]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([234-237], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #936]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([233-236], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #932]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([232-235], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #928]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([231-234], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #924]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([230-233], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #920]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([229-232], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #916]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([228-231], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #912]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([227-230], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #908]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([226-229], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #904]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([225-228], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #900]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([224-227], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #896]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([223-226], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #892]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([222-225], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #888]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([221-224], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #884]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([220-223], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #880]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([219-222], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #876]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([218-221], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #872]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([217-220], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #868]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([216-219], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #864]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([215-218], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #860]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([214-217], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #856]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([213-216], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #852]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([212-215], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #848]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([211-214], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #844]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([210-213], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #840]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([209-212], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #836]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([208-211], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #832]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([207-210], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #828]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([206-209], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #824]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([205-208], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #820]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([240-243], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #972]
	ldr.w	r3, [r2, #968]
	ldr.w	r14, [r2, #964]
	ldr.w	r12, [r2, #960]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([239-242], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #956]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([238-241], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #952]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([237-240], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #948]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([236-239], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #944]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([235-238], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #940]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([234-237], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #936]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([233-236], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #932]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([232-235], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #928]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([231-234], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #924]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([230-233], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #920]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([229-232], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #916]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([228-231], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #912]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([227-230], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #908]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([226-229], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #904]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([225-228], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #900]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([224-227], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #896]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([223-226], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #892]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([222-225], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #888]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([221-224], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #884]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([220-223], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #880]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([219-222], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #876]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([218-221], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #872]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([217-220], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #868]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([216-219], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #864]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([215-218], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #860]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([214-217], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #856]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([213-216], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #852]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([212-215], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #848]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([211-214], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #844]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([210-213], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #840]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([209-212], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #836]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
mul_128:
 // decreasing thread length
	// ([213-216], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r14, [r2, #864]
	ldr.w	r12, [r2, #860]
	ldr.w	r5, [r2, #856]
	ldr.w	r4, [r2, #852]
	umull	r6, r7, r5, r3
	umull	r8, r9, r14, r3
	umlal	r10, r6, r4, r3
	umlal	r7, r8, r12, r3
	// ([214-217], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r3, [r2, #868]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([215-218], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r4, [r2, #872]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([216-219], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r5, [r2, #876]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([217-220], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r12, [r2, #880]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([218-221], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r14, [r2, #884]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([219-222], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r3, [r2, #888]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([220-223], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r4, [r2, #892]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([221-224], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r5, [r2, #896]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([222-225], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r12, [r2, #900]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([223-226], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r14, [r2, #904]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([224-227], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r3, [r2, #908]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([225-228], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r4, [r2, #912]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([226-229], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r5, [r2, #916]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([227-230], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r12, [r2, #920]
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
	// ([228-231], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r14, [r2, #924]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([229-232], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r3, [r2, #928]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([230-233], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r4, [r2, #932]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([231-234], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r5, [r2, #936]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([232-235], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r12, [r2, #940]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([233-236], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r14, [r2, #944]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	// ([234-237], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r3, [r2, #948]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([235-238], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r4, [r2, #952]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([236-239], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r5, [r2, #956]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([237-240], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r12, [r2, #960]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([238-241], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r14, [r2, #964]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([239-242], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r3, [r2, #968]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([240-243], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r4, [r2, #972]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([241-243],3),([242-243],2),(243,1) blocks
	ldr.w	r5, [r1, #12]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #8]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	ldr.w	r5, [r1, #4]
	umlal	r10, r6, r4, r5
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([217-220], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r12, [r2, #880]
	ldr.w	r5, [r2, #876]
	ldr.w	r4, [r2, #872]
	ldr.w	r3, [r2, #868]
	umull	r10, r6, r4, r14
	umull	r7, r8, r12, r14
	umlal	r9, r10, r3, r14
	umlal	r6, r7, r5, r14
	// ([218-221], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r14, [r2, #884]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([219-222], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r3, [r2, #888]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([220-223], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r4, [r2, #892]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([221-224], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r5, [r2, #896]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([222-225], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r12, [r2, #900]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([223-226], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r14, [r2, #904]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([224-227], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r3, [r2, #908]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([225-228], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r4, [r2, #912]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([226-229], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r5, [r2, #916]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([227-230], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r12, [r2, #920]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([228-231], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r14, [r2, #924]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([229-232], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r3, [r2, #928]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([230-233], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r4, [r2, #932]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([231-234], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r5, [r2, #936]
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
	// ([232-235], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r12, [r2, #940]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([233-236], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r14, [r2, #944]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([234-237], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r3, [r2, #948]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([235-238], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r4, [r2, #952]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([236-239], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r5, [r2, #956]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([237-240], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r12, [r2, #960]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	// ([238-241], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r14, [r2, #964]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([239-242], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r3, [r2, #968]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([240-243], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r4, [r2, #972]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([241-243],7),([242-243],6),(243,5) blocks
	ldr.w	r5, [r1, #28]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r14, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #24]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #20]
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([221-224], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r5, [r2, #896]
	ldr.w	r4, [r2, #892]
	ldr.w	r3, [r2, #888]
	ldr.w	r14, [r2, #884]
	umull	r9, r10, r3, r12
	umull	r6, r7, r5, r12
	umlal	r8, r9, r14, r12
	umlal	r10, r6, r4, r12
	// ([222-225], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r12, [r2, #900]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([223-226], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r14, [r2, #904]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([224-227], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r3, [r2, #908]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([225-228], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r4, [r2, #912]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([226-229], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r5, [r2, #916]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([227-230], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r12, [r2, #920]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([228-231], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r14, [r2, #924]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([229-232], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r3, [r2, #928]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([230-233], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r4, [r2, #932]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([231-234], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r5, [r2, #936]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([232-235], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r12, [r2, #940]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([233-236], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r14, [r2, #944]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([234-237], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r3, [r2, #948]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([235-238], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r4, [r2, #952]
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
	// ([236-239], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r5, [r2, #956]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([237-240], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r12, [r2, #960]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([238-241], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r14, [r2, #964]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([239-242], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r3, [r2, #968]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([240-243], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r4, [r2, #972]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([241-243],11),([242-243],10),(243,9) blocks
	ldr.w	r5, [r1, #44]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	ldr.w	r5, [r1, #40]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #36]
	umlal	r8, r9, r4, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([225-228], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r4, [r2, #912]
	ldr.w	r3, [r2, #908]
	ldr.w	r14, [r2, #904]
	ldr.w	r12, [r2, #900]
	umull	r8, r9, r14, r5
	umull	r10, r6, r4, r5
	umlal	r7, r8, r12, r5
	umlal	r9, r10, r3, r5
	// ([226-229], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r5, [r2, #916]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([227-230], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r12, [r2, #920]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([228-231], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r14, [r2, #924]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([229-232], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r3, [r2, #928]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([230-233], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r4, [r2, #932]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([231-234], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r5, [r2, #936]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([232-235], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r12, [r2, #940]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([233-236], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r14, [r2, #944]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([234-237], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r3, [r2, #948]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([235-238], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r4, [r2, #952]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([236-239], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r5, [r2, #956]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([237-240], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r12, [r2, #960]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([238-241], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r14, [r2, #964]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([239-242], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r3, [r2, #968]
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
	// ([240-243], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r4, [r2, #972]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([241-243],15),([242-243],14),(243,13) blocks
	ldr.w	r5, [r1, #60]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	ldr.w	r5, [r1, #56]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	ldr.w	r5, [r1, #52]
	umlal	r7, r8, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([229-232], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r3, [r2, #928]
	ldr.w	r14, [r2, #924]
	ldr.w	r12, [r2, #920]
	ldr.w	r5, [r2, #916]
	umull	r7, r8, r12, r4
	umull	r9, r10, r3, r4
	umlal	r6, r7, r5, r4
	umlal	r8, r9, r14, r4
	// ([230-233], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r4, [r2, #932]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([231-234], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r5, [r2, #936]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([232-235], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r12, [r2, #940]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([233-236], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r14, [r2, #944]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([234-237], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r3, [r2, #948]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([235-238], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r4, [r2, #952]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([236-239], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r5, [r2, #956]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([237-240], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r12, [r2, #960]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([238-241], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r14, [r2, #964]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([239-242], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r3, [r2, #968]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([240-243], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r4, [r2, #972]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([241-243],19),([242-243],18),(243,17) blocks
	ldr.w	r5, [r1, #76]
	umlal	r8, r9, r4, r5
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #72]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #68]
	umlal	r6, r7, r4, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([233-236], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r14, [r2, #944]
	ldr.w	r12, [r2, #940]
	ldr.w	r5, [r2, #936]
	ldr.w	r4, [r2, #932]
	umull	r6, r7, r5, r3
	umull	r8, r9, r14, r3
	umlal	r10, r6, r4, r3
	umlal	r7, r8, r12, r3
	// ([234-237], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r3, [r2, #948]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([235-238], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r4, [r2, #952]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([236-239], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r5, [r2, #956]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([237-240], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r12, [r2, #960]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([238-241], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r14, [r2, #964]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([239-242], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r3, [r2, #968]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([240-243], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r4, [r2, #972]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([241-243],23),([242-243],22),(243,21) blocks
	ldr.w	r5, [r1, #92]
	umlal	r7, r8, r4, r5
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #88]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #84]
	umlal	r10, r6, r4, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([237-240], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r12, [r2, #960]
	ldr.w	r5, [r2, #956]
	ldr.w	r4, [r2, #952]
	ldr.w	r3, [r2, #948]
	umull	r10, r6, r4, r14
	umull	r7, r8, r12, r14
	umlal	r9, r10, r3, r14
	umlal	r6, r7, r5, r14
	// ([238-241], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r14, [r2, #964]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([239-242], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r3, [r2, #968]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([240-243], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r4, [r2, #972]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([241-243],27),([242-243],26),(243,25) blocks
	ldr.w	r5, [r1, #108]
	umlal	r6, r7, r4, r5
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r14, r5
	ldr.w	r5, [r1, #104]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	ldr.w	r5, [r1, #100]
	umlal	r9, r10, r4, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
 // mv hh back to h
	mov	r9, #0
	mov	r10, #0
	mov	r6, #0
	mov	r7, #0
	ldr.w	r14, [r2, #964]
	ldr.w	r3, [r2, #968]
	ldr.w	r4, [r2, #972]
	// ([241-243],31),([242-243],30),(243,29) blocks
	ldr.w	r5, [r1, #124]
	umlal	r10, r6, r4, r5
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	ldr.w	r5, [r1, #120]
	umlal	r9, r10, r4, r5
	umlal	r8, r9, r3, r5
	ldr.w	r5, [r1, #116]
	umlal	r8, r9, r4, r5
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	pop.w {pc}
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x128_jump_head
.type  __polymul_128x128_jump_head, %function
__polymul_128x128_jump_head:
	push.w {lr}
	mov.w r10, #0
	sub.w r2, #852
	b.w mul_128
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x128
.type  __polymul_128x128, %function
__polymul_128x128:
	push.w {lr}
	bl.w mul_head
	mov.w r10, r8
	sub.w r2, #848
	b.w mul_128
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x256_jump_head
.type  __polymul_128x256_jump_head, %function
__polymul_128x256_jump_head:
	push.w {lr}
	mov.w r8, #0
	sub.w r2, #724
	b.w mul_256
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x256
.type  __polymul_128x256, %function
__polymul_128x256:
	push.w {lr}
	bl.w mul_head
	sub.w r2, #720
	b.w mul_256
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x384_jump_head
.type  __polymul_128x384_jump_head, %function
__polymul_128x384_jump_head:
	push.w {lr}
	mov.w r6, #0
	sub.w r2, #596
	b.w mul_384
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x384
.type  __polymul_128x384, %function
__polymul_128x384:
	push.w {lr}
	bl.w mul_head
	mov.w r6, r8
	sub.w r2, #592
	b.w mul_384
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x512_jump_head
.type  __polymul_128x512_jump_head, %function
__polymul_128x512_jump_head:
	push.w {lr}
	mov.w r9, #0
	sub.w r2, #468
	b.w mul_512
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x512
.type  __polymul_128x512, %function
__polymul_128x512:
	push.w {lr}
	bl.w mul_head
	mov.w r9, r8
	sub.w r2, #464
	b.w mul_512
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x640_jump_head
.type  __polymul_128x640_jump_head, %function
__polymul_128x640_jump_head:
	push.w {lr}
	mov.w r7, #0
	sub.w r2, #340
	b.w mul_640
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x640
.type  __polymul_128x640, %function
__polymul_128x640:
	push.w {lr}
	bl.w mul_head
	mov.w r7, r8
	sub.w r2, #336
	b.w mul_640
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x768_jump_head
.type  __polymul_128x768_jump_head, %function
__polymul_128x768_jump_head:
	push.w {lr}
	mov.w r10, #0
	sub.w r2, #212
	b.w mul_768
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x768
.type  __polymul_128x768, %function
__polymul_128x768:
	push.w {lr}
	bl.w mul_head
	mov.w r10, r8
	sub.w r2, #208
	b.w mul_768
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x896_jump_head
.type  __polymul_128x896_jump_head, %function
__polymul_128x896_jump_head:
	push.w {lr}
	mov.w r8, #0
	sub.w r2, #84
	b.w mul_896
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x896
.type  __polymul_128x896, %function
__polymul_128x896:
	push.w {lr}
	bl.w mul_head
	sub.w r2, #80
	b.w mul_896
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x960_jump_head
.type  __polymul_128x960_jump_head, %function
__polymul_128x960_jump_head:
	push.w {lr}
	mov.w r7, #0
	sub.w r2, #20
	b.w mul_960
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x976
.type  __polymul_128x976, %function
__polymul_128x976:
	push.w {lr}
	bl.w mul_head
	b.w mul_976
.p2align 2,,3
.syntax unified
.text
.global __polymul_128x960
.type  __polymul_128x960, %function
__polymul_128x960:
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
	// ([0-3], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #0]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([0-2],9), ([0-1],10), (0,11) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #40]
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #44]
	umlal	r7, r8, r12, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
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
	// ([4-7], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([3-6], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([2-5], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #8]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([1-4], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #4]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([0-3], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #0]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([0-2],13), ([0-1],14), (0,15) blocks
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r14, r5
	umlal	r9, r10, r12, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #56]
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #60]
	umlal	r6, r7, r12, r5
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
	// ([8-11], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([7-10], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #28]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([6-9], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #24]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([5-8], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #20]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([4-7], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #16]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([3-6], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #12]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([2-5], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #8]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([1-4], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #4]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([0-3], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #0]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([0-2],17), ([0-1],18), (0,19) blocks
	ldr.w	r5, [r1, #68]
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	ldr.w	r5, [r1, #72]
	umlal	r10, r6, r14, r5
	umlal	r9, r10, r12, r5
	ldr.w	r5, [r1, #76]
	umlal	r10, r6, r12, r5
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
	// ([12-15], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #48]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([11-14], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #44]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([10-13], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #40]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([8-11], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #32]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([7-10], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #28]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([6-9], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #24]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([5-8], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #20]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([4-7], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #16]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([3-6], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #12]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([2-5], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #8]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([1-4], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #4]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([0-3], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #0]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([0-2],21), ([0-1],22), (0,23) blocks
	ldr.w	r5, [r1, #84]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #88]
	umlal	r9, r10, r14, r5
	umlal	r8, r9, r12, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #92]
	umlal	r9, r10, r12, r5
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
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
	// ([16-19], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #64]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([15-18], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #60]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([14-17], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([13-16], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([12-15], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #48]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([11-14], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #44]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([10-13], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #40]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([9-12], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #36]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([8-11], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #32]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([7-10], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #28]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([6-9], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #24]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([5-8], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #20]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([4-7], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #16]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([3-6], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #12]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([2-5], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #8]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([1-4], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #4]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([0-3], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #0]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([0-2],25), ([0-1],26), (0,27) blocks
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #100]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	and	r5, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #104]
	umlal	r8, r9, r14, r5
	umlal	r7, r8, r12, r5
	and	r5, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #108]
	umlal	r8, r9, r12, r5
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
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
	// ([20-23], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #80]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([19-22], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([18-21], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([17-20], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #68]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([16-19], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #64]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([15-18], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #60]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([14-17], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #56]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([13-16], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #52]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([12-15], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #48]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([11-14], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #44]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([10-13], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #40]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([9-12], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #36]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([8-11], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #32]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([7-10], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([6-9], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([5-8], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([4-7], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #16]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([3-6], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #12]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([2-5], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #8]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([1-4], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #4]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([0-3], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #0]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([0-2],29), ([0-1],30), (0,31) blocks
	and	r5, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r5, LSR #4	// range < 31
	ldr.w	r5, [r1, #116]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r14, r5
	umlal	r10, r6, r12, r5
	ldr.w	r5, [r1, #120]
	umlal	r7, r8, r14, r5
	umlal	r6, r7, r12, r5
	ldr.w	r5, [r1, #124]
	umlal	r7, r8, r12, r5
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
	// ([24-27], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([23-26], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([22-25], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #88]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([21-24], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #84]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([20-23], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #80]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([19-22], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #76]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([18-21], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #72]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([17-20], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #68]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([16-19], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #64]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([15-18], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #60]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([14-17], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #56]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([13-16], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #52]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([12-15], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #48]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([11-14], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #44]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([10-13], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #40]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([9-12], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #36]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([8-11], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #32]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([7-10], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #28]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([6-9], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #24]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([5-8], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #20]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([4-7], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #16]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([3-6], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #12]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([2-5], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #8]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([1-4], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #4]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([28-31], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([27-30], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #108]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([26-29], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #104]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([25-28], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #100]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([24-27], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #96]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([23-26], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #92]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([22-25], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #88]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([21-24], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #84]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([20-23], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #80]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([19-22], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #76]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([18-21], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #72]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([17-20], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #68]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([16-19], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #64]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([15-18], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #60]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([14-17], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #56]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([13-16], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #52]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([12-15], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #48]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([11-14], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #44]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([10-13], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #40]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([9-12], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #36]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([8-11], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #32]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([7-10], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #28]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([6-9], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #24]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([5-8], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #20]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([32-35], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #128]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([31-34], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #124]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([30-33], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #120]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([29-32], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([28-31], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #112]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([27-30], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #108]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([26-29], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #104]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([25-28], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #100]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([24-27], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #96]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([23-26], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #92]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([22-25], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #88]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([21-24], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #84]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([20-23], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #80]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([19-22], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #76]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([18-21], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #72]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([17-20], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #68]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([16-19], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #64]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([15-18], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #60]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([14-17], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #56]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([13-16], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #52]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([12-15], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #48]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([11-14], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #44]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([10-13], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #40]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([9-12], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #36]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([36-39], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #144]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([35-38], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #140]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([34-37], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([33-36], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([32-35], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #128]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([31-34], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #124]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([30-33], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #120]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([29-32], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #116]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([28-31], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #112]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([27-30], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #108]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([26-29], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #104]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([25-28], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #100]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([24-27], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #96]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([23-26], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #92]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([22-25], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #88]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([21-24], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #84]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([20-23], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #80]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([19-22], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #76]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([18-21], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #72]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([17-20], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #68]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([16-19], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #64]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([15-18], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #60]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([14-17], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #56]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([13-16], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #52]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([40-43], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #160]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([39-42], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([38-41], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([37-40], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #148]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([36-39], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #144]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([35-38], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #140]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([34-37], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #136]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([33-36], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #132]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([32-35], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #128]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([31-34], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #124]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([30-33], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #120]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([29-32], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #116]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([28-31], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #112]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([27-30], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #108]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([26-29], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #104]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([25-28], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #100]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([24-27], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #96]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([23-26], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #92]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([22-25], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #88]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([21-24], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #84]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([20-23], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #80]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([19-22], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #76]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([18-21], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #72]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([17-20], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #68]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([44-47], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([43-46], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([42-45], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #168]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([41-44], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #164]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([40-43], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #160]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([39-42], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #156]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([38-41], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #152]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([37-40], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #148]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([36-39], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #144]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([35-38], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #140]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([34-37], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #136]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([33-36], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #132]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([32-35], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #128]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([31-34], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #124]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([30-33], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #120]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([29-32], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #116]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([28-31], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #112]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([27-30], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #108]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([26-29], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #104]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([25-28], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #100]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([24-27], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #96]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([23-26], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #92]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([22-25], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #88]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([21-24], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #84]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([48-51], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([47-50], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #188]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([46-49], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #184]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([45-48], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #180]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([44-47], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #176]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([43-46], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #172]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([42-45], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #168]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([41-44], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #164]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([40-43], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #160]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([39-42], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #156]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([38-41], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #152]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([37-40], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #148]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([36-39], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #144]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([35-38], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #140]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([34-37], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #136]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([33-36], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #132]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([32-35], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #128]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([31-34], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #124]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([30-33], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #120]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([29-32], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #116]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([28-31], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #112]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([27-30], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #108]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([26-29], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #104]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([25-28], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #100]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([52-55], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #208]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([51-54], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #204]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([50-53], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #200]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([49-52], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([48-51], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #192]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([47-50], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #188]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([46-49], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #184]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([45-48], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #180]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([44-47], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #176]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([43-46], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #172]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([42-45], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #168]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([41-44], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #164]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([40-43], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #160]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([39-42], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #156]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([38-41], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #152]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([37-40], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #148]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([36-39], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #144]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([35-38], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #140]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([34-37], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #136]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([33-36], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #132]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([32-35], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #128]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([31-34], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #124]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([30-33], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #120]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([29-32], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #116]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([56-59], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #224]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([55-58], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #220]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([54-57], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #216]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([53-56], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #212]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([52-55], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #208]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([51-54], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #204]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([50-53], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #200]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([49-52], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #196]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([48-51], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #192]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([47-50], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #188]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([46-49], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #184]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([45-48], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #180]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([44-47], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #176]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([43-46], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #172]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([42-45], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #168]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([41-44], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #164]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([40-43], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #160]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([39-42], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #156]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([38-41], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #152]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([37-40], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #148]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([36-39], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #144]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([35-38], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #140]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([34-37], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #136]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([33-36], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #132]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([60-63], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #240]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([59-62], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #236]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([58-61], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #232]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([57-60], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #228]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([56-59], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #224]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([55-58], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #220]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([54-57], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #216]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([53-56], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #212]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([52-55], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #208]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([51-54], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #204]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([50-53], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #200]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([49-52], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #196]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([48-51], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #192]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([47-50], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #188]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([46-49], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #184]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([45-48], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #180]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([44-47], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #176]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([43-46], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #172]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([42-45], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #168]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([41-44], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #164]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([40-43], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #160]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([39-42], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #156]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([38-41], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #152]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([37-40], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #148]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([64-67], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #256]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([63-66], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #252]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([62-65], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #248]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([61-64], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #244]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([60-63], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #240]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([59-62], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #236]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([58-61], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #232]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([57-60], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #228]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([56-59], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #224]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([55-58], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #220]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([54-57], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #216]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([53-56], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #212]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([52-55], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #208]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([51-54], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #204]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([50-53], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #200]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([49-52], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #196]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([48-51], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #192]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([47-50], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #188]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([46-49], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #184]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([45-48], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #180]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([44-47], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #176]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([43-46], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #172]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([42-45], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #168]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([41-44], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #164]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([68-71], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #272]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([67-70], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #268]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([66-69], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #264]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([65-68], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #260]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([64-67], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #256]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([63-66], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #252]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([62-65], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #248]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([61-64], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #244]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([60-63], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #240]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([59-62], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #236]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([58-61], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #232]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([57-60], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #228]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([56-59], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #224]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([55-58], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #220]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([54-57], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #216]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([53-56], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #212]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([52-55], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #208]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([51-54], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #204]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([50-53], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #200]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([49-52], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #196]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([48-51], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #192]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([47-50], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #188]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([46-49], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #184]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([45-48], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #180]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([72-75], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #288]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([71-74], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #284]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([70-73], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #280]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([69-72], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #276]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([68-71], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #272]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([67-70], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #268]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([66-69], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #264]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([65-68], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #260]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([64-67], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #256]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([63-66], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #252]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([62-65], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #248]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([61-64], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #244]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([60-63], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #240]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([59-62], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #236]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([58-61], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #232]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([57-60], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #228]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([56-59], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #224]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([55-58], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #220]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([54-57], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #216]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([53-56], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #212]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([52-55], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #208]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([51-54], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #204]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([50-53], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #200]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([49-52], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #196]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([76-79], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #304]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([75-78], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #300]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([74-77], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #296]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([73-76], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #292]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([72-75], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #288]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([71-74], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #284]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([70-73], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #280]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([69-72], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #276]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([68-71], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #272]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([67-70], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #268]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([66-69], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #264]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([65-68], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #260]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([64-67], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #256]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([63-66], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #252]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([62-65], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #248]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([61-64], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #244]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([60-63], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #240]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([59-62], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #236]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([58-61], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #232]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([57-60], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #228]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([56-59], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #224]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([55-58], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #220]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([54-57], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #216]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([53-56], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #212]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([80-83], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #320]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([79-82], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #316]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([78-81], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #312]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([77-80], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #308]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([76-79], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #304]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([75-78], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #300]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([74-77], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #296]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([73-76], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #292]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([72-75], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #288]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([71-74], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #284]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([70-73], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #280]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([69-72], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #276]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([68-71], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #272]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([67-70], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #268]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([66-69], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #264]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([65-68], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #260]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([64-67], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #256]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([63-66], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #252]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([62-65], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #248]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([61-64], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #244]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([60-63], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #240]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([59-62], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #236]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([58-61], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #232]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([57-60], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #228]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([84-87], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #336]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([83-86], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #332]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([82-85], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #328]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([81-84], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #324]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([80-83], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #320]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([79-82], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #316]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([78-81], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #312]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([77-80], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #308]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([76-79], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #304]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([75-78], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #300]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([74-77], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #296]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([73-76], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #292]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([72-75], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #288]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([71-74], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #284]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([70-73], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #280]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([69-72], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #276]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([68-71], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #272]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([67-70], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #268]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([66-69], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #264]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([65-68], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #260]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([64-67], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #256]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([63-66], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #252]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([62-65], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #248]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([61-64], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #244]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([88-91], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #352]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([87-90], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #348]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([86-89], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #344]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([85-88], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #340]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([84-87], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #336]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([83-86], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #332]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([82-85], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #328]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([81-84], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #324]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([80-83], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #320]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([79-82], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #316]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([78-81], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #312]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([77-80], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #308]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([76-79], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #304]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([75-78], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #300]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([74-77], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #296]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([73-76], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #292]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([72-75], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #288]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([71-74], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #284]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([70-73], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #280]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([69-72], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #276]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([68-71], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #272]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([67-70], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #268]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([66-69], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #264]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([65-68], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #260]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([92-95], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #368]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([91-94], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #364]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([90-93], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #360]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([89-92], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #356]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([88-91], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #352]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([87-90], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #348]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([86-89], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #344]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([85-88], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #340]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([84-87], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #336]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([83-86], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #332]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([82-85], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #328]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([81-84], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #324]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([80-83], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #320]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([79-82], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #316]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([78-81], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #312]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([77-80], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #308]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([76-79], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #304]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([75-78], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #300]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([74-77], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #296]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([73-76], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #292]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([72-75], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #288]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([71-74], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #284]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([70-73], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #280]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([69-72], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #276]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([96-99], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #384]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([95-98], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #380]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([94-97], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #376]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([93-96], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #372]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([92-95], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #368]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([91-94], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #364]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([90-93], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #360]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([89-92], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #356]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([88-91], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #352]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([87-90], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #348]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([86-89], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #344]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([85-88], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #340]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([84-87], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #336]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([83-86], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #332]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([82-85], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #328]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([81-84], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #324]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([80-83], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #320]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([79-82], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #316]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([78-81], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #312]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([77-80], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #308]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([76-79], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #304]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([75-78], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #300]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([74-77], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #296]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([73-76], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #292]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([100-103], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #400]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([99-102], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #396]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([98-101], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #392]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([97-100], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #388]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([96-99], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #384]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([95-98], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #380]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([94-97], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #376]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([93-96], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #372]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([92-95], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #368]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([91-94], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #364]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([90-93], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #360]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([89-92], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #356]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([88-91], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #352]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([87-90], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #348]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([86-89], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #344]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([85-88], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #340]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([84-87], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #336]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([83-86], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #332]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([82-85], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #328]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([81-84], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #324]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([80-83], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #320]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([79-82], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #316]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([78-81], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #312]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([77-80], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #308]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([104-107], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #416]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([103-106], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #412]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([102-105], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #408]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([101-104], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #404]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([100-103], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #400]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([99-102], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #396]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([98-101], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #392]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([97-100], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #388]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([96-99], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #384]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([95-98], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #380]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([94-97], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #376]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([93-96], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #372]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([92-95], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #368]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([91-94], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #364]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([90-93], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #360]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([89-92], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #356]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([88-91], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #352]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([87-90], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #348]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([86-89], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #344]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([85-88], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #340]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([84-87], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #336]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([83-86], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #332]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([82-85], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #328]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([81-84], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #324]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([108-111], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #432]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([107-110], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #428]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([106-109], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #424]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([105-108], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #420]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([104-107], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #416]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([103-106], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #412]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([102-105], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #408]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([101-104], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #404]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([100-103], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #400]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([99-102], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #396]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([98-101], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #392]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([97-100], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #388]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([96-99], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #384]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([95-98], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #380]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([94-97], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #376]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([93-96], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #372]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([92-95], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #368]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([91-94], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #364]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([90-93], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #360]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([89-92], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #356]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([88-91], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #352]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([87-90], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #348]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([86-89], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #344]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([85-88], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #340]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([112-115], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #448]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([111-114], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #444]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([110-113], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #440]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([109-112], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #436]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([108-111], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #432]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([107-110], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #428]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([106-109], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #424]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([105-108], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #420]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([104-107], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #416]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([103-106], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #412]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([102-105], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #408]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([101-104], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #404]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([100-103], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #400]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([99-102], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #396]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([98-101], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #392]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([97-100], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #388]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([96-99], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #384]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([95-98], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #380]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([94-97], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #376]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([93-96], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #372]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([92-95], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #368]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([91-94], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #364]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([90-93], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #360]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([89-92], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #356]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([116-119], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #464]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([115-118], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #460]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([114-117], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #456]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([113-116], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #452]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([112-115], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #448]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([111-114], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #444]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([110-113], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #440]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([109-112], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #436]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([108-111], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #432]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([107-110], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #428]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([106-109], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #424]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([105-108], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #420]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([104-107], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #416]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([103-106], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #412]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([102-105], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #408]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([101-104], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #404]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([100-103], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #400]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([99-102], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #396]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([98-101], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #392]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([97-100], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #388]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([96-99], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #384]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([95-98], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #380]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([94-97], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #376]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([93-96], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #372]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([120-123], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #480]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([119-122], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #476]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([118-121], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #472]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([117-120], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #468]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([116-119], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #464]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([115-118], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #460]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([114-117], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #456]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([113-116], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #452]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([112-115], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #448]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([111-114], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #444]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([110-113], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #440]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([109-112], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #436]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([108-111], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #432]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([107-110], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #428]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([106-109], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #424]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([105-108], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #420]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([104-107], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #416]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([103-106], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #412]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([102-105], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #408]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([101-104], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #404]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([100-103], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #400]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([99-102], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #396]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([98-101], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #392]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([97-100], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #388]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([124-127], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #496]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([123-126], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #492]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([122-125], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #488]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([121-124], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #484]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([120-123], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #480]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([119-122], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #476]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([118-121], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #472]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([117-120], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #468]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([116-119], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #464]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([115-118], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #460]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([114-117], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #456]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([113-116], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #452]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([112-115], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #448]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([111-114], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #444]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([110-113], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #440]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([109-112], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #436]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([108-111], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #432]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([107-110], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #428]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([106-109], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #424]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([105-108], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #420]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([104-107], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #416]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([103-106], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #412]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([102-105], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #408]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([101-104], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #404]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([128-131], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #512]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([127-130], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #508]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([126-129], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #504]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([125-128], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #500]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([124-127], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #496]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([123-126], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #492]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([122-125], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #488]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([121-124], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #484]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([120-123], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #480]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([119-122], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #476]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([118-121], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #472]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([117-120], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #468]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([116-119], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #464]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([115-118], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #460]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([114-117], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #456]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([113-116], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #452]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([112-115], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #448]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([111-114], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #444]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([110-113], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #440]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([109-112], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #436]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([108-111], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #432]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([107-110], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #428]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([106-109], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #424]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([105-108], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #420]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([132-135], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #528]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([131-134], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #524]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([130-133], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #520]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([129-132], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #516]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([128-131], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #512]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([127-130], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #508]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([126-129], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #504]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([125-128], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #500]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([124-127], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #496]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([123-126], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #492]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([122-125], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #488]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([121-124], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #484]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([120-123], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #480]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([119-122], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #476]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([118-121], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #472]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([117-120], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #468]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([116-119], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #464]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([115-118], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #460]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([114-117], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #456]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([113-116], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #452]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([112-115], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #448]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([111-114], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #444]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([110-113], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #440]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([109-112], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #436]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([136-139], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #544]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([135-138], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #540]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([134-137], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #536]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([133-136], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #532]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([132-135], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #528]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([131-134], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #524]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([130-133], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #520]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([129-132], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #516]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([128-131], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #512]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([127-130], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #508]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([126-129], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #504]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([125-128], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #500]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([124-127], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #496]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([123-126], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #492]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([122-125], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #488]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([121-124], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #484]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([120-123], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #480]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([119-122], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #476]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([118-121], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #472]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([117-120], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #468]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([116-119], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #464]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([115-118], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #460]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([114-117], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #456]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([113-116], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #452]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
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
	// ([140-143], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #560]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([139-142], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #556]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([138-141], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #552]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([137-140], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #548]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([136-139], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #544]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([135-138], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #540]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([134-137], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #536]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([133-136], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #532]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([132-135], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #528]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([131-134], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #524]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([130-133], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #520]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([129-132], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #516]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([128-131], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #512]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([127-130], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #508]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([126-129], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #504]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([125-128], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #500]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([124-127], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #496]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([123-126], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #492]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([122-125], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #488]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([121-124], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #484]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([120-123], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #480]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([119-122], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #476]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([118-121], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #472]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([117-120], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #468]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
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
	// ([144-147], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #576]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([143-146], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #572]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([142-145], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #568]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([141-144], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #564]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([140-143], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #560]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([139-142], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #556]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([138-141], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #552]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([137-140], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #548]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([136-139], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #544]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([135-138], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #540]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([134-137], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #536]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([133-136], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #532]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([132-135], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #528]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([131-134], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #524]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([130-133], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #520]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([129-132], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #516]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([128-131], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #512]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([127-130], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #508]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([126-129], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #504]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([125-128], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #500]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([124-127], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #496]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([123-126], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #492]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([122-125], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #488]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([121-124], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #484]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
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
	// ([148-151], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #592]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([147-150], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #588]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([146-149], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #584]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([145-148], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #580]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([144-147], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #576]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([143-146], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #572]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([142-145], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #568]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([141-144], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #564]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([140-143], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #560]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([139-142], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #556]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([138-141], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #552]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([137-140], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #548]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([136-139], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #544]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([135-138], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #540]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([134-137], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #536]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([133-136], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #532]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([132-135], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #528]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([131-134], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #524]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([130-133], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #520]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([129-132], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #516]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([128-131], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #512]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([127-130], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #508]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([126-129], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #504]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([125-128], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #500]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
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
	// ([152-155], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #608]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([151-154], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #604]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([150-153], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #600]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([149-152], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #596]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([148-151], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #592]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([147-150], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #588]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([146-149], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #584]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([145-148], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #580]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([144-147], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #576]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([143-146], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #572]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([142-145], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #568]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([141-144], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #564]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([140-143], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #560]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([139-142], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #556]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([138-141], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #552]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([137-140], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #548]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([136-139], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #544]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([135-138], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #540]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([134-137], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #536]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([133-136], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #532]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([132-135], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #528]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([131-134], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #524]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([130-133], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #520]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([129-132], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #516]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
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
	// ([156-159], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #624]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([155-158], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #620]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([154-157], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #616]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([153-156], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #612]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([152-155], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #608]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([151-154], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #604]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([150-153], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #600]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([149-152], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #596]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([148-151], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #592]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([147-150], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #588]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([146-149], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #584]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([145-148], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #580]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([144-147], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #576]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([143-146], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #572]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([142-145], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #568]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([141-144], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #564]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([140-143], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #560]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([139-142], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #556]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([138-141], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #552]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([137-140], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #548]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([136-139], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #544]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([135-138], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #540]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([134-137], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #536]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([133-136], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #532]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([168-171], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #684]
	ldr.w	r12, [r2, #680]
	ldr.w	r5, [r2, #676]
	ldr.w	r4, [r2, #672]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([167-170], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #668]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([166-169], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #664]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([165-168], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #660]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([164-167], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #656]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([163-166], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #652]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([162-165], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #648]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([161-164], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #644]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([160-163], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #640]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([159-162], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #636]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([158-161], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #632]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([157-160], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #628]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([156-159], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #624]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([155-158], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #620]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([154-157], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #616]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([153-156], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #612]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([152-155], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #608]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([151-154], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #604]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([150-153], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #600]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([149-152], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #596]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([148-151], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #592]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([147-150], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #588]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([146-149], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #584]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([145-148], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #580]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([144-147], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #576]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([143-146], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #572]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([142-145], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #568]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([141-144], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #564]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([140-143], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #560]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([139-142], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #556]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([138-141], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #552]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([137-140], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #548]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([172-175], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #700]
	ldr.w	r5, [r2, #696]
	ldr.w	r4, [r2, #692]
	ldr.w	r3, [r2, #688]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([171-174], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #684]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([170-173], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #680]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([169-172], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #676]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([168-171], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #672]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([167-170], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #668]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([166-169], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #664]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([165-168], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #660]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([164-167], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #656]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([163-166], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #652]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([162-165], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #648]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([161-164], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #644]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([160-163], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #640]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([159-162], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #636]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([158-161], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #632]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([157-160], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #628]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([156-159], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #624]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([155-158], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #620]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([154-157], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #616]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([153-156], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #612]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([152-155], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #608]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([151-154], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #604]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([150-153], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #600]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([149-152], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #596]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([148-151], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #592]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([147-150], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #588]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([146-149], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #584]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([145-148], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #580]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([144-147], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #576]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([143-146], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #572]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([142-145], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #568]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([141-144], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #564]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([176-179], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #716]
	ldr.w	r4, [r2, #712]
	ldr.w	r3, [r2, #708]
	ldr.w	r14, [r2, #704]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([175-178], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #700]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([174-177], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #696]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([173-176], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #692]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([172-175], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #688]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([171-174], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #684]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([170-173], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #680]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([169-172], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #676]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([168-171], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #672]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([167-170], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #668]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([166-169], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #664]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([165-168], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #660]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([164-167], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #656]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([163-166], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #652]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([162-165], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #648]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([161-164], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #644]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([160-163], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #640]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([159-162], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #636]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([158-161], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #632]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([157-160], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #628]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([156-159], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #624]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([155-158], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #620]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([154-157], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #616]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([153-156], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #612]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([152-155], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #608]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([151-154], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #604]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([150-153], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #600]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([149-152], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #596]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([148-151], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #592]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([147-150], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #588]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([146-149], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #584]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([145-148], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #580]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([180-183], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #732]
	ldr.w	r3, [r2, #728]
	ldr.w	r14, [r2, #724]
	ldr.w	r12, [r2, #720]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([179-182], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #716]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([178-181], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #712]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([177-180], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #708]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([176-179], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #704]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([175-178], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #700]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([174-177], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #696]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([173-176], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #692]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([172-175], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #688]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([171-174], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #684]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([170-173], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #680]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([169-172], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #676]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([168-171], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #672]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([167-170], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #668]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([166-169], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #664]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([165-168], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #660]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([164-167], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #656]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([163-166], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #652]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([162-165], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #648]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([161-164], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #644]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([160-163], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #640]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([159-162], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #636]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([158-161], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #632]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([157-160], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #628]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([156-159], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #624]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([155-158], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #620]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([154-157], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #616]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([153-156], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #612]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([152-155], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #608]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([151-154], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #604]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([150-153], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #600]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([149-152], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #596]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([184-187], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #748]
	ldr.w	r14, [r2, #744]
	ldr.w	r12, [r2, #740]
	ldr.w	r5, [r2, #736]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([183-186], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #732]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([182-185], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #728]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([181-184], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #724]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([180-183], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #720]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([179-182], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #716]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([178-181], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #712]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([177-180], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #708]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([176-179], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #704]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([175-178], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #700]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([174-177], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #696]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([173-176], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #692]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([172-175], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #688]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([171-174], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #684]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([170-173], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #680]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([169-172], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #676]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([168-171], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #672]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([167-170], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #668]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([166-169], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #664]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([165-168], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #660]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([164-167], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #656]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([163-166], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #652]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([162-165], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #648]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([161-164], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #644]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([160-163], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #640]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([159-162], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #636]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([158-161], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #632]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([157-160], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #628]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([156-159], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #624]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([155-158], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #620]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([154-157], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #616]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([153-156], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #612]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([188-191], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #764]
	ldr.w	r12, [r2, #760]
	ldr.w	r5, [r2, #756]
	ldr.w	r4, [r2, #752]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([187-190], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #748]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([186-189], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #744]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([185-188], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #740]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([184-187], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #736]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([183-186], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #732]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([182-185], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #728]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([181-184], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #724]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([180-183], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #720]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([179-182], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #716]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([178-181], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #712]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([177-180], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #708]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([176-179], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #704]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([175-178], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #700]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([174-177], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #696]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([173-176], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #692]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([172-175], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #688]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([171-174], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #684]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([170-173], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #680]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([169-172], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #676]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([168-171], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #672]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([167-170], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #668]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([166-169], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #664]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([165-168], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #660]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([164-167], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #656]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([163-166], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #652]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([162-165], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #648]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([161-164], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #644]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([160-163], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #640]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([159-162], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #636]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([158-161], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #632]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([157-160], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #628]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([192-195], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #780]
	ldr.w	r5, [r2, #776]
	ldr.w	r4, [r2, #772]
	ldr.w	r3, [r2, #768]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([191-194], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #764]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([190-193], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #760]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([189-192], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #756]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([188-191], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #752]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([187-190], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #748]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([186-189], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #744]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([185-188], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #740]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([184-187], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #736]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([183-186], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #732]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([182-185], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #728]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([181-184], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #724]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([180-183], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #720]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([179-182], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #716]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([178-181], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #712]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([177-180], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #708]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([176-179], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #704]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([175-178], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #700]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([174-177], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #696]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([173-176], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #692]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([172-175], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #688]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([171-174], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #684]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([170-173], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #680]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([169-172], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #676]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([168-171], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #672]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([167-170], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #668]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([166-169], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #664]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([165-168], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #660]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([164-167], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #656]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([163-166], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #652]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([162-165], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #648]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([161-164], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #644]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([196-199], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #796]
	ldr.w	r4, [r2, #792]
	ldr.w	r3, [r2, #788]
	ldr.w	r14, [r2, #784]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([195-198], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #780]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([194-197], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #776]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([193-196], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #772]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([192-195], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #768]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([191-194], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #764]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([190-193], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #760]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([189-192], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #756]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([188-191], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #752]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([187-190], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #748]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([186-189], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #744]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([185-188], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #740]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([184-187], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #736]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([183-186], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #732]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([182-185], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #728]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([181-184], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #724]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([180-183], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #720]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([179-182], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #716]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([178-181], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #712]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([177-180], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #708]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([176-179], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #704]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([175-178], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #700]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([174-177], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #696]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([173-176], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #692]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([172-175], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #688]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([171-174], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #684]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([170-173], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #680]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([169-172], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #676]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([168-171], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #672]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([167-170], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #668]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([166-169], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #664]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([165-168], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #660]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([200-203], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #812]
	ldr.w	r3, [r2, #808]
	ldr.w	r14, [r2, #804]
	ldr.w	r12, [r2, #800]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([199-202], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #796]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([198-201], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #792]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([197-200], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #788]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([196-199], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #784]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([195-198], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #780]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([194-197], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #776]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([193-196], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #772]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([192-195], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #768]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([191-194], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #764]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([190-193], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #760]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([189-192], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #756]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([188-191], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #752]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([187-190], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #748]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([186-189], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #744]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([185-188], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #740]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([184-187], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #736]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([183-186], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #732]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([182-185], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #728]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([181-184], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #724]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([180-183], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #720]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([179-182], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #716]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([178-181], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #712]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([177-180], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #708]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([176-179], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #704]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([175-178], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #700]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([174-177], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #696]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([173-176], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #692]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([172-175], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #688]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([171-174], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #684]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([170-173], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #680]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([169-172], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #676]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([204-207], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #828]
	ldr.w	r14, [r2, #824]
	ldr.w	r12, [r2, #820]
	ldr.w	r5, [r2, #816]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([203-206], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #812]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([202-205], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #808]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([201-204], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #804]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([200-203], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #800]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([199-202], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #796]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([198-201], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #792]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([197-200], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #788]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([196-199], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #784]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([195-198], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #780]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([194-197], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #776]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([193-196], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #772]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([192-195], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #768]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([191-194], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #764]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([190-193], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #760]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([189-192], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #756]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([188-191], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #752]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([187-190], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #748]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([186-189], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #744]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([185-188], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #740]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([184-187], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #736]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([183-186], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #732]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([182-185], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #728]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([181-184], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #724]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([180-183], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #720]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([179-182], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #716]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([178-181], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #712]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([177-180], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #708]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([176-179], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #704]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([175-178], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #700]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([174-177], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #696]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([173-176], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #692]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([208-211], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #844]
	ldr.w	r12, [r2, #840]
	ldr.w	r5, [r2, #836]
	ldr.w	r4, [r2, #832]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([207-210], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #828]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([206-209], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #824]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([205-208], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #820]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([204-207], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #816]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([203-206], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #812]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([202-205], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #808]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([201-204], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #804]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([200-203], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #800]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([199-202], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #796]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([198-201], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #792]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([197-200], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #788]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([196-199], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #784]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([195-198], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #780]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([194-197], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #776]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([193-196], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #772]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([192-195], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #768]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([191-194], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #764]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([190-193], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #760]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([189-192], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #756]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([188-191], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #752]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([187-190], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #748]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([186-189], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #744]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([185-188], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #740]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([184-187], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #736]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([183-186], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #732]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([182-185], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #728]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([181-184], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #724]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([180-183], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #720]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([179-182], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #716]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([178-181], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #712]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([177-180], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #708]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([212-215], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #860]
	ldr.w	r5, [r2, #856]
	ldr.w	r4, [r2, #852]
	ldr.w	r3, [r2, #848]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([211-214], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #844]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([210-213], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #840]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([209-212], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #836]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([208-211], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #832]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([207-210], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #828]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([206-209], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #824]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([205-208], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #820]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([204-207], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #816]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([203-206], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #812]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([202-205], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #808]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([201-204], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #804]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([200-203], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #800]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([199-202], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #796]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([198-201], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #792]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([197-200], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #788]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([196-199], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #784]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([195-198], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #780]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([194-197], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #776]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([193-196], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #772]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([192-195], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #768]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([191-194], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #764]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([190-193], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #760]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([189-192], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #756]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([188-191], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #752]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([187-190], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #748]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([186-189], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #744]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([185-188], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #740]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([184-187], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #736]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([183-186], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #732]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([182-185], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #728]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([181-184], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #724]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([216-219], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #876]
	ldr.w	r4, [r2, #872]
	ldr.w	r3, [r2, #868]
	ldr.w	r14, [r2, #864]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([215-218], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #860]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([214-217], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #856]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([213-216], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #852]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([212-215], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #848]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([211-214], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #844]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([210-213], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #840]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([209-212], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #836]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([208-211], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #832]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([207-210], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #828]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([206-209], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #824]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([205-208], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #820]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([204-207], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #816]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([203-206], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #812]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([202-205], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #808]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([201-204], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #804]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([200-203], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #800]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([199-202], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #796]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([198-201], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #792]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([197-200], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #788]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([196-199], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #784]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([195-198], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #780]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([194-197], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #776]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([193-196], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #772]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([192-195], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #768]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([191-194], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #764]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([190-193], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #760]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([189-192], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #756]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([188-191], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #752]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([187-190], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #748]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([186-189], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #744]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([185-188], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #740]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([220-223], 0) blocks
	ldr.w	r5, [r1]
	ldr.w	r4, [r2, #892]
	ldr.w	r3, [r2, #888]
	ldr.w	r14, [r2, #884]
	ldr.w	r12, [r2, #880]
	umull	r7, r8, r14, r5
	umull	r9, r10, r4, r5
	umlal	r6, r7, r12, r5
	umlal	r8, r9, r3, r5
	// ([219-222], 1) blocks
	ldr.w	r4, [r1, #4]
	ldr.w	r5, [r2, #876]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([218-221], 2) blocks
	ldr.w	r3, [r1, #8]
	ldr.w	r4, [r2, #872]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([217-220], 3) blocks
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r2, #868]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([216-219], 4) blocks
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r2, #864]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([215-218], 5) blocks
	ldr.w	r5, [r1, #20]
	ldr.w	r12, [r2, #860]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([214-217], 6) blocks
	ldr.w	r4, [r1, #24]
	ldr.w	r5, [r2, #856]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([213-216], 7) blocks
	ldr.w	r3, [r1, #28]
	ldr.w	r4, [r2, #852]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([212-215], 8) blocks
	ldr.w	r14, [r1, #32]
	ldr.w	r3, [r2, #848]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([211-214], 9) blocks
	ldr.w	r12, [r1, #36]
	ldr.w	r14, [r2, #844]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([210-213], 10) blocks
	ldr.w	r5, [r1, #40]
	ldr.w	r12, [r2, #840]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([209-212], 11) blocks
	ldr.w	r4, [r1, #44]
	ldr.w	r5, [r2, #836]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([208-211], 12) blocks
	ldr.w	r3, [r1, #48]
	ldr.w	r4, [r2, #832]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([207-210], 13) blocks
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r2, #828]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([206-209], 14) blocks
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r2, #824]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	and	r12, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r12, LSR #4	// range < 31
	// ([205-208], 15) blocks
	ldr.w	r5, [r1, #60]
	ldr.w	r12, [r2, #820]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([204-207], 16) blocks
	ldr.w	r4, [r1, #64]
	ldr.w	r5, [r2, #816]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([203-206], 17) blocks
	ldr.w	r3, [r1, #68]
	ldr.w	r4, [r2, #812]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([202-205], 18) blocks
	ldr.w	r14, [r1, #72]
	ldr.w	r3, [r2, #808]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([201-204], 19) blocks
	ldr.w	r12, [r1, #76]
	ldr.w	r14, [r2, #804]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([200-203], 20) blocks
	ldr.w	r5, [r1, #80]
	ldr.w	r12, [r2, #800]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	and	r5, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r5, LSR #4	// range < 31
	// ([199-202], 21) blocks
	ldr.w	r4, [r1, #84]
	ldr.w	r5, [r2, #796]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([198-201], 22) blocks
	ldr.w	r3, [r1, #88]
	ldr.w	r4, [r2, #792]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([197-200], 23) blocks
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r2, #788]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	// ([196-199], 24) blocks
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r2, #784]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([195-198], 25) blocks
	ldr.w	r5, [r1, #100]
	ldr.w	r12, [r2, #780]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([194-197], 26) blocks
	ldr.w	r4, [r1, #104]
	ldr.w	r5, [r2, #776]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	// ([193-196], 27) blocks
	ldr.w	r3, [r1, #108]
	ldr.w	r4, [r2, #772]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r12, r3
	umlal	r9, r10, r14, r3
	// ([192-195], 28) blocks
	ldr.w	r14, [r1, #112]
	ldr.w	r3, [r2, #768]
	umlal	r6, r7, r3, r14
	umlal	r7, r8, r4, r14
	umlal	r8, r9, r5, r14
	umlal	r9, r10, r12, r14
	and	r14, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r14, LSR #4	// range < 31
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	// ([191-194], 29) blocks
	ldr.w	r12, [r1, #116]
	ldr.w	r14, [r2, #764]
	umlal	r6, r7, r14, r12
	umlal	r7, r8, r3, r12
	umlal	r8, r9, r4, r12
	umlal	r9, r10, r5, r12
	// ([190-193], 30) blocks
	ldr.w	r5, [r1, #120]
	ldr.w	r12, [r2, #760]
	umlal	r6, r7, r12, r5
	umlal	r7, r8, r14, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([189-192], 31) blocks
	ldr.w	r4, [r1, #124]
	ldr.w	r5, [r2, #756]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r12, r4
	umlal	r8, r9, r14, r4
	umlal	r9, r10, r3, r4
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([224-227], 0) blocks
	ldr.w	r4, [r1]
	ldr.w	r3, [r2, #908]
	ldr.w	r14, [r2, #904]
	ldr.w	r12, [r2, #900]
	ldr.w	r5, [r2, #896]
	umull	r6, r7, r12, r4
	umull	r8, r9, r3, r4
	umlal	r10, r6, r5, r4
	umlal	r7, r8, r14, r4
	// ([223-226], 1) blocks
	ldr.w	r3, [r1, #4]
	ldr.w	r4, [r2, #892]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([222-225], 2) blocks
	ldr.w	r14, [r1, #8]
	ldr.w	r3, [r2, #888]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([221-224], 3) blocks
	ldr.w	r12, [r1, #12]
	ldr.w	r14, [r2, #884]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([220-223], 4) blocks
	ldr.w	r5, [r1, #16]
	ldr.w	r12, [r2, #880]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([219-222], 5) blocks
	ldr.w	r4, [r1, #20]
	ldr.w	r5, [r2, #876]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([218-221], 6) blocks
	ldr.w	r3, [r1, #24]
	ldr.w	r4, [r2, #872]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([217-220], 7) blocks
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r2, #868]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([216-219], 8) blocks
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r2, #864]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([215-218], 9) blocks
	ldr.w	r5, [r1, #36]
	ldr.w	r12, [r2, #860]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([214-217], 10) blocks
	ldr.w	r4, [r1, #40]
	ldr.w	r5, [r2, #856]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([213-216], 11) blocks
	ldr.w	r3, [r1, #44]
	ldr.w	r4, [r2, #852]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([212-215], 12) blocks
	ldr.w	r14, [r1, #48]
	ldr.w	r3, [r2, #848]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([211-214], 13) blocks
	ldr.w	r12, [r1, #52]
	ldr.w	r14, [r2, #844]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([210-213], 14) blocks
	ldr.w	r5, [r1, #56]
	ldr.w	r12, [r2, #840]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
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
	// ([209-212], 15) blocks
	ldr.w	r4, [r1, #60]
	ldr.w	r5, [r2, #836]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([208-211], 16) blocks
	ldr.w	r3, [r1, #64]
	ldr.w	r4, [r2, #832]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([207-210], 17) blocks
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r2, #828]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([206-209], 18) blocks
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r2, #824]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([205-208], 19) blocks
	ldr.w	r5, [r1, #76]
	ldr.w	r12, [r2, #820]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([204-207], 20) blocks
	ldr.w	r4, [r1, #80]
	ldr.w	r5, [r2, #816]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	// ([203-206], 21) blocks
	ldr.w	r3, [r1, #84]
	ldr.w	r4, [r2, #812]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([202-205], 22) blocks
	ldr.w	r14, [r1, #88]
	ldr.w	r3, [r2, #808]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([201-204], 23) blocks
	ldr.w	r12, [r1, #92]
	ldr.w	r14, [r2, #804]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	// ([200-203], 24) blocks
	ldr.w	r5, [r1, #96]
	ldr.w	r12, [r2, #800]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([199-202], 25) blocks
	ldr.w	r4, [r1, #100]
	ldr.w	r5, [r2, #796]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([198-201], 26) blocks
	ldr.w	r3, [r1, #104]
	ldr.w	r4, [r2, #792]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	// ([197-200], 27) blocks
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r2, #788]
	umlal	r10, r6, r3, r14
	umlal	r6, r7, r4, r14
	umlal	r7, r8, r5, r14
	umlal	r8, r9, r12, r14
	// ([196-199], 28) blocks
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r2, #784]
	umlal	r10, r6, r14, r12
	umlal	r6, r7, r3, r12
	umlal	r7, r8, r4, r12
	umlal	r8, r9, r5, r12
	and	r12, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r12, LSR #4	// range < 31
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	and	r12, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r12, LSR #4	// range < 31
	and	r12, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r12, LSR #4	// range < 31
	// ([195-198], 29) blocks
	ldr.w	r5, [r1, #116]
	ldr.w	r12, [r2, #780]
	umlal	r10, r6, r12, r5
	umlal	r6, r7, r14, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	// ([194-197], 30) blocks
	ldr.w	r4, [r1, #120]
	ldr.w	r5, [r2, #776]
	umlal	r10, r6, r5, r4
	umlal	r6, r7, r12, r4
	umlal	r7, r8, r14, r4
	umlal	r8, r9, r3, r4
	// ([193-196], 31) blocks
	ldr.w	r3, [r1, #124]
	ldr.w	r4, [r2, #772]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r12, r3
	umlal	r8, r9, r14, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([228-231], 0) blocks
	ldr.w	r3, [r1]
	ldr.w	r14, [r2, #924]
	ldr.w	r12, [r2, #920]
	ldr.w	r5, [r2, #916]
	ldr.w	r4, [r2, #912]
	umull	r10, r6, r5, r3
	umull	r7, r8, r14, r3
	umlal	r9, r10, r4, r3
	umlal	r6, r7, r12, r3
	// ([227-230], 1) blocks
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r2, #908]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([226-229], 2) blocks
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r2, #904]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([225-228], 3) blocks
	ldr.w	r5, [r1, #12]
	ldr.w	r12, [r2, #900]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([224-227], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r5, [r2, #896]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([223-226], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r4, [r2, #892]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([222-225], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r3, [r2, #888]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([221-224], 7) blocks
	ldr.w	r12, [r1, #28]
	ldr.w	r14, [r2, #884]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([220-223], 8) blocks
	ldr.w	r5, [r1, #32]
	ldr.w	r12, [r2, #880]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([219-222], 9) blocks
	ldr.w	r4, [r1, #36]
	ldr.w	r5, [r2, #876]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([218-221], 10) blocks
	ldr.w	r3, [r1, #40]
	ldr.w	r4, [r2, #872]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([217-220], 11) blocks
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r2, #868]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([216-219], 12) blocks
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r2, #864]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([215-218], 13) blocks
	ldr.w	r5, [r1, #52]
	ldr.w	r12, [r2, #860]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([214-217], 14) blocks
	ldr.w	r4, [r1, #56]
	ldr.w	r5, [r2, #856]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
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
	// ([213-216], 15) blocks
	ldr.w	r3, [r1, #60]
	ldr.w	r4, [r2, #852]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([212-215], 16) blocks
	ldr.w	r14, [r1, #64]
	ldr.w	r3, [r2, #848]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([211-214], 17) blocks
	ldr.w	r12, [r1, #68]
	ldr.w	r14, [r2, #844]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([210-213], 18) blocks
	ldr.w	r5, [r1, #72]
	ldr.w	r12, [r2, #840]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([209-212], 19) blocks
	ldr.w	r4, [r1, #76]
	ldr.w	r5, [r2, #836]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([208-211], 20) blocks
	ldr.w	r3, [r1, #80]
	ldr.w	r4, [r2, #832]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	// ([207-210], 21) blocks
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r2, #828]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([206-209], 22) blocks
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r2, #824]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([205-208], 23) blocks
	ldr.w	r5, [r1, #92]
	ldr.w	r12, [r2, #820]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	// ([204-207], 24) blocks
	ldr.w	r4, [r1, #96]
	ldr.w	r5, [r2, #816]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([203-206], 25) blocks
	ldr.w	r3, [r1, #100]
	ldr.w	r4, [r2, #812]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([202-205], 26) blocks
	ldr.w	r14, [r1, #104]
	ldr.w	r3, [r2, #808]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	// ([201-204], 27) blocks
	ldr.w	r12, [r1, #108]
	ldr.w	r14, [r2, #804]
	umlal	r9, r10, r14, r12
	umlal	r10, r6, r3, r12
	umlal	r6, r7, r4, r12
	umlal	r7, r8, r5, r12
	// ([200-203], 28) blocks
	ldr.w	r5, [r1, #112]
	ldr.w	r12, [r2, #800]
	umlal	r9, r10, r12, r5
	umlal	r10, r6, r14, r5
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
	// ([199-202], 29) blocks
	ldr.w	r4, [r1, #116]
	ldr.w	r5, [r2, #796]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	// ([198-201], 30) blocks
	ldr.w	r3, [r1, #120]
	ldr.w	r4, [r2, #792]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	// ([197-200], 31) blocks
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r2, #788]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([232-235], 0) blocks
	ldr.w	r14, [r1]
	ldr.w	r12, [r2, #940]
	ldr.w	r5, [r2, #936]
	ldr.w	r4, [r2, #932]
	ldr.w	r3, [r2, #928]
	umull	r9, r10, r4, r14
	umull	r6, r7, r12, r14
	umlal	r8, r9, r3, r14
	umlal	r10, r6, r5, r14
	// ([231-234], 1) blocks
	ldr.w	r12, [r1, #4]
	ldr.w	r14, [r2, #924]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([230-233], 2) blocks
	ldr.w	r5, [r1, #8]
	ldr.w	r12, [r2, #920]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([229-232], 3) blocks
	ldr.w	r4, [r1, #12]
	ldr.w	r5, [r2, #916]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([228-231], 4) blocks
	ldr.w	r3, [r1, #16]
	ldr.w	r4, [r2, #912]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([227-230], 5) blocks
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r2, #908]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([226-229], 6) blocks
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r2, #904]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([225-228], 7) blocks
	ldr.w	r5, [r1, #28]
	ldr.w	r12, [r2, #900]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([224-227], 8) blocks
	ldr.w	r4, [r1, #32]
	ldr.w	r5, [r2, #896]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([223-226], 9) blocks
	ldr.w	r3, [r1, #36]
	ldr.w	r4, [r2, #892]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([222-225], 10) blocks
	ldr.w	r14, [r1, #40]
	ldr.w	r3, [r2, #888]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([221-224], 11) blocks
	ldr.w	r12, [r1, #44]
	ldr.w	r14, [r2, #884]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([220-223], 12) blocks
	ldr.w	r5, [r1, #48]
	ldr.w	r12, [r2, #880]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([219-222], 13) blocks
	ldr.w	r4, [r1, #52]
	ldr.w	r5, [r2, #876]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([218-221], 14) blocks
	ldr.w	r3, [r1, #56]
	ldr.w	r4, [r2, #872]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	and	r3, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r3, LSR #4	// range < 31
	and	r3, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r3, LSR #4	// range < 31
	and	r3, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r3, LSR #4	// range < 31
	and	r3, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r3, LSR #4	// range < 31
	// ([217-220], 15) blocks
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r2, #868]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([216-219], 16) blocks
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r2, #864]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([215-218], 17) blocks
	ldr.w	r5, [r1, #68]
	ldr.w	r12, [r2, #860]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([214-217], 18) blocks
	ldr.w	r4, [r1, #72]
	ldr.w	r5, [r2, #856]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([213-216], 19) blocks
	ldr.w	r3, [r1, #76]
	ldr.w	r4, [r2, #852]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([212-215], 20) blocks
	ldr.w	r14, [r1, #80]
	ldr.w	r3, [r2, #848]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	// ([211-214], 21) blocks
	ldr.w	r12, [r1, #84]
	ldr.w	r14, [r2, #844]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([210-213], 22) blocks
	ldr.w	r5, [r1, #88]
	ldr.w	r12, [r2, #840]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([209-212], 23) blocks
	ldr.w	r4, [r1, #92]
	ldr.w	r5, [r2, #836]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
	umlal	r6, r7, r3, r4
	// ([208-211], 24) blocks
	ldr.w	r3, [r1, #96]
	ldr.w	r4, [r2, #832]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([207-210], 25) blocks
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r2, #828]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([206-209], 26) blocks
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r2, #824]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	// ([205-208], 27) blocks
	ldr.w	r5, [r1, #108]
	ldr.w	r12, [r2, #820]
	umlal	r8, r9, r12, r5
	umlal	r9, r10, r14, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([204-207], 28) blocks
	ldr.w	r4, [r1, #112]
	ldr.w	r5, [r2, #816]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r12, r4
	umlal	r10, r6, r14, r4
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
	// ([203-206], 29) blocks
	ldr.w	r3, [r1, #116]
	ldr.w	r4, [r2, #812]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r12, r3
	umlal	r6, r7, r14, r3
	// ([202-205], 30) blocks
	ldr.w	r14, [r1, #120]
	ldr.w	r3, [r2, #808]
	umlal	r8, r9, r3, r14
	umlal	r9, r10, r4, r14
	umlal	r10, r6, r5, r14
	umlal	r6, r7, r12, r14
	// ([201-204], 31) blocks
	ldr.w	r12, [r1, #124]
	ldr.w	r14, [r2, #804]
	umlal	r8, r9, r14, r12
	umlal	r9, r10, r3, r12
	umlal	r10, r6, r4, r12
	umlal	r6, r7, r5, r12
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([236-239], 0) blocks
	ldr.w	r12, [r1]
	ldr.w	r5, [r2, #956]
	ldr.w	r4, [r2, #952]
	ldr.w	r3, [r2, #948]
	ldr.w	r14, [r2, #944]
	umull	r8, r9, r3, r12
	umull	r10, r6, r5, r12
	umlal	r7, r8, r14, r12
	umlal	r9, r10, r4, r12
	// ([235-238], 1) blocks
	ldr.w	r5, [r1, #4]
	ldr.w	r12, [r2, #940]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([234-237], 2) blocks
	ldr.w	r4, [r1, #8]
	ldr.w	r5, [r2, #936]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([233-236], 3) blocks
	ldr.w	r3, [r1, #12]
	ldr.w	r4, [r2, #932]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([232-235], 4) blocks
	ldr.w	r14, [r1, #16]
	ldr.w	r3, [r2, #928]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([231-234], 5) blocks
	ldr.w	r12, [r1, #20]
	ldr.w	r14, [r2, #924]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([230-233], 6) blocks
	ldr.w	r5, [r1, #24]
	ldr.w	r12, [r2, #920]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([229-232], 7) blocks
	ldr.w	r4, [r1, #28]
	ldr.w	r5, [r2, #916]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([228-231], 8) blocks
	ldr.w	r3, [r1, #32]
	ldr.w	r4, [r2, #912]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([227-230], 9) blocks
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r2, #908]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([226-229], 10) blocks
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r2, #904]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([225-228], 11) blocks
	ldr.w	r5, [r1, #44]
	ldr.w	r12, [r2, #900]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([224-227], 12) blocks
	ldr.w	r4, [r1, #48]
	ldr.w	r5, [r2, #896]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([223-226], 13) blocks
	ldr.w	r3, [r1, #52]
	ldr.w	r4, [r2, #892]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([222-225], 14) blocks
	ldr.w	r14, [r1, #56]
	ldr.w	r3, [r2, #888]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	and	r14, r7, #0xF0F0F0F0	// top 4b < 16
	and	r7, r7, #0x0F0F0F0F	// bot 4b < 16
	add	r7, r7, r14, LSR #4	// range < 31
	and	r14, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r14, LSR #4	// range < 31
	and	r14, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r14, LSR #4	// range < 31
	and	r14, r10, #0xF0F0F0F0	// top 4b < 16
	and	r10, r10, #0x0F0F0F0F	// bot 4b < 16
	add	r10, r10, r14, LSR #4	// range < 31
	// ([221-224], 15) blocks
	ldr.w	r12, [r1, #60]
	ldr.w	r14, [r2, #884]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([220-223], 16) blocks
	ldr.w	r5, [r1, #64]
	ldr.w	r12, [r2, #880]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([219-222], 17) blocks
	ldr.w	r4, [r1, #68]
	ldr.w	r5, [r2, #876]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([218-221], 18) blocks
	ldr.w	r3, [r1, #72]
	ldr.w	r4, [r2, #872]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([217-220], 19) blocks
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r2, #868]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([216-219], 20) blocks
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r2, #864]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	and	r12, r6, #0xF0F0F0F0	// top 4b < 16
	and	r6, r6, #0x0F0F0F0F	// bot 4b < 16
	add	r6, r6, r12, LSR #4	// range < 31
	// ([215-218], 21) blocks
	ldr.w	r5, [r1, #84]
	ldr.w	r12, [r2, #860]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([214-217], 22) blocks
	ldr.w	r4, [r1, #88]
	ldr.w	r5, [r2, #856]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([213-216], 23) blocks
	ldr.w	r3, [r1, #92]
	ldr.w	r4, [r2, #852]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
	// ([212-215], 24) blocks
	ldr.w	r14, [r1, #96]
	ldr.w	r3, [r2, #848]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([211-214], 25) blocks
	ldr.w	r12, [r1, #100]
	ldr.w	r14, [r2, #844]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([210-213], 26) blocks
	ldr.w	r5, [r1, #104]
	ldr.w	r12, [r2, #840]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([209-212], 27) blocks
	ldr.w	r4, [r1, #108]
	ldr.w	r5, [r2, #836]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r12, r4
	umlal	r9, r10, r14, r4
	umlal	r10, r6, r3, r4
	// ([208-211], 28) blocks
	ldr.w	r3, [r1, #112]
	ldr.w	r4, [r2, #832]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r12, r3
	umlal	r10, r6, r14, r3
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
	// ([207-210], 29) blocks
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r2, #828]
	umlal	r7, r8, r3, r14
	umlal	r8, r9, r4, r14
	umlal	r9, r10, r5, r14
	umlal	r10, r6, r12, r14
	// ([206-209], 30) blocks
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r2, #824]
	umlal	r7, r8, r14, r12
	umlal	r8, r9, r3, r12
	umlal	r9, r10, r4, r12
	umlal	r10, r6, r5, r12
	// ([205-208], 31) blocks
	ldr.w	r5, [r1, #124]
	ldr.w	r12, [r2, #820]
	umlal	r7, r8, r12, r5
	umlal	r8, r9, r14, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	pop.w {pc}
