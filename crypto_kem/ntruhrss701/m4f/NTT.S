
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt_32
.type __asm_ntt_32, %function
__asm_ntt_32:
    push.w {r4-r12, lr}

    .equ width, 4

    add.w r1, r1, #4

    .equ step, 96

    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #96*width
    vmov.w s2, r12
    _1_2_3_light:
#else
.rept 24
#endif

.rept 4

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #(1*step)*width, #(3*step)*width, #(5*step)*width, #(7*step)*width
    _3_layer_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #(0*step)*width, #(2*step)*width, #(4*step)*width, #(6*step)*width
    _3_layer_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _1_2_3_light
#else
.endr
#endif

    add.w r0, r0, #672*width

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #96*width
    vmov.w s2, r12
    _1_2_3:
#else
.rept 32
#endif

.rept 3

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _1_2_3
#else
.endr
#endif

    add.w r0, r0, #672*width

// ========

    sub.w r0, r0, #1536*width

    .equ step, 12

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #12*width
    vmov.w s2, r12
    _4_5_6_light:
#else
.rept 3
#endif

.rept 4

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #(1*step)*width, #(3*step)*width, #(5*step)*width, #(7*step)*width
    _3_layer_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #(0*step)*width, #(2*step)*width, #(4*step)*width, #(6*step)*width
    _3_layer_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _4_5_6_light
#else
.endr
#endif

    add.w r0, r0, #84*width

#ifdef LOOP
    add.w r12, r0, #1440*width
    vmov.w s2, r12
    _4_5_6:
#else
.rept 15
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #12*width
    vmov.w s3, r14
    _4_5_6_inner:
#else
.rept 4
#endif

.rept 3

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _4_5_6_inner
#else
.endr
#endif

    add.w r0, r0, #84*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _4_5_6
#else
.endr
#endif

    pop.w {r4-r12, pc}

























