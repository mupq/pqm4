.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.p2align 2,,3
.syntax unified

.text
wpad:
    .word 677119
    .word 1
    .word 6342
    .word 558
    .word 5785
    .word 557
    .word 5786
    .word 2674
    .word 3669
    .word 1487
    .word 4856
    .word 5156
    .word 1187
    .word 1715
    .word 4628
    .word 5520
    .word 823
    .word 3805
    .word 2538
    .word 6264
    .word 79
    .word 319
    .word 6024
    .word 398
    .word 5945
    .word 4416
    .word 1927
    .word 3044
    .word 3299
    .word 4971
    .word 1372
    .word 4061
    .word 2282
    .word 1587
    .word 4756
    .word 3869
    .word 2474
    .word 6241
    .word 102
    .word 171
    .word 6172
    .word 273
    .word 6070

.equ basesize, 48
.global basemul_2016
.type basemul_2016, %function
basemul_2016:
    push {r4-r11, lr}
    sub.w sp, sp, #4*basesize
    adr.w r9, wpad
    ldr.w r10, [r9], #4
    mov.w r11, #6343
    add.w r12, r0, #42*basesize*2
    mov.w r7, r0
    mov.w r4, sp
    mov.w r5, r1
    mov.w r6, r2
basemul_2016_body:
    ldr.w r8, [r9], #4
    mov.w r0, r4
    mov.w r1, r5
    mov.w r2, r6
    bl.w gf_polymul_48x48
.rept basesize/2
    ldr.w r2, [r4, #1*basesize*2]
    ldr.w r0, [r4], #4
    sbfx r1, r0, #16, #16
    sbfx r0, r0, #0, #16
    smlabb r0, r8, r2, r0
    smlabt r1, r8, r2, r1
    barrett_reduce r0, r10, r11, r2
    barrett_reduce r1, r10, r11, r2
    pkhbt r0, r0, r1, lsl #16
    str.w r0, [r7], #4
.endr
    sub.w r4, r4, #1*basesize*2
    add.w r5, r5, #1*basesize*2
    add.w r6, r6, #1*basesize*2
    cmp.w r7, r12
    bne.w basemul_2016_body
    add.w sp, sp, #4*basesize
    pop {r4-r11, pc}
    
