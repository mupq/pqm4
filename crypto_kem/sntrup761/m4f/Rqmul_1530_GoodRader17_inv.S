.p2align 2,,3
.syntax unified
.text
iwpad:
	.word 935519
	.word 3270578671
	@ .word 4288150635
    @ .word 4202629097
    @ .word 132839438
    @ .word 4284414565
    @ .word 137624047
    @ .word 4270392526
    @ .word 4212590266
    @ .word 4178246142
	.word 38075360
    .word 23002444
    .word 4192009670
    .word 15663379
    .word 4194236986
    .word 4258792500
    .word 4277272246
    .word 4166450295

.global iRader17_iGood17x9
.type iRader17_iGood17x9, %function
iRader17_iGood17x9:
	push {r2-r12, lr}
	adr lr, iwpad
	vldm lr, {s2-s11}
    vmov s15, r0
	vmov s0, r0
    vmov s1, r1
	sub.w sp, sp, #3060
	mov.w r0, sp
	vmov s0, r0
	add.w lr, r0, #180
iRader_iGood_part1:
	ldr.w r3, [r1, #2340] @ 13
	ldr.w r4, [r1, #900] @ 5
	ldr.w r5, [r1, #2700] @ 15
	ldr.w r6, [r1, #1980] @ 11
	ldr.w r7, [r1, #720] @ 4
	ldr.w r8, [r1, #2160] @ 12
	ldr.w r9, [r1, #360] @ 2
	ldr.w r10, [r1, #1080] @ 6

	sadd16 r12, r3, r4
	sadd16 r12, r12, r5
	sadd16 r12, r12, r6
	sadd16 r12, r12, r7
	sadd16 r12, r12, r8
	sadd16 r12, r12, r9
	sadd16 r12, r12, r10

	sadd16 r2, r3, r7 @ c4 mod (x^8 - 1)
	ssub16 r7, r3, r7 @ c4 mod (x^8 + 1)
	sadd16 r3, r4, r8 @ c5 mod (x^8 - 1)
	ssub16 r8, r4, r8 @ c5 mod (x^8 + 1)
	sadd16 r4, r5, r9 @ c6 mod (x^8 - 1)
	ssub16 r9, r5, r9 @ c6 mod (x^8 + 1)
	sadd16 r5, r6, r10 @ c7 mod (x^8 - 1)
	ssub16 r10, r6, r10 @ c7 mod (x^8 + 1)

	pkhtb r11, r10, r9, asr #16 @ c6, c7 mod (x^8 + 1) b
	pkhbt r10, r9, r10, lsl #16 @ c6, c7 mod (x^8 + 1) a
	pkhtb r9, r8, r7, asr #16 @ c4, c5 mod (x^8 + 1) b
	pkhbt r8, r7, r8, lsl #16 @ c4, c5 mod (x^8 + 1) a
	pkhtb r7, r5, r4, asr #16 @ c6, c7 mod (x^8 - 1) b
	pkhbt r6, r4, r5, lsl #16 @ c6, c7 mod (x^8 - 1) a
	pkhtb r5, r3, r2, asr #16 @ c4, c5 mod (x^8 - 1) b
	pkhbt r4, r2, r3, lsl #16 @ c4, c5 mod (x^8 - 1) a

	str.w r8, [r0, #1260]
	str.w r10, [r0, #1440]
	str.w r9, [r0, #2700]
	str.w r11, [r0, #2880]
	vmov s12, r12

@ r4, r6 = c4~c7 mod (x^8 - 1) a, r5, r7 = c4~c7 mod (x^8 - 1) b
	ldr.w r8, [r1, #1620] @ 9
	ldr.w r9, [r1, #1800] @ 10
	ldr.w r10, [r1, #1440] @ 8
	ldr.w r11, [r1, #1260] @ 7

	sadd16 r12, r8, r9
	sadd16 r12, r12, r10
	sadd16 r12, r12, r11

	sadd16 r2, r8, r10 @ c2 mod (x^8 - 1)
	ssub16 r8, r8, r10 @ c2 mod (x^8 + 1)
	sadd16 r3, r9, r11 @ c3 mod (x^8 - 1)
	ssub16 r9, r9, r11 @ c3 mod (x^8 + 1)

	pkhbt r10, r8, r9, lsl #16 @ c2, c3 mod (x^8 + 1) a
	pkhtb r11, r9, r8, asr #16 @ c2, c3 mod (x^8 + 1) b
	pkhbt r8, r2, r3, lsl #16 @ c2, c3 mod (x^8 - 1) a
	pkhtb r9, r3, r2, asr #16 @ c2, c3 mod (x^8 - 1) b

	sadd16 r2, r8, r6 @ c2, c3 mod (x^4 - 1) a
	ssub16 r6, r8, r6 @ c2, c3 mod (x^4 + 1) a
	sadd16 r3, r9, r7 @ c2, c3 mod (x^4 - 1) b
	ssub16 r7, r9, r7 @ c2, c3 mod (x^4 + 1) b

@ r2 = c2~c3 mod (x^4 - 1) a, r3 = c2~c3 mod (x^4 - 1) b, r4 = c4~c5 mod (x^8 - 1) a, r5 = c4~c5 mod (x^8 - 1) b
	str.w r10, [r0, #1080]
	str.w r11, [r0, #2520]
	str.w r6, [r0, #720]
	str.w r7, [r0, #2160]

	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #540]
	ldr.w r10, [r1, #2880]
	ldr.w r11, [r1, #2520]

	sadd16 r12, r12, r8
	sadd16 r12, r12, r9
	sadd16 r12, r12, r10
	sadd16 r12, r12, r11

	sadd16 r6, r8, r10 @ c0 mod (x^8 - 1)
	ssub16 r8, r8, r10 @ c0 mod (x^8 + 1)
	sadd16 r7, r9, r11 @ c1 mod (x^8 - 1)
	ssub16 r9, r9, r11 @ c1 mod (x^8 + 1)

	pkhbt r10, r8, r9, lsl #16 @ c0, c1 mod (x^8 + 1) a
	pkhtb r11, r9, r8, asr #16 @ c0, c1 mod (x^8 + 1) b
	pkhbt r8, r6, r7, lsl #16 @ c0, c1 mod (x^8 - 1) a
	pkhtb r9, r7, r6, asr #16 @ c0, c1 mod (x^8 - 1) b

	sadd16 r6, r8, r4 @ c0, c1 mod (x^4 - 1) a
	ssub16 r8, r8, r4 @ c0, c1 mod (x^4 + 1) a
	sadd16 r7, r9, r5 @ c0, c1 mod (x^4 - 1) b
	ssub16 r9, r9, r5 @ c0, c1 mod (x^4 + 1) b

	sadd16 r4, r6, r2
	ssub16 r6, r6, r2
	sadd16 r5, r7, r3
	ssub16 r7, r7, r3

	str.w r10, [r0, #900]
	str.w r11, [r0, #2340]
	str.w r8, [r0, #540]
	str.w r9, [r0, #1980]
	str.w r4, [r0, #180]
	str.w r6, [r0, #360]
	str.w r5, [r0, #1620]
	str.w r7, [r0, #1800]

	vmov r11, s12
	vmov r10, s2
	mov.w r9, #4591
	ldr.w r8, [r1], #4

	sbfx r2, r11, #0, #16
	sbfx r3, r12, #0, #16
	sbfx r4, r11, #16, #16
	sbfx r5, r12, #16, #16
	
	add.w r2, r2, r3
	add.w r3, r4, r5
	smmulr r4, r2, r10
	mls r2, r4, r9, r2
	smmulr r4, r3, r10
	mls r3, r4, r9, r3

	pkhbt r2, r2, r3, lsl #16
	sadd16 r2, r2, r8

	str.w r2, [r0], #4
	cmp.w r0, lr
	bne.w iRader_iGood_part1

    vmov r0, s0
    vmov r12, s3
    add.w lr, r0, #180
    vmov r1, s4
    vmov r2, s5
    vmov r3, s6
    vmov r4, s7
iRader_iGood_part2:
	ldr.w r5, [r0, #180]
	ldr.w r6, [r0, #360]
	ldr.w r7, [r0, #540]
	ldr.w r8, [r0, #720]

	smuad r9, r1, r5
	smuadx r10, r1, r5
	smusd r11, r2, r6
	smuadx r5, r2, r6
	add.w r6, r9, r11 @ 0
	sub.w r9, r9, r11 @ 2
	add.w r11, r10, r5 @ 1
	sub.w r10, r10, r5 @ 3
	smulbt r5, r6, r12
	smlabb r6, r5, r12, r6
	smulbt r5, r9, r12
	smlabb r9, r5, r12, r9
	smulbt r5, r11, r12
	smlabb r11, r5, r12, r11
	smulbt r5, r10, r12
	smlabb r10, r5, r12, r10
	pkhtb r10, r10, r9, asr #16
	pkhtb r9, r11, r6, asr #16

	@ smuad r9, r1, r5
	@ smuadx r10, r1, r5
	@ smulbt r5, r9, r12
	@ smlabb r9, r5, r12, r9
	@ smulbt r5, r10, r12
	@ smlabb r10, r5, r12, r10
	@ pkhtb r5, r10, r9, asr #16
	@ smusd r9, r2, r6
	@ smuadx r10, r2, r6
	@ smulbt r6, r9, r12
	@ smlabb r9, r6, r12, r9
	@ smulbt r6, r10, r12
	@ smlabb r10, r6, r12, r10
	@ pkhtb r6, r10, r9, asr #16
	@ sadd16 r9, r5, r6
	@ ssub16 r10, r5, r6

	smuadx r11, r3, r7
	smuadx r5, r4, r8
	sub.w r11, r11, r5
	smuadx r5, r3, r8
	smladx r5, r4, r7, r5
	smulbt r6, r11, r12
	smlabb r11, r6, r12, r11
	smulbt r6, r5, r12
	smlabb r5, r6, r12, r5
	pkhtb r6, r5, r11, asr #16
	pkhbt r11, r7, r8
	pkhtb r5, r7, r8
	smusd r7, r3, r11
	smuad r8, r4, r5
	sub.w r7, r7, r8
	smuad r8, r3, r5
	smlsd r8, r4, r11, r8
	smulbt r11, r7, r12
	smlabb r7, r11, r12, r7
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	pkhtb r7, r8, r7, asr #16
	pkhbt r8, r7, r6, lsl #16
	pkhtb r7, r6, r7, asr #16
	sadd16 r11, r9, r8
	ssub16 r5, r9, r8
	sadd16 r6, r10, r7
	ssub16 r9, r10, r7
	str.w r11, [r0, #180]
	str.w r6, [r0, #360]
	str.w r5, [r0, #540]
	str.w r9, [r0, #720]
	ldr.w r5, [r0, #1620]
	ldr.w r6, [r0, #1800]
	ldr.w r7, [r0, #1980]
	ldr.w r8, [r0, #2160]

	smuad r9, r1, r5
	smuadx r10, r1, r5
	smusd r11, r2, r6
	smuadx r5, r2, r6
	add.w r6, r9, r11 @ 0
	sub.w r9, r9, r11 @ 2
	add.w r11, r10, r5 @ 1
	sub.w r10, r10, r5 @ 3
	smulbt r5, r6, r12
	smlabb r6, r5, r12, r6
	smulbt r5, r9, r12
	smlabb r9, r5, r12, r9
	smulbt r5, r11, r12
	smlabb r11, r5, r12, r11
	smulbt r5, r10, r12
	smlabb r10, r5, r12, r10
	pkhtb r10, r10, r9, asr #16
	pkhtb r9, r11, r6, asr #16

	@ smuad r9, r1, r5
	@ smuadx r10, r1, r5
	@ smulbt r5, r9, r12
	@ smlabb r9, r5, r12, r9
	@ smulbt r5, r10, r12
	@ smlabb r10, r5, r12, r10
	@ pkhtb r5, r10, r9, asr #16
	@ smusd r9, r2, r6
	@ smuadx r10, r2, r6
	@ smulbt r6, r9, r12
	@ smlabb r9, r6, r12, r9
	@ smulbt r6, r10, r12
	@ smlabb r10, r6, r12, r10
	@ pkhtb r6, r10, r9, asr #16
	@ sadd16 r9, r5, r6
	@ ssub16 r10, r5, r6

	smuadx r11, r3, r7
	smuadx r5, r4, r8
	sub.w r11, r11, r5
	smuadx r5, r3, r8
	smladx r5, r4, r7, r5
	smulbt r6, r11, r12
	smlabb r11, r6, r12, r11
	smulbt r6, r5, r12
	smlabb r5, r6, r12, r5
	pkhtb r6, r5, r11, asr #16
	pkhbt r11, r7, r8
	pkhtb r5, r7, r8
	smusd r7, r3, r11
	smuad r8, r4, r5
	sub.w r7, r7, r8
	smuad r8, r3, r5
	smlsd r8, r4, r11, r8
	smulbt r11, r7, r12
	smlabb r7, r11, r12, r7
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	pkhtb r7, r8, r7, asr #16
	pkhbt r8, r7, r6, lsl #16
	pkhtb r7, r6, r7, asr #16
	sadd16 r11, r9, r8
	ssub16 r5, r9, r8
	sadd16 r6, r10, r7
	ssub16 r9, r10, r7
	str.w r11, [r0, #1620]
	str.w r6, [r0, #1800]
	str.w r5, [r0, #1980]
	str.w r9, [r0, #2160]
    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w iRader_iGood_part2

    vmov r0, s0
    vmov r1, s8
    vmov r2, s9
    vmov r3, s10
    vmov r4, s11
iRader_iGood_part3:
    ldr.w r5, [r0, #900]
	ldr.w r6, [r0, #1080]
	ldr.w r7, [r0, #1260]
	ldr.w r8, [r0, #1440]
	smuadx r9, r1, r5
	smuadx r10, r2, r8
	smladx r10, r3, r7, r10
	smladx r10, r4, r6, r10
	sub.w r9, r9, r10
	smuadx r10, r1, r6
	smladx r10, r2, r5, r10
	smuadx r11, r3, r8
	smladx r11, r4, r7, r11
	sub.w r10, r10, r11
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s12, r9
	smuadx r9, r1, r7
	smladx r9, r2, r6, r9
	smladx r9, r3, r5, r9
	smuadx r10, r4, r8
	sub.w r9, r9, r10
	smuadx r10, r1, r8
	smladx r10, r2, r7, r10
	smladx r10, r3, r6, r10
	smladx r10, r4, r5, r10
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s13, r9
	pkhbt r9, r5, r8
	pkhtb r5, r5, r6
	pkhtb r6, r6, r7
	pkhtb r7, r7, r8
	smusd r8, r1, r9
	smuad r10, r2, r7
	smlad r10, r3, r6, r10
	smlad r10, r4, r5, r10
	sub.w r8, r8, r10
	smuad r10, r1, r5
	smlsd r10, r2, r9, r10
	smuad r11, r3, r7
	smlad r11, r4, r6, r11
	sub.w r10, r10, r11
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r11, r10, r8, asr #16
	smuad r8, r1, r6
	smlad r8, r2, r5, r8
	smlsd r8, r3, r9, r8
	smuad r10, r4, r7
	sub.w r8, r8, r10
	smuad r10, r1, r7
	smlad r10, r2, r6, r10
	smlad r10, r3, r5, r10
	smlsd r10, r4, r9, r10
	smulbt r9, r8, r12
	smlabb r8, r9, r12, r8
	smulbt r9, r10, r12
	smlabb r10, r9, r12, r10
	pkhtb r8, r10, r8, asr #16
	vmov r10, s12
	vmov r9, s13
	pkhbt r5, r11, r10, lsl #16
	pkhtb r10, r10, r11, asr #16
	pkhbt r11, r8, r9, lsl #16
	pkhtb r8, r9, r8, asr #16
	str.w r5, [r0, #900]
	str.w r10, [r0, #1080]
	str.w r11, [r0, #1260]
	str.w r8, [r0, #1440]
	ldr.w r5, [r0, #2340]
	ldr.w r6, [r0, #2520]
	ldr.w r7, [r0, #2700]
	ldr.w r8, [r0, #2880]
	smuadx r9, r1, r5
	smuadx r10, r2, r8
	smladx r10, r3, r7, r10
	smladx r10, r4, r6, r10
	sub.w r9, r9, r10
	smuadx r10, r1, r6
	smladx r10, r2, r5, r10
	smuadx r11, r3, r8
	smladx r11, r4, r7, r11
	sub.w r10, r10, r11
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s12, r9
	smuadx r9, r1, r7
	smladx r9, r2, r6, r9
	smladx r9, r3, r5, r9
	smuadx r10, r4, r8
	sub.w r9, r9, r10
	smuadx r10, r1, r8
	smladx r10, r2, r7, r10
	smladx r10, r3, r6, r10
	smladx r10, r4, r5, r10
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s13, r9
	pkhbt r9, r5, r8
	pkhtb r5, r5, r6
	pkhtb r6, r6, r7
	pkhtb r7, r7, r8
	smusd r8, r1, r9
	smuad r10, r2, r7
	smlad r10, r3, r6, r10
	smlad r10, r4, r5, r10
	sub.w r8, r8, r10
	smuad r10, r1, r5
	smlsd r10, r2, r9, r10
	smuad r11, r3, r7
	smlad r11, r4, r6, r11
	sub.w r10, r10, r11
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r11, r10, r8, asr #16
	smuad r8, r1, r6
	smlad r8, r2, r5, r8
	smlsd r8, r3, r9, r8
	smuad r10, r4, r7
	sub.w r8, r8, r10
	smuad r10, r1, r7
	smlad r10, r2, r6, r10
	smlad r10, r3, r5, r10
	smlsd r10, r4, r9, r10
	smulbt r9, r8, r12
	smlabb r8, r9, r12, r8
	smulbt r9, r10, r12
	smlabb r10, r9, r12, r10
	pkhtb r8, r10, r8, asr #16
	vmov r10, s12
	vmov r9, s13
	pkhbt r5, r11, r10, lsl #16
	pkhtb r10, r10, r11, asr #16
	pkhbt r11, r8, r9, lsl #16
	pkhtb r8, r9, r8, asr #16
	str.w r5, [r0, #2340]
	str.w r10, [r0, #2520]
	str.w r11, [r0, #2700]
	str.w r8, [r0, #2880]
    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w iRader_iGood_part3

	vmov r0, s15 @ real output
	vmov r1, s0 @ buffer
	vmov r2, s1 @ input
	mov.w r3, #3459
	mov.w r4, #4591
	vmov r5, s2
	add.w lr, r0, #20
	
iRader_iGood_part4_0:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #900]
	str.w r10, [r0, #2340]
	str.w r11, [r0, #2160]
	str.w r12, [r0, #720]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1800]
	str.w r10, [r0, #1620]
	str.w r11, [r0, #1260]
	str.w r12, [r0, #1440]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #540]
	str.w r10, [r0, #180]
	str.w r11, [r0, #2520]
	str.w r12, [r0, #2880]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1080]
	str.w r10, [r0, #360]
	str.w r11, [r0, #1980]
	str.w r12, [r0, #2700]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0], #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_0
	vmov r0, s15
iRader_iGood_part4_1:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #560]
	str.w r10, [r0, #2000]
	str.w r11, [r0, #1820]
	str.w r12, [r0, #380]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1460]
	str.w r10, [r0, #1280]
	str.w r11, [r0, #920]
	str.w r12, [r0, #1100]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #200]
	str.w r10, [r0, #2900]
	str.w r11, [r0, #2180]
	str.w r12, [r0, #2540]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #740]
	str.w r10, [r0, #20]
	str.w r11, [r0, #1640]
	str.w r12, [r0, #2360]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #2720]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_1
	vmov r0, s15
iRader_iGood_part4_2:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #220]
	str.w r10, [r0, #1660]
	str.w r11, [r0, #1480]
	str.w r12, [r0, #40]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1120]
	str.w r10, [r0, #940]
	str.w r11, [r0, #580]
	str.w r12, [r0, #760]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2920]
	str.w r10, [r0, #2560]
	str.w r11, [r0, #1840]
	str.w r12, [r0, #2200]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #400]
	str.w r10, [r0, #2740]
	str.w r11, [r0, #1300]
	str.w r12, [r0, #2020]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #2380]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_2
	vmov r0, s15
iRader_iGood_part4_3:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2940]
	str.w r10, [r0, #1320]
	str.w r11, [r0, #1140]
	str.w r12, [r0, #2760]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #780]
	str.w r10, [r0, #600]
	str.w r11, [r0, #240]
	str.w r12, [r0, #420]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2580]
	str.w r10, [r0, #2220]
	str.w r11, [r0, #1500]
	str.w r12, [r0, #1860]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #60]
	str.w r10, [r0, #2400]
	str.w r11, [r0, #960]
	str.w r12, [r0, #1680]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #2040]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_3
	vmov r0, s15
iRader_iGood_part4_4:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2600]
	str.w r10, [r0, #980]
	str.w r11, [r0, #800]
	str.w r12, [r0, #2420]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #440]
	str.w r10, [r0, #260]
	str.w r11, [r0, #2960]
	str.w r12, [r0, #80]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2240]
	str.w r10, [r0, #1880]
	str.w r11, [r0, #1160]
	str.w r12, [r0, #1520]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2780]
	str.w r10, [r0, #2060]
	str.w r11, [r0, #620]
	str.w r12, [r0, #1340]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #1700]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_4
	vmov r0, s15
iRader_iGood_part4_5:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2260]
	str.w r10, [r0, #640]
	str.w r11, [r0, #460]
	str.w r12, [r0, #2080]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #100]
	str.w r10, [r0, #2980]
	str.w r11, [r0, #2620]
	str.w r12, [r0, #2800]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1900]
	str.w r10, [r0, #1540]
	str.w r11, [r0, #820]
	str.w r12, [r0, #1180]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2440]
	str.w r10, [r0, #1720]
	str.w r11, [r0, #280]
	str.w r12, [r0, #1000]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #1360]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_5
	vmov r0, s15
iRader_iGood_part4_6:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1920]
	str.w r10, [r0, #300]
	str.w r11, [r0, #120]
	str.w r12, [r0, #1740]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2820]
	str.w r10, [r0, #2640]
	str.w r11, [r0, #2280]
	str.w r12, [r0, #2460]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1560]
	str.w r10, [r0, #1200]
	str.w r11, [r0, #480]
	str.w r12, [r0, #840]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2100]
	str.w r10, [r0, #1380]
	str.w r11, [r0, #3000]
	str.w r12, [r0, #660]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #1020]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_6
	vmov r0, s15
iRader_iGood_part4_7:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1580]
	str.w r10, [r0, #3020]
	str.w r11, [r0, #2840]
	str.w r12, [r0, #1400]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2480]
	str.w r10, [r0, #2300]
	str.w r11, [r0, #1940]
	str.w r12, [r0, #2120]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1220]
	str.w r10, [r0, #860]
	str.w r11, [r0, #140]
	str.w r12, [r0, #500]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1760]
	str.w r10, [r0, #1040]
	str.w r11, [r0, #2660]
	str.w r12, [r0, #320]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #680]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_7
	vmov r0, s15
iRader_iGood_part4_8:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #180] @ 1, 2 a
	ldr.w r8, [r1, #900] @ 9, 10 a
	ldr.w r9, [r1, #1620] @ 1, 2 b
	ldr.w r10, [r1, #2340] @ 9, 10 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1240]
	str.w r10, [r0, #2680]
	str.w r11, [r0, #2500]
	str.w r12, [r0, #1060]

	ldr.w r7, [r1, #360] @ 3, 4 a
	ldr.w r8, [r1, #1080] @ 11, 12 a
	ldr.w r9, [r1, #1800] @ 3, 4 b
	ldr.w r10, [r1, #2520] @ 11, 12 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #2140]
	str.w r10, [r0, #1960]
	str.w r11, [r0, #1600]
	str.w r12, [r0, #1780]

	ldr.w r7, [r1, #540] @ 5, 6 a
	ldr.w r8, [r1, #1260] @ 13, 14 a
	ldr.w r9, [r1, #1980] @ 5, 6 b
	ldr.w r10, [r1, #2700] @ 13, 14 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #880]
	str.w r10, [r0, #520]
	str.w r11, [r0, #2860]
	str.w r12, [r0, #160]

	ldr.w r7, [r1, #720] @ 7, 8 a
	ldr.w r8, [r1, #1440] @ 15, 16 a
	ldr.w r9, [r1, #2160] @ 7, 8 b
	ldr.w r10, [r1, #2880] @ 15, 16 b
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #1420]
	str.w r10, [r0, #700]
	str.w r11, [r0, #2320]
	str.w r12, [r0, #3040]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #340]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_8
	add.w sp, sp, #3060
	pop.w {r2-r12, pc}
