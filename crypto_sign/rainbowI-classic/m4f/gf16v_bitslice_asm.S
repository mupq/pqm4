.syntax unified
.cpu cortex-m4
.thumb

#include "bitslice.inc"

//extern void gf16v_bitslice_asm(uint32_t *out, size_t len);
.global gf16v_bitslice_asm
.type gf16v_bitslice_asm, %function
.align 2
gf16v_bitslice_asm:
    push.w {r4-r7, r14}
    1:
        ldr.w r2, [r0, #0]
        ldr.w r3, [r0, #4]
        ldr.w r4, [r0, #8]
        ldr.w r5, [r0, #12]

        bitslice r6, r7, r12, r14, r2, r3, r4, r5

        str.w r7,  [r0, #4]
        str.w r12, [r0, #8]
        str.w r14, [r0, #12]
        str.w r6, [r0], #16
    subs r1, r1, #1
    bne 1b
    pop.w {r4-r7, pc}

