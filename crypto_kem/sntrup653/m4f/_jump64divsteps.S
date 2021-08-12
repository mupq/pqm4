.p2align 2,,3
.syntax unified
.text
__polymul_32x32:
	push.w {lr}
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	smulbb.w r7, r3, r5
	smulbb.w r9, r3, r6
	smuadx.w r8, r3, r5
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r7
	mls.w r7, r3, r5, r7
	smmulr.w r5, r4, r8
	mls.w r8, r3, r5, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r5, r4, r9
	mls.w r9, r3, r5, r9
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r7, [r0, #0]
	str.w r8, [r0, #4]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r11
	mls.w r11, r5, r3, r11
	smmulr.w r3, r6, r12
	mls.w r12, r5, r3, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r3, r6, lr
	mls.w lr, r5, r3, lr
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r12, lr, r10, lsl #16
	ldr.w r3, [r1, #-8]
	str.w r11, [r0, #8]
	str.w r12, [r0, #12]
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r7
	mls.w r7, r3, r5, r7
	smmulr.w r5, r4, r8
	mls.w r8, r3, r5, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r5, r4, r9
	mls.w r9, r3, r5, r9
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r7, [r0, #16]
	str.w r8, [r0, #20]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r11
	mls.w r11, r5, r3, r11
	smmulr.w r3, r6, r12
	mls.w r12, r5, r3, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r3, r6, lr
	mls.w lr, r5, r3, lr
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r12, lr, r10, lsl #16
	ldr.w r3, [r1, #-8]
	str.w r11, [r0, #24]
	str.w r12, [r0, #28]
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r7
	mls.w r7, r3, r5, r7
	smmulr.w r5, r4, r8
	mls.w r8, r3, r5, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r5, r4, r9
	mls.w r9, r3, r5, r9
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r7, [r0, #32]
	str.w r8, [r0, #36]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r11
	mls.w r11, r5, r3, r11
	smmulr.w r3, r6, r12
	mls.w r12, r5, r3, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r3, r6, lr
	mls.w lr, r5, r3, lr
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r12, lr, r10, lsl #16
	ldr.w r3, [r1, #-8]
	str.w r11, [r0, #40]
	str.w r12, [r0, #44]
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r7
	mls.w r7, r3, r5, r7
	smmulr.w r5, r4, r8
	mls.w r8, r3, r5, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r5, r4, r9
	mls.w r9, r3, r5, r9
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r8, r9, r10, lsl #16
	vmov.w r5, s3
	str.w r7, [r0, #48]
	str.w r8, [r0, #52]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-4
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r11
	mls.w r11, r3, r5, r11
	smmulr.w r5, r4, r12
	mls.w r12, r3, r5, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r5, r4, lr
	mls.w lr, r3, r5, lr
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r12, lr, r10, lsl #16
	vmov.w r5, s3
	str.w r11, [r0, #56]
	str.w r12, [r0, #60]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r7
	mls.w r7, r5, r3, r7
	smmulr.w r3, r6, r8
	mls.w r8, r5, r3, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r3, r6, r9
	mls.w r9, r5, r3, r9
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r8, r9, r10, lsl #16
	ldr.w r3, [r1, #4]
	str.w r7, [r0, #64]
	str.w r8, [r0, #68]
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-4
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r11
	mls.w r11, r3, r5, r11
	smmulr.w r5, r4, r12
	mls.w r12, r3, r5, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r5, r4, lr
	mls.w lr, r3, r5, lr
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r12, lr, r10, lsl #16
	vmov.w r5, s3
	str.w r11, [r0, #72]
	str.w r12, [r0, #76]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r7
	mls.w r7, r5, r3, r7
	smmulr.w r3, r6, r8
	mls.w r8, r5, r3, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r3, r6, r9
	mls.w r9, r5, r3, r9
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r8, r9, r10, lsl #16
	ldr.w r3, [r1, #4]
	str.w r7, [r0, #80]
	str.w r8, [r0, #84]
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #-8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #-4
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r11
	mls.w r11, r3, r5, r11
	smmulr.w r5, r4, r12
	mls.w r12, r3, r5, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r5, r4, lr
	mls.w lr, r3, r5, lr
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r12, lr, r10, lsl #16
	vmov.w r5, s3
	str.w r11, [r0, #88]
	str.w r12, [r0, #92]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #-8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #-4
	ldr.w r5, [r2, #-4]
	ldr.w r6, [r2], #4
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smladx.w r10, r3, r6, r10
	smladx.w r12, r4, r6, r12
	smlatt.w r11, r4, r5, r11
	smlatt.w lr, r4, r6, lr
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r7
	mls.w r7, r5, r3, r7
	smmulr.w r3, r6, r8
	mls.w r8, r5, r3, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r3, r6, r9
	mls.w r9, r5, r3, r9
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r8, r9, r10, lsl #16
	ldr.w r3, [r1, #4]
	str.w r7, [r0, #96]
	str.w r8, [r0, #100]
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smuadx.w r10, r3, r6
	smuadx.w r8, r4, r6
	smultt.w r7, r4, r5
	smultt.w r9, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	ldr.w r6, [r2, #4]
	ldr.w r5, [r2], #8
	ldr.w r3, [r1, #-4]
	ldr.w r4, [r1], #4
	smlabb.w r11, r3, r5, r11
	smlabb.w lr, r3, r6, lr
	smladx.w r12, r3, r5, r12
	smladx.w r10, r3, r6, r10
	smladx.w r8, r4, r6, r8
	smlatt.w r7, r4, r5, r7
	smlatt.w r9, r4, r6, r9
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w lr, r3, r5, lr
	smlad.w r7, r3, r6, r7
	vmov.w s3, r5
	vmov.w r4, s2
	movw.w r3, #4621
	smmulr.w r5, r4, r11
	mls.w r11, r3, r5, r11
	smmulr.w r5, r4, r12
	mls.w r12, r3, r5, r12
	pkhbt.w r11, r11, r12, lsl #16
	smmulr.w r5, r4, lr
	mls.w lr, r3, r5, lr
	smmulr.w r5, r4, r10
	mls.w r10, r3, r5, r10
	pkhbt.w r12, lr, r10, lsl #16
	vmov.w r5, s3
	str.w r11, [r0, #104]
	str.w r12, [r0, #108]
	ldr.w r4, [r1, #4]
	ldr.w r3, [r1], #8
	smlabb.w r7, r3, r5, r7
	smlabb.w r9, r3, r6, r9
	smladx.w r8, r3, r5, r8
	smuadx.w r10, r3, r6
	smuadx.w r12, r4, r6
	smultt.w r11, r4, r5
	smultt.w lr, r4, r6
	smladx.w r10, r4, r5, r10
	pkhbt.w r3, r4, r3
	smlad.w r9, r3, r5, r9
	smlad.w r11, r3, r6, r11
	vmov.w r6, s2
	movw.w r5, #4621
	smmulr.w r3, r6, r7
	mls.w r7, r5, r3, r7
	smmulr.w r3, r6, r8
	mls.w r8, r5, r3, r8
	pkhbt.w r7, r7, r8, lsl #16
	smmulr.w r3, r6, r9
	mls.w r9, r5, r3, r9
	smmulr.w r3, r6, r10
	mls.w r10, r5, r3, r10
	pkhbt.w r8, r9, r10, lsl #16
	smmulr.w r3, r6, r11
	mls.w r11, r5, r3, r11
	smmulr.w r3, r6, r12
	mls.w r12, r5, r3, r12
	pkhbt.w r9, r11, r12, lsl #16
	smmulr.w r3, r6, lr
	mls.w r10, r5, r3, lr
	ubfx.w r10, r10, #0, #16
	str.w r7, [r0, #112]
	str.w r8, [r0, #116]
	str.w r9, [r0, #120]
	str.w r10, [r0, #124]
	pop.w {pc}
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_32x32_2x2_x2p2
.type  __gf_polymul_32x32_2x2_x2p2, %function
@ void __gf_polymul_32x32_2x2_x2p2(int *V,int *M,int *fh,int *gh)
__gf_polymul_32x32_2x2_x2p2:
	push {r1-r12, lr}
	sub.w sp, #264
	vmov.w s0, s1, r0, r1
	vmov.w s4, s5, r2, r3
	movw.w r7, #11941
	movt.w r7, #14
	vmov.w s2, r7
	movw.w r11, #0
	mov.w r7, sp
	add.w r8, sp, #2
	add.w r9, sp, #132
	add.w r0, sp, #134
	str.w r11, [r7]
	str.w r11, [r9]
	vmov.w s6, s7, r7, r8
	vmov.w s8, r9
	movw.w r7, #128
	add.w r1, r7
	bl __polymul_32x32
	vmov.w r0, s7
	vmov.w r2, s5
	bl __polymul_32x32
	vmov.w r0, r3, s0, s1
	vmov.w r1, s6
	vmov.w r2, s8
	mov.w r4, 4621
	vmov.w r5, s2
	movw.w r6, #32768
	ldr.w r7, [r1, #0]
	ldr.w r8, [r1, #4]
	ldr.w r9, [r1, #8]
	ldr.w r10, [r1, #12]
	ldr.w r11, [r2, #0]
	ldr.w r12, [r2, #4]
	ldr.w lr, [r2, #8]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r3, #0]
	ldr.w r12, [r3, #4]
	ldr.w lr, [r3, #8]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #12]
	ldr.w r12, [r3, #12]
	sadd16.w r10,r10,r11
	sadd16.w r10,r10,r12
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #0]
	str.w r8, [r0, #4]
	str.w r9, [r0, #8]
	str.w r10, [r0, #12]
	ldr.w r7, [r1, #16]
	ldr.w r8, [r1, #20]
	ldr.w r9, [r1, #24]
	ldr.w r10, [r1, #28]
	ldr.w r11, [r2, #16]
	ldr.w r12, [r2, #20]
	ldr.w lr, [r2, #24]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r3, #16]
	ldr.w r12, [r3, #20]
	ldr.w lr, [r3, #24]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #28]
	ldr.w r12, [r3, #28]
	sadd16.w r10,r10,r11
	sadd16.w r10,r10,r12
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #16]
	str.w r8, [r0, #20]
	str.w r9, [r0, #24]
	str.w r10, [r0, #28]
	ldr.w r7, [r1, #32]
	ldr.w r8, [r1, #36]
	ldr.w r9, [r1, #40]
	ldr.w r10, [r1, #44]
	ldr.w r11, [r2, #32]
	ldr.w r12, [r2, #36]
	ldr.w lr, [r2, #40]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r3, #32]
	ldr.w r12, [r3, #36]
	ldr.w lr, [r3, #40]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #44]
	ldr.w r12, [r3, #44]
	sadd16.w r10,r10,r11
	sadd16.w r10,r10,r12
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #32]
	str.w r8, [r0, #36]
	str.w r9, [r0, #40]
	str.w r10, [r0, #44]
	ldr.w r7, [r1, #48]
	ldr.w r8, [r1, #52]
	ldr.w r9, [r1, #56]
	ldr.w r10, [r1, #60]
	ldr.w r11, [r2, #48]
	ldr.w r12, [r2, #52]
	ldr.w lr, [r2, #56]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r3, #48]
	ldr.w r12, [r3, #52]
	ldr.w lr, [r3, #56]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #60]
	ldr.w r12, [r3, #60]
	sadd16.w r10,r10,r11
	sadd16.w r10,r10,r12
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #48]
	str.w r8, [r0, #52]
	str.w r9, [r0, #56]
	str.w r10, [r0, #60]
	ldr.w r7, [r1, #64]
	ldr.w r8, [r1, #68]
	ldr.w r9, [r1, #72]
	ldr.w r10, [r1, #76]
	ldr.w r11, [r2, #64]
	ldr.w r12, [r2, #68]
	ldr.w lr, [r2, #72]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #76]
	sadd16.w r10,r10,r11
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #64]
	str.w r8, [r0, #68]
	str.w r9, [r0, #72]
	str.w r10, [r0, #76]
	ldr.w r7, [r1, #80]
	ldr.w r8, [r1, #84]
	ldr.w r9, [r1, #88]
	ldr.w r10, [r1, #92]
	ldr.w r11, [r2, #80]
	ldr.w r12, [r2, #84]
	ldr.w lr, [r2, #88]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #92]
	sadd16.w r10,r10,r11
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #80]
	str.w r8, [r0, #84]
	str.w r9, [r0, #88]
	str.w r10, [r0, #92]
	ldr.w r7, [r1, #96]
	ldr.w r8, [r1, #100]
	ldr.w r9, [r1, #104]
	ldr.w r10, [r1, #108]
	ldr.w r11, [r2, #96]
	ldr.w r12, [r2, #100]
	ldr.w lr, [r2, #104]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #108]
	sadd16.w r10,r10,r11
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #96]
	str.w r8, [r0, #100]
	str.w r9, [r0, #104]
	str.w r10, [r0, #108]
	ldr.w r7, [r1, #112]
	ldr.w r8, [r1, #116]
	ldr.w r9, [r1, #120]
	ldr.w r10, [r1, #124]
	ldr.w r11, [r2, #112]
	ldr.w r12, [r2, #116]
	ldr.w lr, [r2, #120]
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r11, [r2, #124]
	sadd16.w r10,r10,r11
	smlawb.w r12, r5, r7, r6
	smlawt.w r11, r5, r7, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r7, r7, r12
	smlawb.w r12, r5, r8, r6
	smlawt.w r11, r5, r8, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r8, r8, r12
	smlawb.w r12, r5, r9, r6
	smlawt.w r11, r5, r9, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r9, r9, r12
	smlawb.w r12, r5, r10, r6
	smlawt.w r11, r5, r10, r6
	smulbt.w r12, r4, r12
	smulbt.w r11, r4, r11
	pkhbt.w r12, r12, r11, LSL #16
	ssub16.w r10, r10, r12
	str.w r7, [r0, #112]
	str.w r8, [r0, #116]
	str.w r9, [r0, #120]
	str.w r10, [r0, #124]
	vmov.w r2, s4
	add.w r0, r0, #128
	add.w r1, r3, #256
	bl __polymul_32x32
	vmov.w r0, s7
	vmov.w r2, s5
	bl __polymul_32x32
	vmov.w r0, s0
	vmov.w r1, s7
	vmov.w r2, s1
	mov.w r3, 4621
	vmov.w r4, s2
	movw.w r5, #32768
	ldr.w r6, [r0, #128]
	ldr.w r7, [r0, #132]
	ldr.w r8, [r0, #136]
	ldr.w r9, [r0, #140]
	ldr.w r10, [r1, #0]
	ldr.w r11, [r1, #4]
	ldr.w r12, [r1, #8]
	ldr.w lr, [r1, #12]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r10, [r2, #64]
	ldr.w r11, [r2, #68]
	ldr.w r12, [r2, #72]
	ldr.w lr, [r2, #76]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #128]
	str.w r7, [r0, #132]
	str.w r8, [r0, #136]
	str.w r9, [r0, #140]
	ldr.w r6, [r0, #144]
	ldr.w r7, [r0, #148]
	ldr.w r8, [r0, #152]
	ldr.w r9, [r0, #156]
	ldr.w r10, [r1, #16]
	ldr.w r11, [r1, #20]
	ldr.w r12, [r1, #24]
	ldr.w lr, [r1, #28]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r10, [r2, #80]
	ldr.w r11, [r2, #84]
	ldr.w r12, [r2, #88]
	ldr.w lr, [r2, #92]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #144]
	str.w r7, [r0, #148]
	str.w r8, [r0, #152]
	str.w r9, [r0, #156]
	ldr.w r6, [r0, #160]
	ldr.w r7, [r0, #164]
	ldr.w r8, [r0, #168]
	ldr.w r9, [r0, #172]
	ldr.w r10, [r1, #32]
	ldr.w r11, [r1, #36]
	ldr.w r12, [r1, #40]
	ldr.w lr, [r1, #44]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r10, [r2, #96]
	ldr.w r11, [r2, #100]
	ldr.w r12, [r2, #104]
	ldr.w lr, [r2, #108]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #160]
	str.w r7, [r0, #164]
	str.w r8, [r0, #168]
	str.w r9, [r0, #172]
	ldr.w r6, [r0, #176]
	ldr.w r7, [r0, #180]
	ldr.w r8, [r0, #184]
	ldr.w r9, [r0, #188]
	ldr.w r10, [r1, #48]
	ldr.w r11, [r1, #52]
	ldr.w r12, [r1, #56]
	ldr.w lr, [r1, #60]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	ldr.w r10, [r2, #112]
	ldr.w r11, [r2, #116]
	ldr.w r12, [r2, #120]
	ldr.w lr, [r2, #124]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #176]
	str.w r7, [r0, #180]
	str.w r8, [r0, #184]
	str.w r9, [r0, #188]
	ldr.w r6, [r0, #192]
	ldr.w r7, [r0, #196]
	ldr.w r8, [r0, #200]
	ldr.w r9, [r0, #204]
	ldr.w r10, [r1, #64]
	ldr.w r11, [r1, #68]
	ldr.w r12, [r1, #72]
	ldr.w lr, [r1, #76]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #192]
	str.w r7, [r0, #196]
	str.w r8, [r0, #200]
	str.w r9, [r0, #204]
	ldr.w r6, [r0, #208]
	ldr.w r7, [r0, #212]
	ldr.w r8, [r0, #216]
	ldr.w r9, [r0, #220]
	ldr.w r10, [r1, #80]
	ldr.w r11, [r1, #84]
	ldr.w r12, [r1, #88]
	ldr.w lr, [r1, #92]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #208]
	str.w r7, [r0, #212]
	str.w r8, [r0, #216]
	str.w r9, [r0, #220]
	ldr.w r6, [r0, #224]
	ldr.w r7, [r0, #228]
	ldr.w r8, [r0, #232]
	ldr.w r9, [r0, #236]
	ldr.w r10, [r1, #96]
	ldr.w r11, [r1, #100]
	ldr.w r12, [r1, #104]
	ldr.w lr, [r1, #108]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	sadd16.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smlawb.w r11, r4, r9, r5
	smlawt.w r10, r4, r9, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r9, r9, r11
	str.w r6, [r0, #224]
	str.w r7, [r0, #228]
	str.w r8, [r0, #232]
	str.w r9, [r0, #236]
	ldr.w r6, [r0, #240]
	ldr.w r7, [r0, #244]
	ldr.w r8, [r0, #248]
	ldrsh.w r9, [r0, #252]
	ldr.w r10, [r1, #112]
	ldr.w r11, [r1, #116]
	ldr.w r12, [r1, #120]
	ldrsh.w lr, [r1, #124]
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	add.w r9,r9,lr
	smlawb.w r11, r4, r6, r5
	smlawt.w r10, r4, r6, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r6, r6, r11
	smlawb.w r11, r4, r7, r5
	smlawt.w r10, r4, r7, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r7, r7, r11
	smlawb.w r11, r4, r8, r5
	smlawt.w r10, r4, r8, r5
	smulbt.w r11, r3, r11
	smulbt.w r10, r3, r10
	pkhbt.w r11, r11, r10, LSL #16
	ssub16.w r8, r8, r11
	smmulr r10, r9, r4
	mls r9, r10, r3, r9
	str.w r6, [r0, #240]
	str.w r7, [r0, #244]
	str.w r8, [r0, #248]
	strh.w r9, [r0, #252]
	add.w sp, #264
	pop {r1-r12, pc}


.p2align 2,,3
.syntax unified
.text
__polyadd_64:
	push.w {lr}
	mov.w r2, 4621
	vmov.w r3, s2
	movw.w r4, #32768
	ldr.w r5, [r1, #0]
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r9, [r0, #0]
	ldr.w r10, [r0, #4]
	ldr.w r11, [r0, #8]
	ldr.w r12, [r0, #12]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #0]
	str.w r6, [r0, #4]
	str.w r7, [r0, #8]
	str.w r8, [r0, #12]
	ldr.w r5, [r1, #16]
	ldr.w r6, [r1, #20]
	ldr.w r7, [r1, #24]
	ldr.w r8, [r1, #28]
	ldr.w r9, [r0, #16]
	ldr.w r10, [r0, #20]
	ldr.w r11, [r0, #24]
	ldr.w r12, [r0, #28]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #16]
	str.w r6, [r0, #20]
	str.w r7, [r0, #24]
	str.w r8, [r0, #28]
	ldr.w r5, [r1, #32]
	ldr.w r6, [r1, #36]
	ldr.w r7, [r1, #40]
	ldr.w r8, [r1, #44]
	ldr.w r9, [r0, #32]
	ldr.w r10, [r0, #36]
	ldr.w r11, [r0, #40]
	ldr.w r12, [r0, #44]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #32]
	str.w r6, [r0, #36]
	str.w r7, [r0, #40]
	str.w r8, [r0, #44]
	ldr.w r5, [r1, #48]
	ldr.w r6, [r1, #52]
	ldr.w r7, [r1, #56]
	ldr.w r8, [r1, #60]
	ldr.w r9, [r0, #48]
	ldr.w r10, [r0, #52]
	ldr.w r11, [r0, #56]
	ldr.w r12, [r0, #60]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #48]
	str.w r6, [r0, #52]
	str.w r7, [r0, #56]
	str.w r8, [r0, #60]
	ldr.w r5, [r1, #64]
	ldr.w r6, [r1, #68]
	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #76]
	ldr.w r9, [r0, #64]
	ldr.w r10, [r0, #68]
	ldr.w r11, [r0, #72]
	ldr.w r12, [r0, #76]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #64]
	str.w r6, [r0, #68]
	str.w r7, [r0, #72]
	str.w r8, [r0, #76]
	ldr.w r5, [r1, #80]
	ldr.w r6, [r1, #84]
	ldr.w r7, [r1, #88]
	ldr.w r8, [r1, #92]
	ldr.w r9, [r0, #80]
	ldr.w r10, [r0, #84]
	ldr.w r11, [r0, #88]
	ldr.w r12, [r0, #92]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #80]
	str.w r6, [r0, #84]
	str.w r7, [r0, #88]
	str.w r8, [r0, #92]
	ldr.w r5, [r1, #96]
	ldr.w r6, [r1, #100]
	ldr.w r7, [r1, #104]
	ldr.w r8, [r1, #108]
	ldr.w r9, [r0, #96]
	ldr.w r10, [r0, #100]
	ldr.w r11, [r0, #104]
	ldr.w r12, [r0, #108]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #96]
	str.w r6, [r0, #100]
	str.w r7, [r0, #104]
	str.w r8, [r0, #108]
	ldr.w r5, [r1, #112]
	ldr.w r6, [r1, #116]
	ldr.w r7, [r1, #120]
	ldr.w r8, [r1, #124]
	ldr.w r9, [r0, #112]
	ldr.w r10, [r0, #116]
	ldr.w r11, [r0, #120]
	ldr.w r12, [r0, #124]
	sadd16.w r5,r5,r9
	sadd16.w r6,r6,r10
	sadd16.w r7,r7,r11
	sadd16.w r8,r8,r12
	smlawb.w r10, r3, r5, r4
	smlawt.w r9, r3, r5, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r5, r5, r10
	smlawb.w r10, r3, r6, r4
	smlawt.w r9, r3, r6, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r6, r6, r10
	smlawb.w r10, r3, r7, r4
	smlawt.w r9, r3, r7, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r7, r7, r10
	smlawb.w r10, r3, r8, r4
	smlawt.w r9, r3, r8, r4
	smulbt.w r10, r2, r10
	smulbt.w r9, r2, r9
	pkhbt.w r10, r10, r9, LSL #16
	ssub16.w r8, r8, r10
	str.w r5, [r0, #112]
	str.w r6, [r0, #116]
	str.w r7, [r0, #120]
	str.w r8, [r0, #124]
	pop.w {pc}
.p2align 2,,3
.syntax unified
.text
.global __gf_polymul_32x32_2x2_x_2x2
.type  __gf_polymul_32x32_2x2_x_2x2, %function
@ void __gf_polymul_32x32_2x2_x_2x2(int *M,int *S_M1,int *fh,int *gh)
__gf_polymul_32x32_2x2_x_2x2:
	push {r1-r12, lr}
	sub.w sp, #132
	vmov.w s0, s1, r0, r1
	vmov.w s4, r2
	movw.w r7, #11941
	movt.w r7, #14
	vmov.w s2, r7
	movw.w r11, #0
	mov.w r7, sp
	add.w r0, sp, #2
	str.w r11, [r7]
	vmov.w s5, s6, r7, r0
	bl	__polymul_32x32
	vmov.w r0, s0
	vmov.w r1, s1
	add.w r1, #128
	bl	__polymul_32x32
	vmov.w r1, s5
	bl	__polyadd_64
	vmov.w r0, s6
	vmov.w r1, s1
	vmov.w r2, s4
	add.w r1, #64
	bl	__polymul_32x32
	vmov.w r0, s0
	vmov.w r1, s1
	add.w r0, #128
	add.w r1, #192
	bl	__polymul_32x32
	vmov.w r1, s5
	bl	__polyadd_64
	vmov.w r0, s6
	vmov.w r1, s1
	vmov.w r2, s4
	add.w r2, #128
	bl	__polymul_32x32
	vmov.w r0, s0
	vmov.w r1, s1
	add.w r0, #256
	add.w r1, #128
	bl	__polymul_32x32
	vmov.w r1, s5
	bl	__polyadd_64
	vmov.w r0, s6
	vmov.w r1, s1
	vmov.w r2, s4
	add.w r1, #64
	add.w r2, #128
	bl	__polymul_32x32
	vmov.w r0, s0
	vmov.w r1, s1
	add.w r0, #384
	add.w r1, #192
	bl	__polymul_32x32
	vmov.w r1, s5
	bl	__polyadd_64
	add.w sp, #132
	pop {r1-r12, pc}
