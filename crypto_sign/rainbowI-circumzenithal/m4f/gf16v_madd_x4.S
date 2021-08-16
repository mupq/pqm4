.syntax unified
.cpu cortex-m4
.thumb

#include "bitslice.inc"
#include "madd_bitsliced.inc"


// void gf16v_madd_u32_x4_asm(uint32_t *c, uint32_t *a, uint8_t b, size_t n)
.global gf16v_madd_u32_x4_asm
.type gf16v_madd_u32_x4_asm, %function
.align 2
gf16v_madd_u32_x4_asm:
    push.w {r4-r12, r14}
    vmov.w s0, r3
    1:
        ldr.w r3, [r0]
        ldr.w r4, [r0,#4]
        ldr.w r5, [r0,#8]
        ldr.w r6, [r0,#12]
        ldr.w r8, [r1,#4]
        ldr.w r9, [r1,#8]
        ldr.w r10, [r1,#12]
        ldr.w r7, [r1], #16
        vmov.w s1, r1

        bitslice r1, r11, r12, r14, r3, r4, r5, r6
        bitslice r3, r4, r5, r6, r7, r8, r9, r10

        madd_bitsliced r1, r11, r12, r14, r3, r4, r5, r6, r2, r7, r8, r9, r10

        bitslice r3, r4, r5, r6, r1, r11, r12, r14

        str.w r4, [r0,#4]
        str.w r5, [r0,#8]
        str.w r6, [r0,#12]
        str.w r3, [r0], #16

        vmov.w r3, s0
        subs.w r3, #1
        vmov.w s0, r3
        vmov.w r1, s1
        bne.w 1b

    pop.w {r4-r12, pc}

// void gf16v_madd_u32_x4_normal_bitsliced_asm(uint32_t *c, uint32_t *a, uint8_t b, size_t n)
.global gf16v_madd_u32_x4_normal_bitsliced_asm
.type gf16v_madd_u32_x4_normal_bitsliced_asm, %function
.align 2
gf16v_madd_u32_x4_normal_bitsliced_asm:
    push.w {r4-r12, r14}
    vmov.w s0, r3
    1:
        ldr.w r3, [r0]
        ldr.w r4, [r0,#4]
        ldr.w r5, [r0,#8]
        ldr.w r6, [r0,#12]
        ldr.w r8, [r1,#4]
        ldr.w r9, [r1,#8]
        ldr.w r10, [r1,#12]
        ldr.w r7, [r1], #16
        vmov.w s1, r1

        //bitslice A; accumulator is already bitsliced
        bitslice r1, r11, r12, r14, r7, r8, r9, r10

        madd_bitsliced r3, r4, r5, r6, r1, r11, r12, r14, r2, r7, r8, r9, r10

        // keep accumulator bitsliced

        str.w r4, [r0,#4]
        str.w r5, [r0,#8]
        str.w r6, [r0,#12]
        str.w r3, [r0], #16

        vmov.w r3, s0
        subs.w r3, #1
        vmov.w s0, r3
        vmov.w r1, s1
        bne.w 1b

    pop.w {r4-r12, pc}