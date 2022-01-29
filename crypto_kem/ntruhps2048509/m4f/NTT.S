
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt_0_1_2_3_32
.type __asm_ntt_0_1_2_3_32, %function
__asm_ntt_0_1_2_3_32:
    push.w {r4-r12, lr}
    vpush.w {s16-s31}

    ldr.w r14, [sp, #104]

    .equ ldrwidth, 2
    .equ width, 4
    .equ step, 64

    vldm.w r1, {s4-s18}
    vmov.w s0, r14

#ifdef LOOP
    add.w r12, r0, #61*width
    vmov.w s2, r12
    _0_1_2_3:
#else
.rept 61
#endif

    vmov.w r14, s0
    ldrstr4 ldrsh.w, r14, r4, r5, r6, r7, #(1*step)*ldrwidth, #(3*step)*ldrwidth, #(5*step)*ldrwidth, #(7*step)*ldrwidth
    sbfx.w r4, r4, #0, #11
    sbfx.w r5, r5, #0, #11
    sbfx.w r6, r6, #0, #11
    sbfx.w r7, r7, #0, #11
    _3_layer_CT_light_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
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

    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r5, r6, r7, #(2*step)*ldrwidth, #(4*step)*ldrwidth, #(6*step)*ldrwidth, #ldrwidth
    vmov.w s0, r14
    sbfx.w r4, r4, #0, #11
    sbfx.w r5, r5, #0, #11
    sbfx.w r6, r6, #0, #11
    sbfx.w r7, r7, #0, #11
    _3_layer_CT_light_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*step)*width, #(9*step)*width, #(10*step)*width, #(11*step)*width, #(12*step)*width, #(13*step)*width, #(14*step)*width, #(15*step)*width

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_3
#else
.endr
#endif

#ifdef LOOP
    add.w r12, r0, #3*width
    vmov.w s2, r12
    _0_1_2_3_last:
