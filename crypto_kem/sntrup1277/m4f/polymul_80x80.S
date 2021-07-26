.p2align
.syntax unified
.text

.equ size, 80
.global gf_polymul_80x80
.type gf_polymul_80x80, %function
gf_polymul_80x80:
    push {r4-r11, lr}
    vmov s4, r0
    sub.w sp, sp, #3*size*2
    mov.w r0, sp
    add.w lr, r0, #1*size
gf_polymul_80x80_extend:
.rept 2
    ldr.w r4, [r1, #4]
    ldr.w r5, [r1, #1*size]
    ldr.w r6, [r1, #1*size+4]
    ldr.w r3, [r1], #8
    ldr.w r8, [r2, #4]
    ldr.w r9, [r2, #1*size]
    ldr.w r10, [r2, #1*size+4]
    ldr.w r7, [r2], #8
    sadd16 r3, r3, r5
    sadd16 r4, r4, r6
    sadd16 r7, r7, r9
    sadd16 r8, r8, r10
    str.w r4, [r0, #4]
    str.w r7, [r0, #1*size]
    str.w r8, [r0, #1*size+4]
    str.w r3, [r0], #8
.endr
    cmp.w r0, lr
    bne.w gf_polymul_80x80_extend
    
    sub.w r4, r0, #1*size
    sub.w r5, r1, #1*size
    sub.w r6, r2, #1*size

    add.w r0, r4, #2*size*2
    mov.w r1, r4
    add.w r2, r4, #1*size
    bl.w gf_polymul_40x40

    add.w r0, r4, #1*size*2
    add.w r1, r5, #1*size
    add.w r2, r6, #1*size
    bl.w gf_polymul_40x40

    mov.w r0, r4
    mov.w r1, r5
    mov.w r2, r6
    bl.w gf_polymul_40x40

    vmov r0, s4
    mov.w r1, r4
    add.w lr, r1, #1*size
    movw.w r11, #20828
    movt.w r11, #8
    mov.w r12, #7879
@ (a0+a1)(b0+b1)x + (1-x)(a0b0-a1b1x)
@ a0b0bot a0b0top
@         -a1b1bot -a1b1top
@         -a0b0bot -a0b0top
@                  a1b1bot  a1b1top
@         aabbbot  aabbtop
gf_polymul_80x80_output:
    ldr.w r3, [r1, #1*size] @ a0b0top
    ldr.w r4, [r1, #2*size] @ a1b1bot
    ldr.w r5, [r1, #3*size] @ a1b1top
    ldr.w r6, [r1, #4*size] @ (a0+a1)(b0+b1) bot
    ldr.w r7, [r1, #5*size] @ (a0+a1)(b0+b1) top
    ldr.w r2, [r1], #4  @ a0b0bot
    str.w r5, [r0, #3*size]

    ssub16 r8, r3, r4 @ a0b0top - a1b1bot
    ssub16 r9, r8, r2
    sadd16 r9, r9, r6
    
    sadd16 r10, r5, r8
    ssub16 r10, r7, r10

    sbfx r7, r9, #0, #16
    sbfx r8, r9, #16, #16
    smmulr r6, r7, r11
    mls r7, r6, r12, r7
    smmulr r6, r8, r11
    mls r8, r6, r12, r8
    pkhbt r9, r7, r8, lsl #16

    sbfx r7, r10, #0, #16
    sbfx r8, r10, #16, #16
    smmulr r6, r7, r11
    mls r7, r6, r12, r7
    smmulr r6, r8, r11
    mls r8, r6, r12, r8
    pkhbt r10, r7, r8, lsl #16

    str.w r9, [r0, #1*size]
    str.w r10, [r0, #2*size]
    str.w r2, [r0], #4
    cmp.w r1, lr
    bne.w gf_polymul_80x80_output
    add.w sp, sp, #3*size*2
    pop {r4-r11, pc}

    

