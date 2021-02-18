.syntax unified
.thumb
.macro redq a, tmp, q
    add     \tmp, \a,  #4194304
    asrs    \tmp, \tmp, #23
    mls     \a, \tmp, \q, \a
.endm

// void asm_reduce32(int32_t a[N]);
.global pqcrystals_dilithium_asm_reduce32
.type pqcrystals_dilithium_asm_reduce32, %function
.align 2
pqcrystals_dilithium_asm_reduce32:
    push {r4-r10}

    movw r12,#:lower16:8380417
    movt r12,#:upper16:8380417
    movw r10, #32
    1:
        ldr.w r1, [r0]
        ldr.w r2, [r0, #1*4]
        ldr.w r3, [r0, #2*4]
        ldr.w r4, [r0, #3*4]
        ldr.w r5, [r0, #4*4]
        ldr.w r6, [r0, #5*4]
        ldr.w r7, [r0, #6*4]
        ldr.w r8, [r0, #7*4]

        redq r1, r9, r12
        redq r2, r9, r12
        redq r3, r9, r12
        redq r4, r9, r12
        redq r5, r9, r12
        redq r6, r9, r12
        redq r7, r9, r12
        redq r8, r9, r12

        str.w r2, [r0, #1*4]
        str.w r3, [r0, #2*4]
        str.w r4, [r0, #3*4]
        str.w r5, [r0, #4*4]
        str.w r6, [r0, #5*4]
        str.w r7, [r0, #6*4]
        str.w r8, [r0, #7*4]
        str r1, [r0], #8*4
        subs r10, #1
        bne.w 1b

    pop {r4-r10}
    bx lr
.size pqcrystals_dilithium_asm_reduce32, .-pqcrystals_dilithium_asm_reduce32

.macro caddq a, tmp, q
    and     \tmp, \q, \a, asr #31
    add     \a, \a, \tmp
.endm

.macro freezeq a, tmp, q
    redq \a, \tmp, \q
    caddq \a, \tmp, \q
.endm

// void asm_caddq(int32_t a[N]);
.global pqcrystals_dilithium_asm_caddq
.type pqcrystals_dilithium_asm_caddq, %function
.align 2
pqcrystals_dilithium_asm_caddq:
    push {r4-r10}

    movw r12,#:lower16:8380417
    movt r12,#:upper16:8380417

    movw r10, #32
    1:
        ldr.w r1, [r0]
        ldr.w r2, [r0, #1*4]
        ldr.w r3, [r0, #2*4]
        ldr.w r4, [r0, #3*4]
        ldr.w r5, [r0, #4*4]
        ldr.w r6, [r0, #5*4]
        ldr.w r7, [r0, #6*4]
        ldr.w r8, [r0, #7*4]

        caddq r1, r9, r12
        caddq r2, r9, r12
        caddq r3, r9, r12
        caddq r4, r9, r12
        caddq r5, r9, r12
        caddq r6, r9, r12
        caddq r7, r9, r12
        caddq r8, r9, r12

        str.w r2, [r0, #1*4]
        str.w r3, [r0, #2*4]
        str.w r4, [r0, #3*4]
        str.w r5, [r0, #4*4]
        str.w r6, [r0, #5*4]
        str.w r7, [r0, #6*4]
        str.w r8, [r0, #7*4]
        str r1, [r0], #8*4
        subs r10, #1
        bne.w 1b

    pop {r4-r10}
    bx lr
.size pqcrystals_dilithium_asm_caddq, .-pqcrystals_dilithium_asm_caddq


// asm_rej_uniform(int32_t *a,unsigned int len,const unsigned char *buf, unsigned int buflen);
.global pqcrystals_dilithium_asm_rej_uniform
.type pqcrystals_dilithium_asm_rej_uniform, %function
.align 2
pqcrystals_dilithium_asm_rej_uniform:
    push.w {r4-r6}
    push.w {r1}
    // Store Q-1 in r12.
    movw r12,#:lower16:8380416
    movt r12,#:upper16:8380416

    add.w r6, r0, r1, lsl #2
    add.w r3, r2, r3
    sub.w r3, r3, #2

1:
    // If there are less than 3 bytes available, return.
    cmp.w r3, r2
    ble.w end

    ldr r5, [r2], #3
    ubfx r5, r5, #0, #23

    cmp.n r5, r12
    it le
    strle r5, [r0], #4

    cmp.n r0, r6
    bne.n 1b

end:
    pop.w {r5}

    sub.w r0, r6, r0
    sub.w r0, r5, r0, lsr #2
    pop.w {r4-r6}
    bx lr
.size pqcrystals_dilithium_asm_rej_uniform, .-pqcrystals_dilithium_asm_rej_uniform
