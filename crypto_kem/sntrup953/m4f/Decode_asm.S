.p2align 2,,3
.syntax unified
.text
.global Decode_Rq_asm
.type Decode_Rq_asm, %function
Decode_Rq_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1505
@ length = 1, radix = 12558
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 2383
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #2383 @ radix
	movw.w r12, #32864
	movt.w r12, #27 @ barrett coefficient
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
@ length = 4, radix = 781
	add.w r2, r0, #8 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #781 @ radix
	movw.w r12, #59829
	movt.w r12, #83 @ barrett coefficient
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
@ length = 8, radix = 447
	add.w r2, r0, #16 @ used for str
	add.w r0, r0, #8 @ used for ldr
	mov.w r11, #447 @ radix
	movw.w r12, #40171
	movt.w r12, #146 @ barrett coefficient
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
@ length = 15, radix = 338
	add.w r2, r0, #30 @ used for str
	add.w r0, r0, #16 @ used for ldr
	mov.w r11, #338 @ radix
	movw.w r12, #58555
	movt.w r12, #193 @ barrett coefficient
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
@ length = 30, radix = 4701
	add.w r2, r0, #60 @ used for str
	add.w r0, r0, #30 @ used for ldr
	mov.w r11, #4701 @ radix
	movw.w r12, #61660
	movt.w r12, #13 @ barrett coefficient
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
@ length = 60, radix = 1097
	add.w r2, r0, #120 @ used for str
	add.w r0, r0, #60 @ used for ldr
	mov.w r11, #1097 @ radix
	movw.w r12, #48569
	movt.w r12, #59 @ barrett coefficient
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
Decode_Rq_asm_radix1097:
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
	bne.w Decode_Rq_asm_radix1097
@ length = 120, radix = 8476
	add.w r2, r0, #240 @ used for str
	add.w r0, r0, #120 @ used for ldr
	mov.w r11, #8476 @ radix
	movw.w r12, #47969
	movt.w r12, #7 @ barrett coefficient
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
Decode_Rq_asm_radix8476:
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
	bne.w Decode_Rq_asm_radix8476
@ length = 239, radix = 1473
	add.w r2, r0, #478 @ used for str
	add.w r0, r0, #240 @ used for ldr
	mov.w r11, #1473 @ radix
	movw.w r12, #32211
	movt.w r12, #44 @ barrett coefficient
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
Decode_Rq_asm_radix1473:
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
	bne.w Decode_Rq_asm_radix1473
@ length = 477, radix = 614
	add.w r2, r0, #954 @ used for str
	add.w r0, r0, #478 @ used for ldr
	mov.w r11, #614 @ radix
	movw.w r12, #48244
	movt.w r12, #106 @ barrett coefficient
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
Decode_Rq_asm_radix614:
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
	bne.w Decode_Rq_asm_radix614
@ length = 953, radix = 6343
	add.w r2, r0, #1906 @ used for str
	add.w r0, r0, #954 @ used for ldr
	movw.w r9, #3171
	movt.w r9, #3171
	mov.w r11, #6343 @ radix
	movw.w r12, #21759
	movt.w r12, #10 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ssub16 r5, r5, r9
	strh.w r5, [r2, #-2]!
Decode_Rq_asm_radix6343:
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
	bne.w Decode_Rq_asm_radix6343
	pop.w {r2-r12, pc}

.p2align 2,,3
.syntax unified
.text
.global Decode_Rounded_asm
.type Decode_Rounded_asm, %function
Decode_Rounded_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1317
@ length = 1, radix = 124
	ldrb.w r5, [r1, #-1]!
	strh.w r5, [r0]
@ length = 2, radix = 3846
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #3846 @ radix
	movw.w r12, #2624
	movt.w r12, #17 @ barrett coefficient
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
@ length = 4, radix = 15876
	add.w r2, r0, #8 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #15876 @ radix
	movw.w r12, #8388
	movt.w r12, #4 @ barrett coefficient
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
@ length = 8, radix = 126
	add.w r2, r0, #16 @ used for str
	add.w r0, r0, #8 @ used for ldr
	mov.w r11, #126 @ radix
	movw.w r12, #8322
	movt.w r12, #520 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
	ldrh.w r4, [r0, #-2]
	ldr.w r3, [r0, #-6]!
	ubfx r7, r4, #0, #16
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
	smmul r3, r7, r12
	mls r7, r3, r11, r7
	smmul r4, r7, r10
	mls r7, r4, r11, r7
	add.w r3, r3, r4
	pkhbt r7, r7, r3, lsl #16
	str.w r7, [r2, #-4]
	str.w r6, [r2, #-8]
	str.w r5, [r2, #-12]!
@ length = 15, radix = 2863
	add.w r2, r0, #30 @ used for str
	add.w r0, r0, #16 @ used for ldr
	mov.w r11, #2863 @ radix
	movw.w r12, #58371
	movt.w r12, #22 @ barrett coefficient
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
@ length = 30, radix = 856
	add.w r2, r0, #60 @ used for str
	add.w r0, r0, #30 @ used for ldr
	mov.w r11, #856 @ radix
	movw.w r12, #36749
	movt.w r12, #76 @ barrett coefficient
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
@ length = 60, radix = 468
	add.w r2, r0, #120 @ used for str
	add.w r0, r0, #60 @ used for ldr
	mov.w r11, #468 @ radix
	movw.w r12, #2240
	movt.w r12, #140 @ barrett coefficient
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
Decode_Rounded_asm_radix468:
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
	bne.w Decode_Rounded_asm_radix468
@ length = 120, radix = 346
	add.w r2, r0, #240 @ used for str
	add.w r0, r0, #120 @ used for ldr
	mov.w r11, #346 @ radix
	movw.w r12, #26896
	movt.w r12, #189 @ barrett coefficient
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
Decode_Rounded_asm_radix346:
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
	bne.w Decode_Rounded_asm_radix346
@ length = 239, radix = 4761
	add.w r2, r0, #478 @ used for str
	add.w r0, r0, #240 @ used for ldr
	mov.w r11, #4761 @ radix
	movw.w r12, #50146
	movt.w r12, #13 @ barrett coefficient
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
Decode_Rounded_asm_radix4761:
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
	bne.w Decode_Rounded_asm_radix4761
@ length = 477, radix = 69
	add.w r2, r0, #954 @ used for str
	add.w r0, r0, #478 @ used for ldr
	mov.w r11, #69 @ radix
	movw.w r12, #52238
	movt.w r12, #949 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
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
Decode_Rounded_asm_radix69:
	ldr.w r4, [r0, #-4]
	ldr.w r3, [r0, #-8]!
	ubfx r8, r4, #16, #16
	ubfx r7, r4, #0, #16
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
	bne.w Decode_Rounded_asm_radix69
@ length = 953, radix = 2115
	add.w r2, r0, #1906 @ used for str
	add.w r0, r0, #954 @ used for ldr
	movw.w r9, #3171
	movt.w r9, #3171
	mov.w r11, #2115 @ radix
	movw.w r12, #64637
	movt.w r12, #30 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
	ssub16 r5, r5, r9
	strh.w r5, [r2, #-2]!
Decode_Rounded_asm_radix2115:
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
	bne.w Decode_Rounded_asm_radix2115
	pop.w {r2-r12, pc}

