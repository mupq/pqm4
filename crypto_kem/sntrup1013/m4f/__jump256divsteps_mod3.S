.p2align 2,,3
.syntax unified
.text
__polymul_128x128:
	push.w {lr}
sch3_0:			// increasing thread length
	mov	r6, #0
	mov	r12, r1
	mov	r14, r2
	ldr	r11, =0x03030303
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
	ldr	r5, [r12, #4]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
	ldr	r5, [r12, #8]
	umlal	r9, r10, r2, r5
	umlal	r8, r9, r1, r5
	ldr	r5, [r12, #12]
	umlal	r9, r10, r1, r5
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
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
	ldr	r5, [r12, #20]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
	ldr	r5, [r12, #24]
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
	ldr	r5, [r12, #28]
	umlal	r8, r9, r1, r5
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
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
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	ldr	r5, [r12, #36]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	ldr	r5, [r12, #40]
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	ldr	r5, [r12, #44]
	umlal	r7, r8, r1, r5
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
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
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	ldr	r5, [r12, #52]
	umlal	r6, r7, r3, r5
	umlal	r10, r6, r2, r5
	umlal	r9, r10, r1, r5
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	ldr	r5, [r12, #56]
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	ldr	r5, [r12, #60]
	umlal	r6, r7, r1, r5
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
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
	// ([2-5], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r3, [r14, #8]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	and.w r2, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r2, LSR #4 // range < 31
	and.w r2, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r2, LSR #4 // range < 31
	and.w r2, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r2, LSR #4 // range < 31
	and.w r2, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r2, LSR #4 // range < 31
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
	ldr	r5, [r12, #68]
	umlal	r10, r6, r3, r5
	umlal	r9, r10, r2, r5
	umlal	r8, r9, r1, r5
	ldr	r5, [r12, #72]
	umlal	r10, r6, r2, r5
	umlal	r9, r10, r1, r5
	ldr	r5, [r12, #76]
	umlal	r10, r6, r1, r5
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
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
	// ([6-9], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r2, [r14, #24]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	and.w r1, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r1, LSR #4 // range < 31
	and.w r1, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r1, LSR #4 // range < 31
	and.w r1, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r1, LSR #4 // range < 31
	and.w r1, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r1, LSR #4 // range < 31
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
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	// ([0-2],21), ([0-1],22), (0,23) blocks
	ldr	r5, [r12, #84]
	umlal	r9, r10, r3, r5
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	ldr	r5, [r12, #88]
	umlal	r9, r10, r2, r5
	umlal	r8, r9, r1, r5
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	ldr	r5, [r12, #92]
	umlal	r9, r10, r1, r5
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
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
	// ([10-13], 14) blocks
	ldr	r5, [r12, #56]
	ldr	r1, [r14, #40]
	umlal	r10, r6, r1, r5
	umlal	r6, r7, r2, r5
	umlal	r7, r8, r3, r5
	umlal	r8, r9, r4, r5
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
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
	and.w r4, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r4, LSR #4 // range < 31
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
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	ldr	r5, [r12, #100]
	umlal	r8, r9, r3, r5
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	ldr	r5, [r12, #104]
	umlal	r8, r9, r2, r5
	umlal	r7, r8, r1, r5
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	ldr	r5, [r12, #108]
	umlal	r8, r9, r1, r5
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
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
	// ([14-17], 14) blocks
	ldr	r4, [r12, #56]
	ldr	r5, [r14, #56]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	and.w r4, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r4, LSR #4 // range < 31
	and.w r4, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r4, LSR #4 // range < 31
	and.w r4, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r4, LSR #4 // range < 31
	and.w r4, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r4, LSR #4 // range < 31
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
	and.w r3, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r3, LSR #4 // range < 31
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
	// ([0-3], 28) blocks
	ldr	r5, [r12, #112]
	ldr	r1, [r14, #0]
	umlal	r9, r10, r1, r5
	umlal	r10, r6, r2, r5
	umlal	r6, r7, r3, r5
	umlal	r7, r8, r4, r5
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	// ([0-2],29), ([0-1],30), (0,31) blocks
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	ldr	r5, [r12, #116]
	umlal	r7, r8, r3, r5
	umlal	r6, r7, r2, r5
	umlal	r10, r6, r1, r5
	ldr	r5, [r12, #120]
	umlal	r7, r8, r2, r5
	umlal	r6, r7, r1, r5
	ldr	r5, [r12, #124]
	umlal	r7, r8, r1, r5
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
sch3_10:			// decreasing thread length
	// ([1-4], 31) blocks
	ldr	r1, [r12, #124]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r9, r10, r3, r1
	umull	r6, r7, r5, r1
	umlal	r8, r9, r2, r1
	umlal	r10, r6, r4, r1
	// ([2-5], 30) blocks
	ldr	r2, [r12, #120]
	ldr	r1, [r14, #20]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([3-6], 29) blocks
	ldr	r3, [r12, #116]
	ldr	r2, [r14, #24]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([4-7], 28) blocks
	ldr	r4, [r12, #112]
	ldr	r3, [r14, #28]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([5-8], 27) blocks
	ldr	r5, [r12, #108]
	ldr	r4, [r14, #32]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([6-9], 26) blocks
	ldr	r1, [r12, #104]
	ldr	r5, [r14, #36]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([7-10], 25) blocks
	ldr	r2, [r12, #100]
	ldr	r1, [r14, #40]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([8-11], 24) blocks
	ldr	r3, [r12, #96]
	ldr	r2, [r14, #44]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([9-12], 23) blocks
	ldr	r4, [r12, #92]
	ldr	r3, [r14, #48]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([10-13], 22) blocks
	ldr	r5, [r12, #88]
	ldr	r4, [r14, #52]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([11-14], 21) blocks
	ldr	r1, [r12, #84]
	ldr	r5, [r14, #56]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([12-15], 20) blocks
	ldr	r2, [r12, #80]
	ldr	r1, [r14, #60]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([13-16], 19) blocks
	ldr	r3, [r12, #76]
	ldr	r2, [r14, #64]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([14-17], 18) blocks
	ldr	r4, [r12, #72]
	ldr	r3, [r14, #68]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([15-18], 17) blocks
	ldr	r5, [r12, #68]
	ldr	r4, [r14, #72]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	// ([16-19], 16) blocks
	ldr	r1, [r12, #64]
	ldr	r5, [r14, #76]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([17-20], 15) blocks
	ldr	r2, [r12, #60]
	ldr	r1, [r14, #80]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([18-21], 14) blocks
	ldr	r3, [r12, #56]
	ldr	r2, [r14, #84]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([19-22], 13) blocks
	ldr	r4, [r12, #52]
	ldr	r3, [r14, #88]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([20-23], 12) blocks
	ldr	r5, [r12, #48]
	ldr	r4, [r14, #92]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([21-24], 11) blocks
	ldr	r1, [r12, #44]
	ldr	r5, [r14, #96]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	and.w r1, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r1, LSR #4 // range < 31
	// ([22-25], 10) blocks
	ldr	r2, [r12, #40]
	ldr	r1, [r14, #100]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([23-26], 9) blocks
	ldr	r3, [r12, #36]
	ldr	r2, [r14, #104]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([24-27], 8) blocks
	ldr	r4, [r12, #32]
	ldr	r3, [r14, #108]
	umlal	r8, r9, r5, r4
	umlal	r9, r10, r1, r4
	umlal	r10, r6, r2, r4
	umlal	r6, r7, r3, r4
	// ([25-28], 7) blocks
	ldr	r5, [r12, #28]
	ldr	r4, [r14, #112]
	umlal	r8, r9, r1, r5
	umlal	r9, r10, r2, r5
	umlal	r10, r6, r3, r5
	umlal	r6, r7, r4, r5
	// ([26-29], 6) blocks
	ldr	r1, [r12, #24]
	ldr	r5, [r14, #116]
	umlal	r8, r9, r2, r1
	umlal	r9, r10, r3, r1
	umlal	r10, r6, r4, r1
	umlal	r6, r7, r5, r1
	// ([27-30], 5) blocks
	ldr	r2, [r12, #20]
	ldr	r1, [r14, #120]
	umlal	r8, r9, r3, r2
	umlal	r9, r10, r4, r2
	umlal	r10, r6, r5, r2
	umlal	r6, r7, r1, r2
	// ([28-31], 4) blocks
	ldr	r3, [r12, #16]
	ldr	r2, [r14, #124]
	umlal	r8, r9, r4, r3
	umlal	r9, r10, r5, r3
	umlal	r10, r6, r1, r3
	umlal	r6, r7, r2, r3
	// ([29-31],3),([30-31],2),(31,1) blocks
	ldr	r3, [r12, #12]
	umlal	r10, r6, r2, r3
	umlal	r9, r10, r1, r3
	umlal	r8, r9, r5, r3
	and.w r3, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r3, LSR #4 // range < 31
	and.w r3, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r3, LSR #4 // range < 31
	and.w r3, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r3, LSR #4 // range < 31
	and.w r3, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r3, LSR #4 // range < 31
	ldr	r3, [r12, #8]
	umlal	r9, r10, r2, r3
	umlal	r8, r9, r1, r3
	ldr	r3, [r12, #4]
	umlal	r8, r9, r2, r3
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([5-8], 31) blocks
	ldr	r5, [r12, #124]
	ldr	r4, [r14, #32]
	ldr	r3, [r14, #28]
	ldr	r2, [r14, #24]
	ldr	r1, [r14, #20]
	umull	r8, r9, r2, r5
	umull	r10, r6, r4, r5
	umlal	r7, r8, r1, r5
	umlal	r9, r10, r3, r5
	// ([6-9], 30) blocks
	ldr	r1, [r12, #120]
	ldr	r5, [r14, #36]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([7-10], 29) blocks
	ldr	r2, [r12, #116]
	ldr	r1, [r14, #40]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([8-11], 28) blocks
	ldr	r3, [r12, #112]
	ldr	r2, [r14, #44]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([9-12], 27) blocks
	ldr	r4, [r12, #108]
	ldr	r3, [r14, #48]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([10-13], 26) blocks
	ldr	r5, [r12, #104]
	ldr	r4, [r14, #52]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([11-14], 25) blocks
	ldr	r1, [r12, #100]
	ldr	r5, [r14, #56]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([12-15], 24) blocks
	ldr	r2, [r12, #96]
	ldr	r1, [r14, #60]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([13-16], 23) blocks
	ldr	r3, [r12, #92]
	ldr	r2, [r14, #64]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([14-17], 22) blocks
	ldr	r4, [r12, #88]
	ldr	r3, [r14, #68]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([15-18], 21) blocks
	ldr	r5, [r12, #84]
	ldr	r4, [r14, #72]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([16-19], 20) blocks
	ldr	r1, [r12, #80]
	ldr	r5, [r14, #76]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([17-20], 19) blocks
	ldr	r2, [r12, #76]
	ldr	r1, [r14, #80]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([18-21], 18) blocks
	ldr	r3, [r12, #72]
	ldr	r2, [r14, #84]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([19-22], 17) blocks
	ldr	r4, [r12, #68]
	ldr	r3, [r14, #88]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	and.w r4, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r4, LSR #4 // range < 31
	and.w r4, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r4, LSR #4 // range < 31
	and.w r4, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r4, LSR #4 // range < 31
	and.w r4, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r4, LSR #4 // range < 31
	// ([20-23], 16) blocks
	ldr	r5, [r12, #64]
	ldr	r4, [r14, #92]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	// ([21-24], 15) blocks
	ldr	r1, [r12, #60]
	ldr	r5, [r14, #96]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([22-25], 14) blocks
	ldr	r2, [r12, #56]
	ldr	r1, [r14, #100]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([23-26], 13) blocks
	ldr	r3, [r12, #52]
	ldr	r2, [r14, #104]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([24-27], 12) blocks
	ldr	r4, [r12, #48]
	ldr	r3, [r14, #108]
	umlal	r7, r8, r5, r4
	umlal	r8, r9, r1, r4
	umlal	r9, r10, r2, r4
	umlal	r10, r6, r3, r4
	// ([25-28], 11) blocks
	ldr	r5, [r12, #44]
	ldr	r4, [r14, #112]
	umlal	r7, r8, r1, r5
	umlal	r8, r9, r2, r5
	umlal	r9, r10, r3, r5
	umlal	r10, r6, r4, r5
	and.w r5, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r5, LSR #4 // range < 31
	// ([26-29], 10) blocks
	ldr	r1, [r12, #40]
	ldr	r5, [r14, #116]
	umlal	r7, r8, r2, r1
	umlal	r8, r9, r3, r1
	umlal	r9, r10, r4, r1
	umlal	r10, r6, r5, r1
	// ([27-30], 9) blocks
	ldr	r2, [r12, #36]
	ldr	r1, [r14, #120]
	umlal	r7, r8, r3, r2
	umlal	r8, r9, r4, r2
	umlal	r9, r10, r5, r2
	umlal	r10, r6, r1, r2
	// ([28-31], 8) blocks
	ldr	r3, [r12, #32]
	ldr	r2, [r14, #124]
	umlal	r7, r8, r4, r3
	umlal	r8, r9, r5, r3
	umlal	r9, r10, r1, r3
	umlal	r10, r6, r2, r3
	// ([29-31],7),([30-31],6),(31,5) blocks
	ldr	r3, [r12, #28]
	umlal	r9, r10, r2, r3
	umlal	r8, r9, r1, r3
	umlal	r7, r8, r5, r3
	and.w r3, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r3, LSR #4 // range < 31
	ldr	r3, [r12, #24]
	umlal	r8, r9, r2, r3
	umlal	r7, r8, r1, r3
	and.w r3, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r3, LSR #4 // range < 31
	ldr	r3, [r12, #20]
	umlal	r7, r8, r2, r3
	and.w r3, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r3, LSR #4 // range < 31
	and.w r3, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r3, LSR #4 // range < 31
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
	// ([9-12], 31) blocks
	ldr	r4, [r12, #124]
	ldr	r3, [r14, #48]
	ldr	r2, [r14, #44]
	ldr	r1, [r14, #40]
	ldr	r5, [r14, #36]
	umull	r7, r8, r1, r4
	umull	r9, r10, r3, r4
	umlal	r6, r7, r5, r4
	umlal	r8, r9, r2, r4
	// ([10-13], 30) blocks
	ldr	r5, [r12, #120]
	ldr	r4, [r14, #52]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([11-14], 29) blocks
	ldr	r1, [r12, #116]
	ldr	r5, [r14, #56]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([12-15], 28) blocks
	ldr	r2, [r12, #112]
	ldr	r1, [r14, #60]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([13-16], 27) blocks
	ldr	r3, [r12, #108]
	ldr	r2, [r14, #64]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([14-17], 26) blocks
	ldr	r4, [r12, #104]
	ldr	r3, [r14, #68]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([15-18], 25) blocks
	ldr	r5, [r12, #100]
	ldr	r4, [r14, #72]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([16-19], 24) blocks
	ldr	r1, [r12, #96]
	ldr	r5, [r14, #76]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([17-20], 23) blocks
	ldr	r2, [r12, #92]
	ldr	r1, [r14, #80]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([18-21], 22) blocks
	ldr	r3, [r12, #88]
	ldr	r2, [r14, #84]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([19-22], 21) blocks
	ldr	r4, [r12, #84]
	ldr	r3, [r14, #88]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([20-23], 20) blocks
	ldr	r5, [r12, #80]
	ldr	r4, [r14, #92]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([21-24], 19) blocks
	ldr	r1, [r12, #76]
	ldr	r5, [r14, #96]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([22-25], 18) blocks
	ldr	r2, [r12, #72]
	ldr	r1, [r14, #100]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([23-26], 17) blocks
	ldr	r3, [r12, #68]
	ldr	r2, [r14, #104]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	and.w r3, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r3, LSR #4 // range < 31
	and.w r3, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r3, LSR #4 // range < 31
	and.w r3, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r3, LSR #4 // range < 31
	and.w r3, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r3, LSR #4 // range < 31
	// ([24-27], 16) blocks
	ldr	r4, [r12, #64]
	ldr	r3, [r14, #108]
	umlal	r6, r7, r5, r4
	umlal	r7, r8, r1, r4
	umlal	r8, r9, r2, r4
	umlal	r9, r10, r3, r4
	// ([25-28], 15) blocks
	ldr	r5, [r12, #60]
	ldr	r4, [r14, #112]
	umlal	r6, r7, r1, r5
	umlal	r7, r8, r2, r5
	umlal	r8, r9, r3, r5
	umlal	r9, r10, r4, r5
	// ([26-29], 14) blocks
	ldr	r1, [r12, #56]
	ldr	r5, [r14, #116]
	umlal	r6, r7, r2, r1
	umlal	r7, r8, r3, r1
	umlal	r8, r9, r4, r1
	umlal	r9, r10, r5, r1
	// ([27-30], 13) blocks
	ldr	r2, [r12, #52]
	ldr	r1, [r14, #120]
	umlal	r6, r7, r3, r2
	umlal	r7, r8, r4, r2
	umlal	r8, r9, r5, r2
	umlal	r9, r10, r1, r2
	// ([28-31], 12) blocks
	ldr	r3, [r12, #48]
	ldr	r2, [r14, #124]
	umlal	r6, r7, r4, r3
	umlal	r7, r8, r5, r3
	umlal	r8, r9, r1, r3
	umlal	r9, r10, r2, r3
	// ([29-31],11),([30-31],10),(31,9) blocks
	ldr	r3, [r12, #44]
	umlal	r8, r9, r2, r3
	umlal	r7, r8, r1, r3
	umlal	r6, r7, r5, r3
	ldr	r3, [r12, #40]
	umlal	r7, r8, r2, r3
	umlal	r6, r7, r1, r3
	and.w r3, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r3, LSR #4 // range < 31
	ldr	r3, [r12, #36]
	umlal	r6, r7, r2, r3
	and.w r3, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r3, LSR #4 // range < 31
	and.w r3, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r3, LSR #4 // range < 31
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	// ([13-16], 31) blocks
	ldr	r3, [r12, #124]
	ldr	r2, [r14, #64]
	ldr	r1, [r14, #60]
	ldr	r5, [r14, #56]
	ldr	r4, [r14, #52]
	umull	r6, r7, r5, r3
	umull	r8, r9, r2, r3
	umlal	r10, r6, r4, r3
	umlal	r7, r8, r1, r3
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
	and.w r2, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r2, LSR #4 // range < 31
	and.w r2, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r2, LSR #4 // range < 31
	and.w r2, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r2, LSR #4 // range < 31
	and.w r2, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r2, LSR #4 // range < 31
	// ([28-31], 16) blocks
	ldr	r3, [r12, #64]
	ldr	r2, [r14, #124]
	umlal	r10, r6, r4, r3
	umlal	r6, r7, r5, r3
	umlal	r7, r8, r1, r3
	umlal	r8, r9, r2, r3
	// ([29-31],15),([30-31],14),(31,13) blocks
	ldr	r3, [r12, #60]
	umlal	r7, r8, r2, r3
	umlal	r6, r7, r1, r3
	umlal	r10, r6, r5, r3
	ldr	r3, [r12, #56]
	umlal	r6, r7, r2, r3
	umlal	r10, r6, r1, r3
	ldr	r3, [r12, #52]
	umlal	r10, r6, r2, r3
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
	// ([17-20], 31) blocks
	ldr	r2, [r12, #124]
	ldr	r1, [r14, #80]
	ldr	r5, [r14, #76]
	ldr	r4, [r14, #72]
	ldr	r3, [r14, #68]
	umull	r10, r6, r4, r2
	umull	r7, r8, r1, r2
	umlal	r9, r10, r3, r2
	umlal	r6, r7, r5, r2
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
	// ([29-31],19),([30-31],18),(31,17) blocks
	ldr	r3, [r12, #76]
	umlal	r6, r7, r2, r3
	umlal	r10, r6, r1, r3
	umlal	r9, r10, r5, r3
	and.w r3, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r3, LSR #4 // range < 31
	ldr	r3, [r12, #72]
	umlal	r10, r6, r2, r3
	umlal	r9, r10, r1, r3
	and.w r3, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r3, LSR #4 // range < 31
	ldr	r3, [r12, #68]
	umlal	r9, r10, r2, r3
	and.w r3, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r3, LSR #4 // range < 31
	and.w r3, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r3, LSR #4 // range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
	// ([21-24], 31) blocks
	ldr	r1, [r12, #124]
	ldr	r5, [r14, #96]
	ldr	r4, [r14, #92]
	ldr	r3, [r14, #88]
	ldr	r2, [r14, #84]
	umull	r9, r10, r3, r1
	umull	r6, r7, r5, r1
	umlal	r8, r9, r2, r1
	umlal	r10, r6, r4, r1
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
	// ([29-31],23),([30-31],22),(31,21) blocks
	ldr	r3, [r12, #92]
	umlal	r10, r6, r2, r3
	umlal	r9, r10, r1, r3
	umlal	r8, r9, r5, r3
	and.w r3, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r3, LSR #4 // range < 31
	ldr	r3, [r12, #88]
	umlal	r9, r10, r2, r3
	umlal	r8, r9, r1, r3
	and.w r3, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r3, LSR #4 // range < 31
	ldr	r3, [r12, #84]
	umlal	r8, r9, r2, r3
	and.w r3, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r3, LSR #4 // range < 31
	and.w r3, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r3, LSR #4 // range < 31
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	// ([25-28], 31) blocks
	ldr	r5, [r12, #124]
	ldr	r4, [r14, #112]
	ldr	r3, [r14, #108]
	ldr	r2, [r14, #104]
	ldr	r1, [r14, #100]
	umull	r8, r9, r2, r5
	umull	r10, r6, r4, r5
	umlal	r7, r8, r1, r5
	umlal	r9, r10, r3, r5
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
	// ([29-31],27),([30-31],26),(31,25) blocks
	ldr	r3, [r12, #108]
	umlal	r9, r10, r2, r3
	umlal	r8, r9, r1, r3
	umlal	r7, r8, r5, r3
	ldr	r3, [r12, #104]
	umlal	r8, r9, r2, r3
	umlal	r7, r8, r1, r3
	ldr	r3, [r12, #100]
	umlal	r7, r8, r2, r3
	and.w r3, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r3, LSR #4 // range < 31
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	str.w r7, [r0], #16
sch3_20:			// mv hh back to h
	mov	r7, #0
	mov	r8, #0
	mov	r9, #0
	mov	r10, #0
	ldr	r5, [r14, #116]
	ldr	r1, [r14, #120]
	ldr	r2, [r14, #124]
	// ([29-31],31),([30-31],30),(31,29) blocks
	ldr	r3, [r12, #124]
	umlal	r8, r9, r2, r3
	umlal	r7, r8, r1, r3
	umlal	r6, r7, r5, r3
	ldr	r3, [r12, #120]
	umlal	r7, r8, r2, r3
	umlal	r6, r7, r1, r3
	ldr	r3, [r12, #116]
	umlal	r6, r7, r2, r3
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r6, [r0], #16
	pop.w {pc}
// void __gf_polymul_128x128_2x2_x2p2_mod3 (int *V, int *M, int *fh, int *gh);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_128x128_2x2_x2p2_mod3
.type __gf_polymul_128x128_2x2_x2p2_mod3, %function
__gf_polymul_128x128_2x2_x2p2_mod3:
	push.w {r4-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, s3, r2, r3
	sub.w sp, #1028
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	add.w r1, #256
	bl __polymul_128x128
	mov.w r1, r12
	add.w r1, #128
	vmov.w r2, s3
	bl __polymul_128x128
	sub.w r0, #1
	mov.w r1, r12
	add.w r1, #128
	vmov.w r2, s2
	bl __polymul_128x128
	vmov.w r2, s3
	mov.w r1, r12
	add.w r1, #128
	bl __polymul_128x128
	vmov.w r0, s0
	vmov.w r10, s1
	mov.w r1, sp
	add.w lr, r0, #128
add_loop_x2p2_128_0:
	ldr.w r6, [r1, #768]
	ldr.w r7, [r1, #772]
	ldr.w r8, [r1, #776]
	ldr.w r9, [r1, #780]
	ldr.w r2, [r1, #512]
	ldr.w r3, [r1, #516]
	ldr.w r4, [r1, #520]
	ldr.w r5, [r1, #524]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	ldr.w r6, [r10, #128]
	ldr.w r7, [r10, #132]
	ldr.w r8, [r10, #136]
	ldr.w r9, [r10, #140]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r2, [r0, #256]
	str.w r3, [r0, #260]
	str.w r4, [r0, #264]
	str.w r5, [r0, #268]
	ldr.w r6, [r1, #256]
	ldr.w r7, [r1, #260]
	ldr.w r8, [r1, #264]
	ldr.w r9, [r1, #268]
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r2, [r1], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	ldr.w r7, [r10, #4]
	ldr.w r8, [r10, #8]
	ldr.w r9, [r10, #12]
	ldr.w r6, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_x2p2_128_0
	add.w lr, r0, #128
add_loop_x2p2_128_1:
	ldr.w r6, [r1, #768]
	ldr.w r7, [r1, #772]
	ldr.w r8, [r1, #776]
	ldr.w r9, [r1, #780]
	ldr.w r2, [r1, #512]
	ldr.w r3, [r1, #516]
	ldr.w r4, [r1, #520]
	ldr.w r5, [r1, #524]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r2, [r0, #256]
	str.w r3, [r0, #260]
	str.w r4, [r0, #264]
	str.w r5, [r0, #268]
	ldr.w r6, [r1, #256]
	ldr.w r7, [r1, #260]
	ldr.w r8, [r1, #264]
	ldr.w r9, [r1, #268]
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r2, [r1], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_x2p2_128_1
	add.w sp, #1028
	pop.w {r4-r12,pc}
// void __gf_polymul_128x128_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_128x128_2x2_x_2x2_mod3
.type __gf_polymul_128x128_2x2_x_2x2_mod3, %function
__gf_polymul_128x128_2x2_x_2x2_mod3:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #2052
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	bl __polymul_128x128
	vmov.w r1, r2, s1, s2
	add.w r1, #128
	bl __polymul_128x128
	vmov.w r1, r2, s1, s2
	add.w r2, #256
	bl __polymul_128x128
	vmov.w r1, r2, s1, s2
	add.w r2, #256
	add.w r1, #128
	bl __polymul_128x128
	sub.w r0, #1
	vmov.w r1, r2, s1, s2
	add.w r2, #128
	add.w r1, #256
	bl __polymul_128x128
	vmov.w r1, r2, s1, s2
	add.w r2, #128
	add.w r1, #384
	bl __polymul_128x128
	vmov.w r1, r2, s1, s2
	add.w r2, #384
	add.w r1, #256
	bl __polymul_128x128
	vmov.w r1, r2, s1, s2
	add.w r2, #384
	add.w r1, #384
	bl __polymul_128x128
	vmov.w r0, s0
	mov.w r1, sp
	add.w lr, r0, #1020
add_loop_2x2_128:
	ldr.w r7, [r1, #1024]
	ldr.w r8, [r1, #1028]
	ldr.w r9, [r1, #1032]
	ldr.w r10, [r1, #1036]
	ldr.w r12, [r1, #1040]
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r6, [r1, #16]
	ldr.w r2, [r1], #20
	add.w r2, r7
	add.w r3, r8
	add.w r4, r9
	add.w r5, r10
	add.w r6, r12
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	and.w r12, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, r12, LSR #4 // range < 31
	bic.w r12, r6, r11 // top 3b < 8
	and.w r6, r6, r11 // bot 2b < 4
	add.w r6, r6, r12, LSR #2 // range <=10
	bic.w r12, r6, r11 // top 3b < 3
	and.w r6, r6, r11 // bot 2b < 4
	add.w r6, r6, r12, LSR #2 // range <=5
	usub8.w r12, r6, r11 // >= 3 ?
	sel.w r6, r12, r6 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r6, [r0, #16]
	str.w r2, [r0], #20
	cmp.w r0, lr
	bne.w add_loop_2x2_128
	ldr.w r7, [r1, #1024]
	ldr.w r2, [r1], #4
	add.w r2, r7
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	str.w r2, [r0], #4
	add.w sp, #2052
	pop.w {r3-r12,pc}
