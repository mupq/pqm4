#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push.w {r4-r12, lr}

    .equ width, 4

    add.w r1, r1, #7*width
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #1728*width
    vmov.w s2, r12
    _i_5_4_3:
#else
.rept 8
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #27*width
    vmov.w s3, r14
    _i_5_4_3_inner:
#else
.rept 9
#endif

.rept 3

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*27*width), #(1*27*width), #(2*27*width), #(3*27*width), #(4*27*width), #(5*27*width), #(6*27*width), #(7*27*width)
    _3_layer_inv_GS_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*27*width), #(2*27*width), #(3*27*width), #(4*27*width), #(5*27*width), #(6*27*width), #(7*27*width), #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_5_4_3_inner
#else
.endr
#endif

    add.w r0, r0, #27*7*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_5_4_3
#else
.endr
#endif


    pop.w {r4-r12, pc}

.global __asm_3x2block_intt
.type __asm_3x2block_intt, %function
__asm_3x2block_intt:
    push.w {r4-r12, lr}
    vpush.w {s16-s31}

    .equ width, 4

    vldm.w r1, {s4-s30}
    vmov.w r10, r11, s11, s12

    .equ step, 72

#ifdef LOOP
    add.w r12, r0, #1728*width
    vmov.w s2, r12
    _i_3x2_2:
#else
.rept 4
#endif
    vmov.w r1, s7
    vmov.w s7, s8
    vmov.w s8, s9
    vmov.w s9, s10
#ifdef LOOP
    add.w r14, r0, #216*width
    vmov.w s3, r14
    _i_3x2_2_inner:
