
#include "macros.i"
#include "schoolbooks.i"

.syntax unified
.cpu cortex-m4

.global __asm_base_mul_32
.type __asm_base_mul_32, %function
__asm_base_mul_32:
    push.w {r4-r12, lr}

    vldr.w s12, [sp, #40]
    vldr.w s13, [sp, #44]

    .equ width, 4

    vmov.w s0, s1, r0, r1

#ifdef LOOP
    add.w r12, r0, #1024*width
    vmov.w s2, r12
    _mul_32:
#else
.rept 128
#endif

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #4, #8, #12, #16
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #4, #8, #12, #16
    vmov.w s12, s13, r12, r14

    vmov.w r12, s1
    ldr.w r1, [r12], #4
    vmov.w s1, r12

    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #12]

    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #8]

    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #4]

    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0], #16
    vmov.w s0, r0

// ================================

    vmov.w r12, r14, s12, s13
    ldrstr4jump ldr.w, r12, r4, r5, r6, r7, #4, #8, #12, #16
    ldrstr4jump ldr.w, r14, r8, r9, r10, r11, #4, #8, #12, #16
    vmov.w s12, s13, r12, r14

    neg.w r1, r1

    c3_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #12]

    c2_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #8]

    c1_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0, #4]

    c0_4x4_32 r14, r4, r5, r6, r7, r8, r9, r10, r11, r1, r2, r3, r0, r12

    vmov.w r0, s0
    str.w r14, [r0], #16
    vmov.w s0, r0

#ifdef LOOP
    vmov.w r12, s2
    cmp.w r0, r12
    bne.w _mul_32
#else
.endr
#endif

    pop.w {r4-r12, pc}



