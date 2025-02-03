	.syntax	unified
	.cpu	cortex-m4
	.file	"mq_cm4.s"
	.text

	.equ	Q, 12289
	.equ	Q1I, 4143984639
	.equ	R, 10952
	.equ	R2, 5664

@ =======================================================================
@ void fndsa_mqpoly_small_to_int(unsigned logn, const int8_t *f, uint16_t *d)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_small_to_int
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_small_to_int, %function
fndsa_mqpoly_small_to_int:
	@ This implementation actually normalizes to [1,q] (strict internal
	@ representation).
	push	{ r4, r5, r6, r7 }
	@ Set r3 to n = 2^logn
	movs	r3, #1
	lsls	r3, r0
	@ Set both halves of r0 to Q
	movw	r0, #Q
	movt	r0, #Q
	@ Set both halves of r7 to 1
	mov	r7, #0x00010001
fndsa_mqpoly_small_to_int__L1:
	@ Get next four source bytes.
	ldr	r5, [r1], #4
	@ Expand bytes to 16-bit each; for each byte whose value is negative
	@ or zero, we need to add Q.
	sxtb16	r4, r5
	sadd16	r6, r4, r0
	ssub16	r12, r4, r7
	sel	r4, r4, r6
	sxtb16	r5, r5, ror #8
	sadd16	r6, r5, r0
	ssub16	r12, r5, r7
	sel	r5, r5, r6
	@ We need to interleave the values to get them in the right order.
	pkhtb	r6, r5, r4, asr #16
	pkhbt	r5, r4, r5, lsl #16
	@ We can use strd because the caller ensured that the output is
	@ aligned.
	strd	r5, r6, [r2], #8
	subs	r3, #4
	bne	fndsa_mqpoly_small_to_int__L1

	pop	{ r4, r5, r6, r7 }
	bx	lr
	.size	fndsa_mqpoly_small_to_int,.-fndsa_mqpoly_small_to_int

@ =======================================================================
@ void fndsa_mqpoly_signed_to_int(unsigned logn, uint16_t *d)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_signed_to_int
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_signed_to_int, %function
fndsa_mqpoly_signed_to_int:
	@ This implementation actually normalizes to [1,q] (strict internal
	@ representation).
	push	{ r4, r5, r6 }
	movs	r3, #1
	lsls	r3, r0
	@ Set both halves of r0 to Q
	movw	r0, #Q
	movt	r0, #Q
	@ Set both halves of r2 to 1
	mov	r2, #0x00010001
fndsa_mqpoly_signed_to_int__L1:
	@ We can use ldrd because the caller ensured that the input is
	@ aligned.
	ldrd	r4, r5, [r1]
	@ For each word half, we want to add q if the value is negative or 0.
	sadd16	r6, r4, r0
	ssub16	r12, r4, r2
	sel	r4, r4, r6
	sadd16	r6, r5, r0
	ssub16	r12, r5, r2
	sel	r5, r5, r6
	strd	r4, r5, [r1], #8
	subs	r3, #4
	bne	fndsa_mqpoly_signed_to_int__L1

	pop	{ r4, r5, r6 }
	bx	lr
	.size	fndsa_mqpoly_signed_to_int,.-fndsa_mqpoly_signed_to_int

@ =======================================================================
@ void fndsa_mqpoly_int_to_ext(unsigned logn, uint16_t *d)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_int_to_ext
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_int_to_ext, %function
fndsa_mqpoly_int_to_ext:
	push.w	{ r4, r5, r6 }
	movs	r3, #1
	lsls	r3, r0
	@ Set both halves of r0 to Q
	movw	r0, #Q
	movt	r0, #Q
	@ Set both halves of r2 to 0xFFFF
	mov	r2, #0xFFFFFFFF
	@ Set r6 to zero
	movw	r6, #0
fndsa_mqpoly_int_to_ext__L1:
	@ We can use ldrd because the caller ensured that the input is
	@ aligned.
	ldrd	r4, r5, [r1]
	@ Each word half equal to q must be set to 0; others are untouched.
	ssub16	r12, r4, r0
	sel	r4, r6, r4
	ssub16	r12, r5, r0
	sel	r5, r6, r5
	strd	r4, r5, [r1], #8
	subs	r3, #4
	bne	fndsa_mqpoly_int_to_ext__L1

	pop	{ r4, r5, r6 }
	bx	lr
	.size	fndsa_mqpoly_int_to_ext,.-fndsa_mqpoly_int_to_ext

