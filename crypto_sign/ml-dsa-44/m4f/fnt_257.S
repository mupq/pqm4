#include "macros_fnt.i"
.macro final_butterfly c0, c1f, twiddle, c0out, c1, qprime, q, tmp
    vmov.w \c1, \c1f
    vmov.w \tmp, \twiddle

    mla \c0out, \c1, \tmp, \c0
    mls \c1, \c1, \tmp, \c0

    barrett_32 \c0out, \qprime, \q, \tmp
    barrett_32 \c1, \qprime, \q, \tmp
.endm


.syntax unified
.cpu cortex-m4

.align 2
.global __asm_fnt_257
.type __asm_fnt_257, %function
__asm_fnt_257:
    push.w {r4-r11, lr}
    vpush.w {s16-s27}

    vmov.w s27, r1

    .equ width, 4

    add.w r12, r0, #32*width
    _fnt_0_1_2:

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(32*0*width), #(32*1*width), #(32*2*width), #(32*3*width), #(32*4*width), #(32*5*width), #(32*6*width), #(32*7*width)

    FNT_CT_butterfly  r4,  r8, 4
    FNT_CT_butterfly  r5,  r9, 4
    FNT_CT_butterfly  r6, r10, 4
    FNT_CT_butterfly  r7, r11, 4

    FNT_CT_butterfly  r4,  r6, 2
    FNT_CT_butterfly  r5,  r7, 2
    FNT_CT_butterfly  r8, r10, 6
    FNT_CT_butterfly  r9, r11, 6

    FNT_CT_butterfly  r4, r5, 1
    FNT_CT_butterfly  r6, r7, 5
    FNT_CT_butterfly  r8, r9, 3
    FNT_CT_butterfly  r10, r11, 7

    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(32*1*width), #(32*2*width), #(32*3*width), #(32*4*width), #(32*5*width), #(32*6*width), #(32*7*width), #width

    cmp.w r0, r12
    bne.w _fnt_0_1_2

    sub.w r0, r0, #32*width

    add.w r12, r0, #256*width
    vmov.w s25, r12
    _fnt_3_4_5_6:

        vmov r1, s27
        vldm.w r1!, {s2-s16}
        vmov s27, r1

        .rept 2
            ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(4*0*width+2*width), #(4*1*width+2*width), #(4*2*width+2*width), #(4*3*width+2*width), #(4*4*width+2*width), #(4*5*width+2*width), #(4*6*width+2*width), #(4*7*width+2*width)

            _3_layer_CT_32_FNT r4, r5, r6, r7, r8, r9, r10, r11, s2, s3, s4, s5, s6, s7, s8, r14, r2, r3, r1, r12

            vmov.w s17, s18, r4, r5 // a1, a3
            vmov.w s19, s20, r6, r7 // a5, a7
            vmov.w s21, s22, r8, r9 // a9, a11
            vmov.w s23, s24, r10, r11 // a13, a15

            ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(4*0*width), #(4*1*width), #(4*2*width), #(4*3*width), #(4*4*width), #(4*5*width), #(4*6*width), #(4*7*width)

            _3_layer_CT_32_FNT r4, r5, r6, r7, r8, r9, r10, r11, s2, s3, s4, s5, s6, s7, s8, r14, r2, r3, r1, r12

            final_butterfly r5, s18, s10, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*1*width+2*width)]
            str.w r1, [r0, #(4*1*width)]

            final_butterfly r6, s19, s11, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*2*width+2*width)]
            str.w r1, [r0, #(4*2*width)]

            final_butterfly r7, s20, s12, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*3*width+2*width)]
            str.w r1, [r0, #(4*3*width)]

            final_butterfly r8, s21, s13, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*4*width+2*width)]
            str.w r1, [r0, #(4*4*width)]

            final_butterfly r9, s22, s14, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*5*width+2*width)]
            str.w r1, [r0, #(4*5*width)]

            final_butterfly r10, s23, s15, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*6*width+2*width)]
            str.w r1, [r0, #(4*6*width)]

            final_butterfly r11, s24, s16, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*7*width+2*width)]
            str.w r1, [r0, #(4*7*width)]

            final_butterfly r4, s17, s9, r1, r12, r2, r3, r14
            str.w r12, [r0, #(4*0*width+2*width)]
            str.w r1, [r0], #width
        .endr
        add.w r0, #((32-2)*width)

    vmov.w r12, s25
    cmp.w r0, r12
    bne.w _fnt_3_4_5_6

    # switch to 16-bit representation
    sub.w r0, r0, #256*width
    mov.w r1, r0
    _fnt_to_16_bit:
        ldr.w r3, [r0, #1*width]
        ldr.w r4, [r0, #2*width]
        ldr.w r5, [r0, #3*width]
        ldr.w r6, [r0, #4*width]
        ldr.w r7, [r0, #5*width]
        ldr.w r8, [r0, #6*width]
        ldr.w r9, [r0, #7*width]
        ldr.w r2, [r0], #8*width
        strh.w r3, [r1, #1*2]
        strh.w r4, [r1, #2*2]
        strh.w r5, [r1, #3*2]
        strh.w r6, [r1, #4*2]
        strh.w r7, [r1, #5*2]
        strh.w r8, [r1, #6*2]
        strh.w r9, [r1, #7*2]
        strh.w r2, [r1], #8*2
        cmp.w r0, r12
        bne.w _fnt_to_16_bit

    vpop.w {s16-s27}
    pop.w {r4-r11, pc}






