#include "macros_fnt.i"
.macro final_butterfly c0, c1, c1f, twiddle
    vmov.w \c1, \c1f
    add.w \c0, \c1
    sub.w \c1, \c0, \c1, lsl#1
    mul.w \c1, \twiddle
.endm

.macro final_butterfly2 c0, c0out, c1, c1f, twiddle, twiddle2
    vmov.w \c1, \c1f
    mla.w \c0out, \twiddle2, \c1, \c0
    mls.w \c1, \twiddle2, \c1, \c0
    mul.w \c1, \twiddle
.endm

.syntax unified
.cpu cortex-m4
.align 2
.global __asm_ifnt_257
.type __asm_ifnt_257, %function
__asm_ifnt_257:
    push.w {r4-r11, lr}
    vpush.w {s16-s24}

    .equ width, 4

    add.w r12, r0, #256*width
    vmov.w s1, r12
    _ifnt_7_6_5_4:

        vldm.w r1!, {s2-s16}

// ================

            ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(2*8*width), #(2*9*width), #(2*10*width), #(2*11*width), #(2*12*width), #(2*13*width), #(2*14*width), #(2*15*width)

            addSub4 r4, r5, r6, r7, r8, r9, r10, r11
            vmov.w r14, s6
            mul.w r5, r5, r14
            vmov.w r14, s8
            mul.w r9, r9, r14
            addSub2 r4, r6, r8, r10
            vmov.w r14, s7
            mla.w r12, r7, r14, r5
            mls.w r7, r7, r14, r5
            vmov.w r14, s9
            mla.w r5, r11, r14, r9
            mls.w r11, r11, r14, r9

            // r4, r12, r6, r7, r8, r5, r10, r11

            vmov.w r14, s12
            mul.w r6, r6, r14
            mul.w r7, r7, r14
            vmov.w r14, s13
            mul.w r10, r10, r14
            mul.w r11, r11, r14

    barrett_32 r4, r2, r3, r14
    barrett_32 r12, r2, r3, r14
    barrett_32 r6, r2, r3, r14
    barrett_32 r7, r2, r3, r14
    barrett_32 r8, r2, r3, r14
    barrett_32 r5, r2, r3, r14
    barrett_32 r10, r2, r3, r14
    barrett_32 r11, r2, r3, r14

            addSub4 r4, r8, r6, r10, r12, r5, r7, r11

            vmov.w s17, s18, r4, r12
            vmov.w s19, s20, r6, r7
            vmov.w s21, s22, r8, r5
            vmov.w s23, s24, r10, r11

            ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(2*0*width), #(2*1*width), #(2*2*width), #(2*3*width), #(2*4*width), #(2*5*width), #(2*6*width), #(2*7*width)

            addSub4 r4, r5, r6, r7, r8, r9, r10, r11
            vmov.w r14, s2
            mul.w r5, r5, r14
            vmov.w r14, s4
            mul.w r9, r9, r14
            addSub2 r4, r6, r8, r10
            vmov.w r14, s3
            mla.w r12, r7, r14, r5
            mls.w r7, r7, r14, r5
            vmov.w r14, s5
            mla.w r5, r11, r14, r9
            mls.w r11, r11, r14, r9

            // r4, r12, r6, r7, r8, r5, r10, r11

            vmov.w r14, s10
            mul.w r6, r6, r14
            mul.w r7, r7, r14
            vmov.w r14, s11
            mul.w r10, r10, r14
            mul.w r11, r11, r14

    barrett_32 r4, r2, r3, r14
    barrett_32 r12, r2, r3, r14
    barrett_32 r6, r2, r3, r14
    barrett_32 r7, r2, r3, r14
    barrett_32 r8, r2, r3, r14
    barrett_32 r5, r2, r3, r14
    barrett_32 r10, r2, r3, r14
    barrett_32 r11, r2, r3, r14

            addSub4 r4, r8, r6, r10, r12, r5, r7, r11
            vmov.w r14, s14
            mul.w r8, r8, r14
            mul.w r5, r5, r14
            mul.w r10, r10, r14
            mul.w r11, r11, r14
            vmov.w r14, s16
            final_butterfly r12, r9, s18, r14
            str.w r12, [r0, #(2*1*width)]
            str.w r9, [r0, #(2*9*width)]
            final_butterfly r6, r9, s19, r14
            str.w r6, [r0, #(2*2*width)]
            str.w r9, [r0, #(2*10*width)]
            final_butterfly r7, r9, s20, r14
            str.w r7, [r0, #(2*3*width)]
            str.w r9, [r0, #(2*11*width)]
            vmov.w r12, s15
            final_butterfly2 r8, r6, r9, s21, r14, r12
            str.w r6, [r0, #(2*4*width)]
            str.w r9, [r0, #(2*12*width)]
            final_butterfly2 r5, r6, r9, s22, r14, r12
            str.w r6, [r0, #(2*5*width)]
            str.w r9, [r0, #(2*13*width)]
            final_butterfly2 r10, r6, r9, s23, r14, r12
            str.w r6, [r0, #(2*6*width)]
            str.w r9, [r0, #(2*14*width)]
            final_butterfly2 r11, r6, r9, s24, r14, r12
            str.w r6, [r0, #(2*7*width)]
            str.w r9, [r0, #(2*15*width)]
            final_butterfly r4, r9, s17, r14
            str.w r9, [r0, #(2*8*width)]
            str.w r4, [r0], #width

// ================

            ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(2*8*width), #(2*9*width), #(2*10*width), #(2*11*width), #(2*12*width), #(2*13*width), #(2*14*width), #(2*15*width)

            addSub4 r4, r5, r6, r7, r8, r9, r10, r11
            vmov.w r14, s6
            mul.w r5, r5, r14
            vmov.w r14, s8
            mul.w r9, r9, r14
            addSub2 r4, r6, r8, r10
            vmov.w r14, s7
            mla.w r12, r7, r14, r5
            mls.w r7, r7, r14, r5
            vmov.w r14, s9
            mla.w r5, r11, r14, r9
            mls.w r11, r11, r14, r9

            // r4, r12, r6, r7, r8, r5, r10, r11

            vmov.w r14, s12
            mul.w r6, r6, r14
            mul.w r7, r7, r14
            vmov.w r14, s13
            mul.w r10, r10, r14
            mul.w r11, r11, r14

    barrett_32 r4, r2, r3, r14
    barrett_32 r12, r2, r3, r14
    barrett_32 r6, r2, r3, r14
    barrett_32 r7, r2, r3, r14
    barrett_32 r8, r2, r3, r14
    barrett_32 r5, r2, r3, r14
    barrett_32 r10, r2, r3, r14
    barrett_32 r11, r2, r3, r14

            addSub4 r4, r8, r6, r10, r12, r5, r7, r11

            vmov.w s17, s18, r4, r12
            vmov.w s19, s20, r6, r7
            vmov.w s21, s22, r8, r5
            vmov.w s23, s24, r10, r11

            ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(2*0*width), #(2*1*width), #(2*2*width), #(2*3*width), #(2*4*width), #(2*5*width), #(2*6*width), #(2*7*width)

            addSub4 r4, r5, r6, r7, r8, r9, r10, r11
            vmov.w r14, s2
            mul.w r5, r5, r14
            vmov.w r14, s4
            mul.w r9, r9, r14
            addSub2 r4, r6, r8, r10
            vmov.w r14, s3
            mla.w r12, r7, r14, r5
            mls.w r7, r7, r14, r5
            vmov.w r14, s5
            mla.w r5, r11, r14, r9
            mls.w r11, r11, r14, r9

            // r4, r12, r6, r7, r8, r5, r10, r11

            vmov.w r14, s10
            mul.w r6, r6, r14
            mul.w r7, r7, r14
            vmov.w r14, s11
            mul.w r10, r10, r14
            mul.w r11, r11, r14

    barrett_32 r4, r2, r3, r14
    barrett_32 r12, r2, r3, r14
    barrett_32 r6, r2, r3, r14
    barrett_32 r7, r2, r3, r14
    barrett_32 r8, r2, r3, r14
    barrett_32 r5, r2, r3, r14
    barrett_32 r10, r2, r3, r14
    barrett_32 r11, r2, r3, r14

            addSub4 r4, r8, r6, r10, r12, r5, r7, r11
            vmov.w r14, s14
            mul.w r8, r8, r14
            mul.w r5, r5, r14
            mul.w r10, r10, r14
            mul.w r11, r11, r14
            vmov.w r14, s16

            final_butterfly r12, r9, s18, r14
            str.w r12, [r0, #(2*1*width)]
            str.w r9, [r0, #(2*9*width)]
            final_butterfly r6, r9, s19, r14
            str.w r6, [r0, #(2*2*width)]
            str.w r9, [r0, #(2*10*width)]
            final_butterfly r7, r9, s20, r14
            str.w r7, [r0, #(2*3*width)]
            str.w r9, [r0, #(2*11*width)]
            vmov.w r12, s15
            final_butterfly2 r8, r6, r9, s21, r14, r12
            str.w r6, [r0, #(2*4*width)]
            str.w r9, [r0, #(2*12*width)]
            final_butterfly2 r5, r6, r9, s22, r14, r12
            str.w r6, [r0, #(2*5*width)]
            str.w r9, [r0, #(2*13*width)]
            final_butterfly2 r10, r6, r9, s23, r14, r12
            str.w r6, [r0, #(2*6*width)]
            str.w r9, [r0, #(2*14*width)]
            final_butterfly2 r11, r6, r9, s24, r14, r12
            str.w r6, [r0, #(2*7*width)]
            str.w r9, [r0, #(2*15*width)]
            final_butterfly r4, r9, s17, r14
            str.w r9, [r0, #(2*8*width)]
            str.w r4, [r0], #31*width

// ================

    vmov.w r12, s1
    cmp.w r0, r12
    bne.w _ifnt_7_6_5_4

    sub.w r0, r0, #256*width

    mov.w r14, #0

    add.w r1, r0, #32*width
    _ifnt_0_1_2:

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(32*0*width), #(32*1*width), #(32*2*width), #(32*3*width), #(32*4*width), #(32*5*width), #(32*6*width), #(32*7*width)

    addSub4 r4, r5, r6, r7, r8, r9, r10, r11

    addSub2 r4, r6, r8, r10
    FNT_CT_ibutterfly r5, r7, 4
    FNT_CT_ibutterfly r9, r11, 4

    addSub1 r4, r8
    barrett_32 r9, r2, r3, r12
    FNT_CT_ibutterfly r5, r9, 6
    FNT_CT_ibutterfly r6, r10, 4
    FNT_CT_ibutterfly r7, r11, 2

    barrett_32 r6, r2, r3, r12
    barrett_32 r7, r2, r3, r12
    sub.w r4, r14, r4, lsl #1
    neg.w r5, r5
    lsl.w r6, r6, #7
    lsl.w r7, r7, #6
    lsl.w r8, r8, #5
    lsl.w r9, r9, #4
    lsl.w r10, r10, #3
    lsl.w r11, r11, #2

    barrett_32 r4, r2, r3, r12
    barrett_32 r5, r2, r3, r12
    barrett_32 r6, r2, r3, r12
    barrett_32 r7, r2, r3, r12
    barrett_32 r8, r2, r3, r12
    barrett_32 r9, r2, r3, r12
    barrett_32 r10, r2, r3, r12
    barrett_32 r11, r2, r3, r12

    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(32*1*width), #(32*2*width), #(32*3*width), #(32*4*width), #(32*5*width), #(32*6*width), #(32*7*width), #width

.endr

    cmp.w r0, r1
    bne.w _ifnt_0_1_2
    vpop.w {s16-s24}
    pop.w {r4-r11, pc}
