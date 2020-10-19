.syntax unified
.thumb
.macro redq a, tmp, q
    ubfx \tmp, \a, #0, #23
    asr.w \a, \a, #23
    sub.w \tmp, \tmp, \a
    add.w \a, \tmp, \a, lsl#13
    cmp.n \a, \q
    it ge
    subge.w \a, \a, \q
.endm

.global poly_reduce_asm
.type poly_reduce_asm, %function
.align 2
poly_reduce_asm:
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

.macro freezeq a, tmp, q
    ubfx \tmp, \a, #0, #23
    asr.w \a, \a, #23
    sub.w \tmp, \tmp, \a
    add.w \a, \tmp, \a, lsl#13
    cmp.n \a, \q
    it ge
    subge.w \a, \a, \q
    cmp \a, #0
    it mi
    addmi.w \a, \a, \q
.endm

.global poly_freeze_asm
.type poly_freeze_asm, %function
.align 2
poly_freeze_asm:
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

        freezeq r1, r9, r12
        freezeq r2, r9, r12
        freezeq r3, r9, r12
        freezeq r4, r9, r12
        freezeq r5, r9, r12
        freezeq r6, r9, r12
        freezeq r7, r9, r12
        freezeq r8, r9, r12

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

.macro csubq a, tmp, q
    cmp.n \a, \q
    it ge
    subge.w \a, \a, \q
    cmp \a, #0
    it mi
    addmi.w \a, \a, \q
.endm

.global poly_csubq_asm
.type poly_csubq_asm, %function
.align 2
poly_csubq_asm:
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

        csubq r1, r9, r12
        csubq r2, r9, r12
        csubq r3, r9, r12
        csubq r4, r9, r12
        csubq r5, r9, r12
        csubq r6, r9, r12
        csubq r7, r9, r12
        csubq r8, r9, r12

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


//rej_uniform_asm(int32_t *a,unsigned int len,const unsigned char *buf, unsigned int buflen);
.global rej_uniform_asm
.type rej_uniform_asm, %function
.align 2
rej_uniform_asm:
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
