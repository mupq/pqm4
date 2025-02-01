	.syntax	unified
	.cpu	cortex-m4
	.file	"sha3_cm4.s"
	.text

@ =======================================================================
@ void fndsa_sha3_inject_chunk(void *dst, const void *src, size_t len)
@ =======================================================================

	.align	2
	.global	fndsa_sha3_inject_chunk
	.thumb
	.thumb_func
	.type	fndsa_sha3_inject_chunk, %function
fndsa_sha3_inject_chunk:
	push	{ r4, r5 }

	@ If less than 8 bytes to inject, do it byte-by-byte.
	cmp	r2, #8
	blo	fndsa_sha3_inject_chunk__L4

	@ Process some bytes until the destination is aligned.
	rsbs	r5, r0, #0
	ands	r5, r5, #3
	beq	fndsa_sha3_inject_chunk__L2
	subs	r2, r5
fndsa_sha3_inject_chunk__L1:
	ldrb.w	r3, [r0]
	ldrb	r4, [r1], #1
	eor	r3, r3, r4
	strb	r3, [r0], #1
	subs	r5, #1
	bne	fndsa_sha3_inject_chunk__L1

fndsa_sha3_inject_chunk__L2:
	@ Destination is aligned. Source might be unaligned, but the
	@ Cortex-M4 tolerates unaligns accesses with a penalty which is
	@ lower than doing word reassembly in software.
	lsr	r5, r2, #2
fndsa_sha3_inject_chunk__L3:
	ldr.w	r3, [r0]
	ldr	r4, [r1], #4
	eor	r3, r3, r4
	str	r3, [r0], #4
	subs	r5, #1
	bne	fndsa_sha3_inject_chunk__L3

	@ We may have a remaining tail of up to 3 bytes.
	ands	r2, r2, #3
	beq.w	fndsa_sha3_inject_chunk__L5

fndsa_sha3_inject_chunk__L4:
	@ Byte-by-byte processing for the data tail.
	ldrb.w	r3, [r0]
	ldrb	r4, [r1], #1
	eor	r3, r3, r4
	strb	r3, [r0], #1
	subs	r2, #1
	bne	fndsa_sha3_inject_chunk__L4

fndsa_sha3_inject_chunk__L5:
	pop	{ r4, r5 }
	bx	lr
	.size	fndsa_sha3_inject_chunk,.-fndsa_sha3_inject_chunk

@ =======================================================================
@ bit_split_5(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint64_t x4)
@ Split inputs x0 to x4 into even-indexed and odd-indexed bits.
@ Internal function only; non-standard ABI:
@ input:
@    r0:r1    x0
@    r2:r3    x1
@    r4:r5    x2
@    r6:r7    x3
@    r10:r11  x4
@ ASPR.GE flags must have pattern 0110.
@
@ output:
@    r0     even-indexed bits of x0
@    r1     odd-indexed bits of x0
@    r2     even-indexed bits of x1
@    r3     odd-indexed bits of x1
@    r4     even-indexed bits of x2
@    r5     odd-indexed bits of x2
@    r6     even-indexed bits of x3
@    r7     odd-indexed bits of x3
@    r10    even-indexed bits of x4
@    r11    odd-indexed bits of x4
@ clobbers:
@    r8, r14
@
@ bit_split_1, bit_split_2, bit_split_3 and bit_split_4 are alternate
@ entry points that process only the first 1, 2, 3 or 4 words.
@ =======================================================================

	@ This macro splits a word (input register xx) into its
	@ even-indexed bits (into the low half of output register dd)
	@ and odd-indexed bits (high half of dd).
	@ This macro assumes that the ASPR.GE flags have the 0110 pattern.
	@ dd and xx cannot be the same register. xx is consumed.
.macro	BIT_SPLIT_32  xx, dd
	eor	\dd, \xx, \xx, lsr #1
	and	\dd, \dd, #0x22222222
	eor	\xx, \xx, \dd
	eor	\xx, \xx, \dd, lsl #1
	eor	\dd, \xx, \xx, lsr #2
	and	\dd, \dd, #0x0C0C0C0C
	eor	\xx, \xx, \dd
	eor	\xx, \xx, \dd, lsl #2
	eor	\dd, \xx, \xx, lsr #4
	and	\dd, \dd, #0x00F000F0
	eor	\xx, \xx, \dd
	eor	\xx, \xx, \dd, lsl #4
	rev	\dd, \xx
	sel	\dd, \dd, \xx
.endm

	@ Split a 64-bit value x0:x1 into its even-indexed bits (into x0)
	@ and high-indexed bits (into x1). xt is a scratch register.
	@ This macro assumes that the ASPR.GE flags have the 0110 pattern.
.macro	BIT_SPLIT_64  x0, x1, xt
	BIT_SPLIT_32  \x0, \xt
	BIT_SPLIT_32  \x1, \x0
	pkhtb	\x1, \x0, \xt, asr #16
	pkhbt	\x0, \xt, \x0, lsl #16
.endm

	.align	2
	.thumb
	.thumb_func
	.type	bit_split_5, %function
bit_split_5:
	BIT_SPLIT_64	r10, r11, r8
bit_split_4:
	BIT_SPLIT_64	r6,  r7,  r8
bit_split_3:
	BIT_SPLIT_64	r4,  r5,  r8
bit_split_2:
	BIT_SPLIT_64	r2,  r3,  r8
bit_split_1:
	BIT_SPLIT_64	r0,  r1,  r8
	bx	lr
	.size	bit_split_5, .-bit_split_5