#else
.rept 3
#endif

    vmov.w r14, s0
    ldrsh.w r4, [r14, #(1*step)*ldrwidth]
    ldrsh.w r5, [r14, #(3*step)*ldrwidth]
    ldrsh.w r6, [r14, #(5*step)*ldrwidth]
    sbfx.w r4, r4, #0, #11
    sbfx.w r5, r5, #0, #11
    sbfx.w r6, r6, #0, #11
    movw.w r7, #0
    _3_layer_CT_light_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
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

    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r5, r6, r7, #(2*step)*ldrwidth, #(4*step)*ldrwidth, #(6*step)*ldrwidth, #ldrwidth
    vmov.w s0, r14
    sbfx.w r4, r4, #0, #11
    sbfx.w r5, r5, #0, #11
    sbfx.w r6, r6, #0, #11
    sbfx.w r7, r7, #0, #11
    _3_layer_CT_light_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*step)*width, #(9*step)*width, #(10*step)*width, #(11*step)*width, #(12*step)*width, #(13*step)*width, #(14*step)*width, #(15*step)*width

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_3_last
#else
.endr
#endif


    vpop.w {s16-s31}
    pop.w {r4-r12, pc}


.align 2
.global __asm_ntt_0_1_2_3_small_32
.type __asm_ntt_0_1_2_3_small_32, %function
__asm_ntt_0_1_2_3_small_32:
    push.w {r4-r12, lr}
    vpush.w {s16-s31}

    ldr.w r14, [sp, #104]

    .equ ldrwidth, 2
    .equ width, 4
    .equ step, 64

    vldm.w r1, {s4-s18}
    vmov.w s0, r14

#ifdef LOOP
    add.w r12, r0, #61*width
    vmov.w s2, r12
    _0_1_2_3_small:
#else
.rept 61
#endif

    vmov.w r14, s0
    ldrstr4 ldrsh.w, r14, r4, r5, r6, r7, #(1*step)*ldrwidth, #(3*step)*ldrwidth, #(5*step)*ldrwidth, #(7*step)*ldrwidth
    _3_layer_CT_light_small_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
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

    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r5, r6, r7, #(2*step)*ldrwidth, #(4*step)*ldrwidth, #(6*step)*ldrwidth, #ldrwidth
    vmov.w s0, r14
    _3_layer_CT_light_small_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*step)*width, #(9*step)*width, #(10*step)*width, #(11*step)*width, #(12*step)*width, #(13*step)*width, #(14*step)*width, #(15*step)*width

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_3_small
#else
.endr
#endif

#ifdef LOOP
    add.w r12, r0, #3*width
    vmov.w s2, r12
    _0_1_2_3_small_last:
#else
.rept 3
#endif

    vmov.w r14, s0
    ldrsh.w r4, [r14, #(1*step)*ldrwidth]
    ldrsh.w r5, [r14, #(3*step)*ldrwidth]
    ldrsh.w r6, [r14, #(5*step)*ldrwidth]
    movw.w r7, #0
    _3_layer_CT_light_small_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
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

    vmov.w r14, s0
    ldrstr4jump ldrsh.w, r14, r4, r5, r6, r7, #(2*step)*ldrwidth, #(4*step)*ldrwidth, #(6*step)*ldrwidth, #ldrwidth
    vmov.w s0, r14
    _3_layer_CT_light_small_1111_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*step)*width, #(9*step)*width, #(10*step)*width, #(11*step)*width, #(12*step)*width, #(13*step)*width, #(14*step)*width, #(15*step)*width

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_3_small_last
#else
.endr
#endif


    vpop.w {s16-s31}
    pop.w {r4-r12, pc}



.align 2
.global __asm_ntt_4_5_6_7_32
.type __asm_ntt_4_5_6_7_32, %function
__asm_ntt_4_5_6_7_32:
    push.w {r4-r12, lr}
    vpush.w {s16-s31}

    ldr.w r14, [sp, #104]

    .equ width, 4

    .equ step, 4


    add.w r1, r1, #15*width
    vldm.w r1!, {s4-s18}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #4*width
    vmov.w s3, r12
    _4_5_6_7_light:
#else
.rept 4
#endif

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(3*step)*width, #(5*step)*width, #(7*step)*width, #(9*step)*width, #(11*step)*width, #(13*step)*width, #(15*step)*width
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

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(2*step)*width, #(4*step)*width, #(6*step)*width, #(8*step)*width, #(10*step)*width, #(12*step)*width, #(14*step)*width
    _3_layer_CT_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*step)*width, #(9*step)*width, #(10*step)*width, #(11*step)*width, #(12*step)*width, #(13*step)*width, #(14*step)*width, #(15*step)*width

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

#ifdef LOOP
    vmov.w r12, s3
    cmp.w r0, r12
    bne.w _4_5_6_7_light
#else
.endr
#endif

    add.w r0, r0, #(15*step)*width


#ifdef LOOP
    add.w r12, r0, #960*width
    vmov.w s2, r12
    _4_5_6_7:
#else
.rept 15
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s18}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #4*width
    vmov.w s3, r14
    _4_5_6_7_inner:
#else
.rept 4
#endif

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(3*step)*width, #(5*step)*width, #(7*step)*width, #(9*step)*width, #(11*step)*width, #(13*step)*width, #(15*step)*width
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

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(2*step)*width, #(4*step)*width, #(6*step)*width, #(8*step)*width, #(10*step)*width, #(12*step)*width, #(14*step)*width
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w s28, s29, r4, r5
    vmov.w s30, s31, r6, r7

    vmov.w r4, r5, s24, s25
    vmov.w r6, r7, s26, s27

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8 str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(8*step)*width, #(9*step)*width, #(10*step)*width, #(11*step)*width, #(12*step)*width, #(13*step)*width, #(14*step)*width, #(15*step)*width

    vmov.w r4, r5, s20, s21
    vmov.w r6, r7, s22, s23
    vmov.w r8, r9, s28, s29
    vmov.w r10, r11, s30, s31

    add_sub4 r8, r4, r9, r5, r10, r6, r11, r7

    ldrstr8jump str.w, r0, r8, r4, r9, r5, r10, r6, r11, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _4_5_6_7_inner
#else
.endr
#endif

    add.w r0, r0, #(15*step)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _4_5_6_7
#else
.endr
#endif


    vpop.w {s16-s31}
    pop.w {r4-r12, pc}







