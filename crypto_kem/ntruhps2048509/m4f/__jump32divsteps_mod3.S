// void __gf_polymul_16x16_2x2_x2p2_mod3 (int *V, int *M, int *fh, int *gh);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_16x16_2x2_x2p2_mod3
.type __gf_polymul_16x16_2x2_x2p2_mod3, %function
__gf_polymul_16x16_2x2_x2p2_mod3:
	push.w {r4-r12,lr}
	vpush.w {s16-s17}
	vmov.w s0, s1, r2, r3
	add.w r1, #32
	mov.w r6, #0
	ldr.w r5, [r1], #4
	ldr.w r4, [r2, #12]
	ldr.w lr, [r2, #8]
	ldr.w r12, [r2, #4]
	ldr.w r11, [r2], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r11, r5
	vmov.w s2, s3, r6, r7
	vmov.w s4, s5, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r2, #-28]
	ldr.w lr, [r2, #-24]
	ldr.w r4, [r2, #-20]
	ldr.w r9, [r1, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r1, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r1, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s6, s7, r5, r6
	vmov.w s8, s9, r7, r8
	mov.w r2, r3
	mov.w r6, #0
	ldr.w r5, [r1], #4
	ldr.w r4, [r2, #12]
	ldr.w lr, [r2, #8]
	ldr.w r12, [r2, #4]
	ldr.w r11, [r2], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r11, r5
	vmov.w s10, s11, r6, r7
	vmov.w s12, s13, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r2, #-28]
	ldr.w lr, [r2, #-24]
	ldr.w r4, [r2, #-20]
	ldr.w r9, [r1, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r1, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r1, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s14, s15, r5, r6
	vmov.w s16, s17, r7, r8
	vmov.w r2, r3, s6, s7
	vmov.w r4, r5, s8, s9
	vmov.w r6, r7, s14, s15
	vmov.w r8, r9, s16, s17
	add.w r10, r6, r2
	add.w r11, r7, r3
	add.w r12, r8, r4
	add.w lr, r9, r5
	ubfx.w r2, r12, #24, #8
	add.w lr, r2, lr, LSL #8
	ubfx.w r2, r11, #24, #8
	add.w r12, r2, r12, LSL #8
	ubfx.w r2, r10, #24, #8
	add.w r11, r2, r11, LSL #8
	vmov.w r2, r3, s2, s3
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s10, s11
	vmov.w r8, r9, s12, s13
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	ubfx.w r6, r5, #24, #8
	add.w r10, r6, r10, LSL #8
	ldr.w r6, [r1, #-64]
	ldr.w r7, [r1, #-60]
	ldr.w r8, [r1, #-56]
	ldr.w r9, [r1, #-52]
	add.w r6, r6, r2, LSL #8
	add.w r7, r7, r3, LSL #8
	add.w r7, r7, r2, LSR #24
	add.w r8, r8, r4, LSL #8
	add.w r8, r8, r3, LSR #24
	add.w r9, r9, r5, LSL #8
	add.w r9, r9, r4, LSR #24
	mov.w r4, #0x03030303
	bic.w r5, r6, r4 // top 3b < 8
	and.w r6, r6, r4 // bot 2b < 4
	add.w r6, r6, r5, LSR #2 // range <=10
	bic.w r5, r6, r4 // top 3b < 3
	and.w r6, r6, r4 // bot 2b < 4
	add.w r6, r6, r5, LSR #2 // range <=5
	usub8.w r5, r6, r4 // >= 3 ?
	sel.w r6, r5, r6 // select
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	bic.w r5, r7, r4 // top 3b < 8
	and.w r7, r7, r4 // bot 2b < 4
	add.w r7, r7, r5, LSR #2 // range <=10
	bic.w r5, r7, r4 // top 3b < 3
	and.w r7, r7, r4 // bot 2b < 4
	add.w r7, r7, r5, LSR #2 // range <=5
	usub8.w r5, r7, r4 // >= 3 ?
	sel.w r7, r5, r7 // select
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	bic.w r5, r8, r4 // top 3b < 8
	and.w r8, r8, r4 // bot 2b < 4
	add.w r8, r8, r5, LSR #2 // range <=10
	bic.w r5, r8, r4 // top 3b < 3
	and.w r8, r8, r4 // bot 2b < 4
	add.w r8, r8, r5, LSR #2 // range <=5
	usub8.w r5, r8, r4 // >= 3 ?
	sel.w r8, r5, r8 // select
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	bic.w r5, r9, r4 // top 3b < 8
	and.w r9, r9, r4 // bot 2b < 4
	add.w r9, r9, r5, LSR #2 // range <=10
	bic.w r5, r9, r4 // top 3b < 3
	and.w r9, r9, r4 // bot 2b < 4
	add.w r9, r9, r5, LSR #2 // range <=5
	usub8.w r5, r9, r4 // >= 3 ?
	sel.w r9, r5, r9 // select
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	bic.w r5, r10, r4 // top 3b < 8
	and.w r10, r10, r4 // bot 2b < 4
	add.w r10, r10, r5, LSR #2 // range <=10
	bic.w r5, r10, r4 // top 3b < 3
	and.w r10, r10, r4 // bot 2b < 4
	add.w r10, r10, r5, LSR #2 // range <=5
	usub8.w r5, r10, r4 // >= 3 ?
	sel.w r10, r5, r10 // select
	and.w r5, r11, #0xF0F0F0F0 // top 4b < 16
	and.w r11, r11, #0x0F0F0F0F // bot 4b < 16
	add.w r11, r11, r5, LSR #4 // range < 31
	bic.w r5, r11, r4 // top 3b < 8
	and.w r11, r11, r4 // bot 2b < 4
	add.w r11, r11, r5, LSR #2 // range <=10
	bic.w r5, r11, r4 // top 3b < 3
	and.w r11, r11, r4 // bot 2b < 4
	add.w r11, r11, r5, LSR #2 // range <=5
	usub8.w r5, r11, r4 // >= 3 ?
	sel.w r11, r5, r11 // select
	and.w r5, r12, #0xF0F0F0F0 // top 4b < 16
	and.w r12, r12, #0x0F0F0F0F // bot 4b < 16
	add.w r12, r12, r5, LSR #4 // range < 31
	bic.w r5, r12, r4 // top 3b < 8
	and.w r12, r12, r4 // bot 2b < 4
	add.w r12, r12, r5, LSR #2 // range <=10
	bic.w r5, r12, r4 // top 3b < 3
	and.w r12, r12, r4 // bot 2b < 4
	add.w r12, r12, r5, LSR #2 // range <=5
	usub8.w r5, r12, r4 // >= 3 ?
	sel.w r12, r5, r12 // select
	bic.w r5, lr, r4 // top 3b < 8
	and.w lr, lr, r4 // bot 2b < 4
	add.w lr, lr, r5, LSR #2 // range <=10
	bic.w r5, lr, r4 // top 3b < 3
	and.w lr, lr, r4 // bot 2b < 4
	add.w lr, lr, r5, LSR #2 // range <=5
	usub8.w r5, lr, r4 // >= 3 ?
	sel.w lr, r5, lr // select
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r10, [r0, #16]
	str.w r11, [r0, #20]
	str.w r12, [r0, #24]
	str.w lr, [r0, #28]
	str.w r6, [r0], #32
	vmov.w r2, r3, s0, s1
	mov.w r6, #0
	ldr.w r5, [r1], #4
	ldr.w r4, [r2, #12]
	ldr.w lr, [r2, #8]
	ldr.w r12, [r2, #4]
	ldr.w r11, [r2], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r11, r5
	vmov.w s2, s3, r6, r7
	vmov.w s4, s5, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r2, #-28]
	ldr.w lr, [r2, #-24]
	ldr.w r4, [r2, #-20]
	ldr.w r9, [r1, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r1, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r1, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s6, s7, r5, r6
	vmov.w s8, s9, r7, r8
	mov.w r2, r3
	mov.w r6, #0
	ldr.w r5, [r1], #4
	ldr.w r4, [r2, #12]
	ldr.w lr, [r2, #8]
	ldr.w r12, [r2, #4]
	ldr.w r11, [r2], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r1], #4
	umlal.w r9, r10, r11, r5
	vmov.w s10, s11, r6, r7
	vmov.w s12, s13, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r2, #-28]
	ldr.w lr, [r2, #-24]
	ldr.w r4, [r2, #-20]
	ldr.w r9, [r1, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r1, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r1, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s14, s15, r5, r6
	vmov.w s16, s17, r7, r8
	vmov.w r2, r3, s6, s7
	vmov.w r4, r5, s8, s9
	vmov.w r6, r7, s14, s15
	vmov.w r8, r9, s16, s17
	add.w r10, r6, r2
	add.w r11, r7, r3
	add.w r12, r8, r4
	add.w lr, r9, r5
	vmov.w r2, r3, s2, s3
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s10, s11
	vmov.w r8, r9, s12, s13
	add.w r6, r6, r2
	add.w r7, r7, r3
	add.w r8, r8, r4
	add.w r9, r9, r5
	ldr.w r2, [r1, #-80]
	ldr.w r3, [r1, #-76]
	ldr.w r4, [r1, #-72]
	ldr.w r5, [r1, #-68]
	add.w r6, r2
	add.w r7, r3
	add.w r8, r4
	add.w r9, r5
	mov.w r4, #0x03030303
	bic.w r5, r6, r4 // top 3b < 8
	and.w r6, r6, r4 // bot 2b < 4
	add.w r6, r6, r5, LSR #2 // range <=10
	bic.w r5, r6, r4 // top 3b < 3
	and.w r6, r6, r4 // bot 2b < 4
	add.w r6, r6, r5, LSR #2 // range <=5
	usub8.w r5, r6, r4 // >= 3 ?
	sel.w r6, r5, r6 // select
	and.w r5, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r5, LSR #4 // range < 31
	bic.w r5, r7, r4 // top 3b < 8
	and.w r7, r7, r4 // bot 2b < 4
	add.w r7, r7, r5, LSR #2 // range <=10
	bic.w r5, r7, r4 // top 3b < 3
	and.w r7, r7, r4 // bot 2b < 4
	add.w r7, r7, r5, LSR #2 // range <=5
	usub8.w r5, r7, r4 // >= 3 ?
	sel.w r7, r5, r7 // select
	and.w r5, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r5, LSR #4 // range < 31
	bic.w r5, r8, r4 // top 3b < 8
	and.w r8, r8, r4 // bot 2b < 4
	add.w r8, r8, r5, LSR #2 // range <=10
	bic.w r5, r8, r4 // top 3b < 3
	and.w r8, r8, r4 // bot 2b < 4
	add.w r8, r8, r5, LSR #2 // range <=5
	usub8.w r5, r8, r4 // >= 3 ?
	sel.w r8, r5, r8 // select
	and.w r5, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r5, LSR #4 // range < 31
	bic.w r5, r9, r4 // top 3b < 8
	and.w r9, r9, r4 // bot 2b < 4
	add.w r9, r9, r5, LSR #2 // range <=10
	bic.w r5, r9, r4 // top 3b < 3
	and.w r9, r9, r4 // bot 2b < 4
	add.w r9, r9, r5, LSR #2 // range <=5
	usub8.w r5, r9, r4 // >= 3 ?
	sel.w r9, r5, r9 // select
	and.w r5, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r5, LSR #4 // range < 31
	bic.w r5, r10, r4 // top 3b < 8
	and.w r10, r10, r4 // bot 2b < 4
	add.w r10, r10, r5, LSR #2 // range <=10
	bic.w r5, r10, r4 // top 3b < 3
	and.w r10, r10, r4 // bot 2b < 4
	add.w r10, r10, r5, LSR #2 // range <=5
	usub8.w r5, r10, r4 // >= 3 ?
	sel.w r10, r5, r10 // select
	and.w r5, r11, #0xF0F0F0F0 // top 4b < 16
	and.w r11, r11, #0x0F0F0F0F // bot 4b < 16
	add.w r11, r11, r5, LSR #4 // range < 31
	bic.w r5, r11, r4 // top 3b < 8
	and.w r11, r11, r4 // bot 2b < 4
	add.w r11, r11, r5, LSR #2 // range <=10
	bic.w r5, r11, r4 // top 3b < 3
	and.w r11, r11, r4 // bot 2b < 4
	add.w r11, r11, r5, LSR #2 // range <=5
	usub8.w r5, r11, r4 // >= 3 ?
	sel.w r11, r5, r11 // select
	and.w r5, r12, #0xF0F0F0F0 // top 4b < 16
	and.w r12, r12, #0x0F0F0F0F // bot 4b < 16
	add.w r12, r12, r5, LSR #4 // range < 31
	bic.w r5, r12, r4 // top 3b < 8
	and.w r12, r12, r4 // bot 2b < 4
	add.w r12, r12, r5, LSR #2 // range <=10
	bic.w r5, r12, r4 // top 3b < 3
	and.w r12, r12, r4 // bot 2b < 4
	add.w r12, r12, r5, LSR #2 // range <=5
	usub8.w r5, r12, r4 // >= 3 ?
	sel.w r12, r5, r12 // select
	bic.w r5, lr, r4 // top 3b < 8
	and.w lr, lr, r4 // bot 2b < 4
	add.w lr, lr, r5, LSR #2 // range <=10
	bic.w r5, lr, r4 // top 3b < 3
	and.w lr, lr, r4 // bot 2b < 4
	add.w lr, lr, r5, LSR #2 // range <=5
	usub8.w r5, lr, r4 // >= 3 ?
	sel.w lr, r5, lr // select
	str.w r7, [r0, #4]
	str.w r8, [r0, #8]
	str.w r9, [r0, #12]
	str.w r10, [r0, #16]
	str.w r11, [r0, #20]
	str.w r12, [r0, #24]
	str.w lr, [r0, #28]
	str.w r6, [r0], #32
	vpop.w {s16-s17}
	pop.w {r4-r12,pc}
// void __gf_polymul_16x16_2x2_x_2x2_mod3 (int *M,int *M1,int *M2);
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_16x16_2x2_x_2x2_mod3
.type __gf_polymul_16x16_2x2_x_2x2_mod3, %function
__gf_polymul_16x16_2x2_x_2x2_mod3:
	push.w {r3-r12,lr}
	vpush.w {s16-s17}
	mov.w r3, #0x03030303
	vmov.w s0, s1, r1, r2
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s2, s3, r6, r7
	vmov.w s4, s5, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s6, s7, r5, r6
	vmov.w s8, s9, r7, r8
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s10, s11, r6, r7
	vmov.w s12, s13, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s14, s15, r5, r6
	vmov.w s16, s17, r7, r8
	vmov.w r1, r2, s6, s7
	vmov.w r4, r5, s8, s9
	vmov.w r6, r7, s14, s15
	vmov.w r8, r9, s16, s17
	add.w r10, r6, r1, LSL #8
	add.w r11, r7, r2, LSL #8
	add.w r12, r8, r4, LSL #8
	add.w lr, r9, r5, LSL #8
	add.w r11, r11, r1, LSR #24
	add.w r12, r12, r2, LSR #24
	add.w lr, lr, r4, LSR #24
	vmov.w r1, r2, s2, s3
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s10, s11
	vmov.w r8, r9, s12, s13
	add.w r10, r10, r5, LSR #24
	add.w r6, r6, r1, LSL #8
	add.w r7, r7, r2, LSL #8
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r7, r7, r1, LSR #24
	add.w r8, r8, r2, LSR #24
	add.w r9, r9, r4, LSR #24
	bic.w r2, r6, r3 // top 3b < 8
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=10
	bic.w r2, r6, r3 // top 3b < 3
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=5
	usub8.w r2, r6, r3 // >= 3 ?
	sel.w r6, r2, r6 // select
	and.w r2, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r2, LSR #4 // range < 31
	bic.w r2, r7, r3 // top 3b < 8
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=10
	bic.w r2, r7, r3 // top 3b < 3
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=5
	usub8.w r2, r7, r3 // >= 3 ?
	sel.w r7, r2, r7 // select
	and.w r2, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r2, LSR #4 // range < 31
	bic.w r2, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=10
	bic.w r2, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=5
	usub8.w r2, r8, r3 // >= 3 ?
	sel.w r8, r2, r8 // select
	and.w r2, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r2, LSR #4 // range < 31
	bic.w r2, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=10
	bic.w r2, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=5
	usub8.w r2, r9, r3 // >= 3 ?
	sel.w r9, r2, r9 // select
	and.w r2, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r2, LSR #4 // range < 31
	bic.w r2, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=10
	bic.w r2, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=5
	usub8.w r2, r10, r3 // >= 3 ?
	sel.w r10, r2, r10 // select
	and.w r2, r11, #0xF0F0F0F0 // top 4b < 16
	and.w r11, r11, #0x0F0F0F0F // bot 4b < 16
	add.w r11, r11, r2, LSR #4 // range < 31
	bic.w r2, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=10
	bic.w r2, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=5
	usub8.w r2, r11, r3 // >= 3 ?
	sel.w r11, r2, r11 // select
	and.w r2, r12, #0xF0F0F0F0 // top 4b < 16
	and.w r12, r12, #0x0F0F0F0F // bot 4b < 16
	add.w r12, r12, r2, LSR #4 // range < 31
	bic.w r2, r12, r3 // top 3b < 8
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=10
	bic.w r2, r12, r3 // top 3b < 3
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=5
	usub8.w r2, r12, r3 // >= 3 ?
	sel.w r12, r2, r12 // select
	bic.w r2, lr, r3 // top 3b < 8
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=10
	bic.w r2, lr, r3 // top 3b < 3
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=5
	usub8.w r2, lr, r3 // >= 3 ?
	sel.w lr, r2, lr // select
	str r7, [r0, #4]
	str r8, [r0, #8]
	str r9, [r0, #12]
	str r10, [r0, #16]
	str r11, [r0, #20]
	str r12, [r0, #24]
	str lr, [r0, #28]
	str r6, [r0], #32
	vmov.w r1, r2, s0, s1
	add.w r1, #16
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s2, s3, r6, r7
	vmov.w s4, s5, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s6, s7, r5, r6
	vmov.w s8, s9, r7, r8
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s10, s11, r6, r7
	vmov.w s12, s13, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s14, s15, r5, r6
	vmov.w s16, s17, r7, r8
	vmov.w r1, r2, s6, s7
	vmov.w r4, r5, s8, s9
	vmov.w r6, r7, s14, s15
	vmov.w r8, r9, s16, s17
	add.w r10, r6, r1, LSL #8
	add.w r11, r7, r2, LSL #8
	add.w r12, r8, r4, LSL #8
	add.w lr, r9, r5, LSL #8
	add.w r11, r11, r1, LSR #24
	add.w r12, r12, r2, LSR #24
	add.w lr, lr, r4, LSR #24
	vmov.w r1, r2, s2, s3
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s10, s11
	vmov.w r8, r9, s12, s13
	add.w r10, r10, r5, LSR #24
	add.w r6, r6, r1, LSL #8
	add.w r7, r7, r2, LSL #8
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r7, r7, r1, LSR #24
	add.w r8, r8, r2, LSR #24
	add.w r9, r9, r4, LSR #24
	bic.w r2, r6, r3 // top 3b < 8
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=10
	bic.w r2, r6, r3 // top 3b < 3
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=5
	usub8.w r2, r6, r3 // >= 3 ?
	sel.w r6, r2, r6 // select
	and.w r2, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r2, LSR #4 // range < 31
	bic.w r2, r7, r3 // top 3b < 8
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=10
	bic.w r2, r7, r3 // top 3b < 3
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=5
	usub8.w r2, r7, r3 // >= 3 ?
	sel.w r7, r2, r7 // select
	and.w r2, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r2, LSR #4 // range < 31
	bic.w r2, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=10
	bic.w r2, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=5
	usub8.w r2, r8, r3 // >= 3 ?
	sel.w r8, r2, r8 // select
	and.w r2, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r2, LSR #4 // range < 31
	bic.w r2, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=10
	bic.w r2, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=5
	usub8.w r2, r9, r3 // >= 3 ?
	sel.w r9, r2, r9 // select
	and.w r2, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r2, LSR #4 // range < 31
	bic.w r2, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=10
	bic.w r2, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=5
	usub8.w r2, r10, r3 // >= 3 ?
	sel.w r10, r2, r10 // select
	and.w r2, r11, #0xF0F0F0F0 // top 4b < 16
	and.w r11, r11, #0x0F0F0F0F // bot 4b < 16
	add.w r11, r11, r2, LSR #4 // range < 31
	bic.w r2, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=10
	bic.w r2, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=5
	usub8.w r2, r11, r3 // >= 3 ?
	sel.w r11, r2, r11 // select
	and.w r2, r12, #0xF0F0F0F0 // top 4b < 16
	and.w r12, r12, #0x0F0F0F0F // bot 4b < 16
	add.w r12, r12, r2, LSR #4 // range < 31
	bic.w r2, r12, r3 // top 3b < 8
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=10
	bic.w r2, r12, r3 // top 3b < 3
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=5
	usub8.w r2, r12, r3 // >= 3 ?
	sel.w r12, r2, r12 // select
	bic.w r2, lr, r3 // top 3b < 8
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=10
	bic.w r2, lr, r3 // top 3b < 3
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=5
	usub8.w r2, lr, r3 // >= 3 ?
	sel.w lr, r2, lr // select
	str r7, [r0, #4]
	str r8, [r0, #8]
	str r9, [r0, #12]
	str r10, [r0, #16]
	str r11, [r0, #20]
	str r12, [r0, #24]
	str lr, [r0, #28]
	str r6, [r0], #32
	vmov.w r1, r2, s0, s1
	add.w r2, #32
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s2, s3, r6, r7
	vmov.w s4, s5, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s6, s7, r5, r6
	vmov.w s8, s9, r7, r8
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s10, s11, r6, r7
	vmov.w s12, s13, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s14, s15, r5, r6
	vmov.w s16, s17, r7, r8
	vmov.w r1, r2, s6, s7
	vmov.w r4, r5, s8, s9
	vmov.w r6, r7, s14, s15
	vmov.w r8, r9, s16, s17
	add.w r10, r6, r1, LSL #8
	add.w r11, r7, r2, LSL #8
	add.w r12, r8, r4, LSL #8
	add.w lr, r9, r5, LSL #8
	add.w r11, r11, r1, LSR #24
	add.w r12, r12, r2, LSR #24
	add.w lr, lr, r4, LSR #24
	vmov.w r1, r2, s2, s3
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s10, s11
	vmov.w r8, r9, s12, s13
	add.w r10, r10, r5, LSR #24
	add.w r6, r6, r1, LSL #8
	add.w r7, r7, r2, LSL #8
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r7, r7, r1, LSR #24
	add.w r8, r8, r2, LSR #24
	add.w r9, r9, r4, LSR #24
	bic.w r2, r6, r3 // top 3b < 8
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=10
	bic.w r2, r6, r3 // top 3b < 3
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=5
	usub8.w r2, r6, r3 // >= 3 ?
	sel.w r6, r2, r6 // select
	and.w r2, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r2, LSR #4 // range < 31
	bic.w r2, r7, r3 // top 3b < 8
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=10
	bic.w r2, r7, r3 // top 3b < 3
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=5
	usub8.w r2, r7, r3 // >= 3 ?
	sel.w r7, r2, r7 // select
	and.w r2, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r2, LSR #4 // range < 31
	bic.w r2, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=10
	bic.w r2, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=5
	usub8.w r2, r8, r3 // >= 3 ?
	sel.w r8, r2, r8 // select
	and.w r2, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r2, LSR #4 // range < 31
	bic.w r2, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=10
	bic.w r2, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=5
	usub8.w r2, r9, r3 // >= 3 ?
	sel.w r9, r2, r9 // select
	and.w r2, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r2, LSR #4 // range < 31
	bic.w r2, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=10
	bic.w r2, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=5
	usub8.w r2, r10, r3 // >= 3 ?
	sel.w r10, r2, r10 // select
	and.w r2, r11, #0xF0F0F0F0 // top 4b < 16
	and.w r11, r11, #0x0F0F0F0F // bot 4b < 16
	add.w r11, r11, r2, LSR #4 // range < 31
	bic.w r2, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=10
	bic.w r2, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=5
	usub8.w r2, r11, r3 // >= 3 ?
	sel.w r11, r2, r11 // select
	and.w r2, r12, #0xF0F0F0F0 // top 4b < 16
	and.w r12, r12, #0x0F0F0F0F // bot 4b < 16
	add.w r12, r12, r2, LSR #4 // range < 31
	bic.w r2, r12, r3 // top 3b < 8
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=10
	bic.w r2, r12, r3 // top 3b < 3
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=5
	usub8.w r2, r12, r3 // >= 3 ?
	sel.w r12, r2, r12 // select
	bic.w r2, lr, r3 // top 3b < 8
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=10
	bic.w r2, lr, r3 // top 3b < 3
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=5
	usub8.w r2, lr, r3 // >= 3 ?
	sel.w lr, r2, lr // select
	str r7, [r0, #4]
	str r8, [r0, #8]
	str r9, [r0, #12]
	str r10, [r0, #16]
	str r11, [r0, #20]
	str r12, [r0, #24]
	str lr, [r0, #28]
	str r6, [r0], #32
	vmov.w r1, r2, s0, s1
	add.w r1, #16
	add.w r2, #32
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s2, s3, r6, r7
	vmov.w s4, s5, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s6, s7, r5, r6
	vmov.w s8, s9, r7, r8
	mov.w r6, #0
	ldr.w r5, [r2], #4
	ldr.w r4, [r1, #12]
	ldr.w lr, [r1, #8]
	ldr.w r12, [r1, #4]
	ldr.w r11, [r1], #32
	umull.w r7, r8, r12, r5
	umull.w r9, r10, r4, r5
	umlal.w r6, r7, r11, r5
	umlal.w r8, r9, lr, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, lr, r5
	umlal.w r8, r9, r12, r5
	umlal.w r7, r8, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r12, r5
	umlal.w r8, r9, r11, r5
	ldr.w r5, [r2], #4
	umlal.w r9, r10, r11, r5
	vmov.w s10, s11, r6, r7
	vmov.w s12, s13, r8, r9
	mov.w r6, #0
	mov.w r5, r10
	ldr.w r12, [r1, #-28]
	ldr.w lr, [r1, #-24]
	ldr.w r4, [r1, #-20]
	ldr.w r9, [r2, #-4]
	umull.w r7, r8, r4, r9
	umlal.w r6, r7, lr, r9
	umlal.w r5, r6, r12, r9
	ldr.w r9, [r2, #-8]
	umlal.w r6, r7, r4, r9
	umlal.w r5, r6, lr, r9
	ldr.w r9, [r2, #-12]
	umlal.w r5, r6, r4, r9
	vmov.w s14, s15, r5, r6
	vmov.w s16, s17, r7, r8
	vmov.w r1, r2, s6, s7
	vmov.w r4, r5, s8, s9
	vmov.w r6, r7, s14, s15
	vmov.w r8, r9, s16, s17
	add.w r10, r6, r1, LSL #8
	add.w r11, r7, r2, LSL #8
	add.w r12, r8, r4, LSL #8
	add.w lr, r9, r5, LSL #8
	add.w r11, r11, r1, LSR #24
	add.w r12, r12, r2, LSR #24
	add.w lr, lr, r4, LSR #24
	vmov.w r1, r2, s2, s3
	vmov.w r4, r5, s4, s5
	vmov.w r6, r7, s10, s11
	vmov.w r8, r9, s12, s13
	add.w r10, r10, r5, LSR #24
	add.w r6, r6, r1, LSL #8
	add.w r7, r7, r2, LSL #8
	add.w r8, r8, r4, LSL #8
	add.w r9, r9, r5, LSL #8
	add.w r7, r7, r1, LSR #24
	add.w r8, r8, r2, LSR #24
	add.w r9, r9, r4, LSR #24
	bic.w r2, r6, r3 // top 3b < 8
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=10
	bic.w r2, r6, r3 // top 3b < 3
	and.w r6, r6, r3 // bot 2b < 4
	add.w r6, r6, r2, LSR #2 // range <=5
	usub8.w r2, r6, r3 // >= 3 ?
	sel.w r6, r2, r6 // select
	and.w r2, r7, #0xF0F0F0F0 // top 4b < 16
	and.w r7, r7, #0x0F0F0F0F // bot 4b < 16
	add.w r7, r7, r2, LSR #4 // range < 31
	bic.w r2, r7, r3 // top 3b < 8
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=10
	bic.w r2, r7, r3 // top 3b < 3
	and.w r7, r7, r3 // bot 2b < 4
	add.w r7, r7, r2, LSR #2 // range <=5
	usub8.w r2, r7, r3 // >= 3 ?
	sel.w r7, r2, r7 // select
	and.w r2, r8, #0xF0F0F0F0 // top 4b < 16
	and.w r8, r8, #0x0F0F0F0F // bot 4b < 16
	add.w r8, r8, r2, LSR #4 // range < 31
	bic.w r2, r8, r3 // top 3b < 8
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=10
	bic.w r2, r8, r3 // top 3b < 3
	and.w r8, r8, r3 // bot 2b < 4
	add.w r8, r8, r2, LSR #2 // range <=5
	usub8.w r2, r8, r3 // >= 3 ?
	sel.w r8, r2, r8 // select
	and.w r2, r9, #0xF0F0F0F0 // top 4b < 16
	and.w r9, r9, #0x0F0F0F0F // bot 4b < 16
	add.w r9, r9, r2, LSR #4 // range < 31
	bic.w r2, r9, r3 // top 3b < 8
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=10
	bic.w r2, r9, r3 // top 3b < 3
	and.w r9, r9, r3 // bot 2b < 4
	add.w r9, r9, r2, LSR #2 // range <=5
	usub8.w r2, r9, r3 // >= 3 ?
	sel.w r9, r2, r9 // select
	and.w r2, r10, #0xF0F0F0F0 // top 4b < 16
	and.w r10, r10, #0x0F0F0F0F // bot 4b < 16
	add.w r10, r10, r2, LSR #4 // range < 31
	bic.w r2, r10, r3 // top 3b < 8
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=10
	bic.w r2, r10, r3 // top 3b < 3
	and.w r10, r10, r3 // bot 2b < 4
	add.w r10, r10, r2, LSR #2 // range <=5
	usub8.w r2, r10, r3 // >= 3 ?
	sel.w r10, r2, r10 // select
	and.w r2, r11, #0xF0F0F0F0 // top 4b < 16
	and.w r11, r11, #0x0F0F0F0F // bot 4b < 16
	add.w r11, r11, r2, LSR #4 // range < 31
	bic.w r2, r11, r3 // top 3b < 8
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=10
	bic.w r2, r11, r3 // top 3b < 3
	and.w r11, r11, r3 // bot 2b < 4
	add.w r11, r11, r2, LSR #2 // range <=5
	usub8.w r2, r11, r3 // >= 3 ?
	sel.w r11, r2, r11 // select
	and.w r2, r12, #0xF0F0F0F0 // top 4b < 16
	and.w r12, r12, #0x0F0F0F0F // bot 4b < 16
	add.w r12, r12, r2, LSR #4 // range < 31
	bic.w r2, r12, r3 // top 3b < 8
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=10
	bic.w r2, r12, r3 // top 3b < 3
	and.w r12, r12, r3 // bot 2b < 4
	add.w r12, r12, r2, LSR #2 // range <=5
	usub8.w r2, r12, r3 // >= 3 ?
	sel.w r12, r2, r12 // select
	bic.w r2, lr, r3 // top 3b < 8
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=10
	bic.w r2, lr, r3 // top 3b < 3
	and.w lr, lr, r3 // bot 2b < 4
	add.w lr, lr, r2, LSR #2 // range <=5
	usub8.w r2, lr, r3 // >= 3 ?
	sel.w lr, r2, lr // select
	str r7, [r0, #4]
	str r8, [r0, #8]
	str r9, [r0, #12]
	str r10, [r0, #16]
	str r11, [r0, #20]
	str r12, [r0, #24]
	str lr, [r0, #28]
	str r6, [r0], #32
	vpop.w {s16-s17}
	pop.w {r3-r12,pc}
