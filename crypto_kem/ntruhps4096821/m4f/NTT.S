
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_3x2block_ntt
.type __asm_3x2block_ntt, %function
__asm_3x2block_ntt:
    push.w {r4-r12, lr}
    vpush.w {s16-s22}

    .equ width, 4
    .equ base, 3

    ldm.w r1!, {r10-r11}
    vldm.w r1, {s4-s21}

#ifdef LOOP
    add.w r12, r0, #3*width
    vmov.w s2, r12
    _3x2_light:
#else
.rept 3
#endif

#ifdef LOOP
    add.w r14, r0, #432*width
    vmov.w s3, r14
    _3x2_light_inner:
#else
.rept 16
#endif

    ldr.w r4, [r0, #0*base*width]
    ldr.w r5, [r0, #1*base*width]
    ldr.w r6, [r0, #2*base*width]
    ldr.w r7, [r0, #(432+0*base)*width]
    ldr.w r8, [r0, #(432+1*base)*width]
    ldr.w r9, [r0, #(432+2*base)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14
    str.w r5, [r0, #1*base*width]
    str.w r6, [r0, #2*base*width]
    str.w r7, [r0, #(432+0*base)*width]
    str.w r8, [r0, #(432+1*base)*width]
    str.w r9, [r0, #(432+2*base)*width]
    str.w r4, [r0], #9*width

    ldr.w r4, [r0, #0*base*width]
    ldr.w r5, [r0, #1*base*width]
    ldr.w r6, [r0, #2*base*width]
    ldr.w r7, [r0, #(432+0*base)*width]
    ldr.w r8, [r0, #(432+1*base)*width]
    ldr.w r9, [r0, #(432+2*base)*width]
    vmov.w r1, s8
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s9
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14
    str.w r5, [r0, #1*base*width]
    str.w r6, [r0, #2*base*width]
    str.w r7, [r0, #(432+0*base)*width]
    str.w r8, [r0, #(432+1*base)*width]
    str.w r9, [r0, #(432+2*base)*width]
    str.w r4, [r0], #9*width

    ldr.w r4, [r0, #0*base*width]
    ldr.w r5, [r0, #1*base*width]
    ldr.w r6, [r0, #2*base*width]
    ldr.w r7, [r0, #(432+0*base)*width]
    ldr.w r8, [r0, #(432+1*base)*width]
    ldr.w r9, [r0, #(432+2*base)*width]
    vmov.w r1, s11
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s12
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14
    str.w r5, [r0, #1*base*width]
    str.w r6, [r0, #2*base*width]
    str.w r7, [r0, #(432+0*base)*width]
    str.w r8, [r0, #(432+1*base)*width]
    str.w r9, [r0, #(432+2*base)*width]
    str.w r4, [r0], #9*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3x2_light_inner
#else
.endr
#endif

    sub.w r0, r0, #432*width
    add.w r0, r0, #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2_light
#else
.endr
#endif

    sub.w r0, r0, #3*width
    add.w r0, r0, #864*width

#ifdef LOOP
    add.w r12, r0, #3*width
    vmov.w s2, r12
    _3x2:
#else
.rept 3
#endif

#ifdef LOOP
    add.w r14, r0, #432*width
    vmov.w s3, r14
    _3x2_inner:
#else
.rept 16
#endif

    ldr.w r4, [r0, #0*base*width]
    ldr.w r5, [r0, #1*base*width]
    ldr.w r6, [r0, #2*base*width]
    ldr.w r7, [r0, #(432+0*base)*width]
    ldr.w r8, [r0, #(432+1*base)*width]
    ldr.w r9, [r0, #(432+2*base)*width]
    vmov.w r1, s13
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    vmov.w r1, s14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s15
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14
    str.w r5, [r0, #1*base*width]
    str.w r6, [r0, #2*base*width]
    str.w r7, [r0, #(432+0*base)*width]
    str.w r8, [r0, #(432+1*base)*width]
    str.w r9, [r0, #(432+2*base)*width]
    str.w r4, [r0], #9*width

    ldr.w r4, [r0, #0*base*width]
    ldr.w r5, [r0, #1*base*width]
    ldr.w r6, [r0, #2*base*width]
    ldr.w r7, [r0, #(432+0*base)*width]
    ldr.w r8, [r0, #(432+1*base)*width]
    ldr.w r9, [r0, #(432+2*base)*width]
    vmov.w r1, s8
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    vmov.w r1, s9
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    vmov.w r1, s16
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    vmov.w r1, s17
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s18
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14
    str.w r5, [r0, #1*base*width]
    str.w r6, [r0, #2*base*width]
    str.w r7, [r0, #(432+0*base)*width]
    str.w r8, [r0, #(432+1*base)*width]
    str.w r9, [r0, #(432+2*base)*width]
    str.w r4, [r0], #9*width

    ldr.w r4, [r0, #0*base*width]
    ldr.w r5, [r0, #1*base*width]
    ldr.w r6, [r0, #2*base*width]
    ldr.w r7, [r0, #(432+0*base)*width]
    ldr.w r8, [r0, #(432+1*base)*width]
    ldr.w r9, [r0, #(432+2*base)*width]
    vmov.w r1, s11
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    vmov.w r1, s12
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    vmov.w r1, s19
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    vmov.w r1, s20
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s21
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14
    str.w r5, [r0, #1*base*width]
    str.w r6, [r0, #2*base*width]
    str.w r7, [r0, #(432+0*base)*width]
    str.w r8, [r0, #(432+1*base)*width]
    str.w r9, [r0, #(432+2*base)*width]
    str.w r4, [r0], #9*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3x2_inner
#else
.endr
#endif

    sub.w r0, r0, #432*width
    add.w r0, r0, #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3x2
#else
.endr
#endif

    vpop.w {s16-s22}
    pop.w {r4-r12, pc}

.align 2
.global __asm_ntt
.type __asm_ntt, %function
__asm_ntt:
    push.w {r4-r12, lr}
    vpush.w {s16-s31}

    .equ width, 4

    add.w r1, r1, #3*width
    vmov.w s1, r1

    vmov.w r1, s1
    vldm.w r1!, {s4-s18}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #27*width
    vmov.w s2, r12
    _2_3_4_5_light:
#else
.rept 27
#endif

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*27*width), #(3*27*width), #(5*27*width), #(7*27*width), #(9*27*width), #(11*27*width), #(13*27*width), #(15*27*width)
    _3_layer_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s12
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    vmov.w r1, s13
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    vmov.w r1, s14
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    vmov.w r1, s15
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s16
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    vmov.w r1, s17
    montgomery_mul_32 r10, r1, r2, r3, r12, r14
    vmov.w r1, s18
    montgomery_mul_32 r11, r1, r2, r3, r12, r14

    vmov.w s20, s21, r4, r5
    vmov.w s22, s23, r6, r7
    vmov.w s24, s25, r8, r9
    vmov.w s26, s27, r10, r11

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*27*width), #(2*27*width), #(4*27*width), #(6*27*width), #(8*27*width), #(10*27*width), #(12*27*width), #(14*27*width)
    _3_layer_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*27*width), #(9*27*width), #(10*27*width), #(11*27*width), #(12*27*width), #(13*27*width), #(14*27*width), #(15*27*width)

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*27*width), #(2*27*width), #(3*27*width), #(4*27*width), #(5*27*width), #(6*27*width), #(7*27*width), #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _2_3_4_5_light
#else
.endr
#endif

    add.w r0, r0, #405*width

#ifdef LOOP
    add.w r12, r0, #3*432*width
    vmov.w s2, r12
    _2_3_4_5:
#else
.rept 3
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s18}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #27*width
    vmov.w s3, r14
    _2_3_4_5_inner:
#else
.rept 27
#endif

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*27*width), #(3*27*width), #(5*27*width), #(7*27*width), #(9*27*width), #(11*27*width), #(13*27*width), #(15*27*width)
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r1, s11
    montgomery_mul_32 r4, r1, r2, r3, r12, r14
    vmov.w r1, s12
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    vmov.w r1, s13
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    vmov.w r1, s14
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    vmov.w r1, s15
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s16
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    vmov.w r1, s17
    montgomery_mul_32 r10, r1, r2, r3, r12, r14
    vmov.w r1, s18
    montgomery_mul_32 r11, r1, r2, r3, r12, r14

    vmov.w s20, s21, r4, r5
    vmov.w s22, s23, r6, r7
    vmov.w s24, s25, r8, r9
    vmov.w s26, s27, r10, r11

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*27*width), #(2*27*width), #(4*27*width), #(6*27*width), #(8*27*width), #(10*27*width), #(12*27*width), #(14*27*width)
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*27*width), #(9*27*width), #(10*27*width), #(11*27*width), #(12*27*width), #(13*27*width), #(14*27*width), #(15*27*width)

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*27*width), #(2*27*width), #(3*27*width), #(4*27*width), #(5*27*width), #(6*27*width), #(7*27*width), #width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _2_3_4_5_inner
#else
.endr
#endif

    add.w r0, r0, #405*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _2_3_4_5
#else
.endr
#endif

    vpop.w {s16-s31}
    pop.w {r4-r12, pc}









