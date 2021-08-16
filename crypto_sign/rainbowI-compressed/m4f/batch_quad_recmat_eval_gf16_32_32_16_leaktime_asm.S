.syntax unified
.cpu cortex-m4
.thumb
#include "madd_bitsliced.inc"
#include "bitslice.inc"
#include "recmat.inc"



.global batch_quad_recmat_eval_gf16_32_32_16_leaktime_asm
.type batch_quad_recmat_eval_gf16_32_32_16_leaktime_asm, %function
.align 2
batch_quad_recmat_eval_gf16_32_32_16_leaktime_asm:
	push.w {r4-r11, r14}

    recmat .req r1
    x_ptr  .req r3
    y_ptr  .req r2
    lutgf  .req r4

    ctr1 .req r5
    ctr2 .req r5
    ctr3 .req r6

    x_elements .req r7
    y_elements .req r8

    buf0       .req r9
    buf1       .req r10
    buf2       .req r11
    buf3       .req r12


    xiyi       .req r0
    yi         .req r14

    x_ptr_fpu  .req s2
    y_ptr_fpu  .req s3
    ctr1_fpu   .req s4
    ldr.w lutgf, [sp, #9*4]

    vmov.w s0, r0 // store result pointer
    vmov.w x_ptr_fpu, x_ptr // store x_ptr
    vmov.w y_ptr_fpu, y_ptr // store y_ptr

    // allocate tmp
    sub.w sp, sp, #16*16

    // init tmp to zero
	mov.w r0, #0
	.set i, 0
	.rept 30
		strd.w r0, r0, [sp, #16+i*8]
		.set i, i+1
	.endr

    mov.w ctr1, #32/8
    1:
        vmov.w ctr1_fpu, ctr1
        ldr.w y_elements, [y_ptr], #4
        mov.w ctr2, #8
        2:
            ands.w yi, y_elements, #0xF
            beq.w skip_outer32

            mov.w ctr3, #32/8
            vmov.w x_ptr, x_ptr_fpu
            3:
                ldr.w x_elements, [x_ptr], #4
                .set ii, 0
                .rept 8
                    ubfx.w xiyi, x_elements, #ii*4, #4

                    orr.w xiyi, yi, xiyi, lsl#4
                    recmat_inner xiyi, lutgf, recmat, buf0, buf1, buf2, buf3
                    .set ii, ii+1
                .endr
                subs.w ctr3, ctr3, #1
                bne 3b
            cont_outer32:
            lsr.w y_elements, y_elements, #4
            subs.w ctr2, ctr2, #1
            bne 2b

        vmov.w ctr1, ctr1_fpu
        subs.w ctr1, ctr1, #1
        bne.w 1b

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
	add.w sp, sp, #16*16 //16*M
	pop.w {r4-r11, pc}

    skip_outer32:
        add.w recmat, recmat, #32*16
        b cont_outer32