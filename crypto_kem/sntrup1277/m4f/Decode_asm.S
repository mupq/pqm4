.p2align 2,,3
.syntax unified
.text
.global Decode_Rq_asm
.type Decode_Rq_asm, %function
Decode_Rq_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #2067
@ length = 1, radix = 3696
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 376
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
	mov.w r11, #376 @ radix
	movw.w r12, #19521
	movt.w r12, #174 @ barrett coefficient
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
@ length = 3, radix = 4962
	add.w r2, r0, #6 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #4962 @ radix
	movw.w r12, #13603
	movt.w r12, #13 @ barrett coefficient
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
@ length = 5, radix = 1127
	add.w r2, r0, #10 @ used for str
	add.w r0, r0, #6 @ used for ldr
	mov.w r11, #1127 @ radix
	movw.w r12, #9885
	movt.w r12, #58 @ barrett coefficient
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
@ length = 10, radix = 537
	add.w r2, r0, #20 @ used for str
	add.w r0, r0, #10 @ used for ldr
	mov.w r11, #537 @ radix
	movw.w r12, #2684
	movt.w r12, #122 @ barrett coefficient
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
@ length = 20, radix = 5929
	add.w r2, r0, #40 @ used for str
	add.w r0, r0, #20 @ used for ldr
	mov.w r11, #5929 @ radix
	movw.w r12, #3503
	movt.w r12, #11 @ barrett coefficient
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
@ length = 40, radix = 77
	add.w r2, r0, #80 @ used for str
	add.w r0, r0, #40 @ used for ldr
	mov.w r11, #77 @ radix
	movw.w r12, #7660
	movt.w r12, #851 @ barrett coefficient
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
Decode_Rq_asm_radix77:
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
	bne.w Decode_Rq_asm_radix77
@ length = 80, radix = 140
	add.w r2, r0, #160 @ used for str
	add.w r0, r0, #80 @ used for ldr
	mov.w r11, #140 @ radix
	movw.w r12, #7489
	movt.w r12, #468 @ barrett coefficient
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
Decode_Rq_asm_radix140:
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
	bne.w Decode_Rq_asm_radix140
@ length = 160, radix = 189
	add.w r2, r0, #320 @ used for str
	add.w r0, r0, #160 @ used for ldr
	mov.w r11, #189 @ radix
	movw.w r12, #49238
	movt.w r12, #346 @ barrett coefficient
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
Decode_Rq_asm_radix189:
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
	bne.w Decode_Rq_asm_radix189
@ length = 320, radix = 3511
	add.w r2, r0, #640 @ used for str
	add.w r0, r0, #320 @ used for ldr
	mov.w r11, #3511 @ radix
	movw.w r12, #43640
	movt.w r12, #18 @ barrett coefficient
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
Decode_Rq_asm_radix3511:
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
	bne.w Decode_Rq_asm_radix3511
@ length = 639, radix = 948
	add.w r2, r0, #1278 @ used for str
	add.w r0, r0, #640 @ used for ldr
	mov.w r11, #948 @ radix
	movw.w r12, #8572
	movt.w r12, #69 @ barrett coefficient
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
Decode_Rq_asm_radix948:
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
	bne.w Decode_Rq_asm_radix948
@ length = 1277, radix = 7879
	add.w r2, r0, #2554 @ used for str
	add.w r0, r0, #1278 @ used for ldr
	movw.w r9, #3939
	movt.w r9, #3939
	mov.w r11, #7879 @ radix
	movw.w r12, #20827
	movt.w r12, #8 @ barrett coefficient
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
Decode_Rq_asm_radix7879:
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
	bne.w Decode_Rq_asm_radix7879
	pop.w {r2-r12, pc}

.p2align 2,,3
.syntax unified
.text
.global Decode_Rounded_asm
.type Decode_Rounded_asm, %function
Decode_Rounded_asm:
	push.w {r2-r12, lr}
	add.w r1, r1, #1815
@ length = 1, radix = 264
	ldrh.w r5, [r1, #-2]!
	strh.w r5, [r0]
@ length = 2, radix = 7744
	add.w r2, r0, #4 @ used for str
	add.w r0, r0, #2 @ used for ldr
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
@ length = 3, radix = 1408
	add.w r2, r0, #6 @ used for str
	add.w r0, r0, #4 @ used for ldr
	mov.w r11, #1408 @ radix
	movw.w r12, #35746
	movt.w r12, #46 @ barrett coefficient
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
@ length = 5, radix = 9604
	add.w r2, r0, #10 @ used for str
	add.w r0, r0, #6 @ used for ldr
	mov.w r11, #9604 @ radix
	movw.w r12, #53990
	movt.w r12, #6 @ barrett coefficient
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
@ length = 10, radix = 98
	add.w r2, r0, #20 @ used for str
	add.w r0, r0, #10 @ used for ldr
	mov.w r11, #98 @ radix
	movw.w r12, #48148
	movt.w r12, #668 @ barrett coefficient
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
@ length = 20, radix = 158
	add.w r2, r0, #40 @ used for str
	add.w r0, r0, #20 @ used for ldr
	mov.w r11, #158 @ radix
	movw.w r12, #51433
	movt.w r12, #414 @ barrett coefficient
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
@ length = 40, radix = 3211
	add.w r2, r0, #80 @ used for str
	add.w r0, r0, #40 @ used for ldr
	mov.w r11, #3211 @ radix
	movw.w r12, #26859
	movt.w r12, #20 @ barrett coefficient
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
Decode_Rounded_asm_radix3211:
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
	bne.w Decode_Rounded_asm_radix3211
@ length = 80, radix = 14506
	add.w r2, r0, #160 @ used for str
	add.w r0, r0, #80 @ used for ldr
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
Decode_Rounded_asm_radix14506:
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
	bne.w Decode_Rounded_asm_radix14506
@ length = 160, radix = 1927
	add.w r2, r0, #320 @ used for str
	add.w r0, r0, #160 @ used for ldr
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
Decode_Rounded_asm_radix1927:
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
	bne.w Decode_Rounded_asm_radix1927
@ length = 320, radix = 11236
	add.w r2, r0, #640 @ used for str
	add.w r0, r0, #320 @ used for ldr
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
Decode_Rounded_asm_radix11236:
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
	bne.w Decode_Rounded_asm_radix11236
@ length = 639, radix = 106
	add.w r2, r0, #1278 @ used for str
	add.w r0, r0, #640 @ used for ldr
	mov.w r11, #106 @ radix
	movw.w r12, #17311
	movt.w r12, #618 @ barrett coefficient
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
Decode_Rounded_asm_radix106:
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
	bne.w Decode_Rounded_asm_radix106
@ length = 1277, radix = 2627
	add.w r2, r0, #2554 @ used for str
	add.w r0, r0, #1278 @ used for ldr
	movw.w r9, #3939
	movt.w r9, #3939
	mov.w r11, #2627 @ radix
	movw.w r12, #62068
	movt.w r12, #24 @ barrett coefficient
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
Decode_Rounded_asm_radix2627:
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
	bne.w Decode_Rounded_asm_radix2627
	pop.w {r2-r12, pc}

