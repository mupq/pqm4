
#include "macros.i"
#include "butterflies.i"

.syntax unified
.cpu cortex-m4

.align 2
.global __asm_i_3x2
.type __asm_i_3x2, %function
__asm_i_3x2:
    push.w {r4-r12, lr}

    .equ width, 4

    ldr.w r10, [r1, #0]
    ldr.w r11, [r1, #4]

#ifdef LOOP
    add.w r12, r0, #1536*width
    _i_3x2:
#else
.rept 32
#endif

.rept 2

.rept 3

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #12*width]
    ldr.w r8, [r0, #13*width]
    ldr.w r9, [r0, #14*width]

    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #12*width]
    str.w r8, [r0, #13*width]
    str.w r9, [r0, #14*width]
    str.w r4, [r0], #3*width

.endr

    ldm.w r0, {r4-r6}
    ldr.w r7, [r0, #12*width]
    ldr.w r8, [r0, #13*width]
    ldr.w r9, [r0, #14*width]

    _3_ntt r4, r5, r6, r10, r11, r2, r3, r1, r14
    _3_ntt r7, r8, r9, r10, r11, r2, r3, r1, r14

    add_sub2 r4, r7, r5, r8
    add_sub1 r6, r9

    str.w r5, [r0, #1*width]
    str.w r6, [r0, #2*width]
    str.w r7, [r0, #12*width]
    str.w r8, [r0, #13*width]
    str.w r9, [r0, #14*width]
    str.w r4, [r0], #15*width

.endr

#ifdef LOOP
    cmp.w r0, r12
    bne.w _i_3x2
#else
.endr
#endif

    pop.w {r4-r12, pc}



