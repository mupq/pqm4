
#include "macros.i"
#include "special_butterflies.i"

.syntax unified
.cpu cortex-m4
.thumb

.align 2
.global __asm_Good_3x2
.type __asm_Good_3x2, %function
__asm_Good_3x2:
    push.w {r4-r12, lr}

    .equ ldrwidth, 2
    .equ width, 4
    .equ base, 3
    .equ logq, 12

    ldr.w r14, [sp, #40]

    ldm.w r1, {r10-r11}


    add.w r12, r0, #3*width
    _Good_loop0:

    add.w r1, r0, #729*width
    vmov.w s3, r1
    _Good_loop0_inner:

    .equ ldroffset, 0
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((96*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_110_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 3
    .equ stroffset, 27
    ldrsh.w r5, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((32*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_010_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 6
    .equ stroffset, 54
    ldrsh.w r5, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((256*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_011_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 9
    .equ stroffset, 81
    ldrsh.w r5, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((192*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_011_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 12
    .equ stroffset, 108
    ldrsh.w r5, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((128*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_001_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    vmov.w r1, s3
    cmp.w r0, r1
    beq.w _Good_loop0_inner_end

    .equ ldroffset, 15
    .equ stroffset, 135
    ldrsh.w r4, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((64*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_101_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]
    add.w r0, r0, #27*6*width

    .equ ldroffset, 18
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((0*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_101_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 21
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((224*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_100_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 24
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((160*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_110_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    add.w r14, r14, #3*9*ldrwidth
    add.w r0, r0, #27*3*width

    b.w _Good_loop0_inner

    _Good_loop0_inner_end:

    sub.w r14, r14, #81*ldrwidth
    sub.w r0, r0, #729*width

    add.w r14, r14, #ldrwidth
    add.w r0, r0, #width

    cmp.w r0, r12
    bne.w _Good_loop0


    sub.w r14, r14, #3*ldrwidth
    sub.w r0, r0, #3*width


    add.w r0, r0, #base*width

    add.w r12, r0, #3*width
    _Good_loop1:

    add.w r1, r0, #729*width
    vmov.w s3, r1
    _Good_loop1_inner:

    .equ ldroffset, 0
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((160*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_110_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 3
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((96*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_110_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 6
    .equ stroffset, 54
    ldrsh.w r5, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((32*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_010_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 9
    .equ stroffset, 81
    ldrsh.w r5, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((256*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_011_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 12
    .equ stroffset, 108
    ldrsh.w r5, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((192*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_011_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    vmov.w r1, s3
    cmp.w r0, r1
    beq.w _Good_loop1_inner_end

    .equ ldroffset, 15
    .equ stroffset, 135
    ldrsh.w r5, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((128*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_001_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]
    add.w r0, r0, #27*6*width

    .equ ldroffset, 18
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((64*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_101_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 21
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((0*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_101_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 24
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((224*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_100_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    add.w r14, r14, #3*9*ldrwidth
    add.w r0, r0, #27*3*width

    b.w _Good_loop1_inner

    _Good_loop1_inner_end:

    sub.w r14, r14, #81*ldrwidth
    sub.w r0, r0, #729*width

    add.w r14, r14, #ldrwidth
    add.w r0, r0, #width

    cmp.w r0, r12
    bne.w _Good_loop1

    sub.w r14, r14, #3*ldrwidth
    sub.w r0, r0, #3*width


    add.w r0, r0, #base*width

    add.w r12, r0, #3*width
    _Good_loop2:

    add.w r1, r0, #729*width
    vmov.w s3, r1
    _Good_loop2_inner:

    .equ ldroffset, 0
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((224*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_100_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 3
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((160*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_110_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 6
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((96*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_110_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 9
    .equ stroffset, 81
    ldrsh.w r5, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((32*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r9, r9, #0, #logq
    _6_ntt_010_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 12
    .equ stroffset, 108
    ldrsh.w r5, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((256*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_011_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    vmov.w r1, s3
    cmp.w r0, r1
    beq.w _Good_loop2_inner_end

    .equ ldroffset, 15
    .equ stroffset, 135
    ldrsh.w r5, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((192*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r6, r6, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_011_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]
    add.w r0, r0, #27*6*width

    .equ ldroffset, 18
    .equ stroffset, 0
    ldrsh.w r5, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((128*base+ldroffset)*ldrwidth)]
    sbfx.w r5, r5, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_001_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 21
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((64*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_101_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 24
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((0*base+ldroffset)*ldrwidth)]
    sbfx.w r4, r4, #0, #logq
    sbfx.w r7, r7, #0, #logq
    sbfx.w r8, r8, #0, #logq
    _6_ntt_101_low r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    add.w r14, r14, #3*9*ldrwidth
    add.w r0, r0, #27*3*width

    b.w _Good_loop2_inner

    _Good_loop2_inner_end:

    sub.w r14, r14, #81*ldrwidth
    sub.w r0, r0, #729*width

    add.w r14, r14, #ldrwidth
    add.w r0, r0, #width

    cmp.w r0, r12
    bne.w _Good_loop2


    pop.w {r4-r12, pc}

.align 2
.global __asm_Good_3x2_small
.type __asm_Good_3x2_small, %function
__asm_Good_3x2_small:
    push.w {r4-r12, lr}

    .equ ldrwidth, 2
    .equ width, 4
    .equ base, 3

    ldr.w r14, [sp, #40]

    ldm.w r1, {r10-r11}


    add.w r12, r0, #3*width
    _Good_loop0_small:

    add.w r1, r0, #729*width
    vmov.w s3, r1
    _Good_loop0_small_inner:

    .equ ldroffset, 0
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((96*base+ldroffset)*ldrwidth)]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 3
    .equ stroffset, 27
    ldrsh.w r5, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((32*base+ldroffset)*ldrwidth)]
    _6_ntt_010_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 6
    .equ stroffset, 54
    ldrsh.w r5, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((256*base+ldroffset)*ldrwidth)]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 9
    .equ stroffset, 81
    ldrsh.w r5, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((192*base+ldroffset)*ldrwidth)]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 12
    .equ stroffset, 108
    ldrsh.w r5, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((128*base+ldroffset)*ldrwidth)]
    _6_ntt_001_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    vmov.w r1, s3
    cmp.w r0, r1
    beq.w _Good_loop0_small_inner_end

    .equ ldroffset, 15
    .equ stroffset, 135
    ldrsh.w r4, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((64*base+ldroffset)*ldrwidth)]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]
    add.w r0, r0, #27*6*width

    .equ ldroffset, 18
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((0*base+ldroffset)*ldrwidth)]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 21
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((224*base+ldroffset)*ldrwidth)]
    _6_ntt_100_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 24
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((160*base+ldroffset)*ldrwidth)]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    add.w r14, r14, #3*9*ldrwidth
    add.w r0, r0, #27*3*width

    b.w _Good_loop0_small_inner

    _Good_loop0_small_inner_end:

    sub.w r14, r14, #81*ldrwidth
    sub.w r0, r0, #729*width

    add.w r14, r14, #ldrwidth
    add.w r0, r0, #width

    cmp.w r0, r12
    bne.w _Good_loop0_small


    sub.w r14, r14, #3*ldrwidth
    sub.w r0, r0, #3*width


    add.w r0, r0, #base*width

    add.w r12, r0, #3*width
    _Good_loop1_small:

    add.w r1, r0, #729*width
    vmov.w s3, r1
    _Good_loop1_small_inner:

    .equ ldroffset, 0
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((160*base+ldroffset)*ldrwidth)]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 3
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((96*base+ldroffset)*ldrwidth)]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 6
    .equ stroffset, 54
    ldrsh.w r5, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((32*base+ldroffset)*ldrwidth)]
    _6_ntt_010_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 9
    .equ stroffset, 81
    ldrsh.w r5, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((256*base+ldroffset)*ldrwidth)]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 12
    .equ stroffset, 108
    ldrsh.w r5, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((192*base+ldroffset)*ldrwidth)]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    vmov.w r1, s3
    cmp.w r0, r1
    beq.w _Good_loop1_small_inner_end

    .equ ldroffset, 15
    .equ stroffset, 135
    ldrsh.w r5, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((128*base+ldroffset)*ldrwidth)]
    _6_ntt_001_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]
    add.w r0, r0, #27*6*width

    .equ ldroffset, 18
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((64*base+ldroffset)*ldrwidth)]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 21
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((0*base+ldroffset)*ldrwidth)]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 24
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((224*base+ldroffset)*ldrwidth)]
    _6_ntt_100_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    add.w r14, r14, #3*9*ldrwidth
    add.w r0, r0, #27*3*width

    b.w _Good_loop1_small_inner

    _Good_loop1_small_inner_end:

    sub.w r14, r14, #81*ldrwidth
    sub.w r0, r0, #729*width

    add.w r14, r14, #ldrwidth
    add.w r0, r0, #width

    cmp.w r0, r12
    bne.w _Good_loop1_small

    sub.w r14, r14, #3*ldrwidth
    sub.w r0, r0, #3*width


    add.w r0, r0, #base*width

    add.w r12, r0, #3*width
    _Good_loop2_small:

    add.w r1, r0, #729*width
    vmov.w s3, r1
    _Good_loop2_small_inner:

    .equ ldroffset, 0
    .equ stroffset, 0
    ldrsh.w r4, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((224*base+ldroffset)*ldrwidth)]
    _6_ntt_100_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 3
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((160*base+ldroffset)*ldrwidth)]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 6
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((96*base+ldroffset)*ldrwidth)]
    _6_ntt_110_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 9
    .equ stroffset, 81
    ldrsh.w r5, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((128*base+ldroffset)*ldrwidth)]
    ldrsh.w r9, [r14, #((32*base+ldroffset)*ldrwidth)]
    _6_ntt_010_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 12
    .equ stroffset, 108
    ldrsh.w r5, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((64*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((256*base+ldroffset)*ldrwidth)]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    vmov.w r1, s3
    cmp.w r0, r1
    beq.w _Good_loop2_small_inner_end

    .equ ldroffset, 15
    .equ stroffset, 135
    ldrsh.w r5, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r6, [r14, #((0*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((192*base+ldroffset)*ldrwidth)]
    _6_ntt_011_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]
    add.w r0, r0, #27*6*width

    .equ ldroffset, 18
    .equ stroffset, 0
    ldrsh.w r5, [r14, #((32*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((224*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((128*base+ldroffset)*ldrwidth)]
    _6_ntt_001_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 21
    .equ stroffset, 27
    ldrsh.w r4, [r14, #((256*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((160*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((64*base+ldroffset)*ldrwidth)]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    .equ ldroffset, 24
    .equ stroffset, 54
    ldrsh.w r4, [r14, #((192*base+ldroffset)*ldrwidth)]
    ldrsh.w r7, [r14, #((96*base+ldroffset)*ldrwidth)]
    ldrsh.w r8, [r14, #((0*base+ldroffset)*ldrwidth)]
    _6_ntt_101_small r4, r5, r6, r7, r8, r9, r10, r11, r2, r3, r1
    str.w r4, [r0, #(0*base+stroffset)*width]
    str.w r6, [r0, #(3*base+stroffset)*width]
    str.w r8, [r0, #(6*base+stroffset)*width]
    str.w r5, [r0, #(864+0*base+stroffset)*width]
    str.w r7, [r0, #(864+3*base+stroffset)*width]
    str.w r9, [r0, #(864+6*base+stroffset)*width]

    add.w r14, r14, #3*9*ldrwidth
    add.w r0, r0, #27*3*width

    b.w _Good_loop2_small_inner

    _Good_loop2_small_inner_end:

    sub.w r14, r14, #81*ldrwidth
    sub.w r0, r0, #729*width

    add.w r14, r14, #ldrwidth
    add.w r0, r0, #width

    cmp.w r0, r12
    bne.w _Good_loop2_small


    pop.w {r4-r12, pc}