@ =======================================================================
@ bit_merge_5(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint64_t x4)
@ Merge inputs x0 to x4 with bit interleaving. For i = 0 to 4, the
@ low word of x_i contains the even-indexed bits, and the high word
@ contains the odd-indexed bits.
@ Internal function only; non-standard ABI:
@ input:
@    r0:r1    x0
@    r2:r3    x1
@    r4:r5    x2
@    r6:r7    x3
@    r10:r11  x4
@ ASPR.GE flags must have pattern 0110.
@
@ output:
@    r0:r1    merged x0
@    r2:r3    merged x1
@    r4:r5    merged x2
@    r6:r7    merged x3
@    r10:r11  merged x4
@ clobbers:
@    r8, r14
@
@ bit_merge_1, bit_merge_2, bit_merge_3 and bit_merge_4 are alternate
@ entry points that process only the first 1, 2, 3 or 4 words.
@ =======================================================================

	@ This macro merges a word (input register xx): low half yields
	@ the even-indexed bits, and hight half provides the odd-indexed
	@ bits. Output is written into register dd.
	@ This macro assumes that the ASPR.GE flags have the 0110 pattern.
	@ dd and xx cannot be the same register. xx is consumed.
.macro	BIT_MERGE_32  xx, dd
	rev	\dd, \xx
	sel	\xx, \dd, \xx
	eor	\dd, \xx, \xx, lsr #4
	and	\dd, \dd, #0x00F000F0
	eor	\xx, \xx, \dd
	eor	\xx, \xx, \dd, lsl #4
	eor	\dd, \xx, \xx, lsr #2
	and	\dd, \dd, #0x0C0C0C0C
	eor	\xx, \xx, \dd
	eor	\xx, \xx, \dd, lsl #2
	eor	\dd, \xx, \xx, lsr #1
	and	\dd, \dd, #0x22222222
	eor	\xx, \xx, \dd
	eor	\dd, \xx, \dd, lsl #1
.endm

	@ BIT_MERGE_64 interleaves the bits from x0 and from x1, result
	@ is written back to x0:x1. xt is a scratch register.
	@ This macro assumes that the ASPR.GE flags have the 0110 pattern.
.macro	BIT_MERGE_64  x0, x1, xt
	pkhtb	\xt, \x1, \x0, asr #16
	pkhbt	\x1, \x0, \x1, lsl #16
	BIT_MERGE_32	\x1, \x0
	BIT_MERGE_32	\xt, \x1
.endm

	.align	2
	.thumb
	.thumb_func
	.type	bit_merge_5, %function
bit_merge_5:
	BIT_MERGE_64	r10, r11, r8
bit_merge_4:
	BIT_MERGE_64	r6,  r7,  r8
bit_merge_3:
	BIT_MERGE_64	r4,  r5,  r8
bit_merge_2:
	BIT_MERGE_64	r2,  r3,  r8
bit_merge_1:
	BIT_MERGE_64	r0,  r1,  r8
	bx	lr
	.size	bit_merge_5, .-bit_merge_5

@ =======================================================================
@ void fndsa_sha3_process_block(uint64_t *A, unsigned r)
@ =======================================================================

	.align	2
	.global	fndsa_sha3_process_block
	.thumb
	.thumb_func
	.type	fndsa_sha3_process_block, %function
