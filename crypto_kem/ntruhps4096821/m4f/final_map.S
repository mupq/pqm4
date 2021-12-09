
#include "macros.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_final_map
.type __asm_final_map, %function
__asm_final_map:
    push.w {r4-r12, lr}

    .equ width, 4
    .equ strwidth, 2

    ldr.w r8, [sp, #40]

    mov.w r9, r1
    lsr.w r1, r3, #1

#ifdef LOOP
    add.w r11, r8, #820*width
    _final_loop:
#else
.rept 82
#endif

.rept 5
    ldr.w r5, [r8, #1*width]
    ldr.w r6, [r8, #821*width]
    ldr.w r7, [r8, #822*width]
    ldr.w r4, [r8], #2*width
    add r4, r6
    add r5, r7
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    montgomery_mul_32 r5, r9, r2, r3, r12, r14
    central_reduce r4, r1, r3
    central_reduce r5, r1, r3
    pkhbt r4, r4, r5, lsl #16
    bic r4, r4, #0xf000f000
    str.w r4, [r0], #2*strwidth
.endr

#ifdef LOOP
    cmp.w r8, r11
    bne.w _final_loop
#else
.endr
#endif

    ldr.w r4, [r8, #0*width]
    ldr.w r6, [r8, #821*width]
    add.w r4, r4, r6
    montgomery_mul_32 r4, r9, r2, r3, r12, r14
    central_reduce r4, r1, r3
    ubfx.w r4, r4, #0, #12
    strh.w r4, [r0]

    pop.w {r4-r12, pc}





