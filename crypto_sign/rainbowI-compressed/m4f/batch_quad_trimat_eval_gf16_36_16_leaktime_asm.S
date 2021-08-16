.syntax unified
.cpu cortex-m4
.thumb

#include "bitslice.inc"
#include "madd_bitsliced.inc"

.global batch_quad_trimat_eval_gf16_36_16_leaktime_asm
.type batch_quad_trimat_eval_gf16_36_16_leaktime_asm, %function
.align 2
batch_quad_trimat_eval_gf16_36_16_leaktime_asm:
	push.w {r4-r11, r14}
	ctr1   .req r0
	trimat .req r1
	ctr2   .req r2
	xi	   .req r3

	xj       .req r5
	lutgf    .req r0
	mat0     .req r6
	mat1     .req r7
	mat2     .req r8
	mat3     .req r9
	buf0     .req r10
	buf1     .req r11
	buf2     .req r12
	buf3     .req r14
	tmp    	 .req sp
	xptr     .req r4
    // N=36, M=16
	sub.w sp, sp, #16*16+36 //16*M + N
	add.w xptr, sp, #16*16  //16*M
	vmov.w s0, r0
	vmov.w s2, r3

	// init tmp to zero
	mov.w r0, #0
	.set i, 0
	.rept 30 // 16*M / 8
		strd.w r0, r0, [sp, #16+i*8] // skip the first M bytes
		.set i, i+1
	.endr

	// set _x
	.set i, 0
	.rept 4 // N / 8
	ldr.w r0, [r2, #i*4]
	and.w r3, r0, #0xF
	and.w r5, r0, #0xF0
	add.w r3, r3, r5, lsl#4
	and.w r5, r0, #0xF00
	add.w r3, r3, r5, lsl#8
	and.w r5, r0, #0xF000
	add.w r3, r3, r5, lsl#12
	str.w r3, [xptr, #i*8]
	ubfx.w r3, r0, #16, #4
	and.w r5, r0, #0xF00000
	add.w r3, r3, r5, lsr#12
	and.w r5, r0, #0xF000000
	add.w r3, r3, r5, lsr#8
	and.w r5, r0, #0xF0000000
	add.w r3, r3, r5, lsr#4
	str.w r3, [xptr, #i*8+4]
	.set i, i+1
	.endr
    ldrh.w r0, [r2, #16]
	and.w r3, r0, #0xF
	and.w r5, r0, #0xF0
	add.w r3, r3, r5, lsl#4
	and.w r5, r0, #0xF00
	add.w r3, r3, r5, lsl#8
	and.w r5, r0, #0xF000
	add.w r3, r3, r5, lsl#12
	str.w r3, [xptr, #32]
	// setting _x done;

	mov.w ctr1, #36 // N
	vmov.w s1, xptr
	outer4: // for(int i=0;i<dim;i++)
		vmov.w xptr, s1
		ldrb.w xi, [xptr], #1
		vmov.w s1, xptr

		// if 0, do nothing
		cmp.w xi, #0
		beq.w skip_outer4

		mov.w ctr2, ctr1
		vmov.w s3, ctr1
		vmov.w lutgf, s2
		sub.w xptr, xptr, #1
		inner4: // for(int j=i; j<dim; j++)
			ldrb.w xj, [xptr], #1
			// if 0, do nothing
			cmp.w xj, #0
			beq.w skip_inner4
			orr.w xj, xi, xj, lsl#4
			ldrb.w xj, [lutgf, xj]

			// compute address of buffer
			add.w xj, sp, xj, lsl#4 // log_2(M)

			ldr.w buf0, [xj, #0]
			ldr.w buf1, [xj, #4]
			ldr.w buf2, [xj, #8]
			ldr.w buf3, [xj, #12]
			ldr.w mat1, [trimat, #4]
			ldr.w mat2, [trimat, #8]
			ldr.w mat3, [trimat, #12]
			ldr.w mat0, [trimat], #16
			eor.w buf0, buf0, mat0
			str.w buf0, [xj, #0]
			eor.w buf1, buf1, mat1
			str.w buf1, [xj, #4]
			eor.w buf2, buf2, mat2
			str.w buf2, [xj, #8]
			eor.w buf3, buf3, mat3
			str.w buf3, [xj, #12]

			subs.w ctr2, ctr2, #1
			bne.w inner4
			cont_inner4:

		vmov.w ctr1, s3
		subs.w ctr1, ctr1, #1
		bne.w outer4
	cont_outer4:
	// do the actual multiplication
	add.w r1, sp, #16 // M
    ldr.w r7, [r1, #4]
    ldr.w r8, [r1, #8]
    ldr.w r9, [r1, #12]
    ldr.w r6, [r1], #16 // M
    bitslice r2, r3, r4, r5, r6, r7, r8, r9
    mov.w r0, #2
    1:
        ldr.w r7, [r1, #4]
        ldr.w r8, [r1, #8]
        ldr.w r9, [r1, #12]
        ldr.w r6, [r1], #16 // M

        bitslice r10, r11, r12, r14, r6, r7, r8, r9
        madd_bitsliced r2, r3, r4, r5, r10, r11, r12, r14, r0, r6, r7, r8, r9

        add.w r0, r0, #1
        cmp.w r0, #16
        bne.w 1b

    bitslice r6, r7, r8, r9, r2, r3, r4, r5
	vmov.w r0, s0
    str.w r6, [r0]
    str.w r7, [r0, #4]
    str.w r8, [r0, #8]
    str.w r9, [r0, #12]
	add.w sp, sp, #16*16+36 //16*M + N
	pop.w {r4-r11, pc}

	skip_inner4:
		add.w trimat, trimat, #16 // M
		subs.w ctr2, ctr2, #1
		bne.w inner4
		b cont_inner4
	skip_outer4:
		add.w trimat, trimat,  ctr1, lsl#4 // log_2(M)
		subs.w ctr1, ctr1, #1
		bne.w outer4
		b cont_outer4
