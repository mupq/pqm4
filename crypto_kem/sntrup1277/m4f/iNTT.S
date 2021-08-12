
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push {r4-r12, lr}

    // RmodM
    movw r4, #12715
    movt r4, #35
    neg.w r4, r4
    vmov.w s11, r4

    .equ unit, 5

    add.w r1, r1, #252
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r12, r0, #4*unit
    vmov.w s2, r12
    _8_7_6_light:
#else
.rept unit
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    montgomery_mul_vec8 r4, r5, r6, r7, r8, r9, r10, r11, s11, r1, r2, r3, r12, r14
    _3_layer_GS_butterfly_light r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _8_7_6_light
#else
.endr
#endif

    add.w r0, r0, #28*unit

// ================================

#ifdef LOOP
    add.w r12, r0, #10240
    sub.w r12, r12, #160
    vmov.w s2, r12
    _8_7_6:
#else
.rept 63
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _8_7_6_inner:
#else
.rept 2
#endif

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _8_7_6_inner
#else
.endr
#endif

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*unit, #8*unit, #12*unit, #16*unit, #20*unit, #24*unit, #28*unit, #4

    add.w r0, r0, #28*unit

// ================================

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _8_7_6
#else
.endr
#endif

// ================================

    sub.w r0, r0, #2048*unit

    vmov.w r1, s1
    sub.w r1, r1, #2016
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r12, r0, #32*unit
    vmov.w s2, r12
    _5_4_3_light:
#else
.rept 4*unit
#endif

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit
    _3_layer_GS_butterfly_light r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    montgomery_mul_vec8 r4, r5, r6, r7, r8, r9, r10, r11, s11, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit, #4

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _5_4_3_light
#else
.endr
#endif

    add.w r0, r0, #224*unit

// ================================

#ifdef LOOP
    add.w r12, r0, #256*7*unit
    vmov.w s2, r12
    _5_4_3:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm r1!, {s4-s10}
    vmov.w s1, r1

// ================================

#ifdef LOOP
    add.w r14, r0, #32*unit
    vmov.w s3, r14
    _5_4_3_inner:
#else
.rept 4*unit
#endif

.rept 2
    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*unit, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    montgomery_mul_vec4 r4, r5, r6, r7, s11, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*unit, #64*unit, #96*unit, #128*unit, #160*unit, #192*unit, #224*unit, #4
.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _5_4_3_inner
#else
.endr
#endif

    add.w r0, r0, #224*unit

// ================================

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _5_4_3
#else
.endr
#endif

// ================================

    sub.w r14, r0, #1024*unit
    sub.w r0, r14, #1024*unit
    vmov.w s0, r14

    vmov.w r1, s1
    sub.w r1, r1, #252
    vldm r1, {s4-s10}

#ifdef LOOP
    add.w r12, r0, #256*unit
    vmov.w s2, r12
    _2_1_0:
#else
.rept 16*unit
#endif

.rept 4

    vmov.w r14, s0
    ldrstr4 ldr.w, r14, r8, r5, r10, r7, #0*unit, #256*unit, #512*unit, #768*unit
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0*unit, #256*unit, #512*unit, #768*unit
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s0
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #256*unit, #512*unit, #768*unit, #4
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #256*unit, #512*unit, #768*unit, #4
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _2_1_0
#else
.endr
#endif



    pop {r4-r12, pc}