#else
.rept 24
#endif
.rept 3
    ldr.w r4, [r0, #0*3*width]
    ldr.w r5, [r0, #1*3*width]
    ldr.w r6, [r0, #2*3*width]
    ldr.w r7, [r0, #(216+0*3)*width]
    ldr.w r8, [r0, #(216+1*3)*width]
    ldr.w r9, [r0, #(216+2*3)*width]
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    str.w r5, [r0, #1*3*width]
    str.w r6, [r0, #2*3*width]
    str.w r7, [r0, #(216+0*3)*width]
    str.w r8, [r0, #(216+1*3)*width]
    str.w r9, [r0, #(216+2*3)*width]
    str.w r4, [r0], #width
.endr
    add.w r0, r0, #6*width
#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3x2_2_inner
#else
.endr
#endif
    add.w r0, r0, #216*width
#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3x2_2
#else
.endr
#endif

    sub.w r0, r0, #1728*width

    .equ step, 144

#ifdef LOOP
    add.w r12, r0, #3*width
    vmov.w s2, r12
    _i_3x2_1_light:
#else
.rept 3
#endif

#ifdef LOOP
    add.w r14, r0, #432*width
    vmov.w s3, r14
    _i_3x2_1_light_inner:
#else
.rept 16
#endif

    ldr.w r4, [r0, #(6+0*3)*width]
    ldr.w r5, [r0, #(6+3*3)*width]
    ldr.w r6, [r0, #(6+6*3)*width]
    ldr.w r7, [r0, #(438+0*3)*width]
    ldr.w r8, [r0, #(438+3*3)*width]
    ldr.w r9, [r0, #(438+6*3)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    vmov.w r1, s18
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s21
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    str.w r4, [r0, #(6+0*3)*width]
    str.w r5, [r0, #(6+3*3)*width]
    str.w r6, [r0, #(6+6*3)*width]
    str.w r7, [r0, #(438+0*3)*width]
    str.w r8, [r0, #(438+3*3)*width]
    str.w r9, [r0, #(438+6*3)*width]

    ldr.w r4, [r0, #(3+0*3)*width]
    ldr.w r5, [r0, #(3+3*3)*width]
    ldr.w r6, [r0, #(3+6*3)*width]
    ldr.w r7, [r0, #(435+0*3)*width]
    ldr.w r8, [r0, #(435+3*3)*width]
    ldr.w r9, [r0, #(435+6*3)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    vmov.w r1, s17
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s20
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    str.w r4, [r0, #(3+0*3)*width]
    str.w r5, [r0, #(3+3*3)*width]
    str.w r6, [r0, #(3+6*3)*width]
    str.w r7, [r0, #(435+0*3)*width]
    str.w r8, [r0, #(435+3*3)*width]
    str.w r9, [r0, #(435+6*3)*width]

    ldr.w r4, [r0, #(0+0*3)*width]
    ldr.w r5, [r0, #(0+3*3)*width]
    ldr.w r6, [r0, #(0+6*3)*width]
    ldr.w r7, [r0, #(432+0*3)*width]
    ldr.w r8, [r0, #(432+3*3)*width]
    ldr.w r9, [r0, #(432+6*3)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    str.w r5, [r0, #(0+3*3)*width]
    str.w r6, [r0, #(0+6*3)*width]
    str.w r7, [r0, #(432+0*3)*width]
    str.w r8, [r0, #(432+3*3)*width]
    str.w r9, [r0, #(432+6*3)*width]
    str.w r4, [r0], #27*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3x2_1_light_inner
#else
.endr
#endif

    sub.w r0, r0, #(432-1)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3x2_1_light
#else
.endr
#endif

    add.w r0, r0, #(432+432-3)*width

#ifdef LOOP
    add.w r12, r0, #3*width
    vmov.w s2, r12
    _i_3x2_1:
#else
.rept 3
#endif

#ifdef LOOP
    add.w r14, r0, #432*width
    vmov.w s3, r14
    _i_3x2_1_inner:
#else
.rept 16
#endif

    ldr.w r4, [r0, #(6+0*3)*width]
    ldr.w r5, [r0, #(6+3*3)*width]
    ldr.w r6, [r0, #(6+6*3)*width]
    ldr.w r7, [r0, #(438+0*3)*width]
    ldr.w r8, [r0, #(438+3*3)*width]
    ldr.w r9, [r0, #(438+6*3)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    vmov.w r1, s18
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    vmov.w r1, s27
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s21
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    vmov.w r1, s30
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    vmov.w r1, s6
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    str.w r4, [r0, #(6+0*3)*width]
    str.w r5, [r0, #(6+3*3)*width]
    str.w r6, [r0, #(6+6*3)*width]
    str.w r7, [r0, #(438+0*3)*width]
    str.w r8, [r0, #(438+3*3)*width]
    str.w r9, [r0, #(438+6*3)*width]

    ldr.w r4, [r0, #(3+0*3)*width]
    ldr.w r5, [r0, #(3+3*3)*width]
    ldr.w r6, [r0, #(3+6*3)*width]
    ldr.w r7, [r0, #(435+0*3)*width]
    ldr.w r8, [r0, #(435+3*3)*width]
    ldr.w r9, [r0, #(435+6*3)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    vmov.w r1, s17
    montgomery_mul_32 r5, r1, r2, r3, r12, r14
    vmov.w r1, s26
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    vmov.w r1, s20
    montgomery_mul_32 r6, r1, r2, r3, r12, r14
    vmov.w r1, s29
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    vmov.w r1, s6
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    str.w r4, [r0, #(3+0*3)*width]
    str.w r5, [r0, #(3+3*3)*width]
    str.w r6, [r0, #(3+6*3)*width]
    str.w r7, [r0, #(435+0*3)*width]
    str.w r8, [r0, #(435+3*3)*width]
    str.w r9, [r0, #(435+6*3)*width]

    ldr.w r4, [r0, #(0+0*3)*width]
    ldr.w r5, [r0, #(0+3*3)*width]
    ldr.w r6, [r0, #(0+6*3)*width]
    ldr.w r7, [r0, #(432+0*3)*width]
    ldr.w r8, [r0, #(432+3*3)*width]
    ldr.w r9, [r0, #(432+6*3)*width]
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    vmov.w r1, s6
    montgomery_mul_32 r7, r1, r2, r3, r12, r14
    montgomery_mul_32 r8, r1, r2, r3, r12, r14
    montgomery_mul_32 r9, r1, r2, r3, r12, r14
    _3_ntt r4, r5, r6, r10, r11, r2, r3, r12, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r12, r14
    str.w r5, [r0, #(0+3*3)*width]
    str.w r6, [r0, #(0+6*3)*width]
    str.w r7, [r0, #(432+0*3)*width]
    str.w r8, [r0, #(432+3*3)*width]
    str.w r9, [r0, #(432+6*3)*width]
    str.w r4, [r0], #27*width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3x2_1_inner
#else
.endr
#endif

    sub.w r0, r0, #(432-1)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3x2_1
#else
.endr
#endif

    vpop.w {s16-s31}
    pop.w {r4-r12, pc}

.macro wrap_i_64x9_0 mem1, mem2, memn0, memn1, memn2
    ldr.w r5, [r1, \mem1]
    ldr.w r6, [r1, \mem2]
    ldr.w r7, [r1, \memn0]
    ldr.w r8, [r1, \memn1]
    ldr.w r9, [r1, \memn2]
    ldr.w r4, [r1], #30*width
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    str.w r5, [r0, \mem1]
    str.w r6, [r0, \mem2]
    str.w r7, [r0, \memn0]
    str.w r8, [r0, \memn1]
    str.w r9, [r0, \memn2]
    str.w r4, [r0], #3*width
.endm

.macro wrap_i_64x9_1 mem1, mem2, memn0, memn1, memn2
    ldr.w r5, [r1, \mem1]
    ldr.w r6, [r1, \mem2]
    ldr.w r7, [r1, \memn0]
    ldr.w r8, [r1, \memn1]
    ldr.w r9, [r1, \memn2]
    ldr.w r4, [r1], #30*width
    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9
    str.w r4, [r0, \memn0]
    str.w r5, [r0, \memn1]
    str.w r6, [r0, \memn2]
    str.w r8, [r0, \mem1]
    str.w r9, [r0, \mem2]
    str.w r7, [r0], #3*width
.endm


.global __asm_i_Good
.type __asm_i_Good, %function
__asm_i_Good:
    push.w {r4-r12, lr}

    .equ width, 4

// ========

    add.w r2, r0, #81*width
    _i_Good_0:
.rept 9
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
    cmp.w r0, r2
    bne.w _i_Good_0

.rept 5
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_1:
.rept 4
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 5
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_1

.rept 4
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 1
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_2:
.rept 8
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 1
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_2

.rept 5
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_3:
.rept 3
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 6
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_3

.rept 3
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 2
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_4:
.rept 7
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 2
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_4

.rept 5
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_5:
.rept 2
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 7
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_5

.rept 2
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 3
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_6:
.rept 6
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 3
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_6

.rept 5
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_7:
.rept 1
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 8
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_7

.rept 1
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 4
    wrap_i_64x9_1 #1*width, #2*width, #864*width, #865*width, #866*width
.endr

    sub.w r1, r1, #864*width

// ========

    add.w r2, r0, #81*width
    _i_Good_8:
.rept 5
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #27*width
.rept 4
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    cmp.w r0, r2
    bne.w _i_Good_8

.rept 5
    wrap_i_64x9_0 #1*width, #2*width, #864*width, #865*width, #866*width
.endr
    sub.w r1, r1, #864*width

// ========

    pop.w {r4-r12, pc}







