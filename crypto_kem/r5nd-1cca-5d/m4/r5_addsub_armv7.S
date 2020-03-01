//	r5_addsub_armv7.S
//	2019-03-07	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2019, PQShield Ltd. All rights reserved.

#ifdef ARMV7_ASM

.text
.syntax unified
.thumb

/*
	void r5_armv7_addsub16(uint16_t *dst, size_t n,
		const uint16_t *p_add, const uint16_t *p_sub);
*/

.global r5_armv7_addsub16
.type	r5_armv7_addsub16, %function

r5_armv7_addsub16:
		push	{r4, r5}
		add		r1, r0, r1, lsl #1
		sub		r1, r1, #8

unr1a:	ldr		r4, [r0]				// unroll 1
		ldr		r5, [r2], #4
		uadd16	r4, r4, r5
		ldr		r5, [r3], #4
		usub16	r4, r4, r5
		str		r4, [r0], #4

		ldr		r4, [r0]				// unroll 2
		ldr		r5, [r2], #4
		uadd16	r4, r4, r5
		ldr		r5, [r3], #4
		usub16	r4, r4, r5
		str		r4, [r0], #4

		cmp		r0, r1
		bcc		unr1a

		add		r1, r1, #8				// remainder

rem1a:	ldrh	r4, [r0]
		ldrh	r5, [r2], #2
		add		r4, r4, r5
		ldrh	r5, [r3], #2
		sub		r4, r4, r5
		strh	r4, [r0], #2

		cmp		r0, r1
		bcc		rem1a

		pop		{r4, r5}
		bx		lr

		.size	r5_armv7_addsub16, .-r5_armv7_addsub16


/*
	void r5_armv7_addsub8(uint8_t *dst, size_t n,
		const uint8_t *p_add, const uint8_t *p_sub);
*/

.global r5_armv7_addsub8
.type	r5_armv7_addsub8, %function

r5_armv7_addsub8:
		push	{r4, r5}
		add		r1, r0, r1
		sub		r1, r1, #8

unr1b:	ldr		r4, [r0]				// unroll 1
		ldr		r5, [r2], #4
		uadd8	r4, r4, r5
		ldr		r5, [r3], #4
		usub8	r4, r4, r5
		str		r4, [r0], #4

		ldr		r4, [r0]				// unroll 2
		ldr		r5, [r2], #4
		uadd8	r4, r4, r5
		ldr		r5, [r3], #4
		usub8	r4, r4, r5
		str		r4, [r0], #4

		cmp		r0, r1
		bcc		unr1b

		add		r1, r1, #8				// remainder

rem1b:	ldrb	r4, [r0]
		ldrb	r5, [r2], #1
		add		r4, r4, r5
		ldrb	r5, [r3], #1
		sub		r4, r4, r5
		strb	r4, [r0], #1

		cmp		r0, r1
		bcc		rem1b

		pop		{r4, r5}
		bx		lr

		.size	r5_armv7_addsub8, .-r5_armv7_addsub8


/*
	void r5_armv7_addsub16_3(uint16_t *dst, size_t n,
		const uint16_t *p_add1, const uint16_t *p_sub1,
		const uint16_t *p_add2, const uint16_t *p_sub2,
		const uint16_t *p_add3, const uint16_t *p_sub3);
*/

.global r5_armv7_addsub16_3
.type	r5_armv7_addsub16_3, %function

