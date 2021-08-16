
.syntax unified
.cpu cortex-m4
.thumb

#include "bitslice.inc"
#include "madd_bitsliced.inc"
#include "mul_bitsliced.inc"
#include "gf16inverse.inc"


.macro mul_row_bitsliced_first pivot, ai, mat0, mat1, mat2, mat3, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7
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

	ldr.w \tmp0, [\ai, #4*4]
	bitslice_single \mat0, \mat1, \mat2, \mat3, \tmp0
	mul_bitsliced \tmp0, \tmp1, \tmp2, \tmp3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp4, \tmp5, \tmp6, \tmp7
	vmov.w s5, \tmp0
	vmov.w s6, \tmp1
	vmov.w s7, \tmp2
	vmov.w s8, \tmp3

	unbitslice_single \mat0, \tmp0, \tmp1, \tmp2, \tmp3
	str.w \mat0, [\ai, #4*4]
.endm

.macro madd_row_bitsliced_first pivot, ai, mat0, mat1, mat2, mat3, acc0, acc1, acc2, acc3, tmp0, tmp1, tmp2, tmp3
	mov.w \acc0, #0
	mov.w \acc1, #0
	mov.w \acc2, #0
	mov.w \acc3, #0

	vmov \mat0, s1
	vmov \mat1, s2
	vmov \mat2, s3
	vmov \mat3, s4
	madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp0, \tmp1, \tmp2, \tmp3
	bitslice \mat0, \mat1, \mat2, \mat3, \acc0, \acc1, \acc2, \acc3

	ldr.w \tmp0, [\ai, #4*0]
	ldr.w \tmp1, [\ai, #4*1]
	ldr.w \tmp2, [\ai, #4*2]
	ldr.w \tmp3, [\ai, #4*3]

	eor.w \mat0, \tmp0
	eor.w \mat1, \tmp1
	eor.w \mat2, \tmp2
	eor.w \mat3, \tmp3

	str.w \mat0, [\ai, #4*0]
	str.w \mat1, [\ai, #4*1]
	str.w \mat2, [\ai, #4*2]
	str.w \mat3, [\ai, #4*3]

	mov.w \acc0, #0
	mov.w \acc1, #0
	mov.w \acc2, #0
	mov.w \acc3, #0
	vmov \mat0, s5
	vmov \mat1, s6
	vmov \mat2, s7
	vmov \mat3, s8

	madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp0, \tmp1, \tmp2, \tmp3
	unbitslice_single \mat0, \acc0, \acc1, \acc2, \acc3

	ldr.w \tmp0, [\ai, #4*4]
	eor.w \mat0, \tmp0
	str.w \mat0, [\ai, #4*4]
.endm

.macro gauss_elim_inner_first ai, pivotindex, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp11
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
		madd_row_bitsliced_first \tmp0, \ai, \tmp2, \tmp3, \tmp4, \tmp5, \tmp6, \tmp7, \tmp8, \tmp9, \tmp10, \tmp11, \tmp1, \pivotindex
		vmov \tmp1, s9
	skip:
	add.w \tmp1, #1
	add.w \ai, #20
	cmp.w \tmp1, #32
	bne.w 1b
.endm


.macro mul_row_bitsliced_last pivot, ai, mat0, mat1, mat2, mat3, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7
	ldr.w \tmp0, [\ai, #4*1]
	ldr.w \tmp1, [\ai, #4*2]
	ldr.w \tmp2, [\ai, #4*3]
	ldr.w \tmp3, [\ai, #4*4]

	bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3
	mul_bitsliced \tmp0, \tmp1, \tmp2, \tmp3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp4, \tmp5, \tmp6, \tmp7
	vmov.w s1, \tmp0
	vmov.w s2, \tmp1
	vmov.w s3, \tmp2
	vmov.w s4, \tmp3
	bitslice \mat0, \mat1, \mat2, \mat3, \tmp0, \tmp1, \tmp2, \tmp3
	str.w \mat0, [\ai, #4*1]
	str.w \mat1, [\ai, #4*2]
	str.w \mat2, [\ai, #4*3]
	str.w \mat3, [\ai, #4*4]
.endm

.macro madd_row_bitsliced_last pivot, ai, mat0, mat1, mat2, mat3, acc0, acc1, acc2, acc3, tmp0, tmp1, tmp2, tmp3
	mov.w \acc0, #0
	mov.w \acc1, #0
	mov.w \acc2, #0
	mov.w \acc3, #0

	vmov \mat0, s1
	vmov \mat1, s2
	vmov \mat2, s3
	vmov \mat3, s4
	madd_bitsliced \acc0, \acc1, \acc2, \acc3, \mat0, \mat1, \mat2, \mat3, \pivot, \tmp0, \tmp1, \tmp2, \tmp3
	bitslice \mat0, \mat1, \mat2, \mat3, \acc0, \acc1, \acc2, \acc3

	ldr.w \tmp0, [\ai, #4*1]
	ldr.w \tmp1, [\ai, #4*2]
	ldr.w \tmp2, [\ai, #4*3]
	ldr.w \tmp3, [\ai, #4*4]
	eor.w \mat0, \tmp0
	eor.w \mat1, \tmp1
	eor.w \mat2, \tmp2
	eor.w \mat3, \tmp3

	str.w \mat0, [\ai, #4*1]
	str.w \mat1, [\ai, #4*2]
	str.w \mat2, [\ai, #4*3]
	str.w \mat3, [\ai, #4*4]
.endm

.macro gauss_elim_inner_last ai, pivotindex, tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmp10, tmp11
	vmov.w s10, \pivotindex
	mov.w \tmp1, #0
	1:
		vmov \pivotindex, s10
		cmp.w \tmp1, \pivotindex
		beq.w skip2

		lsrs.w \tmp0, \pivotindex, #1
		ldrb.n \tmp0, [\ai, \tmp0]
		ite cs
		lsrcs.w \tmp0, \tmp0, #4
		andcc \tmp0, \tmp0, #0xF
		vmov s9, \tmp1
		madd_row_bitsliced_last \tmp0, \ai, \tmp2, \tmp3, \tmp4, \tmp5, \tmp6, \tmp7, \tmp8, \tmp9, \tmp10, \tmp11, \tmp1, \pivotindex
		vmov \tmp1, s9
	skip2:
	add.w \tmp1, #1
	add.w \ai, #20
	cmp.w \tmp1, #32
	bne.w 1b
.endm




.macro conditional_add_first ai, ii, jj, aj, pivot, ai0, ai1, ai2, ai3, aj0, aj1, aj2, aj3
	add.w \jj, \ii, #1
	add.w \aj, \ai, #20
	1:
		// We could make the index computation faster by using another registers;
		// but then we would need another comparison for the ite
		lsrs.w \pivot, \ii, #1
		ldrb.n \pivot, [\ai, \pivot]
		// this selects the right GF16 depending on if ii is even or odd
		ite cs
		lsrcs.w \pivot, \pivot, #4
		andcc \pivot, \pivot, #0xF
		ldr.w \aj0, [\aj, #4*4]
		ldr.w \ai0, [\ai, #4*4]
		cmp.n \pivot, #0
		it eq
		eoreq \ai0, \ai0, \aj0
		str.w \ai0, [\ai, #4*4]
		ldr.w \aj1, [\aj, #4*1]
		ldr.w \aj2, [\aj, #4*2]
		ldr.w \aj3, [\aj, #4*3]
		ldr.w \aj0, [\aj], #20
		ldr.w \ai1, [\ai, #4*1]
		ldr.w \ai2, [\ai, #4*2]
		ldr.w \ai3, [\ai, #4*3]
		ldr.n \ai0, [\ai]
		itttt eq
		eoreq \ai0, \ai0, \aj0
		eoreq \ai1, \ai1, \aj1
		eoreq \ai2, \ai2, \aj2
		eoreq \ai3, \ai3, \aj3
		str.w \ai0, [\ai, #4*0]
		str.w \ai1, [\ai, #4*1]
		str.w \ai2, [\ai, #4*2]
		str.w \ai3, [\ai, #4*3]
		adds.w \jj, #1
		cmp.w \jj, #32
		bne.w 1b
.endm

.macro conditional_add_last ai, ii, jj, aj, pivot, ai0, ai1, ai2, ai3, aj0, aj1, aj2, aj3
	add.w \jj, \ii, #1
	add.w \aj, \ai, #24
	1:
		// We could make the index computation faster by using another registers;
		// but then we would need another comparison for the ite
		lsrs.w \pivot, \ii, #1
		ldrb.n \pivot, [\ai, \pivot]
		// this selects the right GF16 depending on if ii is even or odd
		ite cs
		lsrcs.w \pivot, \pivot, #4
		andcc \pivot, \pivot, #0xF

		cmp.n \pivot, #0
		ldr.w \aj1, [\aj, #4*1]
		ldr.w \aj2, [\aj, #4*2]
		ldr.w \aj3, [\aj, #4*3]
		ldr.w \aj0, [\aj], #20
		ldr.w \ai0, [\ai, #4*1]
		ldr.w \ai1, [\ai, #4*2]
		ldr.w \ai2, [\ai, #4*3]
		ldr.w \ai3, [\ai, #4*4]
		itttt eq
		eoreq \ai0, \ai0, \aj0
		eoreq \ai1, \ai1, \aj1
		eoreq \ai2, \ai2, \aj2
		eoreq \ai3, \ai3, \aj3
		str.w \ai0, [\ai, #4*1]
		str.w \ai1, [\ai, #4*2]
		str.w \ai2, [\ai, #4*3]
		str.w \ai3, [\ai, #4*4]
		adds.w \jj, #1
		cmp.w \jj, #32
		bne.w 1b
.endm



	.p2align 2,,3
	.global	gf16mat_solve_linear_eq_32x32_asm
	.arch armv7e-m
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	gf16mat_solve_linear_eq_32x32_asm, %function
gf16mat_solve_linear_eq_32x32_asm:
    push {r4-r11, r14}
	vpush.w {s0-s15}

	sol .req r0
	inpmat .req r1
	cterms .req r2

    ai .req r3
    ii .req r1
	pivot .req r2
	jj .req r4

	aj .req r14
	aj0 .req r9
	aj1 .req r6
	aj2 .req r7
	aj3 .req r8
	ai0 .req r5
	ai1 .req r10
	ai2 .req r11
	ai3 .req r12

	extmat_fpu   .req s0
	solution_fpu .req s11
	rc_fpu 		 .req s12

	vmov.w solution_fpu, sol
	// allocate  uint8_t mat[32*vec_len]
	sub.w sp, #32*20
	mov.w r0, sp
	vmov.w extmat_fpu, r0
	bl init_ext_mat


	// start Gauss elimination
	vmov.w ai, extmat_fpu
	mov.w ii, #0
	mov.w r0, #1
	outer: // outer loop: for each row

		// First: make sure that pivot in this row is not zero, by adding the other rows in case it is zero
		cmp.w ii, #8
		bge second
		conditional_add_first ai, ii, jj, aj, pivot, ai0, ai1, ai2, ai3, aj0, aj1, aj2, aj3
		b outer2
		second:
		conditional_add_last ai, ii, jj, aj, pivot, ai0, ai1, ai2, ai3, aj0, aj1, aj2, aj3
		outer2: // for the last row, we don't have rows left to add, so we skip the inner loop

		lsrs.w pivot, ii, #1
		ldrb.n pivot, [ai, pivot]
		ite cs
		lsrcs.w pivot, pivot, #4
		andcc pivot, pivot, #0xF

		cmp.n pivot, #0
		it eq
		moveq.w r0, #0

		vmov.w rc_fpu, r0

		mov.w r0, pivot
	    inverse pivot, r0, r4, r5
		push.w {ii, ai}

		cmp.w ii, #8
		bge second_half

		mul_row_bitsliced_first pivot, ai, r1, r0, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14
		ldr.w ii, [sp, #0]
		vmov.w r0, extmat_fpu
		gauss_elim_inner_first r0, ii, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14
		b end
		second_half:
		mul_row_bitsliced_last pivot, ai, r1, r0, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14
		ldr.w ii, [sp, #0]
		vmov.w r0, extmat_fpu
		gauss_elim_inner_last r0, ii, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r14
		end:

		pop.w {ii, ai}
		vmov.w r0, rc_fpu
		add ai, ai, #20
		add.w ii, ii, #1
		cmp.w ii, #31
		blt.w outer
		beq.w outer2


	vmov.w r0, solution_fpu
	vmov.w r1, extmat_fpu
	bl get_solution
	vmov.w r0, rc_fpu

	// restore sp
	add.w sp, #32*20

	vpop.w {s0-s15}
    pop {r4-r11, pc}

	.p2align 2,,3
	.global	init_ext_mat
	.arch armv7e-m
	.syntax unified
	.thumb
	.thumb_func
	.type	init_ext_mat, %function
init_ext_mat:
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	ip, r0
	mov	r9, r1
	mov	r8, r2
	movs	r6, #0
.L3:
	and	r4, r6, #1
	sbfx	lr, r6, #0, #1
	subs	r4, r4, #1
	lsrs	r7, r6, #1
	uxtb	lr, lr
	sxtb	r4, r4
	movs	r1, #0
	add	r5, r9, r6, lsr #1
.L2:
	lsls	r3, r1, #4
	lsrs	r0, r1, #1
	ldrb	r2, [r5, r3]	@ zero_extendqisi2
	and	r3, r2, #15
	sbfx	fp, r1, #0, #1
	ands	r3, r3, r4
	and	r2, lr, r2, lsr #4
	orrs	r2, r2, r3
	uxtb	fp, fp
	ldrb	r3, [ip, r0]	@ zero_extendqisi2
	eor	r10, fp, #15
	eor	fp, fp, #240
	and	r3, r3, fp
	and	fp, r10, r2
	adds	r1, r1, #1
	orr	r3, r3, fp
	and	r2, r10, r2, lsl #4
	orrs	r3, r3, r2
	cmp	r1, #32
	strb	r3, [ip, r0]
	bne	.L2
	ldrb	r3, [r8, r7]	@ zero_extendqisi2
	and	r2, r3, #15
	adds	r6, r6, #1
	and	lr, lr, r3, lsr #4
	ands	r4, r4, r2
	orr	r4, lr, r4
	cmp	r6, #32
	strb	r4, [ip, #16]
	add	ip, ip, #20
	bne	.L3
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}


	.p2align 2,,3
	.global	get_solution
	.arch armv7e-m
	.syntax unified
	.thumb
	.thumb_func
	.type	get_solution, %function
get_solution:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r4, r0
	mov	lr, #0
1:
	lsr	r0, lr, #1
	sbfx	ip, lr, #0, #1
	ldrb	r2, [r1, #16]	@ zero_extendqisi2
	ldrb	r3, [r4, r0]	@ zero_extendqisi2
	uxtb	ip, ip
	eor	r5, ip, #15
	eor	ip, ip, #240
	and	r3, r3, ip
	and	ip, r5, r2, lsl #4
	ands	r2, r2, r5
	orr	r3, r3, ip
	and	r2, r2, #15
	add	lr, lr, #1
	orrs	r3, r3, r2
	cmp	lr, #32
	strb	r3, [r4, r0]
	add	r1, r1, #20
	bne	1b
	pop	{r4, r5, pc}