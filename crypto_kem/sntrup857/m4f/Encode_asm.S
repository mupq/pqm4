.p2align 2,,3
.syntax unified
.text
.global Encode_Rq_asm
.type Encode_Rq_asm, %function
Encode_Rq_asm:
	push {r2-r12, lr}
	vmov.w s1, r1 @ input
	movw.w r12, #2583
	movt.w r12, #2583
	vmov.w r2, s1
@ iteration 1
@ len = 857
@ tail radix = 5167
	add.w lr, r1, #1712
	mov.w r3, #5167
Encode_Rq_asm_radix5167:
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r5, [r1], #16
	sadd16 r5, r5, r12
	sadd16 r6, r6, r12
	sadd16 r7, r7, r12
	sadd16 r8, r8, r12
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	sxth r9, r7
	smlabt r7, r3, r7, r9
	sxth r9, r8
	smlabt r8, r3, r8, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	pkhbt r6, r7, r8, lsl #16
	pkhtb r7, r8, r7, asr #16
	str.w r6, [r0, #4]
	str.w r4, [r0], #8
	str.w r7, [r2, #4]
	str.w r5, [r2], #8
	cmp.w r1, lr
	bne.w Encode_Rq_asm_radix5167
	ldrh.w r5, [r1]
	sadd16 r5, r5, r12
	strh.w r5, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 2
@ len = 429
@ tail radix = 5167
	mov.w r3, #408
	add.w lr, r1, #832
Encode_Rq_asm_radix408:
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r9, [r1, #20]
	ldr.w r10, [r1, #24]
	ldr.w r11, [r1, #28]
	ldr.w r4, [r1], #32
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	sxth r12, r9
	smlabt r9, r3, r9, r12
	sxth r12, r10
	smlabt r10, r3, r10, r12
	sxth r12, r11
	smlabt r11, r3, r11, r12
	bfi r12, r8, #0, #8
	bfi r12, r9, #8, #8
	bfi r12, r10, #16, #8
	bfi r12, r11, #24, #8
	lsr.w r10, #8
	pkhbt r11, r10, r11, lsl #8
	lsr.w r8, #8
	pkhbt r10, r8, r9, lsl #8
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r12, [r0, #4]
	str.w r9, [r0], #8
	str.w r8, [r2, #4]
	str.w r10, [r2, #8]
	str.w r11, [r2, #12]
	str.w r7, [r2], #16
	cmp.w r1, lr
	bne.w Encode_Rq_asm_radix408
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r4, [r1], #16
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r9, [r0], #4
	str.w r8, [r2, #4]
	str.w r7, [r2], #8
	ldr.w r5, [r1, #4]
	ldr.w r4, [r1], #8
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	lsr.w r4, #8
	pkhbt r4, r4, r5, lsl #8
	strh.w r9, [r0], #2
	str.w r4, [r2], #4
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 3
@ len = 215
@ tail radix = 5167
	mov.w r3, #651
	add.w lr, r1, #416
Encode_Rq_asm_radix651:
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r9, [r1, #20]
	ldr.w r10, [r1, #24]
	ldr.w r11, [r1, #28]
	ldr.w r4, [r1], #32
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	sxth r12, r9
	smlabt r9, r3, r9, r12
	sxth r12, r10
	smlabt r10, r3, r10, r12
	sxth r12, r11
	smlabt r11, r3, r11, r12
	bfi r12, r8, #0, #8
	bfi r12, r9, #8, #8
	bfi r12, r10, #16, #8
	bfi r12, r11, #24, #8
	lsr.w r10, #8
	pkhbt r11, r10, r11, lsl #8
	lsr.w r8, #8
	pkhbt r10, r8, r9, lsl #8
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r12, [r0, #4]
	str.w r9, [r0], #8
	str.w r8, [r2, #4]
	str.w r10, [r2, #8]
	str.w r11, [r2, #12]
	str.w r7, [r2], #16
	cmp.w r1, lr
	bne.w Encode_Rq_asm_radix651
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r4, [r1], #12
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	lsr.w r4, #8
	pkhbt r4, r4, r5, lsl #8
	ubfx r7, r6, #8, #16
	strh.w r9, [r0], #2
	strb.w r6, [r0], #1
	str.w r4, [r2], #4
	strh.w r7, [r2], #2
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 4
@ len = 108
@ tail radix = 5167
	mov.w r3, #1656
	add.w lr, r1, #192
Encode_Rq_asm_radix1656:
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r9, [r1, #20]
	ldr.w r10, [r1, #24]
	ldr.w r11, [r1, #28]
	ldr.w r4, [r1], #32
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	sxth r12, r9
	smlabt r9, r3, r9, r12
	sxth r12, r10
	smlabt r10, r3, r10, r12
	sxth r12, r11
	smlabt r11, r3, r11, r12
	bfi r12, r8, #0, #8
	bfi r12, r9, #8, #8
	bfi r12, r10, #16, #8
	bfi r12, r11, #24, #8
	lsr.w r10, #8
	pkhbt r11, r10, r11, lsl #8
	lsr.w r8, #8
	pkhbt r10, r8, r9, lsl #8
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r12, [r0, #4]
	str.w r9, [r0], #8
	str.w r8, [r2, #4]
	str.w r10, [r2, #8]
	str.w r11, [r2, #12]
	str.w r7, [r2], #16
	cmp.w r1, lr
	bne.w Encode_Rq_asm_radix1656
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r4, [r1], #16
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r9, [r0], #4
	str.w r8, [r2, #4]
	str.w r7, [r2], #8
	ldr.w r4, [r1], #4
	sxth r12, r4
	smlabt r4, r3, r4, r12
	ubfx r5, r4, #8, #16
	strb.w r4, [r0], #1
	strh.w r5, [r2], #2
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #16, #16
	strh.w r5, [r0], #2
	strh.w r6, [r2], #2
	vmov r1, s1
	vmov r2, s1
@ iteration 5
@ len = 54
@ tail radix = 131
	mov.w r3, #10713
	add.w lr, r1, #96
Encode_Rq_asm_radix10713:
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r5, [r1], #16
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	sxth r9, r7
	smlabt r7, r3, r7, r9
	sxth r9, r8
	smlabt r8, r3, r8, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	pkhbt r6, r7, r8, lsl #16
	pkhtb r7, r8, r7, asr #16
	str.w r6, [r0, #4]
	str.w r4, [r0], #8
	str.w r7, [r2, #4]
	str.w r5, [r2], #8
	cmp.w r1, lr
	bne.w Encode_Rq_asm_radix10713
	ldr.w r6, [r1, #4]
	ldr.w r5, [r1], #8
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	str.w r4, [r0], #4
	str.w r5, [r2], #4
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #8, #16
	strb.w r5, [r0], #1
	strh.w r6, [r2], #2
	vmov r1, s1
	vmov r2, s1
@ iteration 6
@ len = 27
@ tail radix = 5483
	mov.w r3, #1752
	add.w lr, r1, #32
Encode_Rq_asm_radix1752:
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r9, [r1, #20]
	ldr.w r10, [r1, #24]
	ldr.w r11, [r1, #28]
	ldr.w r4, [r1], #32
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	sxth r12, r9
	smlabt r9, r3, r9, r12
	sxth r12, r10
	smlabt r10, r3, r10, r12
	sxth r12, r11
	smlabt r11, r3, r11, r12
	bfi r12, r8, #0, #8
	bfi r12, r9, #8, #8
	bfi r12, r10, #16, #8
	bfi r12, r11, #24, #8
	lsr.w r10, #8
	pkhbt r11, r10, r11, lsl #8
	lsr.w r8, #8
	pkhbt r10, r8, r9, lsl #8
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r12, [r0, #4]
	str.w r9, [r0], #8
	str.w r8, [r2, #4]
	str.w r10, [r2, #8]
	str.w r11, [r2, #12]
	str.w r7, [r2], #16
	cmp.w r1, lr
	bne.w Encode_Rq_asm_radix1752
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r4, [r1], #16
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r9, [r0], #4
	str.w r8, [r2, #4]
	str.w r7, [r2], #8
	ldr.w r4, [r1], #4
	sxth r12, r4
	smlabt r4, r3, r4, r12
	ubfx r5, r4, #8, #16
	strb.w r4, [r0], #1
	strh.w r5, [r2], #2
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 7
@ len = 14
@ tail radix = 5483
	mov.w r3, #11991
	ldr.w r5, [r1, #4]
	ldr.w r4, [r1], #8
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	pkhbt r6, r4, r5, lsl #16
	pkhtb r7, r5, r4, asr #16
	str.w r6, [r0], #4
	str.w r7, [r2], #4
	ldr.w r5, [r1, #4]
	ldr.w r4, [r1], #8
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	pkhbt r6, r4, r5, lsl #16
	pkhtb r7, r5, r4, asr #16
	str.w r6, [r0], #4
	str.w r7, [r2], #4
	ldr.w r5, [r1, #4]
	ldr.w r4, [r1], #8
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	pkhbt r6, r4, r5, lsl #16
	pkhtb r7, r5, r4, asr #16
	str.w r6, [r0], #4
	str.w r7, [r2], #4
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #16, #16
	strh.w r5, [r0], #2
	strh.w r6, [r2], #2
	vmov r1, s1
	vmov r2, s1
@ iteration 8
@ len = 7
@ tail radix = 1004
	mov.w r3, #2194
	ldr.w r5, [r1, #4]
	ldr.w r4, [r1], #8
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	pkhbt r6, r4, r5, lsl #16
	pkhtb r7, r5, r4, asr #16
	str.w r6, [r0], #4
	str.w r7, [r2], #4
	ldr.w r4, [r1], #4
	sxth r12, r4
	smlabt r4, r3, r4, r12
	ubfx r5, r4, #16, #16
	strh.w r4, [r0], #2
	strh.w r5, [r2], #2
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 9
@ len = 4
@ tail radix = 1004
	mov.w r3, #74
	ldr.w r4, [r1], #4
	sxth r12, r4
	smlabt r4, r3, r4, r12
	strh.w r4, [r2], #2
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #8, #16
	strb.w r5, [r0], #1
	strh.w r6, [r2], #2
@ len == 2
@ tail radix = 291
	vmov.w r1, s1
	vmov.w r2, s1
	mov.w r3, #5476
	ldr.w r4, [r1], #4
	sxth r9, r4
	smlabt r4, r3, r4, r9
	ubfx r5, r4, #8, #16
	strb.w r4, [r0], #1
	strh.w r5, [r2], #2
@ len == 1
	vmov.w r1, s1
	ldrh.w r2, [r1]
	strh.w r2, [r0]
	pop {r2-r12, pc}

.p2align 2,,3
.syntax unified
.text
.global Encode_Rounded_asm
.type Encode_Rounded_asm, %function
Encode_Rounded_asm:
	push {r2-r12, lr}
	vmov.w s1, r1 @ input
	movw.w r12, #2583
	movt.w r12, #2583
	movw.w r11, #0x5556
	movt.w r11, #0x5555
	vmov.w r2, s1
@ iteration 1
@ len = 857
@ tail radix = 1723
	add.w lr, r1, #1712
	mov.w r3, #1723
Encode_Rounded_asm_radix1723:
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r5, [r1], #16
	sadd16 r5, r5, r12
	sadd16 r6, r6, r12
	sadd16 r7, r7, r12
	sadd16 r8, r8, r12
	smulwb r4, r11, r5
	smulwt r5, r11, r5
	lsr.w r4, #16
	smlabt r5, r3, r5, r4
	smulwb r4, r11, r6
	smulwt r6, r11, r6
	lsr.w r4, #16
	smlabt r6, r3, r6, r4
	smulwb r4, r11, r7
	smulwt r7, r11, r7
	lsr.w r4, #16
	smlabt r7, r3, r7, r4
	smulwb r4, r11, r8
	smulwt r8, r11, r8
	lsr.w r4, #16
	smlabt r8, r3, r8, r4
	bfi.w r4, r5, #0, #8
	bfi.w r4, r6, #8, #8
	bfi.w r4, r7, #16, #8
	bfi.w r4, r8, #24, #8
	lsr.w r5, #8
	pkhbt r5, r5, r6, lsl #8
	lsr.w r7, #8
	pkhbt r6, r7, r8, lsl #8
	str.w r4, [r0], #4
	str.w r6, [r2, #4]
	str.w r5, [r2], #8
	cmp.w r1, lr
	bne.w Encode_Rounded_asm_radix1723
	ldrh.w r5, [r1]
	sadd16 r5, r5, r12
	smulwb r5, r11, r5
	lsr.w r5, #16
	strh.w r5, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 2
@ len = 429
@ tail radix = 1723
	mov.w r3, #11597
	add.w lr, r1, #848
Encode_Rounded_asm_radix11597:
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r5, [r1], #16
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	sxth r9, r7
	smlabt r7, r3, r7, r9
	sxth r9, r8
	smlabt r8, r3, r8, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	pkhbt r6, r7, r8, lsl #16
	pkhtb r7, r8, r7, asr #16
	str.w r6, [r0, #4]
	str.w r4, [r0], #8
	str.w r7, [r2, #4]
	str.w r5, [r2], #8
	cmp.w r1, lr
	bne.w Encode_Rounded_asm_radix11597
	ldr.w r6, [r1, #4]
	ldr.w r5, [r1], #8
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	str.w r4, [r0], #4
	str.w r5, [r2], #4
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 3
@ len = 215
@ tail radix = 1723
	mov.w r3, #2053
	add.w lr, r1, #416
Encode_Rounded_asm_radix2053:
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r5, [r1], #16
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	sxth r9, r7
	smlabt r7, r3, r7, r9
	sxth r9, r8
	smlabt r8, r3, r8, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	pkhbt r6, r7, r8, lsl #16
	pkhtb r7, r8, r7, asr #16
	str.w r6, [r0, #4]
	str.w r4, [r0], #8
	str.w r7, [r2, #4]
	str.w r5, [r2], #8
	cmp.w r1, lr
	bne.w Encode_Rounded_asm_radix2053
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r5, [r1], #12
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	sxth r9, r7
	smlabt r7, r3, r7, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	ubfx r6, r7, #0, #16
	ubfx r7, r7, #16, #16
	strh.w r6, [r0, #4]
	str.w r4, [r0], #6
	strh.w r7, [r2, #4]
	str.w r5, [r2], #6
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 4
@ len = 108
@ tail radix = 1723
	mov.w r3, #65
	add.w lr, r1, #192
Encode_Rounded_asm_radix65:
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r9, [r1, #20]
	ldr.w r10, [r1, #24]
	ldr.w r11, [r1, #28]
	ldr.w r4, [r1], #32
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	sxth r12, r9
	smlabt r9, r3, r9, r12
	sxth r12, r10
	smlabt r10, r3, r10, r12
	sxth r12, r11
	smlabt r11, r3, r11, r12
	pkhbt r12, r10, r11, lsl #16
	pkhbt r11, r8, r9, lsl #16
	pkhbt r10, r6, r7, lsl #16
	pkhbt r9, r4, r5, lsl #16
	str.w r10, [r2, #4]
	str.w r11, [r2, #8]
	str.w r12, [r2, #12]
	str.w r9, [r2], #16
	cmp.w r1, lr
	bne.w Encode_Rounded_asm_radix65
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r4, [r1], #20
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	pkhbt r4, r4, r5, lsl #16
	pkhbt r5, r6, r7, lsl #16
	str.w r4, [r2], #4
	str.w r5, [r2], #4
	strh.w r8, [r2], #2
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #8, #16
	strb.w r5, [r0], #1
	strh.w r6, [r2], #2
	vmov r1, s1
	vmov r2, s1
@ iteration 5
@ len = 54
@ tail radix = 438
	mov.w r3, #4225
	add.w lr, r1, #96
Encode_Rounded_asm_radix4225:
	ldr.w r6, [r1, #4]
	ldr.w r7, [r1, #8]
	ldr.w r8, [r1, #12]
	ldr.w r5, [r1], #16
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	sxth r9, r7
	smlabt r7, r3, r7, r9
	sxth r9, r8
	smlabt r8, r3, r8, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	pkhbt r6, r7, r8, lsl #16
	pkhtb r7, r8, r7, asr #16
	str.w r6, [r0, #4]
	str.w r4, [r0], #8
	str.w r7, [r2, #4]
	str.w r5, [r2], #8
	cmp.w r1, lr
	bne.w Encode_Rounded_asm_radix4225
	ldr.w r6, [r1, #4]
	ldr.w r5, [r1], #8
	sxth r9, r5
	smlabt r5, r3, r5, r9
	sxth r9, r6
	smlabt r6, r3, r6, r9
	pkhbt r4, r5, r6, lsl #16
	pkhtb r5, r6, r5, asr #16
	str.w r4, [r0], #4
	str.w r5, [r2], #4
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #8, #16
	strb.w r5, [r0], #1
	strh.w r6, [r2], #2
	vmov r1, s1
	vmov r2, s1
@ iteration 6
@ len = 27
@ tail radix = 7229
	mov.w r3, #273
	add.w lr, r1, #32
Encode_Rounded_asm_radix273:
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r8, [r1, #16]
	ldr.w r9, [r1, #20]
	ldr.w r10, [r1, #24]
	ldr.w r11, [r1, #28]
	ldr.w r4, [r1], #32
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	sxth r12, r8
	smlabt r8, r3, r8, r12
	sxth r12, r9
	smlabt r9, r3, r9, r12
	sxth r12, r10
	smlabt r10, r3, r10, r12
	sxth r12, r11
	smlabt r11, r3, r11, r12
	bfi r12, r8, #0, #8
	bfi r12, r9, #8, #8
	bfi r12, r10, #16, #8
	bfi r12, r11, #24, #8
	lsr.w r10, #8
	pkhbt r11, r10, r11, lsl #8
	lsr.w r8, #8
	pkhbt r10, r8, r9, lsl #8
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r12, [r0, #4]
	str.w r9, [r0], #8
	str.w r8, [r2, #4]
	str.w r10, [r2, #8]
	str.w r11, [r2, #12]
	str.w r7, [r2], #16
	cmp.w r1, lr
	bne.w Encode_Rounded_asm_radix273
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r4, [r1], #16
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r9, [r0], #4
	str.w r8, [r2, #4]
	str.w r7, [r2], #8
	ldr.w r4, [r1], #4
	sxth r12, r4
	smlabt r4, r3, r4, r12
	ubfx r5, r4, #8, #16
	strb.w r4, [r0], #1
	strh.w r5, [r2], #2
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 7
@ len = 14
@ tail radix = 7229
	mov.w r3, #292
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r7, [r1, #12]
	ldr.w r4, [r1], #16
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	sxth r12, r7
	smlabt r7, r3, r7, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	bfi r9, r6, #16, #8
	bfi r9, r7, #24, #8
	lsr.w r6, #8
	pkhbt r8, r6, r7, lsl #8
	lsr.w r4, #8
	pkhbt r7, r4, r5, lsl #8
	str.w r9, [r0], #4
	str.w r8, [r2, #4]
	str.w r7, [r2], #8
	ldr.w r5, [r1, #4]
	ldr.w r4, [r1], #8
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	lsr.w r4, #8
	pkhbt r4, r4, r5, lsl #8
	strh.w r9, [r0], #2
	str.w r4, [r2], #4
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #8, #16
	strb.w r5, [r0], #1
	strh.w r6, [r2], #2
	vmov r1, s1
	vmov r2, s1
@ iteration 8
@ len = 7
@ tail radix = 8246
	mov.w r3, #334
	ldr.w r5, [r1, #4]
	ldr.w r6, [r1, #8]
	ldr.w r4, [r1], #12
	sxth r12, r4
	smlabt r4, r3, r4, r12
	sxth r12, r5
	smlabt r5, r3, r5, r12
	sxth r12, r6
	smlabt r6, r3, r6, r12
	bfi r9, r4, #0, #8
	bfi r9, r5, #8, #8
	lsr.w r4, #8
	pkhbt r4, r4, r5, lsl #8
	ubfx r7, r6, #8, #16
	strh.w r9, [r0], #2
	strb.w r6, [r0], #1
	str.w r4, [r2], #4
	strh.w r7, [r2], #2
	ldrh.w r4, [r1]
	strh.w r4, [r2]
	vmov r1, s1
	vmov r2, s1
@ iteration 9
@ len = 4
@ tail radix = 8246
	mov.w r3, #436
	ldr.w r4, [r1], #4
	sxth r12, r4
	smlabt r4, r3, r4, r12
	ubfx r5, r4, #8, #16
	strb.w r4, [r0], #1
	strh.w r5, [r2], #2
	ldr.w r5, [r1], #4
	sxth r9, r5
	smlabt r5, r3, r5, r9
	ubfx r6, r5, #8, #16
	strb.w r5, [r0], #1
	strh.w r6, [r2], #2
@ len == 2
@ tail radix = 14044
	vmov.w r1, s1
	vmov.w r2, s1
	mov.w r3, #743
	ldr.w r4, [r1], #4
	sxth r9, r4
	smlabt r4, r3, r4, r9
	ubfx r5, r4, #16, #16
	strh.w r4, [r0], #2
	strh.w r5, [r2], #2
@ len == 1
	vmov.w r1, s1
	ldrh.w r2, [r1]
	strb.w r2, [r0]
	pop {r2-r12, pc}