r5_armv7_addsub16_3:

		push	{r4, r6, r7, r8, lr}

		add		r1, r0, r1, lsl #1

		ldr		lr, [sp, #20]
		ldr		ip, [sp, #24]
		ldr		r7, [sp, #28]
		ldr		r6, [sp, #32]

		sub		r1, r1, #8

unr2:	ldr		r4, [r0]				// unroll 1
		ldr		r8, [r2], #4
		uadd16	r4, r4, r8
		ldr		r8, [r3], #4
		usub16	r4, r4, r8
		ldr		r8, [lr], #4
		uadd16	r4, r4, r8
		ldr		r8, [ip], #4
		usub16	r4, r4, r8
		ldr		r8, [r7], #4
		uadd16	r4, r4, r8
		ldr		r8, [r6], #4
		usub16	r4, r4, r8
		str		r4, [r0], #4

		ldr		r4, [r0]				// unroll 2
		ldr		r8, [r2], #4
		uadd16	r4, r4, r8
		ldr		r8, [r3], #4
		usub16	r4, r4, r8
		ldr		r8, [lr], #4
		uadd16	r4, r4, r8
		ldr		r8, [ip], #4
		usub16	r4, r4, r8
		ldr		r8, [r7], #4
		uadd16	r4, r4, r8
		ldr		r8, [r6], #4
		usub16	r4, r4, r8
		str		r4, [r0], #4

		cmp		r0, r1
		bcc		unr2

		add		r1, r1, #8				// remainder

rem2:	ldrh	r4, [r0]
		ldrh	r8, [r2], #2
		add		r4, r4, r8
		ldrh	r8, [r3], #2
		sub		r4, r4, r8
		ldrh	r8, [lr], #2
		add		r4, r4, r8
		ldrh	r8, [ip], #2
		sub		r4, r4, r8
		ldrh	r8, [r7], #2
		add		r4, r4, r8
		ldrh	r8, [r6], #2
		sub		r4, r4, r8
		strh	r4, [r0], #2

		cmp		r0, r1
		bcc		rem2

		pop		{r4, r6, r7, r8, pc}

		.size	r5_armv7_addsub16_3, .-r5_armv7_addsub16_3

/*
void r5_armv7_addsub16_perm(modq_t *dst, size_t n, size_t m,
	const uint16_t *perm,
	const uint16_t *p_add, const uint16_t *p_sub);
*/

.global r5_armv7_addsub16_perm
.type	r5_armv7_addsub16_perm, %function

r5_armv7_addsub16_perm:

		push	{r4, r5, r6}
		ldrd	r5, ip, [sp, #12]

		add		r1, r3, r1, lsl #1
		lsl		r2, r2, #1

loop3:	ldrh	r6, [r3], #2
		ldrh	r4, [r5, r6, lsl #1]
		ldrh	r6, [ip, r6, lsl #1]
		sub		r4, r4, r6
		ldrh	r6, [r0]
		add		r4, r4, r6
		strh	r4, [r0]

		add		r0, r0, r2
		cmp		r3, r1
		bne		loop3

		pop		{r4, r5, r6}
		bx		lr

		.size	r5_armv7_addsub16_perm, .-r5_armv7_addsub16_perm

/*
	void r5_armv7_addsub16_perm_3(modq_t *dst, size_t n, size_t m,
		const uint16_t *perm,
		const uint16_t *p_add1, const uint16_t *p_sub1,
		const uint16_t *p_add2, const uint16_t *p_sub2,
		const uint16_t *p_add3, const uint16_t *p_sub3);
*/

.global r5_armv7_addsub16_perm_3
.type	r5_armv7_addsub16_perm_3, %function

r5_armv7_addsub16_perm_3:

		push	{r4, r5, r6, r7, r8, r9, r10, lr}

		ldrd	r7, r8,	 [sp, #32]
		ldrd	r9, r10, [sp, #40]
		ldrd	ip, lr,	 [sp, #48]

		add		r1, r3, r1, lsl #1

loop4:	ldrh	r5, [r3], #2

		ldrh	r4, [r0]

		ldrh	r6, [r7, r5, lsl #1]
		add		r4, r4, r6
		ldrh	r6, [r8, r5, lsl #1]
		sub		r4, r4, r6
		ldrh	r6, [r9, r5, lsl #1]
		add		r4, r4, r6
		ldrh	r6, [r10, r5, lsl #1]
		sub		r4, r4, r6
		ldrh	r6, [ip, r5, lsl #1]
		add		r4, r4, r6
		ldrh	r6, [lr, r5, lsl #1]
		sub		r4, r4, r6

		strh	r4, [r0]
		add		r0, r0, r2, lsl #1

		cmp		r1, r3
		bne		loop4

		pop		{r4, r5, r6, r7, r8, r9, r10, pc}

.size	r5_armv7_addsub16_perm_3, .-r5_armv7_addsub16_perm_3

#endif /* ARMV7_ASM */

