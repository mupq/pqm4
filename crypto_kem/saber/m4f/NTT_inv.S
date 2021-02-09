
#include "macros_common.S"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m4

.align 2
.global _NTT_inv
.type _NTT_inv, %function
_NTT_inv:
    vldr.w s0, [sp, #0]
    push.w {r4-r12, lr}

    .equ width, 2

    mov.w r4, r0
    add.w r1, r1, #28
    vmov.w r0, s0
    vmov.w s0, s1, r4, r1

    // RmodM = -(128 * 2^16 + 43947)
    movw r4, #43947
    movt r4, #128
    neg.w r4, r4

    // R2invN = 117 * 2^16 + 22072
    movw r5, #22072
    movt r5, #117

    vmov.w s14, s15, r4, r5

#ifdef LOOP
    add.w r12, r0, #1024
    vmov.w s2, r12
    _6_5_4:
#else
.rept 8
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #16
    vmov.w s3, r14
    _6_5_4_inner:
#else
.rept 2
#endif

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #16, #32, #48, #64, #80, 96, #112
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #16, #32, #48, #64, #80, 96, #112, #4

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _6_5_4_inner
#else
.endr
#endif

    add.w r0, r0, #112

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _6_5_4
#else
.endr
#endif

    vmov.w r1, s1
    sub.w r0, r0, #1024
    sub.w r1, r1, #252
    vldm.w r1, {s4-s10}

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #128, #256, #384, #512, #640, #768, #896
    montgomery_mul_vec8 r4, r5, r6, r7, r8, r9, r10, r11, s14, r1, r2, r3, r12, r14
    ldrstrvec str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #128, #256, #384, #512, #640, #768, #896

#ifdef LOOP
    add.w r12, r0, #128
    vmov.w s2, r12
    _3_2_1:
#else
.rept 16
#endif

.rept 2

    ldrstrvecjump ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #128, #256, #384, #512, #640, #768, #896, #4
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    montgomery_mul_vec4 r4, r5, r6, r7, s15, r1, r2, r3, r12, r14
    lsr.w r1, r2, #1
    central_reduce r4, r1, r2
    central_reduce r5, r1, r2
    central_reduce r6, r1, r2
    central_reduce r7, r1, r2
    central_reduce r8, r1, r2
    central_reduce r9, r1, r2
    central_reduce r10, r1, r2
    central_reduce r11, r1, r2
    vmov.w r14, s0
    ldrstrvecjump strh.w r14, r4, r5, r6, r7, r8, r9, r10, r11, #32*width, #64*width, #96*width, #128*width, #160*width, #192*width, #224*width, #width
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_2_1
#else
.endr
#endif

    pop.w {r4-r12, pc}