@ =======================================================================
@ void fndsa_mqpoly_mul_ntt(unsigned logn, uint16_t *a, const uint16_t *b)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_mul_ntt
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_mul_ntt, %function
fndsa_mqpoly_mul_ntt:
	push.w	{ r4, r5, r6, r7, r8, r10, lr }
	movs	r3, #1
	lsls	r3, r0

	@ r10 <- q
	movw	r10, #Q
	@ r14 <- -1/q mod 2^32
	movw	r14, #(Q1I & 0xFFFF)
	movt	r14, #(Q1I >> 16)
	@ r0 <- 2^64 mod q
	movw	r0, #R2

	@ r12 is a temporary

fndsa_mqpoly_mul_ntt__L1:
	@ A sequence of four ldr is faster than two ldrd or two ldm.
	ldr	r5, [r1]
	ldr	r6, [r1, #4]
	ldr.w	r7, [r2], #4
	ldr.w	r8, [r2], #4

	@ First pair of words (r5 and r7)
	@ Products over integers.
	smulbb	r4, r5, r7
	smultt	r5, r5, r7
	@ Montgomery reduction.
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	@ Conversion Montgomery -> normal
	muls	r4, r0
	muls	r5, r0
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	@ Repack the two output values and write word
	pkhbt	r7, r4, r5, lsl #16
	str.w	r7, [r1], #4

	@ Second pair of words (r6 and r8)
	@ Products over integers.
	smulbb	r4, r6, r8
	smultt	r5, r6, r8
	@ Montgomery reduction.
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	@ Conversion Montgomery -> normal
	muls	r4, r0
	muls	r5, r0
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	@ Repack the two output values and write word
	pkhbt	r8, r4, r5, lsl #16
	str.w	r8, [r1], #4

	@ Store the four output values.
	subs	r3, #4
	bne	fndsa_mqpoly_mul_ntt__L1

	pop	{ r4, r5, r6, r7, r8, r10, pc }
	.size	fndsa_mqpoly_mul_ntt,.-fndsa_mqpoly_mul_ntt

@ =======================================================================
@ void fndsa_mqpoly_sub(unsigned logn, uint16_t *a, const uint16_t *b)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_sub
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_sub, %function
fndsa_mqpoly_sub:
	push.w	{ r4, r5, r6, r7, lr }
	movs	r3, #1
	lsls	r3, r0

	@ r0 <- 0
	movw	r0, #0
	@ r14 <- q (both halves)
	movw	r14, #Q
	movt	r14, #Q

fndsa_mqpoly_sub__L1:
	@ Four ldr are faster than two ldrd or two ldm.
	ldr	r4, [r1]
	ldr	r5, [r1, #4]
	ldr.w	r6, [r2], #4
	ldr.w	r7, [r2], #4

	@ We do the subtraction over the integers, then add q back if
	@ the result is negative.
	ssub16	r4, r4, r6
	sel	r12, r0, r14
	sadd16	r4, r4, r12
	str.w	r4, [r1], #4
	ssub16	r5, r5, r7
	sel	r12, r0, r14
	sadd16	r5, r5, r12
	str.w	r5, [r1], #4

	subs	r3, #4
	bne	fndsa_mqpoly_sub__L1

	pop	{ r4, r5, r6, r7, pc }
	.size	fndsa_mqpoly_sub,.-fndsa_mqpoly_sub

@ =======================================================================
@ uint32_t fndsa_mqpoly_sqnorm_signed(unsigned logn, const uint16_t *a)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_sqnorm_signed
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_sqnorm_signed, %function
fndsa_mqpoly_sqnorm_signed:
	movs	r3, #1
	lsls	r3, r0

	movw	r0, #0
fndsa_mqpoly_sqnorm_signed__L1:
	@ We can use ldrd because the caller ensured that the input is
	@ aligned.
	ldrd	r2, r12, [r1], #8
	smlad	r0, r2, r2, r0
	smlad	r0, r12, r12, r0
	@ The whole operation cannot overflow in unsigned convention,
	@ since signed values are at most 2047 (in absolute value) and
	@ there are at most 1024 of them, hence a maximum squared norm
	@ of 1024*2047*2047 = 4290774016, which fits on 32 bits.
	subs	r3, #4
	bne	fndsa_mqpoly_sqnorm_signed__L1

	bx	lr
	.size	fndsa_mqpoly_sqnorm_signed,.-fndsa_mqpoly_sqnorm_signed

@ =======================================================================
@ uint32_t fndsa_mqpoly_sqnorm_ext(unsigned logn, const uint16_t *a)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_sqnorm_ext
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_sqnorm_ext, %function
fndsa_mqpoly_sqnorm_ext:
	push.w	{ r4, r5, r6, r7 }
	movs	r3, #1
	lsls	r3, r0

	@ r5 <- q (in both halves)
	movw	r5, #Q
	movt	r5, #Q
	@ r6 <- ceil(q/2) (in both halves)
	movw	r6, #((Q + 1) >> 1)
	movt	r6, #((Q + 1) >> 1)

	movw	r0, #0
	@ We clear the Q flag, which we will use to detect overflows.
	msr	APSR_nzcvq, r0
fndsa_mqpoly_sqnorm_ext__L1:
	@ We can use ldrd because the caller ensured that the input is
	@ aligned.
	ldrd	r2, r4, [r1], #8

	@ Normalize values to [-q/2,+q/2]
	ssub16	r7, r2, r5
	ssub16	r12, r2, r6
	sel	r2, r7, r2
	ssub16	r7, r4, r5
	ssub16	r12, r4, r6
	sel	r4, r7, r4
	@ If any addition overflows (signed interpretation), then the Q
	@ flag will be set.
	smlad	r0, r2, r2, r0
	smlad	r0, r4, r4, r0
	subs	r3, #4
	bne	fndsa_mqpoly_sqnorm_ext__L1

	@ If the Q flag is set, saturate the returned value to 0xFFFFFFFF
	mrs	r1, APSR
	sbfx	r1, r1, #27, #1
	orrs	r0, r1

	pop	{ r4, r5, r6, r7 }
	bx	lr
	.size	fndsa_mqpoly_sqnorm_ext,.-fndsa_mqpoly_sqnorm_ext

@ =======================================================================
@ void fndsa_mqpoly_int_to_ntt(unsigned logn, uint16_t *d)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_int_to_ntt
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_int_to_ntt, %function
fndsa_mqpoly_int_to_ntt:
	push.w	{ r4, r5, r6, r7, r8, r10, r11, lr }

	@ ASSUMPTION: logn >= 2

	@ State:
	@   r0    0
	@   r1    &d[j1]
	@   r2    t = ht*2
	@   r3    middle loop counter
	@   r6    s
	@   r7    innermost loop counter
	@   r8    &mq_GM[i + m]
	@   r10   q
	@   r11   q:q
	@   r12   scratch
	@   r14   -1/q mod 2^32
	@
	@   s2    d
	@   s3    m

	vmov	s2, r1         @ original &d[0]
	movs	r2, #1
	lsls	r2, r0         @ r2 <- t = ht*2 (initially equal to n)
	movw	r0, #1         @ m <- 1
	vmov	s3, r0

	@ Constants.
	@ r0 <- 0
	movw	r0, #0
	@ r10 <- q
	movw	r10, #Q
	@ r11 <- q (both halves)
	orr	r11, r10, r10, lsl #16
	@ r14 <- -1/q mod 2^32
	movw	r14, #(Q1I & 0xFFFF)
	movt	r14, #(Q1I >> 16)

	@ r8 <- &mq_GM[1]
	adr	r8, fndsa_mqpoly_int_to_ntt__gmaddr_plus1
	ldr	r8, [r8]

	@ If n = 4, then skip directly to the specialized code for the
	@ last two iterations.
	cmp	r2, #4
	beq	fndsa_mqpoly_int_to_ntt__L4

fndsa_mqpoly_int_to_ntt__L1:
	@ Middle loop has m iterations.
	vmov	r3, s3
	lsl	r6, r3, #1     @ prepare m for next iteration
	vmov	s3, r6
fndsa_mqpoly_int_to_ntt__L2:
	ldrh	r6, [r8], #2   @ s <- mq_GM[i + m]
	lsr	r7, r2, #1     @ r7 <- ht
fndsa_mqpoly_int_to_ntt__L3:
	@ Each inner loop iteration processes two pairs (x1,x2) and (y1,y2).
	ldr.w	r4, [r1, r2]   @ r4 <- x2:y2

	@ r5 <- mmul(y2, s)
	smultb	r5, r4, r6
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	@ r4 <- mmul(x2, s)
	smulbb	r4, r4, r6
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	@ r5 <- x2:y2
	pkhbt	r5, r4, r5, lsl #16

	@ r4 <- x1:y1
	ldr.w	r4, [r1]       @ r4 <- x1:y1

	@ d[j1] <- x1+x2 : y1+y2
	@ d[j2] <- x1-x2 : y1-y2
	sadd16	r12, r4, r5
	ssub16	r5, r4, r5
	sel	r4, r0, r11
	sadd16	r5, r5, r4
	str.w	r5, [r1, r2]
	ssub16	r4, r12, r11
	sel	r4, r4, r12
	str.w	r4, [r1], #4

	@ loop ht/2 times
	subs	r7, #2
	bne	fndsa_mqpoly_int_to_ntt__L3

	@ ---------------------------

	@ j0 <- j0 + t
	@ j0 is implicit in r1, which has been increased for ht elements,
	@ hence we add ht here (ht*2, since elements are 2-byte values)
	add.w	r1, r1, r2
	@ We loop m times
	subs	r3, #1
	bne	fndsa_mqpoly_int_to_ntt__L2

	@ r1 now contains &d[n], we must reset it to &d[0] for the next
	@ iteration.
	vmov	r1, s2

	@ replace t with ht
	@ Loop until t reaches 2
	lsr	r2, r2, #1
	cmp	r2, #4
	bne	fndsa_mqpoly_int_to_ntt__L1

fndsa_mqpoly_int_to_ntt__L4:
	@ Last two outer iterations use specialized code.
	@   m = n/4
	@   t = 4
	@ We do n/4 inner iterations, each processing four consecutive values.

	@ Loop counter (m = n/4).
	vmov	r3, s3

	@ We need two pointers to read s values; we use r8 and r7.
	@ At this point, r8 is correct (&mq_GM[m]) and we set r7 to
	@ &mq_GM[2*m] by adding 2*m (in bytes) to r8.
	add	r7, r8, r3, lsl #1

	@ r2 is free, since we know it contains 4.

fndsa_mqpoly_int_to_ntt__L5:
	@ Next-to-last outer iteration: the four values are, in RAM order:
	@   x1 y1 x2 y2
	@ We load x2:y2 (into r5) and s (into r6)
	ldr.w	r5, [r1, #4]
	ldrh	r6, [r8], #2

	@ r4 <- mmul(x2, s)
	smulbb	r4, r5, r6
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	@ r5 <- mmul(y2, s)
	smultb	r5, r5, r6
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	@ r5 <- mmul(x2, s) : mmul(y2, s)
	pkhbt	r5, r4, r5, lsl #16

	@ Load x1:y1 (into r4)
	ldr.w	r4, [r1]

	@ r4 <- (x1+mmul(x2,s)):(y1+mmul(y2,s))
	@ r5 <- (x1-mmul(x2,s)):(y1-mmul(y2,s))
	sadd16	r12, r4, r5
	ssub16	r5, r4, r5
	sel	r4, r0, r11
	sadd16	r5, r5, r4
	ssub16	r4, r12, r11
	sel	r4, r4, r12

	@ Last iteration: the four values are, in RAM order: x1 x2 y1 y2
	@ The values have not been really written to RAM, though; they
	@ are in r4 (x1:x2) and r5 (y1:y2).
	@ Get the two relevant s values into r6.
	ldr	r6, [r7], #4

	@ r2 <- x1:y1
	pkhbt	r2, r4, r5, lsl #16
	@ r5 <- mmul(x2,s):mmul(y2,s)
	smultb	r4, r4, r6
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	smultt	r5, r5, r6
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	pkhbt	r5, r4, r5, lsl #16
	@ r4 <- (x1+mmul(x2,s):(y1+mmul(y2,s))
	sadd16	r4, r2, r5
	ssub16	r12, r4, r11
	sel	r4, r12, r4
	@ r5 <- (x1-mmul(x2,s):(y1-mmul(y2,s))
	ssub16	r5, r2, r5
	sel	r12, r0, r11
	sadd16	r5, r5, r12

	@ We write the four final values in x1 x2 y1 y2 order.
	pkhbt	r12, r4, r5, lsl #16
	str.w	r12, [r1], #4
	pkhtb	r12, r5, r4, asr #16
	str.w	r12, [r1], #4

	subs	r3, #1
	bne	fndsa_mqpoly_int_to_ntt__L5

fndsa_mqpoly_int_to_ntt__Lend:
	pop	{ r4, r5, r6, r7, r8, r10, r11, pc }
	.align	2
fndsa_mqpoly_int_to_ntt__gmaddr_plus1:
	.word	fndsa_mq_GM + 2
	.size	fndsa_mqpoly_int_to_ntt,.-fndsa_mqpoly_int_to_ntt

@ =======================================================================
@ void fndsa_mqpoly_ntt_to_int(unsigned logn, uint16_t *d)
@ =======================================================================

	.align	2
	.global	fndsa_mqpoly_ntt_to_int
	.thumb
	.thumb_func
	.type	fndsa_mqpoly_ntt_to_int, %function
fndsa_mqpoly_ntt_to_int:
	push.w	{ r4, r5, r6, r7, r8, r10, r11, lr }

	@ ASSUMPTION: logn >= 2

	@ State:
	@   r0    scratch
	@   r1    &d[j1]
	@   r2    dt = 2*t
	@   r3    middle loop counter
	@   r4    x1
	@   r5    x2
	@   r6    s
	@   r7    innermost loop counter
	@   r8    &mq_GM[i + hm]
	@   r10   q
	@   r11   q:q
	@   r12   scratch
	@   r14   -1/q mod 2^32
	@
	@   s2    d
	@   s3    m

	@ We save the original d in s2.
	vmov	s2, r1
	@ m = n initially; we save m/2 to s3, and set r8 to &mq_iGM[m/2]
	adr	r8, fndsa_mqpoly_ntt_to_int__igmaddr
	ldr	r8, [r8]
	movs	r3, #1
	subs	r0, #1
	lsl	r0, r3, r0     @ r0 <- n/2 = 2^(logn-1)
	add.w	r8, r8, r0     @ r8 <- &mq_iGM[n/4]
	lsr	r3, r0, #1
	vmov	s3, r3         @ s3 <- n/4

	@ r0 <- 0
	movw	r0, #0
	@ r10 <- q
	movw	r10, #Q
	@ r11 <- q:q
	orr	r11, r10, r10, lsl #16
	@ r14 <- -1/q mod 2^32
	movw	r14, #(Q1I & 0xFFFF)
	movt	r14, #(Q1I >> 16)

	@ r8 is the pointer into mq_GM[] for the second outer iteration.
	@ r7 is the pointer into mq_GM[] for the first outer iteration.
	add	r7, r8, r3, lsl #1

	@ r3 is the loop counter. r10, r11 and r14 are constants used for
	@ modular reduction. r2, r4, r5 and r12 are scratch.

	@ First two iterations are specialized.
fndsa_mqpoly_ntt_to_int__L0:
	@ First iteration: values are in x1 x2 y1 y2 order.
	ldr	r2, [r1]        @ r2 <- x1:x2
	ldr	r5, [r1, #4]    @ r5 <- y1:y2
	ldr.w	r6, [r7], #4    @ r6 <- s1:s2

	@ r4 <- x1:y1
	pkhbt	r4, r2, r5, lsl #16
	@ r5 <- x2:y2
	pkhtb	r5, r5, r2, asr #16
	@ r2 <- (x1+x2)/2:(y1+y2)/2
	sadd16	r2, r4, r5
	ssub16	r12, r2, r11
	sel	r2, r12, r2
	and	r12, r2, #0x00010001
	umlal	r2, r12, r12, r10
	lsr.w	r2, r2, #1
	@ r5 <- (x1-x2):(y1-y2)
	ssub16	r5, r4, r5
	sel	r12, r0, r11
	sadd16	r5, r5, r12
	@ r4 <- mmul(x1-x2,s)
	smulbb	r4, r5, r6
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	@ r5 <- mmul(y1-y2,s)
	smultt	r5, r5, r6
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10

	@ Second iteration. Normally we get x1 y1 x2 y2 from RAM; here,
	@ we have x1:x2 in r2, y1 in r4 and y2 in r5.
	@ Reorganize the values:
	pkhbt	r4, r2, r4, lsl #16   @ r4 <- x1:y1
	lsl.w	r5, r5, #16
	orr	r5, r5, r2, lsr #16   @ r5 <- x2:y2
	@ Read s for the second iteration.
	ldrh	r6, [r8], #2

	@ r2 <- (x1+x2)/2:(y1+y2)/2
	sadd16	r2, r4, r5
	ssub16	r12, r2, r11
	sel	r2, r12, r2
	and	r12, r2, #0x00010001
	umlal	r2, r12, r12, r10
	lsr.w	r2, r2, #1
	@ r5 <- (x1-x2):(y1-y2)
	ssub16	r5, r4, r5
	sel	r12, r0, r11
	sadd16	r5, r5, r12
	@ r4 <- mmul(x1-x2,s)
	smulbb	r4, r5, r6
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	@ r5 <- mmul(y1-y2,s)
	smultb	r5, r5, r6
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10

	@ Repack values, to write them in x1 y1 x2 y2 order.
	str.w	r2, [r1], #4
	pkhbt	r4, r4, r5, lsl #16
	str.w	r4, [r1], #4

	@ Loop n/4 times.
	subs	r3, #1
	bne	fndsa_mqpoly_ntt_to_int__L0

	@ Prepare for remaining iterations.
	@ r2 <- -2*t = -8
	movs	r2, #8
	rsbs	r2, #0
	@ r3 <- m (for next iteration)
	vmov	r3, s3

	@ If logn=2 then m=1 and we are finished.
	cmp	r3, #1
	beq	fndsa_mqpoly_ntt_to_int__Lend

fndsa_mqpoly_ntt_to_int__L1:
	@ Rewind r1 to start of array.
	vmov	r1, s2

	@ m is in r3. r8 was left at &mq_iGM[2*m]; we need to adjust it
	@ to &mq_iGM[m/2], by subtracting 3*m (each element is two bytes).
	sub	r8, r8, r3, lsl #1
	sub.w	r8, r8, r3

	@ Middle loop has m/2 iterations (r3 is used as counter).
fndsa_mqpoly_ntt_to_int__L2:
	ldrh	r6, [r8], #2   @ s <- mq_iGM[i + m/2]

	asrs	r7, r2, #1     @ r7 <- -t
	@ We use r1 to point to the second pair (x2:y2); r2 is negative.
	@ The inner loop will inherently adjust r1 to point to the start
	@ of the next chunk for the next middle loop iteration.
	subs	r1, r1, r2

fndsa_mqpoly_ntt_to_int__L3:
	@ Each inner loop iteration processes two pairs (x1,x2) and (y1,y2).
	ldr	r4, [r1, r2]   @ r4 <- x1:y1
	ldr	r5, [r1]       @ r5 <- x2:y2

	@ r4 <- (x1+x2):(y1+y2)
	@ r5 <- (x1-x2):(y1-x2)
	sadd16	r12, r4, r5
	ssub16	r5, r4, r5
	sel	r4, r0, r11
	sadd16	r5, r5, r4
	ssub16	r4, r12, r11
	sel	r4, r4, r12
	@ r4 <- (x1+x2)/2:(y1+y2)/2
	and	r12, r4, #0x00010001
	umlal	r4, r12, r12, r10
	lsr.w	r4, r4, #1
	@ Write first output word
	str.w	r4, [r1, r2]

	@ r5 <- mmul(x1-x2,s):mmul(y1-y2,s)
	smulbb	r4, r5, r6
	mul	r12, r4, r14
	umaal	r14, r4, r12, r10
	smultb	r5, r5, r6
	mul	r12, r5, r14
	umaal	r14, r5, r12, r10
	pkhbt	r5, r4, r5, lsl #16
	@ Write second output word
	str.w	r5, [r1], #4

	@ We should do t iterations, but since we process a pair of elements
	@ each time, we only do t/2 iterations. Take care that the r7 counter
	@ is negative.
	adds	r7, #2
	bne	fndsa_mqpoly_ntt_to_int__L3

	@ We loop m/2 times
	subs	r3, #2
	bne	fndsa_mqpoly_ntt_to_int__L2

	@ Replace -t with -dt = 2*(-t)
	lsl.w	r2, r2, #1

	@ Replace m with m/2. We are finished when m becomes 1.
	vmov	r3, s3
	lsr.w	r3, r3, #1
	vmov	s3, r3
	cmp	r3, #1
	bne	fndsa_mqpoly_ntt_to_int__L1

fndsa_mqpoly_ntt_to_int__Lend:
	pop	{ r4, r5, r6, r7, r8, r10, r11, pc }
	.align	2
fndsa_mqpoly_ntt_to_int__igmaddr:
	.word	fndsa_mq_iGM
	.size	fndsa_mqpoly_ntt_to_int,.-fndsa_mqpoly_ntt_to_int
