

#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_ntt
.type __asm_ntt, %function
__asm_ntt:
    push {r4-r12, lr}

    .equ unit, 5

    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #160
    vmov.w s2, r12
    _1_2_3_light:
#else
.rept 40
#endif

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #8*4*unit, #24*4*unit, #40*4*unit, #56*4*unit
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*4*unit, #16*4*unit, #32*4*unit, #48*4*unit
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #8*4*unit+2560, #24*4*unit+2560, #40*4*unit+2560, #56*4*unit+2560
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*4*unit+2560, #16*4*unit+2560, #32*4*unit+2560, #48*4*unit+2560
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560

    add.w r0, r0, #5120

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #8*4*unit, #24*4*unit, #40*4*unit, #56*4*unit
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*4*unit, #16*4*unit, #32*4*unit, #48*4*unit
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _1_2_3_light
#else
.endr
#endif

    add.w r0, r0, #1120

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #160
    vmov.w s2, r12
    _1_2_3:
#else
.rept 40
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #8*4*unit+2560, #16*4*unit+2560, #24*4*unit+2560, #32*4*unit+2560, #40*4*unit+2560, #48*4*unit+2560, #56*4*unit+2560

    add.w r0, r0, #5120

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #8*4*unit, #16*4*unit, #24*4*unit, #32*4*unit, #40*4*unit, #48*4*unit, #56*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _1_2_3
#else
.endr
#endif

    sub.w r0, r0, #1440

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #20
    vmov.w s2, r12
    _4_5_6_light:
#else
.rept 5
#endif

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #1*4*unit, #3*4*unit, #5*4*unit, #7*4*unit
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*4*unit, #2*4*unit, #4*4*unit, #6*4*unit
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #1*4*unit+2560, #3*4*unit+2560, #5*4*unit+2560, #7*4*unit+2560
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*4*unit+2560, #2*4*unit+2560, #4*4*unit+2560, #6*4*unit+2560
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560

    add.w r0, r0, #5120

    ldrstr4 ldr.w, r0, r5, r7, r8, r10, #1*4*unit, #3*4*unit, #5*4*unit, #7*4*unit
    _3_layer_CT_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r6, r8, r10, #0*4*unit, #2*4*unit, #4*4*unit, #6*4*unit
    _3_layer_CT_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _4_5_6_light
#else
.endr
#endif

    add.w r0, r0, #140

#ifdef LOOP
    add.w r12, r0, #2400
    vmov.w s2, r12
    _4_5_6:
#else
.rept 15
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #20
    vmov.w s3, r14
    _4_5_6_inner:
#else
.rept 5
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit+2560, #1*4*unit+2560, #2*4*unit+2560, #3*4*unit+2560, #4*4*unit+2560, #5*4*unit+2560, #6*4*unit+2560, #7*4*unit+2560

    add.w r0, r0, #5120

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*4*unit, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit
    _3_layer_CT_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #1*4*unit, #2*4*unit, #3*4*unit, #4*4*unit, #5*4*unit, #6*4*unit, #7*4*unit, #4

    sub.w r0, r0, #5120

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _4_5_6_inner
#else
.endr
#endif

    add.w r0, r0, #140

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _4_5_6
#else
.endr
#endif

    pop {r4-r12, pc}

