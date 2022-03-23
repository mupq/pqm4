.p2align 2,,3
.syntax unified
.text
__polymul_32x32:
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
	and	r5, r8, #0xF0F0F0F0	// top 4b < 16
	and	r8, r8, #0x0F0F0F0F	// bot 4b < 16
	add	r8, r8, r5, LSR #4	// range < 31
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	str.w r10, [r0], #16
sch3_10:			// decreasing thread length
	// ([1-4], 7) blocks
	ldr	r1, [r12, #28]
	ldr	r5, [r14, #16]
	ldr	r4, [r14, #12]
	ldr	r3, [r14, #8]
	ldr	r2, [r14, #4]
	umull	r10, r6, r3, r1
	umull	r7, r8, r5, r1
	umlal	r9, r10, r2, r1
	umlal	r6, r7, r4, r1
	// ([2-5], 6) blocks
	ldr	r2, [r12, #24]
	ldr	r1, [r14, #20]
	umlal	r9, r10, r3, r2
	umlal	r10, r6, r4, r2
	umlal	r6, r7, r5, r2
	umlal	r7, r8, r1, r2
	// ([3-6], 5) blocks
	ldr	r3, [r12, #20]
	ldr	r2, [r14, #24]
	umlal	r9, r10, r4, r3
	umlal	r10, r6, r5, r3
	umlal	r6, r7, r1, r3
	umlal	r7, r8, r2, r3
	// ([4-7], 4) blocks
	ldr	r4, [r12, #16]
	ldr	r3, [r14, #28]
	umlal	r9, r10, r5, r4
	umlal	r10, r6, r1, r4
	umlal	r6, r7, r2, r4
	umlal	r7, r8, r3, r4
	// ([5-7],3),([6-7],2),(7,1) blocks
	ldr	r4, [r12, #12]
	umlal	r6, r7, r3, r4
	umlal	r10, r6, r2, r4
	umlal	r9, r10, r1, r4
	ldr	r4, [r12, #8]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r2, r4
	ldr	r4, [r12, #4]
	umlal	r9, r10, r3, r4
	and	r4, r9, #0xF0F0F0F0	// top 4b < 16
	and	r9, r9, #0x0F0F0F0F	// bot 4b < 16
	add	r9, r9, r4, LSR #4	// range < 31
	str.w r10, [r0, #4]
	str.w r6, [r0, #8]
	str.w r7, [r0, #12]
	str.w r9, [r0], #16
sch3_20:			// mv hh back to h
	mov	r9, #0
	mov	r10, #0
	mov	r6, #0
	mov	r7, #0
	ldr	r1, [r14, #20]
	ldr	r2, [r14, #24]
	ldr	r3, [r14, #28]
	// ([5-7],7),([6-7],6),(7,5) blocks
	ldr	r4, [r12, #28]
	umlal	r10, r6, r3, r4
	umlal	r9, r10, r2, r4
	umlal	r8, r9, r1, r4
	ldr	r4, [r12, #24]
	umlal	r9, r10, r3, r4
	umlal	r8, r9, r2, r4
	ldr	r4, [r12, #20]
	umlal	r8, r9, r3, r4
	str.w r9, [r0, #4]
	str.w r10, [r0, #8]
	str.w r6, [r0, #12]
	str.w r8, [r0], #16
	pop.w {pc}
// void __gf_polymul_32x32_2x2_x2p2_mod3 (int *V, int *M, int *fh, int *gh);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_32x32_2x2_x2p2_mod3
.type __gf_polymul_32x32_2x2_x2p2_mod3, %function
__gf_polymul_32x32_2x2_x2p2_mod3:
	push.w {r4-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, s3, r2, r3
	sub.w sp, #260
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	add.w r1, #64
	bl __polymul_32x32
	mov.w r1, r12
	add.w r1, #32
	vmov.w r2, s3
	bl __polymul_32x32
	sub.w r0, #1
	mov.w r1, r12
	add.w r1, #32
	vmov.w r2, s2
	bl __polymul_32x32
	vmov.w r2, s3
	mov.w r1, r12
	add.w r1, #32
	bl __polymul_32x32
	vmov.w r0, s0
	vmov.w r10, s1
	mov.w r1, sp
	add.w lr, r0, #32
add_loop_x2p2_32_0:
	ldr.w r6, [r1, #192]
	ldr.w r7, [r1, #196]
	ldr.w r8, [r1, #200]
	ldr.w r9, [r1, #204]
	ldr.w r2, [r1, #128]
	ldr.w r3, [r1, #132]
	ldr.w r4, [r1, #136]
	ldr.w r5, [r1, #140]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	ldr.w r6, [r10, #32]
	ldr.w r7, [r10, #36]
	ldr.w r8, [r10, #40]
	ldr.w r9, [r10, #44]
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
	str.w r2, [r0, #64]
	str.w r3, [r0, #68]
	str.w r4, [r0, #72]
	str.w r5, [r0, #76]
	ldr.w r6, [r1, #64]
	ldr.w r7, [r1, #68]
	ldr.w r8, [r1, #72]
	ldr.w r9, [r1, #76]
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
	bne.w add_loop_x2p2_32_0
	add.w lr, r0, #32
add_loop_x2p2_32_1:
	ldr.w r6, [r1, #192]
	ldr.w r7, [r1, #196]
	ldr.w r8, [r1, #200]
	ldr.w r9, [r1, #204]
	ldr.w r2, [r1, #128]
	ldr.w r3, [r1, #132]
	ldr.w r4, [r1, #136]
	ldr.w r5, [r1, #140]
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
	str.w r2, [r0, #64]
	str.w r3, [r0, #68]
	str.w r4, [r0, #72]
	str.w r5, [r0, #76]
	ldr.w r6, [r1, #64]
	ldr.w r7, [r1, #68]
	ldr.w r8, [r1, #72]
	ldr.w r9, [r1, #76]
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
	bne.w add_loop_x2p2_32_1
	add.w sp, #260
	pop.w {r4-r12,pc}
// void __gf_polymul_32x32_2x2_x_2x2_mod3 (int *M, int *M1, int *M2);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_32x32_2x2_x_2x2_mod3
.type __gf_polymul_32x32_2x2_x_2x2_mod3, %function
__gf_polymul_32x32_2x2_x_2x2_mod3:
	push.w {r3-r12,lr}
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #516
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	bl __polymul_32x32
	vmov.w r1, r2, s1, s2
	add.w r1, #32
	bl __polymul_32x32
	vmov.w r1, r2, s1, s2
	add.w r2, #64
	bl __polymul_32x32
	vmov.w r1, r2, s1, s2
	add.w r2, #64
	add.w r1, #32
	bl __polymul_32x32
	sub.w r0, #1
	vmov.w r1, r2, s1, s2
	add.w r2, #32
	add.w r1, #64
	bl __polymul_32x32
	vmov.w r1, r2, s1, s2
	add.w r2, #32
	add.w r1, #96
	bl __polymul_32x32
	vmov.w r1, r2, s1, s2
	add.w r2, #96
	add.w r1, #64
	bl __polymul_32x32
	vmov.w r1, r2, s1, s2
	add.w r2, #96
	add.w r1, #96
	bl __polymul_32x32
	vmov.w r0, s0
	mov.w r1, sp
	add.w lr, r0, #240
add_loop_2x2_32:
	ldr.w r7, [r1, #256]
	ldr.w r8, [r1, #260]
	ldr.w r9, [r1, #264]
	ldr.w r10, [r1, #268]
	ldr.w r12, [r1, #272]
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
	bne.w add_loop_2x2_32
	ldr.w r7, [r1, #256]
	ldr.w r8, [r1, #260]
	ldr.w r9, [r1, #264]
	ldr.w r10, [r1, #268]
	ldr.w r3, [r1, #4]
	ldr.w r4, [r1, #8]
	ldr.w r5, [r1, #12]
	ldr.w r2, [r1], #16
	add.w r2, r7
	add.w r3, r8
	add.w r4, r9
	add.w r5, r10
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
	add.w sp, #516
	pop.w {r3-r12,pc}
