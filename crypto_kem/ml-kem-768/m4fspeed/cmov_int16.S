.syntax unified
.cpu cortex-m4
.thumb

// void cmov_int16(int16_t *r, int16_t v, uint16_t b)
.global cmov_int16
.type cmov_int16, %function
.align 2
cmov_int16:
    cmp.w r2, #0
    ldrsh.w r3, [r0]
    it ne
    movne.w r3, r1
    strh.w r3, [r0]
    bx lr