
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt_32
.type __asm_intt_32, %function
__asm_intt_32:
    push.w {r4-r12, lr}

    .equ width, 4

    add.w r1, r1, #31*width
    vmov.w s1, r1

    .equ step, 4

#ifdef LOOP
    add.w r12, r0, #1024*width
    vmov.w s2, r12
    _i_7_6_5:
#else
.rept 32
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #4*width
    vmov.w s3, r14
    _i_7_6_5_inner:
#else
.rept 2
#endif

.rept 2

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_GS_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_7_6_5_inner
#else
.endr
#endif

    add.w r0, r0, #28*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_7_6_5
#else
.endr
#endif

    sub.w r0, r0, #1024*width

    .equ step, 32

    vmov.w r1, s1
    sub.w r1, r1, #255*width
    add.w r1, r1, #3*width
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #32*width
    vmov.w s2, r12
    _i_4_3_2_light:
#else
.rept 8
#endif

.rept 4

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_GS_light_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_4_3_2_light
#else
.endr
#endif

    add.w r0, r0, #224*width



#ifdef LOOP
    add.w r12, r0, #768*width
    vmov.w s2, r12
    _i_4_3_2:
#else
.rept 3
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #32*width
    vmov.w s3, r14
    _i_4_3_2_inner:
#else
.rept 16
#endif

.rept 2

    ldrstr8 ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(0*step)*width, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width
    _3_layer_inv_GS_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr8jump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #(1*step)*width, #(2*step)*width, #(3*step)*width, #(4*step)*width, #(5*step)*width, #(6*step)*width, #(7*step)*width, #width

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_4_3_2_inner
#else
.endr
#endif

    add.w r0, r0, #224*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_4_3_2
#else
.endr
#endif


    pop.w {r4-r12, pc}









