.p2align 2,,3
.syntax unified
.text
.global Decode_Rq_asm
.type Decode_Rq_asm, %function
Decode_Rq_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1623
@ length = 1, radix = 274
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 91
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #91 @ radix
	movw.w r12, #11522
	movt.w r12, #720 @ barrett coefficient
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
@ length = 4, radix = 152
	add.w r2, r0, #8 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #152 @ radix
	movw.w r12, #10347
	movt.w r12, #431 @ barrett coefficient
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
@ length = 8, radix = 197
	add.w r2, r0, #16 @ used for str
	add.w r0, r0, #8 @ used for ldr
	mov.w r11, #197 @ radix
	movw.w r12, #43912
	movt.w r12, #332 @ barrett coefficient
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
@ length = 16, radix = 3586
	add.w r2, r0, #32 @ used for str
	add.w r0, r0, #16 @ used for ldr
	mov.w r11, #3586 @ radix
	movw.w r12, #18056
	movt.w r12, #18 @ barrett coefficient
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
@ length = 32, radix = 958
	add.w r2, r0, #64 @ used for str
	add.w r0, r0, #32 @ used for ldr
	mov.w r11, #958 @ radix
	movw.w r12, #26816
	movt.w r12, #68 @ barrett coefficient
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
@ length = 64, radix = 7921
	add.w r2, r0, #128 @ used for str
	add.w r0, r0, #64 @ used for ldr
	mov.w r11, #7921 @ radix
	movw.w r12, #17937
	movt.w r12, #8 @ barrett coefficient
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
Decode_Rq_asm_radix7921:
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
	bne.w Decode_Rq_asm_radix7921
@ length = 127, radix = 89
	add.w r2, r0, #254 @ used for str
	add.w r0, r0, #128 @ used for ldr
	mov.w r11, #89 @ radix
	movw.w r12, #23563
	movt.w r12, #736 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
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
Decode_Rq_asm_radix89:
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
	bne.w Decode_Rq_asm_radix89
@ length = 254, radix = 2414
	add.w r2, r0, #508 @ used for str
	add.w r0, r0, #254 @ used for ldr
	mov.w r11, #2414 @ radix
	movw.w r12, #9719
	movt.w r12, #27 @ barrett coefficient
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
Decode_Rq_asm_radix2414:
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
	bne.w Decode_Rq_asm_radix2414
@ length = 507, radix = 786
	add.w r2, r0, #1014 @ used for str
	add.w r0, r0, #508 @ used for ldr
	mov.w r11, #786 @ radix
	movw.w r12, #24846
	movt.w r12, #83 @ barrett coefficient
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
Decode_Rq_asm_radix786:
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
	bne.w Decode_Rq_asm_radix786
@ length = 1013, radix = 7177
	add.w r2, r0, #2026 @ used for str
	add.w r0, r0, #1014 @ used for ldr
	movw.w r9, #3588
	movt.w r9, #3588
	mov.w r11, #7177 @ radix
	movw.w r12, #8610
	movt.w r12, #9 @ barrett coefficient
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
Decode_Rq_asm_radix7177:
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
	bne.w Decode_Rq_asm_radix7177
	pop.w {r2-r12, pc}

.p2align 2,,3
.syntax unified
.text
.global Decode_Rounded_asm
.type Decode_Rounded_asm, %function
Decode_Rounded_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1423
@ length = 1, radix = 276
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 14506
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #14506 @ radix
	movw.w r12, #33938
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
@ length = 4, radix = 1927
	add.w r2, r0, #8 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #1927 @ radix
	movw.w r12, #612
	movt.w r12, #34 @ barrett coefficient
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
@ length = 8, radix = 11236
	add.w r2, r0, #16 @ used for str
	add.w r0, r0, #8 @ used for ldr
	mov.w r11, #11236 @ radix
	movw.w r12, #54570
	movt.w r12, #5 @ barrett coefficient
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
@ length = 16, radix = 106
	add.w r2, r0, #32 @ used for str
	add.w r0, r0, #16 @ used for ldr
	mov.w r11, #106 @ radix
	movw.w r12, #17311
	movt.w r12, #618 @ barrett coefficient
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
@ length = 32, radix = 164
	add.w r2, r0, #64 @ used for str
	add.w r0, r0, #32 @ used for ldr
	mov.w r11, #164 @ radix
	movw.w r12, #39960
	movt.w r12, #399 @ barrett coefficient
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
@ length = 64, radix = 3278
	add.w r2, r0, #128 @ used for str
	add.w r0, r0, #64 @ used for ldr
	mov.w r11, #3278 @ radix
	movw.w r12, #65056
	movt.w r12, #19 @ barrett coefficient
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
Decode_Rounded_asm_radix3278:
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
	bne.w Decode_Rounded_asm_radix3278
@ length = 127, radix = 916
	add.w r2, r0, #254 @ used for str
	add.w r0, r0, #128 @ used for ldr
	mov.w r11, #916 @ radix
	movw.w r12, #35772
	movt.w r12, #71 @ barrett coefficient
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
Decode_Rounded_asm_radix916:
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
	bne.w Decode_Rounded_asm_radix916
@ length = 254, radix = 7744
	add.w r2, r0, #508 @ used for str
	add.w r0, r0, #254 @ used for ldr
	mov.w r11, #7744 @ radix
	movw.w r12, #30330
	movt.w r12, #8 @ barrett coefficient
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
Decode_Rounded_asm_radix7744:
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
	bne.w Decode_Rounded_asm_radix7744
@ length = 507, radix = 88
	add.w r2, r0, #1014 @ used for str
	add.w r0, r0, #508 @ used for ldr
	mov.w r11, #88 @ radix
	movw.w r12, #47662
	movt.w r12, #744 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	strh.w r5, [r2, #-2]!
	ldrh.w r3, [r0, #-2]!
	ubfx r5, r3, #0, #16
	smmul r3, r5, r12
	mls r5, r3, r11, r5
	smmul r4, r5, r10
	mls r5, r4, r11, r5
	add.w r3, r3, r4
	pkhbt r5, r5, r3, lsl #16
	str.w r5, [r2, #-4]!
Decode_Rounded_asm_radix88:
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
	bne.w Decode_Rounded_asm_radix88
@ length = 1013, radix = 2393
	add.w r2, r0, #2026 @ used for str
	add.w r0, r0, #1014 @ used for ldr
	movw.w r9, #3588
	movt.w r9, #3588
	mov.w r11, #2393 @ radix
	movw.w r12, #25332
	movt.w r12, #27 @ barrett coefficient
	add.w r10, r12, #1
	ldrh.w r5, [r0, #-2]!
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
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
	uadd16 r4, r5, r5
	uadd16 r5, r5, r4
	uadd16 r4, r6, r6
	uadd16 r6, r6, r4
	ssub16 r5, r5, r9
	ssub16 r6, r6, r9
	str.w r6, [r2, #-4]
	str.w r5, [r2, #-8]!
Decode_Rounded_asm_radix2393:
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
	bne.w Decode_Rounded_asm_radix2393
	pop.w {r2-r12, pc}

