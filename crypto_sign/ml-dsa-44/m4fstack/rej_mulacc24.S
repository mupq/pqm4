.syntax unified
.thumb

// unsigned int asm_rej_mulacc24(uint8_t w[3*N], const int32_t b[N], unsigned int ctr, const uint8_t *buf, unsigned int buflen);
// For each three bytes of buf (buflen a multiple of 3), the candidate t is their low 23 bits; if t < Q:
// w[ctr] = (w[ctr] + t*b[ctr]*2^-32) mod Q on the 24-bit packed w (canonical in, canonical out), ctr++.
// Stops when ctr reaches N; returns the new ctr (ctr <= N on entry; ctr = N returns without reading or writing w, b or buf).
// Candidates and w are accessed with exact 3-byte loads and stores (unaligned halfword access, as elsewhere in this implementation).
// The Montgomery product uses -Q^-1, so it lies in (-Q, Q) and may differ from the C montgomery_reduce by Q; the stored value is the same.
.global pqcrystals_dilithium_asm_rej_mulacc24
.type pqcrystals_dilithium_asm_rej_mulacc24, %function
.align 2
pqcrystals_dilithium_asm_rej_mulacc24:
    push.w {r4-r11, lr}
    ldr.w r6, [sp, #36]

    add.w r7, r1, #1024
    add.w r6, r3, r6
    add.w r0, r0, r2
    add.w r0, r0, r2, lsl #1
    add.w r1, r1, r2, lsl #2
    mov.w r2, r3

    movw r4,#:lower16:8380417
    movt r4,#:upper16:8380417
    movw r5,#:lower16:0xfc7fdfff
    movt r5,#:upper16:0xfc7fdfff

    cmp.w r1, r7
    beq.w 3f
    cmp.w r2, r6
    bhs.w 3f

1:
    ldrh.w r8, [r2], #2
    ldrb.w r12, [r2], #1
    orr.w r8, r8, r12, lsl #16
    bic.w r8, r8, #0x800000

    cmp.w r8, r4
    bhs.w 2f

    // Montgomery product in (-Q, Q)
    ldr.w r9, [r1], #4
    smull r8, r10, r8, r9
    mul.w r9, r8, r5
    smlal r8, r10, r9, r4

    // 24-bit accumulate and reduce to [0, Q)
    ldrh.w r11, [r0]
    ldrb.w r12, [r0, #2]
    orr.w r11, r11, r12, lsl #16
    add.w r11, r11, r10
    and.w r12, r4, r11, asr #31
    add.w r11, r11, r12
    subs.w r12, r11, r4
    it hs
    movhs.w r11, r12
    strh.w r11, [r0], #2
    lsr.w r11, r11, #16
    strb.w r11, [r0], #1

    cmp.w r1, r7
    beq.w 3f
2:
    cmp.w r2, r6
    blo.w 1b

3:
    sub.w r0, r7, r1
    rsb.w r0, r0, #1024
    lsr.w r0, r0, #2
    pop.w {r4-r11, pc}
.size pqcrystals_dilithium_asm_rej_mulacc24, .-pqcrystals_dilithium_asm_rej_mulacc24
