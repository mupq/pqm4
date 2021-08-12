
#include "macros.S"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    vldr.w s0, [sp, #0]
    push.w {r4-r12, lr}

    // invN_R2modM
    movw r11, #36580
    movt r11, #26

    // O_Mbar
    movw r12, #8611
    movt r12, #9

    // O_M
    movw r14, #7177

    movw r8, #0

#ifdef LOOP
    add.w r9, r0, #4032
    vmov.w s2, r9
    _final_loop:
#else
.rept 56
#endif

// ================================

.rept 9
    ldr.w r7, [r0, #4052]
    ldr.w r5, [r0, #4]
    ldr.w r4, [r0], #8
    add r4, r8
    add r4, r7
    ldr.w r8, [r0, #4048]
    add r5, r7
    add r5, r8
    montgomery_mul r4, r11, r10, r4, r2, r3, r9
    montgomery_mul r5, r11, r10, r5, r2, r3, r9
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    barrett r4, r12, r14, r9
    barrett r5, r12, r14, r9
    vmov.w r9, s0
    pkhbt r4, r4, r5, lsl #16
    str.w r4, [r9], #4
    vmov.w s0, r9
.endr

// ================================

#ifdef LOOP
    vmov.w r9, s2
    cmp.w r0, r9
    bne.w _final_loop
#else
.endr
#endif

.rept 2
    ldr.w r7, [r0, #4052]
    ldr.w r5, [r0, #4]
    ldr.w r4, [r0], #8
    add r4, r8
    add r4, r7
    ldr.w r8, [r0, #4048]
    add r5, r7
    add r5, r8
    montgomery_mul r4, r11, r10, r4, r2, r3, r9
    montgomery_mul r5, r11, r10, r5, r2, r3, r9
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    barrett r4, r12, r14, r9
    barrett r5, r12, r14, r9
    vmov.w r9, s0
    pkhbt r4, r4, r5, lsl #16
    str.w r4, [r9], #4
    vmov.w s0, r9
.endr


    ldr.w r7, [r0, #4052]
    ldr.w r4, [r0]
    add r4, r8
    add r4, r7
    montgomery_mul r4, r11, r10, r4, r2, r3, r9
    central_reduce r4, r1, r3
    barrett r4, r12, r14, r9
    vmov.w r9, s0
    strh.w r4, [r9]

    pop.w {r4-r12, pc}
