
#include "macros.i"
#include "CT_butterflies.i"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_negacyclic_ntt_16
.type __asm_negacyclic_ntt_16, %function
__asm_negacyclic_ntt_16:
    push {r4-r12, lr}

    .equ width, 2
    .equ logq, 13

    vldr.w s15, [sp, #40]

    mov.w r14, r3

    vldm.w r1!, {s4-s7}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #32*width
    vmov.w s2, r12
    _0_1_2_16:
#else
.rept 8
#endif

.rept 2

    ldrstrvecjump ldr.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #32*width, #64*width, #96*width, #128*width, #160*width, #192*width, #224*width, #2*width
    _3_layer_double_CT_16 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, r1, r2, r3, r12
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*width, #64*width, #96*width, #128*width, #160*width, #192*width, #224*width, #2*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_16
#else
.endr
#endif

    sub.w r0, r0, #32*width
    vmov.w r14, s15

#ifdef LOOP
    add.w r12, r0, #256*width
    vmov.w s2, r12
    _3_4_5_16:
#else
.rept 8
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s7}
    vmov.w s1, r1

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*width, #4*width, #8*width, #12*width, #16*width, #20*width, #24*width, #28*width
    doublemontgomery_16_4 b, r4, r5, r6, r7, r14, r2, r3, r12
    _3_layer_double_CT_16 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, r1, r2, r3, r12
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*width, #8*width, #12*width, #16*width, #20*width, #24*width, #28*width, #2*width

.endr

    add.w r0, r0, #28*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_16
#else
.endr
#endif

    pop {r4-r12, pc}

.align 2
.global __asm_negacyclic_ntt_16_light
.type __asm_negacyclic_ntt_16_light, %function
__asm_negacyclic_ntt_16_light:
    push {r4-r12, lr}

    .equ width, 2
    .equ logq, 13

    vldr.w s15, [sp, #40]

    mov.w r14, r3

    vldm.w r1!, {s4-s7}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #32*width
    vmov.w s2, r12
    _0_1_2_16_light:
#else
.rept 8
#endif

.rept 2

    ldrstrvecjump ldr.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #32*width, #64*width, #96*width, #128*width, #160*width, #192*width, #224*width, #2*width
    _3_layer_double_CT_16 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, r1, r2, r3, r12
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*width, #64*width, #96*width, #128*width, #160*width, #192*width, #224*width, #2*width

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_16_light
#else
.endr
#endif

    sub.w r0, r0, #32*width
    vmov.w r14, s15

#ifdef LOOP
    add.w r12, r0, #256*width
    vmov.w s2, r12
    _3_4_5_16_light:
#else
.rept 8
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s7}
    vmov.w s1, r1

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*width, #4*width, #8*width, #12*width, #16*width, #20*width, #24*width, #28*width
    _3_layer_double_CT_16 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, r1, r2, r3, r12
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*width, #8*width, #12*width, #16*width, #20*width, #24*width, #28*width, #2*width

.endr

    add.w r0, r0, #28*width

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_16_light
#else
.endr
#endif

    pop {r4-r12, pc}

.align 2
.global __asm_negacyclic_ntt_32
.type __asm_negacyclic_ntt_32, %function
__asm_negacyclic_ntt_32:
    push {r4-r12, lr}

    .equ ldrwidth, 2
    .equ strwidth, 4

    vmov.w s0, r0
    ldr.w r0, [sp, #40]

    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #32*ldrwidth
    vmov.w s2, r12
    _0_1_2_32:
#else
.rept 16
#endif

.rept 2

    ldrstrvecjump ldrsh.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*ldrwidth, #64*ldrwidth, #96*ldrwidth, #128*ldrwidth, #160*ldrwidth, #192*ldrwidth, #224*ldrwidth, #ldrwidth
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

    vmov.w r14, s0
    ldrstrvecjump str.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #32*strwidth, #64*strwidth, #96*strwidth, #128*strwidth, #160*strwidth, #192*strwidth, #224*strwidth, #strwidth
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _0_1_2_32
#else
.endr
#endif

    sub.w r0, r14, #32*strwidth

#ifdef LOOP
    add.w r12, r0, #256*strwidth
    vmov.w s2, r12
    _3_4_5_32:
#else
.rept 8
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #4*strwidth
    vmov.w s3, r14
    _3_4_5_inner_32:
#else
.rept 2
#endif

.rept 2

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0*strwidth, #4*strwidth, #8*strwidth, #12*strwidth, #16*strwidth, #20*strwidth, #24*strwidth, #28*strwidth
    _3_layer_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*strwidth, #8*strwidth, #12*strwidth, #16*strwidth, #20*strwidth, #24*strwidth, #28*strwidth, #strwidth

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _3_4_5_inner_32
#else
.endr
#endif

    add.w r0, r0, #28*strwidth

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _3_4_5_32
#else
.endr
#endif

    pop {r4-r12, pc}


















