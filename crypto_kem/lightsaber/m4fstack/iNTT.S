
#include "macros.i"
#include "CT_butterflies.i"

#ifndef LOOP
#define LOOP
#endif

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_negacyclic_intt_32
.type __asm_negacyclic_intt_32, %function
__asm_negacyclic_intt_32:
    vmov.w s0, r0
    ldr.w r0, [sp, #0]
    push {r4-r12, lr}
    vpush.w {s16-s20}

    .equ ldrwidth, 4
    .equ strwidth, 2

    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #256*ldrwidth
    vmov.w s2, r12
    _i_0_1_2:
#else
.rept 8
#endif

.rept 4

    ldrstr4 ldr.w r0, r8, r5, r10, r7, #16*ldrwidth, #20*ldrwidth, #24*ldrwidth, #28*ldrwidth
    _3_layer_inv_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w r0, r4, r5, r6, r7, #0*ldrwidth, #4*ldrwidth, #8*ldrwidth, #12*ldrwidth
    _3_layer_inv_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #4*ldrwidth, #8*ldrwidth, #12*ldrwidth, #16*ldrwidth, #20*ldrwidth, #24*ldrwidth, #28*ldrwidth, #ldrwidth

.endr

    add.w r0, r0, #28*ldrwidth

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_0_1_2
#else
.endr
#endif

    sub.w r0, r0, #256*ldrwidth

    vmov.w r1, s1
    vldm.w r1!, {s4-s18}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #4*ldrwidth
    vmov.w s2, r12
    _i_3_4_5_first:
#else
.rept 2
#endif

.rept 2

    ldrstr4 ldr.w r0, r8, r5, r10, r7, #128*ldrwidth, #160*ldrwidth, #192*ldrwidth, #224*ldrwidth
    _3_layer_inv_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4jump ldr.w r0, r4, r5, r6, r7, #32*ldrwidth, #64*ldrwidth, #96*ldrwidth, #ldrwidth
    _3_layer_inv_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

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

    lsr.w r1, r3, #1

    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    central_reduce r6, r1, r3
    central_reduce r7, r1, r3
    central_reduce r8, r1, r3
    central_reduce r9, r1, r3
    central_reduce r10, r1, r3
    central_reduce r11, r1, r3

    vmov.w r14, s0
    ldrstrvecjump strh.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #32*strwidth, #64*strwidth, #96*strwidth, #128*strwidth, #160*strwidth, #192*strwidth, #224*strwidth, #strwidth
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3_4_5_first
#else
.endr
#endif

#ifdef LOOP
    add.w r12, r0, #28*ldrwidth
    vmov.w s2, r12
    _i_3_4_5:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s18}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #4*ldrwidth
    vmov.w s3, r14
    _i_3_4_5_inner:
#else
.rept 2
#endif

.rept 2

    ldrstrvecjump ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #32*ldrwidth, #64*ldrwidth, #96*ldrwidth, #128*ldrwidth, #160*ldrwidth, #192*ldrwidth, #224*ldrwidth, #ldrwidth
    _3_layer_inv_CT_32 r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14

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

    lsr.w r1, r3, #1

    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    central_reduce r6, r1, r3
    central_reduce r7, r1, r3
    central_reduce r8, r1, r3
    central_reduce r9, r1, r3
    central_reduce r10, r1, r3
    central_reduce r11, r1, r3

    vmov.w r14, s0
    ldrstrvecjump strh.w, r14, r4, r5, r6, r7, r8, r9, r10, r11, #32*strwidth, #64*strwidth, #96*strwidth, #128*strwidth, #160*strwidth, #192*strwidth, #224*strwidth, #strwidth
    vmov.w s0, r14

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _i_3_4_5_inner
#else
.endr
#endif

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _i_3_4_5
#else
.endr
#endif

    vpop.w {s16-s20}
    pop {r4-r12, pc}













