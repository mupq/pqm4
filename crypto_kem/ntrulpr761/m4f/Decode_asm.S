.p2align 2,,3
.syntax unified
.text
.global Decode_Rq_asm
.type Decode_Rq_asm, %function
Decode_Rq_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1158
@ length = 1, radix = 1608
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 9470
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #9470 @ radix
	movw.w r12, #60318
	movt.w r12, #6 @ barrett coefficient
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
@ length = 3, radix = 1557
	add.w r2, r0, #6 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #1557 @ radix
	movw.w r12, #5976
	movt.w r12, #42 @ barrett coefficient
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
@ length = 6, radix = 10101
	add.w r2, r0, #12 @ used for str
	add.w r0, r0, #6 @ used for ldr
	mov.w r11, #10101 @ radix
	movw.w r12, #31986
	movt.w r12, #6 @ barrett coefficient
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
@ length = 12, radix = 1608
	add.w r2, r0, #24 @ used for str
	add.w r0, r0, #12 @ used for ldr
	mov.w r11, #1608 @ radix
	movw.w r12, #49559
	movt.w r12, #40 @ barrett coefficient
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
	ldrb.w r5, [r1, #-1]!
	add.w r5, r5, r3, lsl #8
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
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
@ length = 24, radix = 10265
	add.w r2, r0, #48 @ used for str
	add.w r0, r0, #24 @ used for ldr
	mov.w r11, #10265 @ radix
	movw.w r12, #25192
	movt.w r12, #6 @ barrett coefficient
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
@ length = 48, radix = 1621
	add.w r2, r0, #96 @ used for str
	add.w r0, r0, #48 @ used for ldr
	mov.w r11, #1621 @ radix
	movw.w r12, #28138
	movt.w r12, #40 @ barrett coefficient
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
Decode_Rq_asm_radix1621:
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
	bne.w Decode_Rq_asm_radix1621
@ length = 96, radix = 644
	add.w r2, r0, #192 @ used for str
	add.w r0, r0, #96 @ used for ldr
	mov.w r11, #644 @ radix
	movw.w r12, #50067
	movt.w r12, #101 @ barrett coefficient
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
Decode_Rq_asm_radix644:
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
	bne.w Decode_Rq_asm_radix644
@ length = 191, radix = 406
	add.w r2, r0, #382 @ used for str
	add.w r0, r0, #192 @ used for ldr
	mov.w r11, #406 @ radix
	movw.w r12, #27441
	movt.w r12, #161 @ barrett coefficient
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
Decode_Rq_asm_radix406:
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
	bne.w Decode_Rq_asm_radix406
@ length = 381, radix = 322
	add.w r2, r0, #762 @ used for str
	add.w r0, r0, #382 @ used for ldr
	mov.w r11, #322 @ radix
	movw.w r12, #34599
	movt.w r12, #203 @ barrett coefficient
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
Decode_Rq_asm_radix322:
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
	bne.w Decode_Rq_asm_radix322
@ length = 761, radix = 4591
	add.w r2, r0, #1522 @ used for str
	add.w r0, r0, #762 @ used for ldr
	movw.w r9, #2295
	movt.w r9, #2295
	mov.w r11, #4591 @ radix
	movw.w r12, #18014
	movt.w r12, #14 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	ssub16 r5, r5, r9
	strh.w r5, [r2, #-2]!
Decode_Rq_asm_radix4591:
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
	bne.w Decode_Rq_asm_radix4591
	pop.w {r2-r12, pc}

.p2align 2,,3
.syntax unified
.text
.global Decode_Rounded_asm
.type Decode_Rounded_asm, %function
Decode_Rounded_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1007
@ length = 1, radix = 3475
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 593
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #593 @ radix
	movw.w r12, #33817
	movt.w r12, #110 @ barrett coefficient
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
@ length = 3, radix = 6232
	add.w r2, r0, #6 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #6232 @ radix
	movw.w r12, #33819
	movt.w r12, #10 @ barrett coefficient
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
@ length = 6, radix = 1263
	add.w r2, r0, #12 @ used for str
	add.w r0, r0, #6 @ used for ldr
	mov.w r11, #1263 @ radix
	movw.w r12, #58271
	movt.w r12, #51 @ barrett coefficient
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
@ length = 12, radix = 9097
	add.w r2, r0, #24 @ used for str
	add.w r0, r0, #12 @ used for ldr
	mov.w r11, #9097 @ radix
	movw.w r12, #13378
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
@ length = 24, radix = 1526
	add.w r2, r0, #48 @ used for str
	add.w r0, r0, #24 @ used for ldr
	mov.w r11, #1526 @ radix
	movw.w r12, #62014
	movt.w r12, #42 @ barrett coefficient
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
@ length = 48, radix = 625
	add.w r2, r0, #96 @ used for str
	add.w r0, r0, #48 @ used for ldr
	mov.w r11, #625 @ radix
	movw.w r12, #56203
	movt.w r12, #104 @ barrett coefficient
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
Decode_Rounded_asm_radix625:
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
	bne.w Decode_Rounded_asm_radix625
@ length = 96, radix = 6400
	add.w r2, r0, #192 @ used for str
	add.w r0, r0, #96 @ used for ldr
	mov.w r11, #6400 @ radix
	movw.w r12, #15728
	movt.w r12, #10 @ barrett coefficient
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
Decode_Rounded_asm_radix6400:
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
	bne.w Decode_Rounded_asm_radix6400
@ length = 191, radix = 1280
	add.w r2, r0, #382 @ used for str
	add.w r0, r0, #192 @ used for ldr
	mov.w r11, #1280 @ radix
	movw.w r12, #13107
	movt.w r12, #51 @ barrett coefficient
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
Decode_Rounded_asm_radix1280:
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
	bne.w Decode_Rounded_asm_radix1280
@ length = 381, radix = 9157
	add.w r2, r0, #762 @ used for str
	add.w r0, r0, #382 @ used for ldr
	mov.w r11, #9157 @ radix
	movw.w r12, #10284
	movt.w r12, #7 @ barrett coefficient
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
Decode_Rounded_asm_radix9157:
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
	bne.w Decode_Rounded_asm_radix9157
@ length = 761, radix = 1531
	add.w r2, r0, #1522 @ used for str
	add.w r0, r0, #762 @ used for ldr
	movw.w r9, #2295
	movt.w r9, #2295
	mov.w r11, #1531 @ radix
	movw.w r12, #52822
	movt.w r12, #42 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
	ssub16 r5, r5, r9
	strh.w r5, [r2, #-2]!
Decode_Rounded_asm_radix1531:
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
	bne.w Decode_Rounded_asm_radix1531
	pop.w {r2-r12, pc}

