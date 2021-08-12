.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.p2align 2,,3
.syntax unified

.text
wpad:
    .word 545116
    .word 1
    .word 7878
    .word 6513
    .word 1366
    .word 6512
    .word 1367
    .word 3871
    .word 4008
    .word 6902
    .word 977
    .word 3031
    .word 4848
    .word 6662
    .word 1217
    .word 7832
    .word 47
    .word 1170
    .word 6709
    .word 635
    .word 7244
    .word 7159
    .word 720
    .word 6524
    .word 1355
    .word 7716
    .word 163
    .word 2046
    .word 5833
    .word 2209
    .word 5670
    .word 7226
    .word 653
    .word 1671
    .word 6208
    .word 2324
    .word 5555
    .word 1396
    .word 6483
    .word 7661
    .word 218
    .word 6265
    .word 1614
    .word 6801
    .word 1078
    .word 7054
    .word 825
    .word 253
    .word 7626
    .word 2932
    .word 4947
    .word 5299
    .word 2580
    .word 2367
    .word 5512
    .word 4012
    .word 3867
    .word 3392
    .word 4487
    .word 7259
    .word 620
    .word 943
    .word 6936
    .word 4018
    .word 3861
    .word 3075
    .word 4804
    .word 2376
    .word 5503
    .word 532
    .word 7347
    .word 6035
    .word 1844
    .word 2703
    .word 5176
    .word 2953
    .word 4926
    .word 250
    .word 7629

.equ basesize, 16
.global basemul_1248
.type basemul_1248, %function
basemul_1248:
    push {r4-r11, lr}
    sub.w sp, sp, #4*basesize
    adr.w r9, wpad
    ldr.w r10, [r9], #4
    mov.w r11, #7879
    add.w r12, r0, #40*basesize*2
    add.w r12, r12, #38*basesize*2
    mov.w r7, r0
    mov.w r4, sp
    mov.w r5, r1
    mov.w r6, r2
basemul_1248_body:
    ldr.w r8, [r9], #4
    mov.w r0, r4
    mov.w r1, r5
    mov.w r2, r6
    bl.w gf_polymul_16x16
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
    bne.w basemul_1248_body
    add.w sp, sp, #4*basesize
    pop {r4-r11, pc}
    
