.p2align 2,,3
.syntax unified
.text
.global Decode_Rq_asm
.type Decode_Rq_asm, %function
Decode_Rq_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #994
@ length = 1, radix = 86
	ldrb.w r5, [r1, #-1]!
	strh.w r5, [r0]
@ length = 2, radix = 835
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #835 @ radix
	movw.w r12, #31865
	movt.w r12, #78 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrh.w r6, [r1, #-2]!
	add.w r5, r6, r5, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
@ length = 3, radix = 7396
	add.w r2, r0, #6 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #7396 @ radix
	movw.w r12, #56426
	movt.w r12, #8 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r3, [r0, #-2]!
	ldrh.w r5, [r1, #-2]!
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
@ length = 6, radix = 86
	add.w r2, r0, #12 @ used for str
	add.w r0, r0, #6 @ used for ldr
	mov.w r11, #86 @ radix
	movw.w r12, #3048
	movt.w r12, #762 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldr.w r3, [r0, #-4]!
	ubfx r6, r3, #16, #16
	ubfx r5, r3, #0, #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
@ length = 11, radix = 2370
	add.w r2, r0, #22 @ used for str
	add.w r0, r0, #12 @ used for ldr
	mov.w r11, #2370 @ radix
	movw.w r12, #42750
	movt.w r12, #27 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r3, [r0, #-2]!
	ldrh.w r5, [r1, #-2]!
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
@ length = 21, radix = 12461
	add.w r2, r0, #42 @ used for str
	add.w r0, r0, #22 @ used for ldr
	mov.w r11, #12461 @ radix
	movw.w r12, #16992
	movt.w r12, #5 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldr.w r3, [r0, #-4]!
	ldr.w r5, [r1, #-4]!
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
@ length = 41, radix = 1786
	add.w r2, r0, #82 @ used for str
	add.w r0, r0, #42 @ used for ldr
	mov.w r11, #1786 @ radix
	movw.w r12, #45500
	movt.w r12, #36 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
Decode_Rq_asm_radix1786:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rq_asm_radix1786
@ length = 82, radix = 676
	add.w r2, r0, #164 @ used for str
	add.w r0, r0, #82 @ used for ldr
	mov.w r11, #676 @ radix
	movw.w r12, #62045
	movt.w r12, #96 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrh.w r6, [r1, #-2]!
	add.w r5, r6, r5, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
Decode_Rq_asm_radix676:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rq_asm_radix676
@ length = 164, radix = 416
	add.w r2, r0, #328 @ used for str
	add.w r0, r0, #164 @ used for ldr
	mov.w r11, #416 @ radix
	movw.w r12, #35288
	movt.w r12, #157 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrb.w r6, [r1, #-1]!
	add.w r5, r6, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldrh.w r3, [r0, #-2]!
	ldrb.w r5, [r1, #-1]!
	add.w r5, r5, r3, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
Decode_Rq_asm_radix416:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rq_asm_radix416
@ length = 327, radix = 326
	add.w r2, r0, #654 @ used for str
	add.w r0, r0, #328 @ used for ldr
	mov.w r11, #326 @ radix
	movw.w r12, #2010
	movt.w r12, #201 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r4, [r0, #-2]
	ldr.w r3, [r0, #-6]!
	ldrb.w r6, [r1, #-1]
	ldrh.w r5, [r1, #-3]!
	add.w r7, r6, r4, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	str.w r7, [r2, #-4]
	str.w r6, [r2, #-8]
	str.w r5, [r2, #-12]!
Decode_Rq_asm_radix326:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rq_asm_radix326
@ length = 653, radix = 4621
	add.w r2, r0, #1306 @ used for str
	add.w r0, r0, #654 @ used for ldr
	movw.w r9, #2310
	movt.w r9, #2310
	mov.w r11, #4621 @ radix
	movw.w r12, #11941
	movt.w r12, #14 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ssub16 r5, r5, r9
	strh.w r5, [r2, #-2]!
	ldr.w r3, [r0, #-4]!
	ldr.w r5, [r1, #-4]!
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	ssub16 r5, r5, r9
	ssub16 r6, r6, r9
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
Decode_Rq_asm_radix4621:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	ssub16 r5, r5, r9
	ssub16 r6, r6, r9
	ssub16 r7, r7, r9
	ssub16 r8, r8, r9
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rq_asm_radix4621
	pop.w {r2-r12, pc}

.p2align 2,,3
.syntax unified
.text
.global Decode_Rounded_asm
.type Decode_Rounded_asm, %function
Decode_Rounded_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #865
@ length = 1, radix = 2608
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 71
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #71 @ radix
	movw.w r12, #2769
	movt.w r12, #923 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrb.w r6, [r1, #-1]!
	add.w r5, r6, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
@ length = 3, radix = 134
	add.w r2, r0, #6 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #134 @ radix
	movw.w r12, #4890
	movt.w r12, #489 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r3, [r0, #-2]!
	ldrb.w r5, [r1, #-1]!
	add.w r5, r5, r3, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
@ length = 6, radix = 2953
	add.w r2, r0, #12 @ used for str
	add.w r0, r0, #6 @ used for ldr
	mov.w r11, #2953 @ radix
	movw.w r12, #12650
	movt.w r12, #22 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrb.w r6, [r1, #-1]!
	add.w r5, r6, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldr.w r3, [r0, #-4]!
	ldr.w r5, [r1, #-4]!
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
@ length = 11, radix = 13910
	add.w r2, r0, #22 @ used for str
	add.w r0, r0, #12 @ used for ldr
	mov.w r11, #13910 @ radix
	movw.w r12, #46624
	movt.w r12, #4 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r3, [r0, #-2]!
	ldrh.w r5, [r1, #-2]!
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
@ length = 21, radix = 1887
	add.w r2, r0, #42 @ used for str
	add.w r0, r0, #22 @ used for ldr
	mov.w r11, #1887 @ radix
	movw.w r12, #47858
	movt.w r12, #34 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldr.w r3, [r0, #-4]!
	ldrh.w r5, [r1, #-2]!
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
@ length = 41, radix = 695
	add.w r2, r0, #82 @ used for str
	add.w r0, r0, #42 @ used for ldr
	mov.w r11, #695 @ radix
	movw.w r12, #19425
	movt.w r12, #94 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
Decode_Rounded_asm_radix695:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rounded_asm_radix695
@ length = 82, radix = 6745
	add.w r2, r0, #164 @ used for str
	add.w r0, r0, #82 @ used for ldr
	mov.w r11, #6745 @ radix
	movw.w r12, #46939
	movt.w r12, #9 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrh.w r6, [r1, #-2]!
	add.w r5, r6, r5, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
Decode_Rounded_asm_radix6745:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rounded_asm_radix6745
@ length = 164, radix = 1314
	add.w r2, r0, #328 @ used for str
	add.w r0, r0, #164 @ used for ldr
	mov.w r11, #1314 @ radix
	movw.w r12, #57356
	movt.w r12, #49 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ldrb.w r6, [r1, #-1]!
	add.w r5, r6, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldrh.w r3, [r0, #-2]!
	ldrb.w r5, [r1, #-1]!
	add.w r5, r5, r3, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
Decode_Rounded_asm_radix1314:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rounded_asm_radix1314
@ length = 327, radix = 9277
	add.w r2, r0, #654 @ used for str
	add.w r0, r0, #328 @ used for ldr
	mov.w r11, #9277 @ radix
	movw.w r12, #4217
	movt.w r12, #7 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r4, [r0, #-2]
	ldr.w r3, [r0, #-6]!
	ldrh.w r6, [r1, #-2]
	ldr.w r5, [r1, #-6]!
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	str.w r7, [r2, #-4]
	str.w r6, [r2, #-8]
	str.w r5, [r2, #-12]!
Decode_Rounded_asm_radix9277:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r6, [r1, #-4]
	ldr.w r5, [r1, #-8]!
	pkhtb r8, r4, r6, asr #16
	pkhbt r7, r6, r4, lsl #16
	pkhtb r6, r3, r5, asr #16
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rounded_asm_radix9277
@ length = 653, radix = 1541
	add.w r2, r0, #1306 @ used for str
	add.w r0, r0, #654 @ used for ldr
	movw.w r9, #2310
	movt.w r9, #2310
	mov.w r11, #1541 @ radix
	movw.w r12, #34617
	movt.w r12, #42 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
	ssub16 r5, r5, r9
	strh.w r5, [r2, #-2]!
	ldr.w r3, [r0, #-4]!
	ldrh.w r5, [r1, #-2]!
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
	uadd16 r4, r6, r6
	uadd16 r6, r6, r4
	ssub16 r5, r5, r9
	ssub16 r6, r6, r9
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
Decode_Rounded_asm_radix1541:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ldr.w r5, [r1, #-4]!
	ubfx r8, r4, #16, #16
	ubfx r7, r5, #24, #8
	add.w r8, r7, r8, lsl #8
	ubfx r7, r4, #0, #16
	ubfx r6, r5, #16, #8
	add.w r7, r6, r7, lsl #8
	ubfx r6, r3, #16, #16
	ubfx r4, r5, #8, #8
	add.w r6, r4, r6, lsl #8
	ubfx r4, r5, #0, #8
	ubfx r5, r3, #0, #16
	add.w r5, r4, r5, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	smmul r3, r6, r12
	mls r6, r3, r11, r6
	smmul r4, r6, r10
	mls r6, r4, r11, r6
	add.w r3, r3, r4
	pkhbt r6, r6, r3, lsl #16
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	smmul r3, r8, r12
	mls r8, r3, r11, r8
	smmul r4, r8, r10
	mls r8, r4, r11, r8
	add.w r3, r3, r4
	pkhbt r8, r8, r3, lsl #16
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
	uadd16 r4, r6, r6
	uadd16 r6, r6, r4
	uadd16 r4, r7, r7
	uadd16 r7, r7, r4
	uadd16 r4, r8, r8
	uadd16 r8, r8, r4
	ssub16 r5, r5, r9
	ssub16 r6, r6, r9
	ssub16 r7, r7, r9
	ssub16 r8, r8, r9
	str.w r8, [r2, #-4]
	str.w r7, [r2, #-8]
	str.w r6, [r2, #-12]
	str.w r5, [r2, #-16]!
	cmp.w r0, r2
	bne.w Decode_Rounded_asm_radix1541
	pop.w {r2-r12, pc}

