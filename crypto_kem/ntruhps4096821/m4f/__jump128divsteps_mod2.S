.p2align 2,,3
.syntax unified
.text
__polymul_64x64_mod2:
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
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([2-5], 6) blocks
	ldr.w	r14, [r1, #24]
	ldr.w	r12, [r2, #20]
	umlal	r9, r10, r3, r14
	umlal	r10, r6, r4, r14
	umlal	r6, r7, r5, r14
	umlal	r7, r8, r12, r14
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([3-6], 5) blocks
	ldr.w	r3, [r1, #20]
	ldr.w	r14, [r2, #24]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r12, r3
	umlal	r7, r8, r14, r3
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([4-7], 4) blocks
	ldr.w	r4, [r1, #16]
	ldr.w	r3, [r2, #28]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r12, r4
	umlal	r6, r7, r14, r4
	umlal	r7, r8, r3, r4
	and.w	r9, r9, #0x11111111
	and.w	r10, r10, #0x11111111
	and.w	r6, r6, #0x11111111
	and.w	r7, r7, #0x11111111
	and.w	r8, r8, #0x11111111
	// ([5-7],3),([6-7],2),(7,1) blocks
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
	pop.w {pc}

// void __gf_polymul_64x64_2x2_x2p2_mod2 (int *V, int *M, int *fh, int *gh);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_64x64_2x2_x2p2_mod2
.type __gf_polymul_64x64_2x2_x2p2_mod2, %function
__gf_polymul_64x64_2x2_x2p2_mod2:
	push.w {r4-r11,lr}
	vmov.w s0, s1, r0, r3
	sub.w sp, #260
	mov.w r0, sp
	add.w r1, #64
	bl __polymul_64x64_mod2
	add.w r1, #64
	bl __polymul_64x64_mod2
	add.w r1, #-32
	vmov.w r2, s1
	bl __polymul_64x64_mod2
	add.w r1, #64
	vmov.w r2, s1
	bl __polymul_64x64_mod2
	mov.w lr, sp
	vmov.w r0, s0
	add.w r1, #-160
	movw.w r12, #0
	add.w r3, r0, #32
add_loop_x2p2_64_0:
	ldr.w r8, [lr, #192]
	ldr.w r9, [lr, #196]
	ldr.w r10, [lr, #200]
	ldr.w r11, [lr, #204]
	ldr.w r4, [lr, #64]
	ldr.w r5, [lr, #68]
	ldr.w r6, [lr, #72]
	ldr.w r7, [lr, #76]
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	ldr.w r8, [r1, #32]
	ldr.w r9, [r1, #36]
	ldr.w r10, [r1, #40]
	ldr.w r11, [r1, #44]
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	str r4, [r0, #64]
	str r5, [r0, #68]
	str r6, [r0, #72]
	str r7, [r0, #76]
	ldr.w r8, [lr, #128]
	ldr.w r9, [lr, #132]
	ldr.w r10, [lr, #136]
	ldr.w r11, [lr, #140]
	ldr.w r5, [lr, #4]
	ldr.w r6, [lr, #8]
	ldr.w r7, [lr, #12]
	ldr.w r4, [lr], #16
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	ldr.w r9, [r1, #4]
	ldr.w r10, [r1, #8]
	ldr.w r11, [r1, #12]
	ldr.w r8, [r1], #16
	eor.w r8, r8, r4, LSL #4
	eor.w r8, r12
	eor.w r9, r9, r5, LSL #4
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r6, LSL #4
	eor.w r10, r10, r5, LSR #28
	eor.w r11, r11, r7, LSL #4
	eor.w r11, r11, r6, LSR #28
	ubfx.w r12, r7, #28, #1
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	cmp.w r0, r3
	bne.w add_loop_x2p2_64_0
	add.w r3, r0, #32
add_loop_x2p2_64_1:
	ldr.w r8, [lr, #192]
	ldr.w r9, [lr, #196]
	ldr.w r10, [lr, #200]
	ldr.w r11, [lr, #204]
	ldr.w r4, [lr, #64]
	ldr.w r5, [lr, #68]
	ldr.w r6, [lr, #72]
	ldr.w r7, [lr, #76]
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	str r4, [r0, #64]
	str r5, [r0, #68]
	str r6, [r0, #72]
	str r7, [r0, #76]
	ldr.w r8, [lr, #128]
	ldr.w r9, [lr, #132]
	ldr.w r10, [lr, #136]
	ldr.w r11, [lr, #140]
	ldr.w r5, [lr, #4]
	ldr.w r6, [lr, #8]
	ldr.w r7, [lr, #12]
	ldr.w r4, [lr], #16
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	eor.w r8, r12, r4, LSL #4
	ubfx.w r12, r4, #28, #4
	eor.w r9, r12, r5, LSL #4
	ubfx.w r12, r5, #28, #4
	eor.w r10, r12, r6, LSL #4
	ubfx.w r12, r6, #28, #4
	eor.w r11, r12, r7, LSL #4
	ubfx.w r12, r7, #28, #4
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	cmp.w r0, r3
	bne.w add_loop_x2p2_64_1
	add.w sp, #260
	pop.w {r4-r11,pc}

// void __gf_polymul_64x64_2x2_x_2x2_mod2 (int *M,int *M1,int *M2);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_64x64_2x2_x_2x2_mod2
.type __gf_polymul_64x64_2x2_x_2x2_mod2, %function
__gf_polymul_64x64_2x2_x_2x2_mod2:
	push.w {r4-r11,lr}
	vmov.w s0, r0
	sub.w sp, #516
	mov.w r0, sp
	bl __polymul_64x64_mod2
	add.w r1, #32
	bl __polymul_64x64_mod2
	add.w r2, #64
	add.w r1, #-32
	bl __polymul_64x64_mod2
	add.w r1, #32
	bl __polymul_64x64_mod2
	add.w r2, #-32
	add.w r1, #32
	bl __polymul_64x64_mod2
	add.w r1, #32
	bl __polymul_64x64_mod2
	add.w r2, #64
	add.w r1, #-32
	bl __polymul_64x64_mod2
	add.w r1, #32
	bl __polymul_64x64_mod2
	mov.w r1, sp
	vmov.w r0, s0
	add.w r2, r0, #64
	vmov.w s1, r2
	movw.w r10, #0
	movw.w r11, #0
	movw.w r12, #0
	movw.w lr, #0
add_loop_2x2_64:
	//1
	ldr.w r6, [r1, #320]
	ldr.w r7, [r1, #324]
	ldr.w r8, [r1, #328]
	ldr.w r9, [r1, #332]
	ldr.w r2, [r1, #64]
	ldr.w r3, [r1, #68]
	ldr.w r4, [r1, #72]
	ldr.w r5, [r1, #76]
	eor.w r6, r6, r11
	eor.w r6, r6, r2, LSL #4
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r7, r7, r2, LSR #28
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	ubfx.w r11, r5, #28, #1
	str r6, [r0, #64]
	str r7, [r0, #68]
	str r8, [r0, #72]
	str r9, [r0, #76]
	//2
	ldr.w r6, [r1, #384]
	ldr.w r7, [r1, #388]
	ldr.w r8, [r1, #392]
	ldr.w r9, [r1, #396]
	ldr.w r2, [r1, #128]
	ldr.w r3, [r1, #132]
	ldr.w r4, [r1, #136]
	ldr.w r5, [r1, #140]
	eor.w r6, r6, r12
	eor.w r6, r6, r2, LSL #4
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r7, r7, r2, LSR #28
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	ubfx.w r12, r5, #28, #1
	str r6, [r0, #128]
	str r7, [r0, #132]
	str r8, [r0, #136]
	str r9, [r0, #140]
	//3
	ldr.w r6, [r1, #448]
	ldr.w r7, [r1, #452]
	ldr.w r8, [r1, #456]
	ldr.w r9, [r1, #460]
	ldr.w r2, [r1, #192]
	ldr.w r3, [r1, #196]
	ldr.w r4, [r1, #200]
	ldr.w r5, [r1, #204]
	eor.w r6, r6, lr
	eor.w r6, r6, r2, LSL #4
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r7, r7, r2, LSR #28
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	ubfx.w lr, r5, #28, #1
	str r6, [r0, #192]
	str r7, [r0, #196]
	str r8, [r0, #200]
	str r9, [r0, #204]
	//0
	ldr.w r6, [r1, #256]
	ldr.w r7, [r1, #260]
	ldr.w r8, [r1, #264]
	ldr.w r9, [r1, #268]
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r2, [r1], #16
	eor.w r6, r6, r10
	eor.w r6, r6, r2, LSL #4
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r7, r7, r2, LSR #28
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	ubfx.w r10, r5, #28, #1
	str r7, [r0, #4]
	str r8, [r0, #8]
	str r9, [r0, #12]
	str r6, [r0], #16
	vmov.w r2, s1
	cmp.w r0, r2
	bne.w add_loop_2x2_64
	add.w sp, #516
	pop.w {r4-r11,pc}
