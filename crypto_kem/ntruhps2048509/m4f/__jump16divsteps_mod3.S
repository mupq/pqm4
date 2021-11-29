// void __gf_polymul_8x8_2x2_x2p2_mod3 (int *V, int *M, int *fh, int *gh);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_8x8_2x2_x2p2_mod3
.type __gf_polymul_8x8_2x2_x2p2_mod3, %function
__gf_polymul_8x8_2x2_x2p2_mod3:
	push.w {r4-r12,lr}
	vmov.w s1, s2, r2, r3
	add.w r1, #16
	ldr.w r10, [r2]
	ldr.w r11, [r2, #4]
	ldr.w r8, [r1], #4
	ldr.w r9, [r1], #4
	umull.w r4, r5, r8, r10
	umull.w r6, r7, r9, r11
	umlal.w r5, r6, r9, r10
	umlal.w r5, r6, r8, r11
	ldr.w r12, [r3]
	ldr.w lr, [r3, #4]
	ldr.w r2, [r1], #4
	ldr.w r3, [r1], #4
	umull.w r8, r9, r2, r12
	umull.w r10, r11, r3, lr
	umlal.w r9, r10, r3, r12
	umlal.w r9, r10, r2, lr
	add.w r4, r8
	add.w r5, r9
	add.w r6, r10
	add.w r7, r11
	ldr.w r8, [r1, #-32]
	ldr.w r9, [r1, #-28]
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r9, r9, r4, LSR #24
	ubfx.w r2, r5, #24, #8
	add.w r10, r2, r6, LSL #8
	ubfx.w r2, r6, #24, #8
	add.w r11, r2, r7, LSL #8
	mov.w r12, #0x03030303
	bic.w lr, r8, r12 // top 3b < 8
	and.w r8, r8, r12 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=10
	bic.w lr, r8, r12 // top 3b < 3
	and.w r8, r8, r12 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=5
	usub8.w lr, r8, r12 // >= 3 ?
	sel.w r8, lr, r8 // select
	bic.w lr, r9, r12 // top 3b < 8
	and.w r9, r9, r12 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=10
	bic.w lr, r9, r12 // top 3b < 3
	and.w r9, r9, r12 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=5
	usub8.w lr, r9, r12 // >= 3 ?
	sel.w r9, lr, r9 // select
	and.w lr, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, lr, LSR #4 // range < 31
	bic.w lr, r10, r12 // top 3b < 8
	and.w r10, r10, r12 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=10
	bic.w lr, r10, r12 // top 3b < 3
	and.w r10, r10, r12 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=5
	usub8.w lr, r10, r12 // >= 3 ?
	sel.w r10, lr, r10 // select
	bic.w lr, r11, r12 // top 3b < 8
	and.w r11, r11, r12 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=10
	bic.w lr, r11, r12 // top 3b < 3
	and.w r11, r11, r12 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=5
	usub8.w lr, r11, r12 // >= 3 ?
	sel.w r11, lr, r11 // select
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	vmov.w r2, r3, s1, s2
	ldr.w r10, [r2]
	ldr.w r11, [r2, #4]
	ldr.w r8, [r1], #4
	ldr.w r9, [r1], #4
	umull.w r4, r5, r8, r10
	umull.w r6, r7, r9, r11
	umlal.w r5, r6, r9, r10
	umlal.w r5, r6, r8, r11
	ldr.w r12, [r3]
	ldr.w lr, [r3, #4]
	ldr.w r2, [r1], #4
	ldr.w r3, [r1], #4
	umull.w r8, r9, r2, r12
	umull.w r10, r11, r3, lr
	umlal.w r9, r10, r3, r12
	umlal.w r9, r10, r2, lr
	add.w r4, r8
	add.w r5, r9
	add.w r6, r10
	add.w r7, r11
	ldr.w r8, [r1, #-40]
	ldr.w r9, [r1, #-36]
	add.w r4, r8
	add.w r5, r9
	mov.w r12, #0x03030303
	bic.w lr, r4, r12 // top 3b < 8
	and.w r4, r4, r12 // bot 2b < 4
	add.w r4, r4, lr, LSR #2 // range <=10
	bic.w lr, r4, r12 // top 3b < 3
	and.w r4, r4, r12 // bot 2b < 4
	add.w r4, r4, lr, LSR #2 // range <=5
	usub8.w lr, r4, r12 // >= 3 ?
	sel.w r4, lr, r4 // select
	bic.w lr, r5, r12 // top 3b < 8
	and.w r5, r5, r12 // bot 2b < 4
	add.w r5, r5, lr, LSR #2 // range <=10
	bic.w lr, r5, r12 // top 3b < 3
	and.w r5, r5, r12 // bot 2b < 4
	add.w r5, r5, lr, LSR #2 // range <=5
	usub8.w lr, r5, r12 // >= 3 ?
	sel.w r5, lr, r5 // select
	and.w lr, r6, #0xF0F0F0F0 // top 4b < 16
	and.w r6, r6, #0x0F0F0F0F // bot 4b < 16
	add.w r6, r6, lr, LSR #4 // range < 31
	bic.w lr, r6, r12 // top 3b < 8
	and.w r6, r6, r12 // bot 2b < 4
	add.w r6, r6, lr, LSR #2 // range <=10
	bic.w lr, r6, r12 // top 3b < 3
	and.w r6, r6, r12 // bot 2b < 4
	add.w r6, r6, lr, LSR #2 // range <=5
	usub8.w lr, r6, r12 // >= 3 ?
	sel.w r6, lr, r6 // select
	bic.w lr, r7, r12 // top 3b < 8
	and.w r7, r7, r12 // bot 2b < 4
	add.w r7, r7, lr, LSR #2 // range <=10
	bic.w lr, r7, r12 // top 3b < 3
	and.w r7, r7, r12 // bot 2b < 4
	add.w r7, r7, lr, LSR #2 // range <=5
	usub8.w lr, r7, r12 // >= 3 ?
	sel.w r7, lr, r7 // select
	str r5, [r0, #4]
	str r6, [r0, #8]
	str r7, [r0, #12]
	str r4, [r0], #16
	pop.w {r4-r12,pc}
// void __gf_polymul_8x8_2x2_x_2x2_mod3 (int *M,int *M1,int *M2);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_8x8_2x2_x_2x2_mod3
.type __gf_polymul_8x8_2x2_x_2x2_mod3, %function
__gf_polymul_8x8_2x2_x_2x2_mod3:
	push.w {r3-r12,lr}
	mov.w r3, #0x03030303
	vmov.w s0, s1, r2, r3
	ldr.w r10, [r2], #4
	ldr.w r11, [r2], #4
	ldr.w r8, [r1], #4
	ldr.w r9, [r1], #12
	umull.w r4, r5, r8, r10
	umull.w r6, r7, r9, r11
	umlal.w r5, r6, r9, r10
	umlal.w r5, r6, r8, r11
	ldr.w r12, [r2], #4
	ldr.w lr, [r2], #4
	ldr.w r2, [r1], #4
	ldr.w r3, [r1], #12
	umull.w r8, r9, r2, r12
	umull.w r10, r11, r3, lr
	umlal.w r9, r10, r3, r12
	umlal.w r9, r10, r2, lr
	vmov.w r2, r3, s0, s1
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r10, r10, r6, LSL #8
	add.w r11, r11, r7, LSL #8
	add.w r9, r9, r4, LSR #24
	add.w r10, r10, r5, LSR #24
	add.w r11, r11, r6, LSR #24
	bic.w lr, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=10
	bic.w lr, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=5
	usub8.w lr, r8, r3 // >= 3 ?
	sel.w r8, lr, r8 // select
	and.w lr, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, lr, LSR #4 // range < 31
	bic.w lr, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=10
	bic.w lr, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=5
	usub8.w lr, r9, r3 // >= 3 ?
	sel.w r9, lr, r9 // select
	and.w lr, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, lr, LSR #4 // range < 31
	bic.w lr, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=10
	bic.w lr, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=5
	usub8.w lr, r10, r3 // >= 3 ?
	sel.w r10, lr, r10 // select
	bic.w lr, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=10
	bic.w lr, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=5
	usub8.w lr, r11, r3 // >= 3 ?
	sel.w r11, lr, r11 // select
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	sub.w r1, #24
	ldr.w r10, [r2], #4
	ldr.w r11, [r2], #4
	ldr.w r8, [r1], #4
	ldr.w r9, [r1], #12
	umull.w r4, r5, r8, r10
	umull.w r6, r7, r9, r11
	umlal.w r5, r6, r9, r10
	umlal.w r5, r6, r8, r11
	ldr.w r12, [r2], #4
	ldr.w lr, [r2], #4
	ldr.w r2, [r1], #4
	ldr.w r3, [r1], #12
	umull.w r8, r9, r2, r12
	umull.w r10, r11, r3, lr
	umlal.w r9, r10, r3, r12
	umlal.w r9, r10, r2, lr
	vmov.w r2, r3, s0, s1
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r10, r10, r6, LSL #8
	add.w r11, r11, r7, LSL #8
	add.w r9, r9, r4, LSR #24
	add.w r10, r10, r5, LSR #24
	add.w r11, r11, r6, LSR #24
	bic.w lr, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=10
	bic.w lr, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=5
	usub8.w lr, r8, r3 // >= 3 ?
	sel.w r8, lr, r8 // select
	and.w lr, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, lr, LSR #4 // range < 31
	bic.w lr, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=10
	bic.w lr, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=5
	usub8.w lr, r9, r3 // >= 3 ?
	sel.w r9, lr, r9 // select
	and.w lr, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, lr, LSR #4 // range < 31
	bic.w lr, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=10
	bic.w lr, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=5
	usub8.w lr, r10, r3 // >= 3 ?
	sel.w r10, lr, r10 // select
	bic.w lr, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=10
	bic.w lr, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=5
	usub8.w lr, r11, r3 // >= 3 ?
	sel.w r11, lr, r11 // select
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	sub.w r1, #40
	add.w r2, #16
	ldr.w r10, [r2], #4
	ldr.w r11, [r2], #4
	ldr.w r8, [r1], #4
	ldr.w r9, [r1], #12
	umull.w r4, r5, r8, r10
	umull.w r6, r7, r9, r11
	umlal.w r5, r6, r9, r10
	umlal.w r5, r6, r8, r11
	ldr.w r12, [r2], #4
	ldr.w lr, [r2], #4
	ldr.w r2, [r1], #4
	ldr.w r3, [r1], #12
	umull.w r8, r9, r2, r12
	umull.w r10, r11, r3, lr
	umlal.w r9, r10, r3, r12
	umlal.w r9, r10, r2, lr
	vmov.w r2, r3, s0, s1
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r10, r10, r6, LSL #8
	add.w r11, r11, r7, LSL #8
	add.w r9, r9, r4, LSR #24
	add.w r10, r10, r5, LSR #24
	add.w r11, r11, r6, LSR #24
	bic.w lr, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=10
	bic.w lr, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=5
	usub8.w lr, r8, r3 // >= 3 ?
	sel.w r8, lr, r8 // select
	and.w lr, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, lr, LSR #4 // range < 31
	bic.w lr, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=10
	bic.w lr, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=5
	usub8.w lr, r9, r3 // >= 3 ?
	sel.w r9, lr, r9 // select
	and.w lr, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, lr, LSR #4 // range < 31
	bic.w lr, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=10
	bic.w lr, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=5
	usub8.w lr, r10, r3 // >= 3 ?
	sel.w r10, lr, r10 // select
	bic.w lr, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=10
	bic.w lr, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=5
	usub8.w lr, r11, r3 // >= 3 ?
	sel.w r11, lr, r11 // select
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	sub.w r1, #24
	add.w r2, #16
	ldr.w r10, [r2], #4
	ldr.w r11, [r2], #4
	ldr.w r8, [r1], #4
	ldr.w r9, [r1], #12
	umull.w r4, r5, r8, r10
	umull.w r6, r7, r9, r11
	umlal.w r5, r6, r9, r10
	umlal.w r5, r6, r8, r11
	ldr.w r12, [r2], #4
	ldr.w lr, [r2], #4
	ldr.w r2, [r1], #4
	ldr.w r3, [r1], #12
	umull.w r8, r9, r2, r12
	umull.w r10, r11, r3, lr
	umlal.w r9, r10, r3, r12
	umlal.w r9, r10, r2, lr
	vmov.w r2, r3, s0, s1
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r10, r10, r6, LSL #8
	add.w r11, r11, r7, LSL #8
	add.w r9, r9, r4, LSR #24
	add.w r10, r10, r5, LSR #24
	add.w r11, r11, r6, LSR #24
	bic.w lr, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=10
	bic.w lr, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, lr, LSR #2 // range <=5
	usub8.w lr, r8, r3 // >= 3 ?
	sel.w r8, lr, r8 // select
	and.w lr, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, lr, LSR #4 // range < 31
	bic.w lr, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=10
	bic.w lr, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, lr, LSR #2 // range <=5
	usub8.w lr, r9, r3 // >= 3 ?
	sel.w r9, lr, r9 // select
	and.w lr, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, lr, LSR #4 // range < 31
	bic.w lr, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=10
	bic.w lr, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, lr, LSR #2 // range <=5
	usub8.w lr, r10, r3 // >= 3 ?
	sel.w r10, lr, r10 // select
	bic.w lr, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=10
	bic.w lr, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, lr, LSR #2 // range <=5
	usub8.w lr, r11, r3 // >= 3 ?
	sel.w r11, lr, r11 // select
	str r9, [r0, #4]
	str r10, [r0, #8]
	str r11, [r0, #12]
	str r8, [r0], #16
	pop.w {r3-r12,pc}
