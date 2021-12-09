
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push.w {r4-r12, lr}

    .equ width, 4

    add.w r1, r1, #4

    .equ step, 24

// layers 1, 2, 3 start

    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #1536*width
    vmov.w s2, r12
    _i_1_2_3_light:
#else
.rept 8
#endif

#ifdef LOOP
    add.w r14, r0, #12*width
    vmov.w s3, r14
    _i_1_2_3_light_inner:
#else
.rept 3
#endif

.rept 4
    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    _3_layer_inv_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_1_2_3_light_inner
#else
.endr
#endif

    add.w r0, r0, #(8*step-12)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_1_2_3_light
#else
.endr
#endif

    sub.w r0, r0, #1536*width
    add.w r0, r0, #12*width

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #1536*width
    vmov.w s2, r12
    _i_1_2_3:
#else
.rept 8
#endif

#ifdef LOOP
    add.w r14, r0, #12*width
    vmov.w s3, r14
    _i_1_2_3_inner:
#else
.rept 4
#endif

.rept 3
    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_1_2_3_inner
#else
.endr
#endif

    add.w r0, r0, #(8*step-12)*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_1_2_3
#else
.endr
#endif

    sub.w r0, r0, #1536*width
    sub.w r0, r0, #12*width

// layers 1, 2, 3 end

// layers 4, 5, 6 start

    .equ step, 192

    add.w r14, r0, #768*width
    vmov.w s0, r14

#ifdef LOOP
    add.w r12, r0, #192*width
    vmov.w s2, r12
    _i_4_5_6:
#else
.rept 16
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #12*width
    vmov.w s3, r14
    _i_4_5_6_inner:
#else
.rept 4
#endif

.rept 3
    vmov.w r14, s0
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    ldrstr4 ldr.w, r14, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width
    _3_layer_inv_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s0
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #width
    vmov.w s0, r14
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_4_5_6_inner
#else
.endr
#endif

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_4_5_6
#else
.endr
#endif

// layers 4, 5, 6 end

    pop.w {r4-r12, pc}


































