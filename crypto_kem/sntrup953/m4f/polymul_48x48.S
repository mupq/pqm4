.macro barrett_reduce tar, qinv, q, tmp
	smmulr \tmp, \tar, \qinv
	mls \tar, \tmp, \q, \tar
.endm

.macro polymul_4x4_hold_f f01, f23, g01, g23, c0, c1, c2, c3, c4, c5, c6
	smulbb \c0, \f01, \g01
	smuadx \c1, \f01, \g01
	smulbb \c2, \f23, \g01
	smuadx \c3, \f01, \g23
	smladx \c3, \f23, \g01, \c3
	smultt \c4, \f01, \g23
	smuadx \c5, \f23, \g23
	smultt \c6, \f23, \g23
	pkhbt \g01, \g23, \g01
	smlad \c2, \f01, \g01, \c2
	smlad \c4, \f23, \g01, \c4
.endm

.macro polymul_4x4_hold_g f01, f23, g01, g23, c0, c1, c2, c3, c4, c5, c6
	smulbb \c0, \f01, \g01
	smuadx \c1, \f01, \g01
	smulbb \c2, \f01, \g23
	smuadx \c3, \f01, \g23
	smladx \c3, \f23, \g01, \c3
	smultt \c4, \f23, \g01
	smuadx \c5, \f23, \g23
	smultt \c6, \f23, \g23
	pkhbt \f01, \f23, \f01
	smlad \c2, \f01, \g01, \c2
	smlad \c4, \f01, \g23, \c4
.endm

.macro polymul_4x4_accumulate_456to012 f01, f23, g01, g23, c0, c1, c2, c3, c4, c5, c6
	smlabb \c0, \f01, \g01, \c4
	smladx \c1, \f01, \g01, \c5
	smlabb \c2, \f23, \g01, \c6
	smuadx \c3, \f01, \g23
	smladx \c3, \f23, \g01, \c3
	smultt \c4, \f01, \g23
	smuadx \c5, \f23, \g23
	smultt \c6, \f23, \g23
	pkhbt \g01, \g23, \g01
	smlad \c2, \f01, \g01, \c2
	smlad \c4, \f23, \g01, \c4
.endm

.macro polymul_4x4_accumulate_all_hold_f f01, f23, g01, g23, c0, c1, c2, c3, c4, c5, c6
	smlabb \c0, \f01, \g01, \c0
	smladx \c1, \f01, \g01, \c1
	smlabb \c2, \f23, \g01, \c2
	smladx \c3, \f01, \g23, \c3
	smladx \c3, \f23, \g01, \c3
	smlatt \c4, \f01, \g23, \c4
	smladx \c5, \f23, \g23, \c5
	smlatt \c6, \f23, \g23, \c6
	pkhbt \g01, \g23, \g01
	smlad \c2, \f01, \g01, \c2
	smlad \c4, \f23, \g01, \c4
.endm

.macro polymul_4x4_accumulate_all_hold_g f01, f23, g01, g23, c0, c1, c2, c3, c4, c5, c6
	smlabb \c0, \f01, \g01, \c0
	smladx \c1, \f01, \g01, \c1
	smlabb \c2, \f01, \g23, \c2
	smladx \c3, \f01, \g23, \c3
	smladx \c3, \f23, \g01, \c3
	smlatt \c4, \f23, \g01, \c4
	smladx \c5, \f23, \g23, \c5
	smlatt \c6, \f23, \g23, \c6
	pkhbt \f01, \f23, \f01
	smlad \c2, \f01, \g01, \c2
	smlad \c4, \f01, \g23, \c4
.endm

.p2align
.syntax unified
.text
.global gf_polymul_48x48
.type gf_polymul_48x48, %function
gf_polymul_48x48:
	push {r4-r12, lr}
	movw.w r3, #21759
	movt.w r3, #10
	mov.w r4, #6343
	vmov s1, s2, r3, r4

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-8
	polymul_4x4_accumulate_all_hold_g r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r5
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_all_hold_f r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov.w s3, r4
	vmov r5, r6, s1, s2
	barrett_reduce r7, r5, r6, r4
	barrett_reduce r8, r5, r6, r4
	barrett_reduce r9, r5, r6, r4
	barrett_reduce r10, r5, r6, r4
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	vmov.w r4, s3
	str.w r8, [r0, #4]
	str.w r7, [r0], #8

	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	polymul_4x4_accumulate_456to012 r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr
	vmov r3, r4, s1, s2
	barrett_reduce r7, r3, r4, r5
	barrett_reduce r8, r3, r4, r5
	barrett_reduce r9, r3, r4, r5
	barrett_reduce r10, r3, r4, r5
	barrett_reduce r11, r3, r4, r5
	barrett_reduce r12, r3, r4, r5
	barrett_reduce lr, r3, r4, r5
	pkhbt r7, r7, r8, lsl #16
	pkhbt r8, r9, r10, lsl #16
	pkhbt r9, r11, r12, lsl #16
	ubfx r10, lr, #0, #16
	str.w r7, [r0]
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	pop {r4-r12, pc}
