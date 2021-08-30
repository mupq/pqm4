	.cpu cortex-m4

#include "bitslice.inc"
#include "madd_bitsliced.inc"
#include "mul_bitsliced.inc"
#include "gf16inverse.inc"

.macro mul_row_bitsliced pivot, ai, mat0, mat1, mat2, mat3, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7
	ldr.w \tmp0, [\ai, #4*0]
	ldr.w \tmp1, [\ai, #4*1]
	ldr.w \tmp2, [\ai, #4*2]
	ldr.w \tmp3, [\ai, #4*3]

	bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3
	mul_bitsliced \tmp0, \tmp1, \tmp2, \tmp3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp4, \tmp5, \tmp6, \tmp7
	vmov.w s1, \tmp0
	vmov.w s2, \tmp1
	vmov.w s3, \tmp2
	vmov.w s4, \tmp3
	bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3
	str.w \mat0, [\ai, #4*0]
	str.w \mat1, [\ai, #4*1]
	str.w \mat2, [\ai, #4*2]
	str.w \mat3, [\ai, #4*3]

	ldr.w \mat0, [\ai, #4*4]
	ldr.w \mat1, [\ai, #4*5]
	ldr.w \mat2, [\ai, #4*6]
	ldr.w \mat3, [\ai, #4*7]
	// already bitsliced
	//bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3
	mul_bitsliced \tmp0, \tmp1, \tmp2, \tmp3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp4, \tmp5, \tmp6, \tmp7
	vmov.w s5, \tmp0
	vmov.w s6, \tmp1
	vmov.w s7, \tmp2
	vmov.w s8, \tmp3
	// keep bitlisced
	//bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3


	str.w \tmp0, [\ai, #4*4]
	str.w \tmp1, [\ai, #4*5]
	str.w \tmp2, [\ai, #4*6]
	str.w \tmp3, [\ai, #4*7]
.endm



.macro madd_row_bitsliced pivot, ai, mat0, mat1, mat2, mat3, acc0, acc1, acc2, acc3, tmp0, tmp1, tmp2, tmp3
	ldr.w \tmp0, [\ai, #4*0]
	ldr.w \tmp1, [\ai, #4*1]
	ldr.w \tmp2, [\ai, #4*2]
	ldr.w \tmp3, [\ai, #4*3]

	bitslice \acc0, \acc1, \acc2, \acc3, \tmp0, \tmp1, \tmp2, \tmp3
	vmov \mat0, s1
	vmov \mat1, s2
	vmov \mat2, s3
	vmov \mat3, s4
	madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp0, \tmp1, \tmp2, \tmp3
	bitslice \mat0, \mat1, \mat2, \mat3, \acc0, \acc1, \acc2, \acc3

	str.w \mat0, [\ai, #4*0]
	str.w \mat1, [\ai, #4*1]
	str.w \mat2, [\ai, #4*2]
	str.w \mat3, [\ai, #4*3]

	ldr.w \acc0, [\ai, #4*4]
	ldr.w \acc1, [\ai, #4*5]
	ldr.w \acc2, [\ai, #4*6]
	ldr.w \acc3, [\ai, #4*7]
	// already- bitsliced
	//bitslice \acc0, \acc1, \acc2, \acc3, \tmp0, \tmp1, \tmp2, \tmp3
	vmov \mat0, s5
	vmov \mat1, s6
	vmov \mat2, s7
	vmov \mat3, s8

	madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp0, \tmp1, \tmp2, \tmp3
	//keep-bitsliced
	//bitslice \mat0, \mat1, \mat2, \mat3, \acc0, \acc1, \acc2, \acc3

	str.w \acc0, [\ai, #4*4]
	str.w \acc1, [\ai, #4*5]
	str.w \acc2, [\ai, #4*6]
	str.w \acc3, [\ai, #4*7]
.endm


.macro gauss_elim_inner ai, pivotindex, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp11
	vmov.w s10, \pivotindex
	mov.w \tmp1, #0
	1:
		vmov \pivotindex, s10
		cmp.w \tmp1, \pivotindex
		beq.w skip

		lsrs.w \tmp0, \pivotindex, #1
		ldrb.n \tmp0, [\ai, \tmp0]
		ite cs
		lsrcs.w \tmp0, \tmp0, #4
		andcc \tmp0, \tmp0, #0xF
		vmov s9, \tmp1
		madd_row_bitsliced \tmp0, \ai, \tmp2, \tmp3, \tmp4, \tmp5, \tmp6, \tmp7, \tmp8, \tmp9, \tmp10, \tmp11, \tmp1, \pivotindex
		vmov \tmp1, s9
	skip:
	add.w \tmp1, #1
	add.w \ai, #32
	cmp.w \tmp1, #32
	bne.w 1b
.endm


	.p2align 2,,3
	.global	gf16mat_inv_512_bitsliced_asm
	.arch armv7e-m
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	gf16mat_inv_512_bitsliced_asm, %function
gf16mat_inv_512_bitsliced_asm:
	push {r4-r11, r14}
	ai .req r3
	ii .req r1
	pivot .req r2
	jj .req r4

	aj0 .req r9
	aj1 .req r6
	aj2 .req r7
	aj3 .req r8

	ai0 .req r5
	ai1 .req r10
	ai2 .req r11
	ai3 .req r12


	pivot0 .req r9
	pivot1 .req r10
	pivot2 .req r11
	pivot3 .req r12
	aj   .req r14

	inputoutput_fpu .req s11
	extmat_fpu  .req s0

	// allocate space for the extended matrix
	vmov.w inputoutput_fpu, r0
	sub.w sp, sp, #1024
	mov.w r0, sp
	vmov.w extmat_fpu, r0

	// set the entire extended matrix matrix to zero
	mov.w r1, #0
	mov.w r2, #1024
	bl.w memset

	// copy over the input matrix to the left half of the extended matrix
	vmov.w r0, inputoutput_fpu
	vmov.w ai, extmat_fpu
	mov.w ii, #16
	1:
		ldr.w ai1, [r0, #4]
		ldr.w ai2, [r0, #8]
		ldr.w ai3, [r0, #12]
		ldr.w aj0, [r0, #16]
		ldr.w aj1, [r0, #20]
		ldr.w aj2, [r0, #24]
		ldr.w aj3, [r0, #28]
		ldr.w ai0, [r0], #32
		str.w ai1, [ai, #4]
		str.w ai2, [ai, #8]
		str.w ai3, [ai, #12]
		str.w aj0, [ai, #32]
		str.w aj1, [ai, #36]
		str.w aj2, [ai, #40]
		str.w aj3, [ai, #44]
		str.w ai0, [ai], #64
		subs.w ii, ii, #1
		bne.w 1b



	// set the right half of the extended matrix to an identity matrix
	// (a bitsliced identity matrix looks a bit weird)
	vmov.w r1, extmat_fpu
	mov.w aj0, #0x01
	mov.w aj1, #0x10
	mov.w aj2, #0x02
	mov.w aj3, #0x20
	mov.w ai0, #0x04
	mov.w ai1, #0x40
	mov.w ai2, #0x08
	mov.w ai3, #0x80
	add.w ai, r1, #16
	mov.w ii, #4
	1:
		strb.w aj2, [ai, #8*32]
		strb.w aj3, [ai, #9*32]
		strb.w ai0, [ai, #16*32]
		strb.w ai1, [ai, #17*32]
		strb.w ai2, [ai, #24*32]
		strb.w ai3, [ai, #25*32]
		strb.w aj1, [ai, #32]
		strb.w aj0, [ai], #32*2+1
		subs.w ii, #1
		bne.w 1b


	// start the Gauss elimination
	vmov.w ai, extmat_fpu
	mov.w ii, #0
	mov.w r0, #1
	outer: // outer loop: for each row

		// First: make sure that pivot in this row is not zero, by adding the other rows in case it is zero
		add.w jj, ii, #1
		add.w aj, ai, #32
		inner:
		// We could make the index computation faster by using another registers;
		// but then we would need another comparison for the ite
		lsrs.w pivot, ii, #1
		ldrb.n pivot, [ai, pivot]
		// this selects the right GF16 depending on if ii is even or odd
		ite cs
		lsrcs.w pivot, pivot, #4
		andcc pivot, pivot, #0xF

		ldr.w aj0, [aj, #4*4]
		ldr.w aj1, [aj, #4*5]
		ldr.w aj2, [aj, #4*6]
		ldr.w aj3, [aj, #4*7]

		ldr.w ai0, [ai, #4*4]
		ldr.w ai1, [ai, #4*5]
		ldr.w ai2, [ai, #4*6]
		ldr.w ai3, [ai, #4*7]
		cmp.n pivot, #0

		itttt eq
		eoreq ai0, ai0, aj0
		eoreq ai1, ai1, aj1
		eoreq ai2, ai2, aj2
		eoreq ai3, ai3, aj3

		str.w ai0, [ai, #4*4]
		str.w ai1, [ai, #4*5]
		str.w ai2, [ai, #4*6]
		str.w ai3, [ai, #4*7]


		ldr.w aj1, [aj, #4*1]
		ldr.w aj2, [aj, #4*2]
		ldr.w aj3, [aj, #4*3]
		ldr.w aj0, [aj], #32

		ldr.w ai1, [ai, #4*1]
		ldr.w ai2, [ai, #4*2]
		ldr.w ai3, [ai, #4*3]
		ldr.n ai0, [ai]

		itttt eq
		eoreq ai0, ai0, aj0
		eoreq ai1, ai1, aj1
		eoreq ai2, ai2, aj2
		eoreq ai3, ai3, aj3

		str.w ai0, [ai, #4*0]
		str.w ai1, [ai, #4*1]
		str.w ai2, [ai, #4*2]
		str.w ai3, [ai, #4*3]

		adds.w jj, #1
		cmp.w jj, #32
		bne.w inner

	outer2: // for the last row, we don't have rows left to add, so we skip the inner loop
	lsrs.n pivot, ii, #1
	ldrb.n pivot, [ai, pivot]
	ite cs
	lsrcs pivot, pivot, #4
	andcc pivot, pivot, #0xF

	cmp.n pivot, #0
	it eq
	moveq.w r0, #0


	// get mat
	push.w {r0}

	// invert pivot
	mov.n r0, pivot
	inverse pivot, r0, ai0, ai1

	push.n {r1, r3}
	mul_row_bitsliced pivot, ai, ai0, ai1, ai2, ai3, aj0, aj1, aj2, aj3, r0, jj, aj, ii
	ldr.w r1, [sp, #0]
	vmov.w r0, extmat_fpu
	gauss_elim_inner r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14
	pop.w {r1, r3}
	pop.w {r0}

	add ai, ai, #32
	add.w ii, ii, #1
	cmp.w ii, #31
	blt.w outer
	beq.w outer2

	// un-bitslice the inverse
	vmov.w ai, extmat_fpu
	vmov.w r2, inputoutput_fpu
	mov.w ii, #32
	add.w ai, #16
	1:
	ldr.w aj1, [ai, #4]
	ldr.w aj2, [ai, #8]
	ldr.w aj3, [ai, #12]
	ldr.w aj0, [ai], #32
	// keep bitsliced
	//bitslice aj0, aj1, aj2, aj3, ai0, ai1, ai2, ai3
	str.w aj1, [r2, #4]
	str.w aj2, [r2, #8]
	str.w aj3, [r2, #12]
	str.w aj0, [r2], #16
	subs.w ii, #1
	bne.w 1b

	add sp, sp, #1024
	pop {r4-r11, pc}

