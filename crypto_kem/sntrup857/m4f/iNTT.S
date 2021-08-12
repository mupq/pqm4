
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_intt
.type __asm_intt, %function
__asm_intt:
    push {r4-r12, lr}

    add.w r1, r1, #28
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r12, r0, #108
    vmov.w s2, r12
    _5_4_3_light_inner:
#else
.rept 9
#endif

.rept 3

    ldrstr4 ldr.w, r0, r8, r5, r10, r7, #432, #540, #648, #756
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0, #108, #216, #324
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #108, #216, #324, #432, #540, #648, #756, #4

.endr

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _5_4_3_light_inner
#else
.endr
#endif

    add.w r0, r0, #756

#ifdef LOOP
    add.w r12, r0, #6048
    vmov.w s2, r12
    _5_4_3:
#else
.rept 7
#endif

    vmov.w r1, s1
    vldm.w r1!, {s4-s10}
    vmov.w s1, r1

#ifdef LOOP
    add.w r14, r0, #108
    vmov.w s3, r14
    _5_4_3_inner:
#else
.rept 9
#endif

.rept 3

    ldrstrvec ldr.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #0, #108, #216, #324, #432, #540, #648, #756
    _3_layer_GS_butterfly r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstrvecjump str.w, r0, r4, r5, r6, r7, r8, r9, r10, r11, #108, #216, #324, #432, #540, #648, #756, #4

.endr

#ifdef LOOP
    vmov.w r14, s3
    cmp.w r0, r14
    bne.w _5_4_3_inner
#else
.endr
#endif

    add.w r0, r0, #756

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _5_4_3
#else
.endr
#endif

    sub.w r0, r0, #6912
    add.w r14, r0, #3456
    vmov.w s0, r14

    vmov.w r1, s1
    sub.w r1, r1, #252
    vldm.w r1, {s4-s10}

#ifdef LOOP
    add.w r12, r0, #864
    vmov.w s2, r12
    _2_1_0:
#else
.rept 54
#endif

.rept 4

    vmov.w r14, s0
    ldrstr4 ldr.w, r14, r8, r5, r10, r7, #0, #864, #1728, #2592
    _3_layer_GS_butterfly_light_fast_first r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    ldrstr4 ldr.w, r0, r4, r5, r6, r7, #0, #864, #1728, #2592
    _3_layer_GS_butterfly_light_fast_second r4, r5, r6, r7, r8, r9, r10, r11, s4, s5, s6, s7, s8, s9, s10, r1, r2, r3, r12, r14
    vmov.w r14, s0
    ldrstr4jump str.w, r0, r4, r5, r6, r7, #864, #1728, #2592, #4
    ldrstr4jump str.w, r14, r8, r9, r10, r11, #864, #1728, #2592, #4
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










