fndsa_sha3_process_block:
	push.w	{ r4, r5, r6, r7, r8, r10, r11, lr }
	vpush.64 { d8, d9, d10, d11, d12, d13, d14, d15 }

	@ Source state is read from the provided buffer. The first r
	@ words (with "word" being a 64-bit state element) are split
	@ into even-indexed and odd-indexed bits. The state is loaded
	@ into FP registers and a stack buffer:
	@   d0 to d15 receive A[0] to A[15]
	@   sp[] receives A[i] at offset 8*(i-16) for i >= 16

	@ TODO: with the split, most of each round is really two separate
	@ sequences, each working on 25 32-bit values; they communicate
	@ with each other only through the rotation of the XOR of the
	@ lanes (step 2 of theta, section 3.2.1 in FIPS 202) and when
	@ further lane rotations use an odd count (rho function, section
	@ 3.2.2). We might be able to leverage that to improve locality,
	@ i.e. keep more values in integer registers and reduce traffic
	@ with storage (FP registers and stack). The state layout in FP
	@ registers and the stack would have to change so that accesses
	@ to FP can still be done with the double-width vmov most of
	@ the time.

	@ Stack:
	@ off  size
	@   0   72   state words 16 to 24
	@  72    4   pointer to state array
	@  76    4   number of data words
	@  80    8   temporary for one state word
	sub	sp, #88
	str	r0, [sp, #72]   @ Save state pointer
	str	r1, [sp, #76]   @ Save rate (in 64-bit words)
	mov.n	r14, r1

	@ Read word A[idx] into the specified register pair.
.macro	A_LD  x0, x1, idx
	.if ((\idx) == 0)
	vmov	\x0, \x1, s0, s1
	.elseif ((\idx) == 1)
	vmov	\x0, \x1, s2, s3
	.elseif ((\idx) == 2)
	vmov	\x0, \x1, s4, s5
	.elseif ((\idx) == 3)
	vmov	\x0, \x1, s6, s7
	.elseif ((\idx) == 4)
	vmov	\x0, \x1, s8, s9
	.elseif ((\idx) == 5)
	vmov	\x0, \x1, s10, s11
	.elseif ((\idx) == 6)
	vmov	\x0, \x1, s12, s13
	.elseif ((\idx) == 7)
	vmov	\x0, \x1, s14, s15
	.elseif ((\idx) == 8)
	vmov	\x0, \x1, s16, s17
	.elseif ((\idx) == 9)
	vmov	\x0, \x1, s18, s19
	.elseif ((\idx) == 10)
	vmov	\x0, \x1, s20, s21
	.elseif ((\idx) == 11)
	vmov	\x0, \x1, s22, s23
	.elseif ((\idx) == 12)
	vmov	\x0, \x1, s24, s25
	.elseif ((\idx) == 13)
	vmov	\x0, \x1, s26, s27
	.elseif ((\idx) == 14)
	vmov	\x0, \x1, s28, s29
	.elseif ((\idx) == 15)
	vmov	\x0, \x1, s30, s31
	.else
	ldrd	\x0, \x1, [sp, #(8 * ((\idx) - 16))]
	.endif
.endm

	@ Like A_LD, except that it uses two ldr opcodes instead of one
	@ ldrd for the words which are on the stack. This allows that
	@ load to pipeline with a previous load.
	@ WARNING: the two destination registers shall be both low
	@ (r0 to r7) or both high (r8 to r14), otherwise misalignment
	@ may occur. When the two registers are high, the footprint is
	@ 8 bytes, while A_LD would use 4 bytes.
.macro	A_LDX  x0, x1, idx
	.if (\idx) <= 15
	A_LD	\x0, \x1, \idx
	.else
	ldr	\x0, [sp, #(8 * ((\idx) - 16))]
	ldr	\x1, [sp, #(8 * ((\idx) - 16) + 4)]
	.endif
.endm

	@ Write into word A[idx] from the specified register pair.
	@ WARNING: the two destination registers shall be both low
	@ (r0 to r7) or both high (r8 to r14), otherwise misalignment
	@ may occur.
.macro	A_ST  x0, x1, idx
	.if ((\idx) == 0)
	vmov	s0, s1, \x0, \x1
	.elseif ((\idx) == 1)
	vmov	s2, s3, \x0, \x1
	.elseif ((\idx) == 2)
	vmov	s4, s5, \x0, \x1
	.elseif ((\idx) == 3)
	vmov	s6, s7, \x0, \x1
	.elseif ((\idx) == 4)
	vmov	s8, s9, \x0, \x1
	.elseif ((\idx) == 5)
	vmov	s10, s11, \x0, \x1
	.elseif ((\idx) == 6)
	vmov	s12, s13, \x0, \x1
	.elseif ((\idx) == 7)
	vmov	s14, s15, \x0, \x1
	.elseif ((\idx) == 8)
	vmov	s16, s17, \x0, \x1
	.elseif ((\idx) == 9)
	vmov	s18, s19, \x0, \x1
	.elseif ((\idx) == 10)
	vmov	s20, s21, \x0, \x1
	.elseif ((\idx) == 11)
	vmov	s22, s23, \x0, \x1
	.elseif ((\idx) == 12)
	vmov	s24, s25, \x0, \x1
	.elseif ((\idx) == 13)
	vmov	s26, s27, \x0, \x1
	.elseif ((\idx) == 14)
	vmov	s28, s29, \x0, \x1
	.elseif ((\idx) == 15)
	vmov	s30, s31, \x0, \x1
	.else
	@ Two str opcodes will pair and run in 2 cycles (as long as there
	@ is no stall from another memory access immediately before or
	@ after); strd would be shorter (one instruction) but use 3 cycles.
	str	\x0, [sp, #(8 * ((\idx) - 16))]
	str	\x1, [sp, #(8 * ((\idx) - 16) + 4)]
	.endif
.endm

	@ Rotate-right registers x0 and x1 by e0 and e1 bits, respectively;
	@ rotation counts must be in [0,31]. Rotation is skipped when the
	@ rotation count is zero.
.macro	ROR_WORD  x0, x1, e0, e1
	.if (\e0) != 0
	ror	\x0, \x0, #(\e0)
	.endif
	.if (\e1) != 0
	ror	\x1, \x1, #(\e1)
	.endif
.endm

	@ XOR right-rotated registers xa into registers xd. Rotation count
	@ must be in [0,31].
.macro	XOR_ROR_WORD  xd0, xd1, xa0, xa1, e0, e1
	.if (\e0) == 0
	eor	\xd0, \xd0, \xa0
	.else
	eor	\xd0, \xd0, \xa0, ror #(\e0)
	.endif
	.if (\e1) == 0
	eor	\xd1, \xd1, \xa1
	.else
	eor	\xd1, \xd1, \xa1, ror #(\e1)
	.endif
.endm

	@ Prepare the ASPR.GE flags with pattern 0110.
	@ All operations in the complete routine preserve these flags. This
	@ flag pattern is used in bit_split_5 and bit_merge_5.
	movw	r7, #0xFF00
	movt	r7, #0x00FF
	uadd8	r7, r7, r7

	@ For the initial input, we must split even/odd bits from data word
	@ (the non-data words are assumed to be already split), and
	@ pre-rotate all words in the way the loop expects.
	@
	@ Possible rate values (in 64-bit words):
	@   SHAKE128              21
	@   SHA3-224              18
	@   SHAKE256, SHA3-256    17
	@   SHA3-384              13
	@   SHA3-512               9
	@
	@ We fast-path the case r = 17, which corresponds to SHAKE256 and
	@ SHA3-256.

	@ A[0] to A[5]
	mov.w	r12, r0    @ move state pointer to r12
	ldm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	bl	bit_split_5
	ROR_WORD  r0,  r1,   0,  0
	ROR_WORD  r2,  r3,  22, 22
	ROR_WORD  r4,  r5,  22, 21
	ROR_WORD  r6,  r7,  11, 10
	ROR_WORD  r10, r11,  7,  7
	A_ST	r0,  r1,   0
	A_ST	r2,  r3,   1
	A_ST	r4,  r5,   2
	A_ST	r6,  r7,   3
	A_ST	r10, r11,  4
	@ A[5] to A[10]
	ldm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	@ If r = 9 then we split only four words; otherwise, r >= 13
	@ and we split 5 words.
	cmp	r14, #9
	bhi.w	fndsa_sha3_process_block__L1
	bl	bit_split_4
	b.w	fndsa_sha3_process_block__L2
fndsa_sha3_process_block__L1:
	bl	bit_split_5
fndsa_sha3_process_block__L2:
	ROR_WORD  r0,  r1,  14, 14
	ROR_WORD  r2,  r3,  10, 10
	ROR_WORD  r4,  r5,   2,  1
	ROR_WORD  r6,  r7,  23, 22
	ROR_WORD  r10, r11, 31, 30
	A_ST	r0,  r1,   5
	A_ST	r2,  r3,   6
	A_ST	r4,  r5,   7
	A_ST	r6,  r7,   8
	A_ST	r10, r11,  9
	@ A[10] to A[14]
	ldm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	@ If r = 9 then we do not split any word.
	@ If r = 13 then we split three words.
	@ Otherwise, r >= 17 and we split 5 words.
	cmp	r14, #13
	bhi.w	fndsa_sha3_process_block__L3
	cmp	r14, #10
	bls.w	fndsa_sha3_process_block__L4
	bl	bit_split_3
	b.w	fndsa_sha3_process_block__L4
fndsa_sha3_process_block__L3:
	bl	bit_split_5
fndsa_sha3_process_block__L4:
	ROR_WORD  r0,  r1,   1,  0
	ROR_WORD  r2,  r3,   3,  3
	ROR_WORD  r4,  r5,  13, 12
	ROR_WORD  r6,  r7,   4,  4
	ROR_WORD  r10, r11,  9,  9
	A_ST	r0,  r1,  10
	A_ST	r2,  r3,  11
	A_ST	r4,  r5,  12
	A_ST	r6,  r7,  13
	A_ST	r10, r11, 14
	@ A[15] to A[19]
	ldm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	@ If r = 9 or 13, then we do not split any word.
	@ If r = 17 then we split two words.
	@ If r = 18 then we split three words.
	@ Otherwise, r = 21 and we split 5 words.
	cmp	r14, #17
	beq.w	fndsa_sha3_process_block__L6
	cmp	r14, #18
	beq.w	fndsa_sha3_process_block__L5
	cmp	r14, #15
	bls.w	fndsa_sha3_process_block__L7
	bl	bit_split_5
	b.w	fndsa_sha3_process_block__L7
fndsa_sha3_process_block__L5:
	bl	bit_split_3
	b.w	fndsa_sha3_process_block__L7
fndsa_sha3_process_block__L6:
	bl	bit_split_2
fndsa_sha3_process_block__L7:
	ROR_WORD  r0,  r1,  14, 13
	ROR_WORD  r2,  r3,  18, 18
	ROR_WORD  r4,  r5,   5,  5
	ROR_WORD  r6,  r7,   8,  7
	ROR_WORD  r10, r11, 28, 28
	A_ST	r0,  r1,  15
	A_ST	r2,  r3,  16
	A_ST	r4,  r5,  17
	A_ST	r6,  r7,  18
	A_ST	r10, r11, 19
	@ A[20] to A[24]
	ldm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	@ If r = 9, 13, 17 or 18, then no split happens here.
	@ Otherwise, r = 21 and we split word A[20].
	cmp	r14, #20
	bls.w	fndsa_sha3_process_block__L8
	bl	bit_split_1
fndsa_sha3_process_block__L8:
	@ We have the split but not rotated words in the registers; we
	@ want to keep them that way, hence we have to copy through r8:r12
	@ for the pre-rotation.
	mov	r8, r0
	mov	r12, r1
	ROR_WORD  r8,  r12, 31, 31
	A_ST	r8,  r12, 20
	mov	r8, r2
	mov	r12, r3
	ROR_WORD  r8,  r12, 28, 27
	A_ST	r8,  r12, 21
	mov	r8, r4
	mov	r12, r5
	ROR_WORD  r8,  r12, 20, 19
	A_ST	r8,  r12, 22
	mov	r8, r6
	mov	r12, r7
	ROR_WORD  r8,  r12, 21, 20
	A_ST	r8,  r12, 23
	mov	r8, r10
	mov	r12, r11
	ROR_WORD  r8,  r12,  1,  1
	A_ST	r8,  r12, 24

	@ Here begins the preamble for the first iteration (XORing the
	@ words into t0..t4). Afterwards, that operation is done at the
	@ end of each iteration (in preparation for the next one) so
	@ this sequence is done only once.

	@ xor(A[5*i+0]) -> r0:r1
	@ xor(A[5*i+1]) -> r2:r3
	@ xor(A[5*i+2]) -> r4:r5
	@ xor(A[5*i+3]) -> r6:r7
	@ xor(A[5*i+4]) -> r10:r11

	@ Previous code left A[20..24] into the registers, we do not have
	@ to read them again.
	@add	r12, sp, #32
	@ldm	r12, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	A_LD	r8, r12, 0
	XOR_ROR_WORD  r0, r1, r8, r12,  0,  0
	A_LD	r8, r12, 5
	XOR_ROR_WORD  r0, r1, r8, r12, 18, 18
	A_LD	r8, r12, 10
	XOR_ROR_WORD  r0, r1, r8, r12, 31,  0
	A_LD	r8, r12, 15
	XOR_ROR_WORD  r0, r1, r8, r12, 18, 19

	A_LD	r8, r12, 1
	XOR_ROR_WORD  r2, r3, r8, r12, 10, 10
	A_LD	r8, r12, 6
	XOR_ROR_WORD  r2, r3, r8, r12, 22, 22
	A_LD	r8, r12, 11
	XOR_ROR_WORD  r2, r3, r8, r12, 29, 29
	A_LD	r8, r12, 16
	XOR_ROR_WORD  r2, r3, r8, r12, 14, 14

	A_LD	r8, r12, 2
	XOR_ROR_WORD  r4, r5, r8, r12, 10, 11
	A_LD	r8, r12, 7
	XOR_ROR_WORD  r4, r5, r8, r12, 30, 31
	A_LD	r8, r12, 12
	XOR_ROR_WORD  r4, r5, r8, r12, 19, 20
	A_LD	r8, r12, 17
	XOR_ROR_WORD  r4, r5, r8, r12, 27, 27

	A_LD	r8, r12, 3
	XOR_ROR_WORD  r6, r7, r8, r12, 21, 22
	A_LD	r8, r12, 8
	XOR_ROR_WORD  r6, r7, r8, r12,  9, 10
	A_LD	r8, r12, 13
	XOR_ROR_WORD  r6, r7, r8, r12, 28, 28
	A_LD	r8, r12, 18
	XOR_ROR_WORD  r6, r7, r8, r12, 24, 25

	A_LD	r8, r12, 4
	XOR_ROR_WORD  r10, r11, r8, r12, 25, 25
	A_LD	r8, r12, 9
	XOR_ROR_WORD  r10, r11, r8, r12,  1,  2
	A_LD	r8, r12, 14
	XOR_ROR_WORD  r10, r11, r8, r12, 23, 23
	A_LD	r8, r12, 19
	XOR_ROR_WORD  r10, r11, r8, r12,  4,  4

	@ We will perform 24 rounds. Each loop iteration performs one round.
	@ We keep minus eight times the current round counter in r14 (i.e. a
	@ multiple of 8, from -192 to -8).
	mvn	r14, #0xBF

fndsa_sha3_process_block__loop_step2:
	@ The A[] words have delayed rotations from the previous round:
	@   A[ 0]   er0:  0  er1:  0
	@   A[ 1]   er0: 10  er1: 10
	@   A[ 2]   er0: 10  er1: 11
	@   A[ 3]   er0: 21  er1: 22
	@   A[ 4]   er0: 25  er1: 25
	@   A[ 5]   er0: 18  er1: 18
	@   A[ 6]   er0: 22  er1: 22
	@   A[ 7]   er0: 30  er1: 31
	@   A[ 8]   er0:  9  er1: 10
	@   A[ 9]   er0:  1  er1:  2
	@   A[10]   er0: 31  er1:  0
	@   A[11]   er0: 29  er1: 29
	@   A[12]   er0: 19  er1: 20
	@   A[13]   er0: 28  er1: 28
	@   A[14]   er0: 23  er1: 23
	@   A[15]   er0: 18  er1: 19
	@   A[16]   er0: 14  er1: 14
	@   A[17]   er0: 27  er1: 27
	@   A[18]   er0: 24  er1: 25
	@   A[19]   er0:  4  er1:  4
	@   A[20]   er0:  1  er1:  1
	@   A[21]   er0:  4  er1:  5
	@   A[22]   er0: 12  er1: 13
	@   A[23]   er0: 11  er1: 12
	@   A[24]   er0: 31  er1: 31

	@ t0 = xor(A[5*i+4]) ^ rotl1(xor(A[5*i+1])) -> r8:r12
	@ t1 = xor(A[5*i+0]) ^ rotl1(xor(A[5*i+2])) -> r0:r1
	@ t2 = xor(A[5*i+1]) ^ rotl1(xor(A[5*i+3])) -> r2:r3
	@ t3 = xor(A[5*i+2]) ^ rotl1(xor(A[5*i+4])) -> r4:r5
	@ t4 = xor(A[5*i+3]) ^ rotl1(xor(A[5*i+0])) -> r6:r7

	eor	r12, r11, r2
	eor	r8, r10, r3, ror #31
	eor	r3, r3, r6
	eor	r2, r2, r7, ror #31
	eor	r7, r7, r0
	eor	r6, r6, r1, ror #31
	eor	r1, r1, r4
	eor	r0, r0, r5, ror #31
	eor	r5, r5, r10
	eor	r4, r4, r11, ror #31

	@ XOR each t_i into A[5*j+i] (for j = 0 to 4).
	@   t0:t1    value t_i (register pair)
	@   idx      index of A[] word
	@   e0, e1   delayed rotations for the A[] word
	@   swap     non-zero for a register swap
	@ The delayed rotations (from the previous round) are absorbed here.
	@ New delayed rotations are created here; only the register swap
	@ is performed (if the new rotation count, over 64 bits, is odd).
	@ Clobbers: r10, r11

.macro	XOR_T  t0, t1, idx, e0, e1, swap
	A_LD	r10, r11, \idx
	.if (\e0) == 0
	eor	r10, \t0, r10
	.else
	eor	r10, \t0, r10, ror #(\e0)
	.endif
	.if (\e1) == 0
	eor	r11, \t1, r11
	.else
	eor	r11, \t1, r11, ror #(\e1)
	.endif
	.if (\swap) != 0
	A_ST	r11, r10, \idx
	.else
	A_ST	r10, r11, \idx
	.endif
.endm

	@ We process all words except 0, 6, 12, 18 and 24, which come last
	@ with a special sequence.
	@ We also interleave "high" (16+) and "low" (0 to 15) words, so as
	@ to avoid str + ldrd sequences which create memory stalls.

	XOR_T	r0,  r1,   1, 10, 10, 1
	XOR_T	r0,  r1,  16, 14, 14, 1
	XOR_T	r2,  r3,   2, 10, 11, 0
	XOR_T	r2,  r3,  17, 27, 27, 1
	XOR_T	r4,  r5,   3, 21, 22, 0
	XOR_T	r6,  r7,  19,  4,  4, 0
	XOR_T	r6,  r7,   4, 25, 25, 1
	XOR_T	r8,  r12, 20,  1,  1, 0
	XOR_T	r8,  r12,  5, 18, 18, 0
	XOR_T	r0,  r1,  21,  4,  5, 0
	XOR_T	r2,  r3,   7, 30, 31, 0
	XOR_T	r2,  r3,  22, 12, 13, 1
	XOR_T	r4,  r5,   8,  9, 10, 1
	XOR_T	r4,  r5,  23, 11, 12, 0
	XOR_T	r6,  r7,   9,  1,  2, 0
	XOR_T	r8,  r12, 10, 31,  0, 1
	XOR_T	r0,  r1,  11, 29, 29, 0
	XOR_T	r4,  r5,  13, 28, 28, 1
	XOR_T	r6,  r7,  14, 23, 23, 1
	XOR_T	r8,  r12, 15, 18, 19, 1

	@ For words 0, 6, 12, 18 and 24, we omit writing back to storage
	@ because we'll need them right away in the first KHI_STEP.
	A_LD	r10, r11, 24
	eor	r10, r6, r10, ror #31
	eor	r11, r7, r11, ror #31
	A_LD	r7, r6, 18
	eor	r7, r4, r7, ror #24
	eor	r6, r5, r6, ror #25
	A_LD	r5, r4, 12
	eor	r5, r2, r5, ror #19
	eor	r4, r3, r4, ror #20
	A_LD	r2, r3, 6
	eor	r2, r0, r2, ror #22
	eor	r3, r1, r3, ror #22
	A_LD	r0, r1, 0
	eor	r0, r8, r0
	eor	r1, r12, r1

	@ Delayed right-rotations on low (even) and high (odd) words:
	@   A[ 0]   dr0:  0  dr1:  0
	@   A[ 1]   dr0: 31  dr1:  0
	@   A[ 2]   dr0:  1  dr1:  1
	@   A[ 3]   dr0: 18  dr1: 18
	@   A[ 4]   dr0: 18  dr1: 19
	@   A[ 5]   dr0: 14  dr1: 14
	@   A[ 6]   dr0: 10  dr1: 10
	@   A[ 7]   dr0: 29  dr1: 29
	@   A[ 8]   dr0:  4  dr1:  5
	@   A[ 9]   dr0: 22  dr1: 22
	@   A[10]   dr0: 30  dr1: 31
	@   A[11]   dr0: 27  dr1: 27
	@   A[12]   dr0: 10  dr1: 11
	@   A[13]   dr0: 19  dr1: 20
	@   A[14]   dr0: 12  dr1: 13
	@   A[15]   dr0: 11  dr1: 12
	@   A[16]   dr0:  9  dr1: 10
	@   A[17]   dr0: 24  dr1: 25
	@   A[18]   dr0: 21  dr1: 22
	@   A[19]   dr0: 28  dr1: 28
	@   A[20]   dr0: 23  dr1: 23
	@   A[21]   dr0: 31  dr1: 31
	@   A[22]   dr0:  1  dr1:  2
	@   A[23]   dr0:  4  dr1:  4
	@   A[24]   dr0: 25  dr1: 25

@ Apply operation 'op' (Boolean bitwise opcode) on values xa0:xa1
@ and xb0:xb1 (register pairs), then XOR with xd0:xd1 and write
@ result at index j. Each register comes with a "delayed rotation" count
@ which is applied here.
.macro	KHI_OP xa0, da0, xa1, da1, xb0, db0, xb1, db1, xd0, dd0, xd1, dd1, j
	@ 'op' on xa and xb
	.if (\da0) == (\db0)
	bic	r8, \xb0, \xa0
	.else
	bic	r8, \xb0, \xa0, ror #((32 + (\da0) - (\db0)) & 31)
	.endif
	.if (\da1) == (\db1)
	bic	r12, \xb1, \xa1
	.else
	bic	r12, \xb1, \xa1, ror #((32 + (\da1) - (\db1)) & 31)
	.endif
	@ XOR with xd, result back in r8:r12 (xd itself is unmodified)
	@ r8 and r12 have delayed rotations by da0 and da1, respectively
	.if (\db0) == (\dd0)
	eor	r8, \xd0, r8
	.else
	eor	r8, \xd0, r8, ror #((32 + (\db0) - (\dd0)) & 31)
	.endif
	.if (\db1) == (\dd1)
	eor	r12, \xd1, r12
	.else
	eor	r12, \xd1, r12, ror #((32 + (\db1) - (\dd1)) & 31)
	.endif
	@ Store back XOR result
	A_ST	r8, r12, \j
.endm

@ Apply Khi on five words. Word indexes are i0 to i4. Each word comes with
@ its two "delayed rotation" counts.
@ If notx1 is non-zero, then word i1 is complemented before the computations.
@ If notx3 is non-zero, then word i3 is complemented before the computations.
@ If swap1 is non-zero, then the two operands for the second operation are
@ swapped.
.macro	KHI_STEP i0, e00, e01, i1, e10, e11, i2, e20, e21, i3, e30, e31, i4, e40, e41
	@ Load all five state words.
	A_LDX	r0,  r1,  \i0
	A_LDX	r2,  r3,  \i1
	A_LDX	r4,  r5,  \i2
	A_LDX	r6,  r7,  \i3
	A_LDX	r10, r11  \i4
	@ Apply operations.
	KHI_OP	r2,  \e10, r3,  \e11, r4,  \e20, r5,  \e21, r0,  \e00, r1,  \e01, \i0
	KHI_OP	r4,  \e20, r5,  \e21, r6,  \e30, r7,  \e31, r2,  \e10, r3,  \e11, \i1
	KHI_OP	r6,  \e30, r7,  \e31, r10, \e40, r11, \e41, r4,  \e20, r5,  \e21, \i2
	KHI_OP	r10, \e40, r11, \e41, r0,  \e00, r1,  \e01, r6,  \e30, r7,  \e31, \i3
	KHI_OP	r0,  \e00, r1,  \e01, r2,  \e10, r3,  \e11, r10, \e40, r11, \e41, \i4
.endm

@ Special case for first KHI_STEP:
@ Words are received already loaded in registers (permuted).
.macro	KHI_STEP_1 i0, e00, e01, i1, e10, e11, i2, e20, e21, i3, e30, e31, i4, e40, e41, op0, op1, op2, op3, op4
	KHI_OP	r2,  \e10, r3,  \e11, r4,  \e20, r5,  \e21, r0,  \e00, r1,  \e01, \i0
	KHI_OP	r4,  \e20, r5,  \e21, r6,  \e30, r7,  \e31, r2,  \e10, r3,  \e11, \i1
	KHI_OP	r6,  \e30, r7,  \e31, r10, \e40, r11, \e41, r4,  \e20, r5,  \e21, \i2
	KHI_OP	r10, \e40, r11, \e41, r0,  \e00, r1,  \e01, r6,  \e30, r7,  \e31, \i3
	KHI_OP	r0,  \e00, r1,  \e01, r2,  \e10, r3,  \e11, r10, \e40, r11, \e41, \i4
.endm

	@ 0, 6, 12, 18, 24
	KHI_STEP_1  0,  0,  0,  6, 10, 10, 12, 10, 11, 18, 21, 22, 24, 25, 25

	@ 3, 9, 10, 16, 22
	KHI_STEP    3, 18, 18,  9, 22, 22, 10, 30, 31, 16,  9, 10, 22,  1,  2

	@ 1, 7, 13, 19, 20
	KHI_STEP    1, 31,  0,  7, 29, 29, 13, 19, 20, 19, 28, 28, 20, 23, 23

	@ 4, 5, 11, 17, 23
	KHI_STEP    4, 18, 19,  5, 14, 14, 11, 27, 27, 17, 24, 25, 23,  4,  4

	@ 2, 8, 14, 15, 21
	KHI_STEP    2,  1,  1,  8,  4,  5, 14, 12, 13, 15, 11, 12, 21, 31, 31

	@ XOR next round constant into A[0]
	adr.w	r5, process_block_RC__end
	add.w	r5, r14
	ldrd	r2, r3, [r5]
	A_LD	r0, r1, 0
	eors	r0, r2
	eors	r1, r3
	@ Increment counter for next iteration. Since the counter starts at
	@ -192, it reaches 0 when 24 rounds have been completed.
	adds	r14, #8
	beq.w	fndsa_sha3_process_block__final

	@ We store back the modified A[0] only if looping (exit sequence
	@ uses the r0:r1 registers directly).
	A_ST	r0, r1, 0

	@ Permute the state words for next round.
	@    6 ->  1
	@    1 -> 10
	@   10 ->  7
	@    7 -> 11
	@   11 -> 17
	@   17 -> 18
	@   18 ->  3
	@    3 ->  5
	@    5 -> 16
	@   16 ->  8
	@    8 -> 21
	@   21 -> 24
	@   24 ->  4
	@    4 -> 15
	@   15 -> 23
	@   23 -> 19
	@   19 -> 13
	@   13 -> 12
	@   12 ->  2
	@    2 -> 20
	@   20 -> 14
	@   14 -> 22
	@   22 ->  9
	@    9 ->  6
	@ Word 0 is not permuted.
	@ We compute the XOR of the permuted words, as would normally
	@ be done at the start of the next iteration. For that computation,
	@ we need to take the delayed rotations into account.

	@ Load word i, store in j, and also rotate the in-register copy
	@ to absorbate the specified delayed rotations.
.macro	A_LD_ST  i, j, e0, e1
	.if (\j) % 5 == 0
	A_LD	r0, r1, \i
	A_ST	r0, r1, \j
	ROR_WORD  r0, r1, \e0, \e1
	.elseif (\j) % 5 == 1
	A_LD	r2, r3, \i
	A_ST	r2, r3, \j
	ROR_WORD  r2, r3, \e0, \e1
	.elseif (\j) % 5 == 2
	A_LD	r4, r5, \i
	A_ST	r4, r5, \j
	ROR_WORD  r4, r5, \e0, \e1
	.elseif (\j) % 5 == 3
	A_LD	r6, r7, \i
	A_ST	r6, r7, \j
	ROR_WORD  r6, r7, \e0, \e1
	.else
	A_LD	r10, r11, \i
	A_ST	r10, r11, \j
	ROR_WORD  r10, r11, \e0, \e1
	.endif
.endm

	@ Load word i, store in j, and also XOR that word into the
	@ appropriate registers (based on j mod 5), applying the specified
	@ delayed rotations.
.macro	A_LD_XOR_ST  i, j, e0, e1
	A_LD	r8, r12, \i
	.if (\j) % 5 == 0
	XOR_ROR_WORD  r0,  r1,  r8,  r12, \e0, \e1
	.elseif (\j) % 5 == 1
	XOR_ROR_WORD  r2,  r3,  r8,  r12, \e0, \e1
	.elseif (\j) % 5 == 2
	XOR_ROR_WORD  r4,  r5,  r8,  r12, \e0, \e1
	.elseif (\j) % 5 == 3
	XOR_ROR_WORD  r6,  r7,  r8,  r12, \e0, \e1
	.else
	XOR_ROR_WORD  r10, r11, r8,  r12, \e0, \e1
	.endif
	A_ST	r8, r12, \j
.endm

	@ r0:r1 still contains A[0], for whom the delayed rotations are zero.
	A_LD	r2, r3, 6
	str	r2, [sp, #80]
	str	r3, [sp, #84]
	ror	r2, r2, #10
	ror	r3, r3, #10
	A_LD_XOR_ST   9,  6, 22, 22
	A_LD_ST	     22,  9,  1,  2
	A_LD_ST      14, 22, 12, 13
	A_LD_XOR_ST  20, 14, 23, 23
	A_LD_XOR_ST   2, 20,  1,  1
	A_LD_XOR_ST  12,  2, 10, 11
	A_LD_XOR_ST  13, 12, 19, 20
	A_LD_ST      19, 13, 28, 28
	A_LD_XOR_ST  23, 19,  4,  4
	A_LD_XOR_ST  15, 23, 11, 12
	A_LD_XOR_ST   4, 15, 18, 19
	A_LD_XOR_ST  24,  4, 25, 25
	A_LD_XOR_ST  21, 24, 31, 31
	A_LD_XOR_ST   8, 21,  4,  5
	A_LD_XOR_ST  16,  8,  9, 10
	A_LD_XOR_ST   5, 16, 14, 14
	A_LD_XOR_ST   3,  5, 18, 18
	A_LD_XOR_ST  18,  3, 21, 22
	A_LD_XOR_ST  17, 18, 24, 25
	A_LD_XOR_ST  11, 17, 27, 27
	A_LD_XOR_ST   7, 11, 29, 29
	A_LD_XOR_ST  10,  7, 30, 31
	A_LD_XOR_ST   1, 10, 31,  0
	ldrd	r8, r12, [sp, #80]
	A_ST	r8, r12, 1

	b.w	fndsa_sha3_process_block__loop_step2

fndsa_sha3_process_block__final:
	@ Recombine even-indexed and odd-indexed bits.
	@ Everything is written back into the original state array.
	@ Words are still in permuted state, and have delayed rotations
	@ that should be applied here.
	ldr	r12, [sp, #72]   @ Pointer to state array
	ldr	r14, [sp, #76]   @ Rate (9, 13, 17, 18 or 21)

	@ Load word i into the given registers, and apply the specified
	@ rotations. Moreover, if donot is non-zero, the word is negated.
.macro	A_LDROR  x0, x1, i, e0, e1
	A_LD		\x0, \x1, \i
	ROR_WORD	\x0, \x1, \e0, \e1
.endm

	@ r0:r1 was set in the last iteration and has no delayed rotation
	@A_LD	r0,  r1,   0
	A_LDROR	r2,  r3,   6, 10, 10
	A_LDROR	r4,  r5,  12, 10, 11
	A_LDROR	r6,  r7,  18, 21, 22
	A_LDROR	r10, r11, 24, 25, 25
	bl	bit_merge_5
	stm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	A_LDROR	r0,  r1,   3, 18, 18
	A_LDROR	r2,  r3,   9, 22, 22
	A_LDROR	r4,  r5,  10, 30, 31
	A_LDROR	r6,  r7,  16,  9, 10
	A_LDROR	r10, r11, 22,  1,  2
	cmp	r14, #9
	bhi.w	fndsa_sha3_process_block__L10
	bl	bit_merge_4
	b.w	fndsa_sha3_process_block__L11
fndsa_sha3_process_block__L10:
	bl	bit_merge_5
fndsa_sha3_process_block__L11:
	stm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	A_LDROR	r0,  r1,   1, 31,  0
	A_LDROR	r2,  r3,   7, 29, 29
	A_LDROR	r4,  r5,  13, 19, 20
	A_LDROR	r6,  r7,  19, 28, 28
	A_LDROR	r10, r11, 20, 23, 23
	cmp	r14, #13
	bhi.w	fndsa_sha3_process_block__L12
	cmp	r14, #10
	bls.w	fndsa_sha3_process_block__L13
	bl	bit_merge_3
	b.w	fndsa_sha3_process_block__L13
fndsa_sha3_process_block__L12:
	bl	bit_merge_5
fndsa_sha3_process_block__L13:
	stm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	A_LDROR	r0,  r1,   4, 18, 19
	A_LDROR	r2,  r3,   5, 14, 14
	A_LDROR	r4,  r5,  11, 27, 27
	A_LDROR	r6,  r7,  17, 24, 25
	A_LDROR	r10, r11, 23,  4,  4
	cmp	r14, #17
	beq.w	fndsa_sha3_process_block__L15
	cmp	r14, #18
	beq.w	fndsa_sha3_process_block__L14
	cmp	r14, #15
	bls.w	fndsa_sha3_process_block__L16
	bl	bit_merge_5
	b.w	fndsa_sha3_process_block__L16
fndsa_sha3_process_block__L14:
	bl	bit_merge_3
	b.w	fndsa_sha3_process_block__L16
fndsa_sha3_process_block__L15:
	bl	bit_merge_2
fndsa_sha3_process_block__L16:
	stm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }
	A_LDROR	r0,  r1,   2,  1,  1
	A_LDROR	r2,  r3,   8,  4,  5
	A_LDROR	r4,  r5,  14, 12, 13
	A_LDROR	r6,  r7,  15, 11, 12
	A_LDROR	r10, r11, 21, 31, 31
	cmp	r14, #20
	bls.w	fndsa_sha3_process_block__L17
	bl	bit_merge_1
fndsa_sha3_process_block__L17:
	stm	r12!, { r0, r1, r2, r3, r4, r5, r6, r7, r10, r11 }

	add	sp, #88
	vpop.64 { d8, d9, d10, d11, d12, d13, d14, d15 }
	pop	{ r4, r5, r6, r7, r8, r10, r11, pc }

	.align	2
process_block_RC:
	.word	0x00000001, 0x00000000
	.word	0x00000000, 0x00000089
	.word	0x00000000, 0x8000008B
	.word	0x00000000, 0x80008080
	.word	0x00000001, 0x0000008B
	.word	0x00000001, 0x00008000
	.word	0x00000001, 0x80008088
	.word	0x00000001, 0x80000082
	.word	0x00000000, 0x0000000B
	.word	0x00000000, 0x0000000A
	.word	0x00000001, 0x00008082
	.word	0x00000000, 0x00008003
	.word	0x00000001, 0x0000808B
	.word	0x00000001, 0x8000000B
	.word	0x00000001, 0x8000008A
	.word	0x00000001, 0x80000081
	.word	0x00000000, 0x80000081
	.word	0x00000000, 0x80000008
	.word	0x00000000, 0x00000083
	.word	0x00000000, 0x80008003
	.word	0x00000001, 0x80008088
	.word	0x00000000, 0x80000088
	.word	0x00000001, 0x00008000
	.word	0x00000000, 0x80008082
process_block_RC__end:

	.size	fndsa_sha3_process_block,.-fndsa_sha3_process_block
