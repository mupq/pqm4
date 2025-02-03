	.syntax	unified
	.cpu	cortex-m4
	.file	"mq_cm4.s"
	.text

	.equ	Q, 12289

@ =======================================================================
@ size_t fndsa_mqpoly_decode(unsigned logn, const uint8_t *f, uint16_t *h)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_decode
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_decode, %function
fndsa_mqpoly_decode:
	push	{ r4, r5, r6, r7, r8, r10, r11 }

	@ ASSUMPTIONS:
	@  - logn >= 2 (hence, n is a multiple of 4)
	@  - output buffer is 32-bit aligned
	@ We process input by chunks of 7 bytes, to produce 4 values.
	@ TODO: try using chunks of 28 bytes when source is aligned; it
	@ would avoid most unaligned penalties and save 1/8 of reads.

	@ r0 <- n = 2^logn 
	movs	r3, #1
	lsl	r0, r3, r0
	@ r11 <- original source pointer
	mov	r11, r1

	@ r3 <- 0x3FFF:0x3FFF
	movw	r3, 0x3FFF
	movt	r3, 0x3FFF
	@ r10 <- q:q
	movw	r10, #Q
	movt	r10, #Q
	@ r12 <- 0xFFFFFFFF
	@ If any value overflows, then bit 15 or 31 of r12 will be cleared.
	mov	r12, #0xFFFFFFFF

fndsa_mqpoly_decode__L1:
	@ Get next 7-byte value as integer r7:r5 with big-endian
	@ interpretation.
	ldr	r5, [r1], #3
	ldr	r4, [r1], #4
	lsls	r5, #8
	rev	r5, r5
	rev	r4, r4
	@ We assemble the 4 values in r6:r7 (packed 16-bit):
	@ x0: r6<0,13>  <- r5<10,23>
	@ x1: r6<16,19> <- r4<28,31>,  r6<20,29> <- r5<0,9>
	@ x2: r7<0,13>  <- r4<14,27>
	@ x3: r7<16,29> <- r4<0,13>
	ubfx	r6, r5, #10, #14
	bfi	r6, r5, #20, #10
	lsrs	r7, r4, #28
	orr	r6, r6, r7, lsl #16
	lsrs	r7, r4, #14
	bfi	r7, r4, #16, #14
	ands	r6, r3
	ands	r7, r3
	@ Update the overflow mask.
	usub16	r8, r6, r10
	and	r12, r12, r8
	usub16	r8, r7, r10
	and	r12, r12, r8
	@ Store the extracted values.
	strd	r6, r7, [r2], #8
	@ Loop until all values have been decoded.
	subs	r0, #4
	bne	fndsa_mqpoly_decode__L1

	@ Get output value (number of consumed bytes).
	@ Clamp it to 0 on overflow.
	sub	r0, r1, r11
	and	r12, r12, r12, lsl #16
	and	r0, r0, r12, asr #31

	pop	{ r4, r5, r6, r7, r8, r10, r11 }
	bx	lr
	.size	fndsa_mqpoly_decode,.-fndsa_mqpoly_decode

@ =======================================================================
@ size_t fndsa_comp_decode(unsigned logn,
@                          const uint8_t *d, size_t dlen, int16_t *s)
@ =======================================================================

	.align	2
	.global	fndsa_comp_decode
	.thumb
	.thumb_func
	.type	fndsa_comp_decode, %function
fndsa_comp_decode:
	push	{ r4, r5, r6, r7 }

	@ r0 <- n = 2^logn
	movs	r4, #1
	lsl	r0, r4, r0
	@ r2 <- upper bound for d
	adds	r2, r1

	@ r4   acc
	@ r5   acc_ptr
	@ Unprocessed bits are in the top bits of acc. First unprocessed bit
	@ is at index acc_ptr + 8.
	eors	r4, r4
	movs	r5, #24

fndsa_comp_decode__L1:
	@ Invariant: acc_ptr >= 17 (i.e. there are at most 7 unprocessed bits).

	@ Get next 8 bits.
	cmp	r1, r2
	beq	fndsa_comp_decode__Lerr
	ldrb	r6, [r1], #1
	lsls	r6, r5
	orrs	r4, r6

	@ r6 <- low 7 absolute value bits
	@ r12 <- sign (word-extended)
	ubfx	r6, r4, #24, #7
	asr	r12, r4, #31
	lsls	r4, #8

	@ We injected 8 bits then consumed 8 bits: acc_ptr is unmodified.

	@ Locate next bit of value 1. If necessary, read one or two
	@ extra bytes. Heuristically, values are small, so the fast
	@ path is that the extra bit is already there.
	cbz	r4, fndsa_comp_decode__Lzb1
	clz	r7, r4
fndsa_comp_decode__L2:
	@ There are r7 zeros, then a one. r7 <= 15.
	add	r6, r6, r7, lsl #7
	@ Consume the zeros and the final one.
	adds	r7, #1
	lsls	r4, r7
	adds	r5, r7
	@ Mantissa is in r6, sign in r12. Reject "minus zero" encoding,
	@ i.e. r6 = 0 and r12 = -1
	orn	r7, r6, r12
	cbz	r7, fndsa_comp_decode__Lerr
	@ We assemble the value in r6
	eor	r6, r6, r12
	sub	r6, r6, r12
	strh	r6, [r3], #2

	@ Loop until all values have been obtained.
	subs	r0, #1
	bne	fndsa_comp_decode__L1

	@ Check that remaining unused bits are zero (accumulator and
	@ all unused bytes).
	movs	r0, #1
	cbnz	r4, fndsa_comp_decode__Lerr
	cmp	r1, r2
	beq	fndsa_comp_decode__Lexit
fndsa_comp_decode__L3:
	ldrb	r6, [r1], #1
	cbnz	r6, fndsa_comp_decode__Lerr
	cmp	r1, r2
	bne	fndsa_comp_decode__L3
fndsa_comp_decode__Lexit:
	pop	{ r4, r5, r6, r7 }
	bx	lr

fndsa_comp_decode__Lzb1:
	@ All currently buffered bits are zero, we must get an extra byte.
	@ Get next byte.
	cmp	r1, r2
	beq	fndsa_comp_decode__Lerr
	ldrb	r7, [r1], #1
	lsls	r7, r5
	orrs	r4, r7
	cbz	r4, fndsa_comp_decode__Lzb2
	subs	r5, #8
	clz	r7, r4
	b	fndsa_comp_decode__L2

fndsa_comp_decode__Lzb2:
	@ All currently buffered bits are zero, and the next byte was
	@ all-zeros too; we must get another byte.
	cmp	r1, r2
	beq	fndsa_comp_decode__Lerr
	ldrb	r7, [r1], #1
	subs	r5, #8
	lsls	r7, r5
	orrs	r4, r7
	cbz	r4, fndsa_comp_decode__Lerr
	subs	r5, #8
	clz	r7, r4
	@ Since we added two bytes and the accumulator already contained
	@ up to 7 bits, then we may have up to 23 bits at this point,
	@ hence r7 can be up to 22. Values greater than 15 are invalid.
	cmp	r7, #15
	bls	fndsa_comp_decode__L2
	@ Fall through to error sequence.
fndsa_comp_decode__Lerr:
	eors	r0, r0
	b	fndsa_comp_decode__Lexit
	.size	fndsa_comp_decode,.-fndsa_comp_decode
