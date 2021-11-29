// void __gf_polymul_32x32_2x2_x2p2_mod2 (int *V, int *M, int *fh, int *gh);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_32x32_2x2_x2p2_mod2
.type __gf_polymul_32x32_2x2_x2p2_mod2, %function
__gf_polymul_32x32_2x2_x2p2_mod2:
	push.w {r4-r11,lr}
	add.w r1, #32
	mov.w r9, #0
	ldr.w r4, [r1]
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r2]
	umull r10, r11, r5, r8
	umull r12, lr, r7, r8
	umlal r9, r10, r4, r8
	umlal r11, r12, r6, r8
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	vmov.w s0, r9
	ldr.w r8, [r2, #4]
	mov.w r9, #0
	umlal r11, r12, r5, r8
	umlal lr, r9, r7, r8
	umlal r10, r11, r4, r8
	umlal r12, lr, r6, r8
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s1, r10
	ldr.w r8, [r2, #8]
	mov.w r10, #0
	umlal r12, lr, r5, r8
	umlal r9, r10, r7, r8
	umlal r11, r12, r4, r8
	umlal lr, r9, r6, r8
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s2, r11
	ldr.w r8, [r2, #12]
	mov.w r11, #0
	umlal lr, r9, r5, r8
	umlal r10, r11, r7, r8
	umlal r12, lr, r4, r8
	umlal r9, r10, r6, r8
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	vmov.w s3, r12
	vmov.w s4, s5, lr, r9
	vmov.w s6, s7, r10, r11
	mov.w r9, #0
	ldr.w r4, [r1, #16]
	ldr.w r5, [r1, #20]
	ldr.w r6, [r1, #24]
	ldr.w r7, [r1, #28]
	ldr.w r8, [r3]
	umull r10, r11, r5, r8
	umull r12, lr, r7, r8
	umlal r9, r10, r4, r8
	umlal r11, r12, r6, r8
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	vmov.w s8, r9
	ldr.w r8, [r3, #4]
	mov.w r9, #0
	umlal r11, r12, r5, r8
	umlal lr, r9, r7, r8
	umlal r10, r11, r4, r8
	umlal r12, lr, r6, r8
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s9, r10
	ldr.w r8, [r3, #8]
	mov.w r10, #0
	umlal r12, lr, r5, r8
	umlal r9, r10, r7, r8
	umlal r11, r12, r4, r8
	umlal lr, r9, r6, r8
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s10, r11
	ldr.w r8, [r3, #12]
	mov.w r11, #0
	umlal lr, r9, r5, r8
	umlal r10, r11, r7, r8
	umlal r12, lr, r4, r8
	umlal r9, r10, r6, r8
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	vmov.w s11, r12
	vmov.w s12, s13, lr, r9
	vmov.w s14, s15, r10, r11
	vmov.w r4, r5, s0, s1
	vmov.w r6, r7, s2, s3
	vmov.w r8, r9, s8, s9
	vmov.w r10, r11, s10, s11
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	ldr.w r8, [r1, #-32]
	ldr.w r9, [r1, #-28]
	ldr.w r10, [r1, #-24]
	ldr.w r11, [r1, #-20]
	eor.w r8, r8, r4, LSL #4
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
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s6, s7
	vmov.w r8, r9, s12, s13
	vmov.w r10, r11, s14, s15
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
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	mov.w r9, #0
	ldr.w r4, [r1, #32]
	ldr.w r5, [r1, #36]
	ldr.w r6, [r1, #40]
	ldr.w r7, [r1, #44]
	ldr.w r8, [r2]
	umull r10, r11, r5, r8
	umull r12, lr, r7, r8
	umlal r9, r10, r4, r8
	umlal r11, r12, r6, r8
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	vmov.w s0, r9
	ldr.w r8, [r2, #4]
	mov.w r9, #0
	umlal r11, r12, r5, r8
	umlal lr, r9, r7, r8
	umlal r10, r11, r4, r8
	umlal r12, lr, r6, r8
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s1, r10
	ldr.w r8, [r2, #8]
	mov.w r10, #0
	umlal r12, lr, r5, r8
	umlal r9, r10, r7, r8
	umlal r11, r12, r4, r8
	umlal lr, r9, r6, r8
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s2, r11
	ldr.w r8, [r2, #12]
	mov.w r11, #0
	umlal lr, r9, r5, r8
	umlal r10, r11, r7, r8
	umlal r12, lr, r4, r8
	umlal r9, r10, r6, r8
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	vmov.w s3, r12
	vmov.w s4, s5, lr, r9
	vmov.w s6, s7, r10, r11
	mov.w r9, #0
	ldr.w r4, [r1, #48]
	ldr.w r5, [r1, #52]
	ldr.w r6, [r1, #56]
	ldr.w r7, [r1, #60]
	ldr.w r8, [r3]
	umull r10, r11, r5, r8
	umull r12, lr, r7, r8
	umlal r9, r10, r4, r8
	umlal r11, r12, r6, r8
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	vmov.w s8, r9
	ldr.w r8, [r3, #4]
	mov.w r9, #0
	umlal r11, r12, r5, r8
	umlal lr, r9, r7, r8
	umlal r10, r11, r4, r8
	umlal r12, lr, r6, r8
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s9, r10
	ldr.w r8, [r3, #8]
	mov.w r10, #0
	umlal r12, lr, r5, r8
	umlal r9, r10, r7, r8
	umlal r11, r12, r4, r8
	umlal lr, r9, r6, r8
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s10, r11
	ldr.w r8, [r3, #12]
	mov.w r11, #0
	umlal lr, r9, r5, r8
	umlal r10, r11, r7, r8
	umlal r12, lr, r4, r8
	umlal r9, r10, r6, r8
	and.w r12, r12, #0x11111111
	and.w lr, lr, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	vmov.w s11, r12
	vmov.w s12, s13, lr, r9
	vmov.w s14, s15, r10, r11
	vmov.w r4, r5, s0, s1
	vmov.w r6, r7, s2, s3
	vmov.w r8, r9, s8, s9
	vmov.w r10, r11, s10, s11
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	ldr.w r8, [r1, #-16]
	ldr.w r9, [r1, #-12]
	ldr.w r10, [r1, #-8]
	ldr.w r11, [r1, #-4]
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	str r5, [r0, #4]
	str r6, [r0, #8]
	str r7, [r0, #12]
	str r4, [r0], #16
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s6, s7
	vmov.w r8, r9, s12, s13
	vmov.w r10, r11, s14, s15
	eor.w r4, r8
	eor.w r5, r9
	eor.w r6, r10
	eor.w r7, r11
	str r5, [r0, #4]
	str r6, [r0, #8]
	str r7, [r0, #12]
	str r4, [r0], #16
	pop.w {r4-r11,pc}

// void __gf_polymul_32x32_2x2_x_2x2_mod2 (int *M,int *M1,int *M2);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_32x32_2x2_x_2x2_mod2
.type __gf_polymul_32x32_2x2_x_2x2_mod2, %function
__gf_polymul_32x32_2x2_x_2x2_mod2:
	push.w {r4-r11,lr}
	mov.w r8, #0
	ldr.w r3, [r1]
	ldr.w r4, [r1, #4]
	ldr.w r5, [r1, #8]
	ldr.w r6, [r1, #12]
	ldr.w r7, [r2]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s0, r8
	ldr.w r7, [r2, #4]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s1, r9
	ldr.w r7, [r2, #8]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s2, r10
	ldr.w r7, [r2, #12]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s3, r11
	vmov.w s4, s5, r12, r8
	vmov.w s6, s7, r9, r10
	mov.w r8, #0
	ldr.w r3, [r1, #32]
	ldr.w r4, [r1, #36]
	ldr.w r5, [r1, #40]
	ldr.w r6, [r1, #44]
	ldr.w r7, [r2, #16]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s8, r8
	ldr.w r7, [r2, #20]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s9, r9
	ldr.w r7, [r2, #24]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s10, r10
	ldr.w r7, [r2, #28]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s11, r11
	vmov.w s12, s13, r12, r8
	vmov.w s14, s15, r9, r10
	vmov.w r3, r4, s0, s1
	vmov.w r5, r6, s2, s3
	vmov.w r7, r8, s8, s9
	vmov.w r9, r10, s10, s11
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	ubfx.w r11, r6, #28, #1
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	vmov.w r3, r4, s4, s5
	vmov.w r5, r6, s6, s7
	vmov.w r7, r8, s12, s13
	vmov.w r9, r10, s14, s15
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	eor.w r7, r7, r11
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	mov.w r8, #0
	ldr.w r3, [r1, #16]
	ldr.w r4, [r1, #20]
	ldr.w r5, [r1, #24]
	ldr.w r6, [r1, #28]
	ldr.w r7, [r2]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s0, r8
	ldr.w r7, [r2, #4]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s1, r9
	ldr.w r7, [r2, #8]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s2, r10
	ldr.w r7, [r2, #12]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s3, r11
	vmov.w s4, s5, r12, r8
	vmov.w s6, s7, r9, r10
	mov.w r8, #0
	ldr.w r3, [r1, #48]
	ldr.w r4, [r1, #52]
	ldr.w r5, [r1, #56]
	ldr.w r6, [r1, #60]
	ldr.w r7, [r2, #16]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s8, r8
	ldr.w r7, [r2, #20]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s9, r9
	ldr.w r7, [r2, #24]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s10, r10
	ldr.w r7, [r2, #28]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s11, r11
	vmov.w s12, s13, r12, r8
	vmov.w s14, s15, r9, r10
	vmov.w r3, r4, s0, s1
	vmov.w r5, r6, s2, s3
	vmov.w r7, r8, s8, s9
	vmov.w r9, r10, s10, s11
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	ubfx.w r11, r6, #28, #1
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	vmov.w r3, r4, s4, s5
	vmov.w r5, r6, s6, s7
	vmov.w r7, r8, s12, s13
	vmov.w r9, r10, s14, s15
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	eor.w r7, r7, r11
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	mov.w r8, #0
	ldr.w r3, [r1]
	ldr.w r4, [r1, #4]
	ldr.w r5, [r1, #8]
	ldr.w r6, [r1, #12]
	ldr.w r7, [r2, #32]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s0, r8
	ldr.w r7, [r2, #36]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s1, r9
	ldr.w r7, [r2, #40]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s2, r10
	ldr.w r7, [r2, #44]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s3, r11
	vmov.w s4, s5, r12, r8
	vmov.w s6, s7, r9, r10
	mov.w r8, #0
	ldr.w r3, [r1, #32]
	ldr.w r4, [r1, #36]
	ldr.w r5, [r1, #40]
	ldr.w r6, [r1, #44]
	ldr.w r7, [r2, #48]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s8, r8
	ldr.w r7, [r2, #52]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s9, r9
	ldr.w r7, [r2, #56]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s10, r10
	ldr.w r7, [r2, #60]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s11, r11
	vmov.w s12, s13, r12, r8
	vmov.w s14, s15, r9, r10
	vmov.w r3, r4, s0, s1
	vmov.w r5, r6, s2, s3
	vmov.w r7, r8, s8, s9
	vmov.w r9, r10, s10, s11
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	ubfx.w r11, r6, #28, #1
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	vmov.w r3, r4, s4, s5
	vmov.w r5, r6, s6, s7
	vmov.w r7, r8, s12, s13
	vmov.w r9, r10, s14, s15
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	eor.w r7, r7, r11
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	mov.w r8, #0
	ldr.w r3, [r1, #16]
	ldr.w r4, [r1, #20]
	ldr.w r5, [r1, #24]
	ldr.w r6, [r1, #28]
	ldr.w r7, [r2, #32]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s0, r8
	ldr.w r7, [r2, #36]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s1, r9
	ldr.w r7, [r2, #40]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s2, r10
	ldr.w r7, [r2, #44]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s3, r11
	vmov.w s4, s5, r12, r8
	vmov.w s6, s7, r9, r10
	mov.w r8, #0
	ldr.w r3, [r1, #48]
	ldr.w r4, [r1, #52]
	ldr.w r5, [r1, #56]
	ldr.w r6, [r1, #60]
	ldr.w r7, [r2, #48]
	umull r9, r10, r4, r7
	umull r11, r12, r6, r7
	umlal r8, r9, r3, r7
	umlal r10, r11, r5, r7
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	vmov.w s8, r8
	ldr.w r7, [r2, #52]
	mov.w r8, #0
	umlal r10, r11, r4, r7
	umlal r12, r8, r6, r7
	umlal r9, r10, r3, r7
	umlal r11, r12, r5, r7
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	vmov.w s9, r9
	ldr.w r7, [r2, #56]
	mov.w r9, #0
	umlal r11, r12, r4, r7
	umlal r8, r9, r6, r7
	umlal r10, r11, r3, r7
	umlal r12, r8, r5, r7
	and.w r10, r10, #0x11111111
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	vmov.w s10, r10
	ldr.w r7, [r2, #60]
	mov.w r10, #0
	umlal r12, r8, r4, r7
	umlal r9, r10, r6, r7
	umlal r11, r12, r3, r7
	umlal r8, r9, r5, r7
	and.w r11, r11, #0x11111111
	and.w r12, r12, #0x11111111
	and.w r8, r8, #0x11111111
	and.w r9, r9, #0x11111111
	and.w r10, r10, #0x11111111
	vmov.w s11, r11
	vmov.w s12, s13, r12, r8
	vmov.w s14, s15, r9, r10
	vmov.w r3, r4, s0, s1
	vmov.w r5, r6, s2, s3
	vmov.w r7, r8, s8, s9
	vmov.w r9, r10, s10, s11
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	ubfx.w r11, r6, #28, #1
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	vmov.w r3, r4, s4, s5
	vmov.w r5, r6, s6, s7
	vmov.w r7, r8, s12, s13
	vmov.w r9, r10, s14, s15
	eor.w r7, r7, r3, LSL #4
	eor.w r8, r8, r4, LSL #4
	eor.w r9, r9, r5, LSL #4
	eor.w r10, r10, r6, LSL #4
	eor.w r8, r8, r3, LSR #28
	eor.w r9, r9, r4, LSR #28
	eor.w r10, r10, r5, LSR #28
	eor.w r7, r7, r11
	str r8, [r0, #4]
	str r9, [r0, #8]
	str r10, [r0, #12]
	str r7, [r0], #16
	pop.w {r4-r11,pc}
