
.macro montgomery_mul a, b, lower, upper, tmp, M_inv, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \M_inv
    smlal.w \lower, \upper, \tmp, \M
.endm

.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it hi
    subhi \target, \M
.endm

.syntax unified
.cpu cortex-m4

// deal with this stuff
// (1026, -1, 258, -1, -1, 642, -1, -1)
// (-1, 132, 1284, -1, 516, -1, -1, 900)
// (6, 1158, -1, 390, -1, -1, 774, -1)
// (1032, -1, 264, -1, -1, 648, -1, -1)
// (-1, 138, 1290, -1, 522, -1, -1, 906)
// (12, 1164, -1, 396, -1, -1, 780, -1)
// ...

.align 10   // 0x000
Good_loop_combined_16:
    vmov.w s11, lr
    start_loop_combined_16:

    /**** type 1 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #1026]
    ldrsh.w r5, [r1, #642]
    ldrsh.w r6, [r1, #258]


    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12

    neg.w r11, r5

    // level 2

    // a256<->a384, c[0]
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2

    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r4, r6
    sub.w r6, r4, r6, lsl #1

    mov.w r7, r5


    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r11, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    /**** type 2 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #516]
    ldrsh.w r5, [r1, #132]
    ldrsh.w r6, [r1, #1284]
    ldrsh.w r7, [r1, #900]

    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // level 2

    // a256<->a384, c[0]
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2

    // a320<->a448, c[0]
    montgomery_mul r7, r1, r12, r11, r14, r3, r2

    sub.w r8, r10, r4
    sub.w r9, r5, r11
    add r4, r6
    add r5, r7
    sub.w r10, r8, r10, lsl #1
    add.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #4]
    str.w r5, [r0, #260]
    str.w r6, [r0, #516]
    str.w r7, [r0, #772]
    str.w r8, [r0, #1028]
    str.w r9, [r0, #1284]
    str.w r10, [r0, #1540]
    str.w r11, [r0, #1796]

    /**** type 0 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #6]
    ldrsh.w r5, [r1, #1158]
    ldrsh.w r6, [r1, #774]
    ldrsh.w r7, [r1, #390]
    add.w r1, #6
    vmov.w s9, r1

    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // layer 2
    // a256<->a384, c[0]
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2

    // a320<->a448, c[0]
    montgomery_mul r7, r1, r12, r11, r14, r3, r2

    sub.w r8, r4, r10
    add.w r9, r5, r11
    add r4, r6
    add r5, r7
    add.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #8]
    str.w r5, [r0, #264]
    str.w r6, [r0, #520]
    str.w r7, [r0, #776]
    str.w r8, [r0, #1032]
    str.w r9, [r0, #1288]
    str.w r10, [r0, #1544]
    str.w r11, [r0, #1800]

    add.w r0, #12

    // compare
    vmov.w r7, s13
    cmp.w r7, r0
    bne.w start_loop_combined_16

    vmov.w lr, s11
    bx lr

.align 10   // 0x000
remaining_type3_16:
    vmov.w s11, lr

    vmov.w r1, s9
    ldrsh.w r4, [r1, #1144]
    ldrsh.w r5, [r1, #760]
    ldrsh.w r6, [r1, #376]
    add.w r1, #2
    vmov.w s9, r1


    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12

    neg.w r11, r5

    // layer 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2

    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r4, r6
    sub.w r6, r4, r6, lsl #1

    mov.w r7, r5

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r11, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

.align 10   // 0x000
remaining_type2_16:
    vmov.w s11, lr
    /**** type 2 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #512]
    ldrsh.w r5, [r1, #128]
    ldrsh.w r6, [r1, #1280]
    ldrsh.w r7, [r1, #896]
    add.w r1, #2
    vmov.w s9, r1

    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // level 2

    // a256<->a384, c[0]
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2

    // a320<->a448, c[0]
    montgomery_mul r7, r1, r12, r11, r14, r3, r2

    sub.w r8, r10, r4
    sub.w r9, r5, r11
    add r4, r6
    add r5, r7
    sub.w r10, r8, r10, lsl #1
    add.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

.align 10   // 0x000
remaining_type0_16:
    vmov.w s11, lr
    /**** type 0 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #0]
    ldrsh.w r5, [r1, #1152]
    ldrsh.w r6, [r1, #768]
    ldrsh.w r7, [r1, #384]
    add.w r1, #2
    vmov.w s9, r1


    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // layer 2
    // a256<->a384, c[0]
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2

    // a320<->a448, c[0]
    montgomery_mul r7, r1, r12, r11, r14, r3, r2

    sub.w r8, r4, r10
    add.w r9, r5, r11
    add r4, r6
    add r5, r7
    add.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

    .align 10   // 0x000
remaining_type4_16:
    vmov.w s11, lr
    /**** type 2 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #634]
    ldrsh.w r5, [r1, #250]
    ldrsh.w r7, [r1, #1018]
    add.w r1, #2
    vmov.w s9, r1



    // central_reduce: [-4096, 4096]
    mov.w r1, #4096
    add.w r12, r1, r1
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r7, r1, r12

    // level 2

    // a256<->a384, c[0]
    neg r8, r4
    neg r10, r4

    // a320<->a448, c[0]
    vmov.w r1, s0
    montgomery_mul r7, r1, r12, r11, r14, r3, r2

    // order dependent, don't change
    sub.w r9, r5, r11
    add.w r11, r9, r11, lsl #1
    mov r6, r4
    add r5, r7
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

/***
0x000  ________________
      | loop:          |
      | ...            |
      | ...            |
0x248 |________________|

0x300  ________________
      | start:         |
      | ...            |
      | bl.w loop      |
      | set something  |
      | bl.w loop      |
      | set something  |
      | bl.w loop      |
      | ...            |
      |________________|

(I-cache size: 0x400)

.align 10
__pad0:
    nop

.align 9
__pad1:
    nop

.align 8
start:     // start will be in the bottom part of I-cache
    ...

.align 10
loop:      // loop will be in the upper part of I-cache
    ...

Minimize the need to replace the I-cache that will be used many times.
    ***/

// a = a+cb
// b = a-cb
.align 10 // 0x000
aaa_16:
    nop
.align 9  // 0x200
bbb_16:
    nop
.align 8  // 0x300
.global __asm_NTT_forward_16
.type __asm_NTT_forward_16, %function
__asm_NTT_forward_16:
    vmov.w s9, r0
    vmov.w s10, r0
    push.w {r4-r12, lr}
    vldm.w r1!, {s0-s3}
    ldr.w r0, [sp, #40]  // r0 --> Good0
    vmov.w s4, r0
    vmov.w s15, r1

    // s4  --> Good0
    // s9  --> tmp_src (for variable src pointer)
    // s10 --> original src
    // s11 --> link register
    // s13 --> counter
    // s15 --> root table

    // do for Good[0] 60 entries (a1~a60), remain 4 to do, (a0, a61~a63)
    add.w r0, #4
    add.w r7, r0, #240 // set counter (20*12=240)
    vmov.w s13, r7
    bl.w Good_loop_combined_16

    // do for Good[1] 60 entries (a2~a61), remain 4 to do, (a0, a1, a62~a63)
    add.w r0, #1812    // set Good[1][2]
    add.w r7, r0, #240 // set counter (20*12=240)
    vmov.w s13, r7
    vmov.w r8, s10
    add.w r8, #2
    vmov.w s9, r8      // set src + 2, 1028
    bl.w Good_loop_combined_16

    // do for Good[2] 60 entries (a0~a59), remain 4 to do, (a60~a63)
    add.w r0, #1800    // set Good[2][0]
    add.w r7, r0, #240 // set counter (20*12=240)
    vmov.w s13, r7
    vmov.w r8, s10
    add.w r8, #-2
    vmov.w s9, r8      // set src - 2, 1024
    bl.w Good_loop_combined_16



    // Type 3, offset 1144
    // (1144, -1, 376, -1, -1, 760, -1, -1)   type3 to Good[2][60]
    add.w r0, #0
    vmov.w s9, s10
    bl.w remaining_type3_16

    // (1146, -1, 378, -1, -1, 762, -1, -1)   type3 to Good[0][61]
    add.w r0, #-4092
    bl.w remaining_type3_16

    // (1148, -1, 380, -1, -1, 764, -1, -1)   type3 to Good[1][62]
    add.w r0, #2052
    bl.w remaining_type3_16

    // (1150, -1, 382, -1, -1, 766, -1, -1)   type3 to Good[2][63]
    add.w r0, #2052
    bl.w remaining_type3_16


    // Type 2, offset 128
    // (-1, 128, 1280, -1, 512, -1, -1, 896)  type2 to Good[1][0]
    add.w r0, #-2300
    vmov.w s9, s10
    bl.w remaining_type2_16

    // Type 2, offset 250
    // (-1, 250, -1, -1, 634, -1, -1, 1018, 'Good2', 61) type2 to Good[2][61]
    add.w r0, #2292
    vmov.w s9, s10
    bl.w remaining_type4_16

    // (-1, 252, -1, -1, 636, -1, -1, 1020, 'Good0', 62) type2 to Good[0][62]
    add.w r0, #-4092
    bl.w remaining_type4_16

    // (-1, 254, -1, -1, 638, -1, -1, 1022, 'Good1', 63) type2 to Good[1][63]
    add.w r0, #2052
    bl.w remaining_type4_16


    // Type 0, offset 0
    // (124, 1276, -1, 508, -1, -1, 892, -1)  type0 to Good[2][62]
    add.w r0, #2044
    vmov.w r8, s10
    add.w r8, #124
    vmov.w s9, r8
    bl.w remaining_type0_16

    // (126, 1278, -1, 510, -1, -1, 894, -1)  type0 to Good[0][63]
    add.w r0, #-4092
    bl.w remaining_type0_16

    // (0, 1152, -1, 384, -1, -1, 768, -1)    type0 to Good[0][0]
    add.w r0, #-252
    vmov.w s9, s10
    bl.w remaining_type0_16

    // (2, 1154, -1, 386, -1, -1, 770, -1)    type0 to Good[1][1]
    add.w r0, #2052
    bl.w remaining_type0_16


    // go to Good[0] + 228
    add.w r0, #-1824
    b.w _4_5_6

// deal with this stuff
// (1026, -1, 258, -1, -1, 642, -1, -1)
// (-1, 132, 1284, -1, 516, -1, -1, 900)
// (6, 1158, -1, 390, -1, -1, 774, -1)
// (1032, -1, 264, -1, -1, 648, -1, -1)
// (-1, 138, 1290, -1, 522, -1, -1, 906)
// (12, 1164, -1, 396, -1, -1, 780, -1)
// ...

.align 10   // 0x000
Good_loop_combined_16_small:
    vmov.w s11, lr
    start_loop_combined_16_small:

    /**** type 1 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #1026]
    ldrsh.w r5, [r1, #642]
    ldrsh.w r6, [r1, #258]


    neg.w r11, r5

    // level 2

    vmov.w r1, s3
    mul.w r10, r6, r1

    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r4, r6
    sub.w r6, r4, r6, lsl #1

    mov.w r7, r5


    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r11, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    /**** type 2 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #516]
    ldrsh.w r5, [r1, #132]
    ldrsh.w r6, [r1, #1284]
    ldrsh.w r7, [r1, #900]

    // level 2

    vmov.w r1, s3
    mul.w r10, r6, r1

    // a320<->a448, c[0]
    mul.w r11, r7, r1

    sub.w r8, r10, r4
    sub.w r9, r5, r11
    add r4, r6
    add r5, r7
    sub.w r10, r8, r10, lsl #1
    add.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #4]
    str.w r5, [r0, #260]
    str.w r6, [r0, #516]
    str.w r7, [r0, #772]
    str.w r8, [r0, #1028]
    str.w r9, [r0, #1284]
    str.w r10, [r0, #1540]
    str.w r11, [r0, #1796]

    /**** type 0 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #6]
    ldrsh.w r5, [r1, #1158]
    ldrsh.w r6, [r1, #774]
    ldrsh.w r7, [r1, #390]
    add.w r1, #6
    vmov.w s9, r1

    // layer 2
    // a256<->a384, c[0]
    vmov.w r1, s3
    mul.w r10, r6, r1

    // a320<->a448, c[0]
    mul.w r11, r7, r1

    sub.w r8, r4, r10
    add.w r9, r5, r11
    add r4, r6
    add r5, r7
    add.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #8]
    str.w r5, [r0, #264]
    str.w r6, [r0, #520]
    str.w r7, [r0, #776]
    str.w r8, [r0, #1032]
    str.w r9, [r0, #1288]
    str.w r10, [r0, #1544]
    str.w r11, [r0, #1800]

    add.w r0, #12

    // compare
    vmov.w r7, s13
    cmp.w r7, r0
    bne.w start_loop_combined_16_small

    vmov.w lr, s11
    bx lr

.align 10   // 0x000
remaining_type3_16_small:
    vmov.w s11, lr

    vmov.w r1, s9
    ldrsh.w r4, [r1, #1144]
    ldrsh.w r5, [r1, #760]
    ldrsh.w r6, [r1, #376]
    add.w r1, #2
    vmov.w s9, r1


    neg.w r11, r5

    // layer 2
    vmov.w r1, s3
    mul.w r10, r6, r1

    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r4, r6
    sub.w r6, r4, r6, lsl #1

    mov.w r7, r5

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r11, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

.align 10   // 0x000
remaining_type2_16_small:
    vmov.w s11, lr
    /**** type 2 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #512]
    ldrsh.w r5, [r1, #128]
    ldrsh.w r6, [r1, #1280]
    ldrsh.w r7, [r1, #896]
    add.w r1, #2
    vmov.w s9, r1

    // level 2

    vmov.w r1, s3
    mul.w r10, r6, r1

    // a320<->a448, c[0]
    mul.w r11, r7, r1

    sub.w r8, r10, r4
    sub.w r9, r5, r11
    add r4, r6
    add r5, r7
    sub.w r10, r8, r10, lsl #1
    add.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

.align 10   // 0x000
remaining_type0_16_small:
    vmov.w s11, lr
    /**** type 0 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #0]
    ldrsh.w r5, [r1, #1152]
    ldrsh.w r6, [r1, #768]
    ldrsh.w r7, [r1, #384]
    add.w r1, #2
    vmov.w s9, r1


    // layer 2
    // a256<->a384, c[0]
    vmov.w r1, s3
    mul.w r10, r6, r1

    // a320<->a448, c[0]
    mul.w r11, r7, r1

    sub.w r8, r4, r10
    add.w r9, r5, r11
    add r4, r6
    add r5, r7
    add.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

    .align 10   // 0x000
remaining_type4_16_small:
    vmov.w s11, lr
    /**** type 2 ****/

    // level 1 load
    vmov.w r1, s9
    ldrsh.w r4, [r1, #634]
    ldrsh.w r5, [r1, #250]
    ldrsh.w r7, [r1, #1018]
    add.w r1, #2
    vmov.w s9, r1



    // level 2

    // a256<->a384,
    neg r8, r4
    neg r10, r4

    // a320<->a448, special s
    vmov.w r1, s3
    mul.w r11, r7, r1

    // order dependent, don't change
    sub.w r9, r5, r11
    add.w r11, r9, r11, lsl #1
    mov r6, r4
    add r5, r7
    sub.w r7, r5, r7, lsl #1

    // level 3
    ### a0<->a64, a128<->a192, a256<->a320, a384<->a448
    ###        1,        c[0],       c[1],        c[2]

    // a0<->a64, 1

    // a128<->a192, c[0]

    mul.w r7, r7, r1

    // a256<->a320, c[1]
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    // a384<->a448, c[2]
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #0]
    str.w r5, [r0, #256]
    str.w r6, [r0, #512]
    str.w r7, [r0, #768]
    str.w r8, [r0, #1024]
    str.w r9, [r0, #1280]
    str.w r10, [r0, #1536]
    str.w r11, [r0, #1792]

    vmov.w lr, s11
    bx lr

/***
0x000  ________________
      | loop:          |
      | ...            |
      | ...            |
0x248 |________________|

0x300  ________________
      | start:         |
      | ...            |
      | bl.w loop      |
      | set something  |
      | bl.w loop      |
      | set something  |
      | bl.w loop      |
      | ...            |
      |________________|

(I-cache size: 0x400)

.align 10
__pad0:
    nop

.align 9
__pad1:
    nop

.align 8
start:     // start will be in the bottom part of I-cache
    ...

.align 10
loop:      // loop will be in the upper part of I-cache
    ...

Minimize the need to replace the I-cache that will be used many times.
    ***/

// a = a+cb
// b = a-cb
.align 10 // 0x000
aaa_16_small:
    nop
.align 9  // 0x200
bbb_16_small:
    nop
.align 8  // 0x300
.global __asm_NTT_forward_16_small
.type __asm_NTT_forward_16_small, %function
__asm_NTT_forward_16_small:
    vmov.w s9, r0
    vmov.w s10, r0
    push.w {r4-r12, lr}
    vldm.w r1!, {s0-s3}
    ldr.w r0, [sp, #40]  // r0 --> Good0
    vmov.w s4, r0
    vmov.w s15, r1

    // s4  --> Good0
    // s9  --> tmp_src (for variable src pointer)
    // s10 --> original src
    // s11 --> link register
    // s13 --> counter
    // s15 --> root table

    // do for Good[0] 60 entries (a1~a60), remain 4 to do, (a0, a61~a63)
    add.w r0, #4
    add.w r7, r0, #240 // set counter (20*12=240)
    vmov.w s13, r7
    bl.w Good_loop_combined_16_small

    // do for Good[1] 60 entries (a2~a61), remain 4 to do, (a0, a1, a62~a63)
    add.w r0, #1812    // set Good[1][2]
    add.w r7, r0, #240 // set counter (20*12=240)
    vmov.w s13, r7
    vmov.w r8, s10
    add.w r8, #2
    vmov.w s9, r8      // set src + 2, 1028
    bl.w Good_loop_combined_16_small

    // do for Good[2] 60 entries (a0~a59), remain 4 to do, (a60~a63)
    add.w r0, #1800    // set Good[2][0]
    add.w r7, r0, #240 // set counter (20*12=240)
    vmov.w s13, r7
    vmov.w r8, s10
    add.w r8, #-2
    vmov.w s9, r8      // set src - 2, 1024
    bl.w Good_loop_combined_16_small



    // Type 3, offset 1144
    // (1144, -1, 376, -1, -1, 760, -1, -1)   type3 to Good[2][60]
    add.w r0, #0
    vmov.w s9, s10
    bl.w remaining_type3_16_small

    // (1146, -1, 378, -1, -1, 762, -1, -1)   type3 to Good[0][61]
    add.w r0, #-4092
    bl.w remaining_type3_16_small

    // (1148, -1, 380, -1, -1, 764, -1, -1)   type3 to Good[1][62]
    add.w r0, #2052
    bl.w remaining_type3_16_small

    // (1150, -1, 382, -1, -1, 766, -1, -1)   type3 to Good[2][63]
    add.w r0, #2052
    bl.w remaining_type3_16_small


    // Type 2, offset 128
    // (-1, 128, 1280, -1, 512, -1, -1, 896)  type2 to Good[1][0]
    add.w r0, #-2300
    vmov.w s9, s10
    bl.w remaining_type2_16_small

    // Type 2, offset 250
    // (-1, 250, -1, -1, 634, -1, -1, 1018, 'Good2', 61) type2 to Good[2][61]
    add.w r0, #2292
    vmov.w s9, s10
    bl.w remaining_type4_16_small

    // (-1, 252, -1, -1, 636, -1, -1, 1020, 'Good0', 62) type2 to Good[0][62]
    add.w r0, #-4092
    bl.w remaining_type4_16_small

    // (-1, 254, -1, -1, 638, -1, -1, 1022, 'Good1', 63) type2 to Good[1][63]
    add.w r0, #2052
    bl.w remaining_type4_16_small


    // Type 0, offset 0
    // (124, 1276, -1, 508, -1, -1, 892, -1)  type0 to Good[2][62]
    add.w r0, #2044
    vmov.w r8, s10
    add.w r8, #124
    vmov.w s9, r8
    bl.w remaining_type0_16_small

    // (126, 1278, -1, 510, -1, -1, 894, -1)  type0 to Good[0][63]
    add.w r0, #-4092
    bl.w remaining_type0_16_small

    // (0, 1152, -1, 384, -1, -1, 768, -1)    type0 to Good[0][0]
    add.w r0, #-252
    vmov.w s9, s10
    bl.w remaining_type0_16_small

    // (2, 1154, -1, 386, -1, -1, 770, -1)    type0 to Good[1][1]
    add.w r0, #2052
    bl.w remaining_type0_16_small


    // go to Good[0] + 228
    add.w r0, #-1824
    b.w _4_5_6

.align 10   // 0x000
_4_5_6:

// Deal with first part of 4_5_6 a0~a63
// Eight iterations:
//   a0 a8  a16 a24 a32 a40 a48 a56
//   a1 a9  a17 a25 a33 a41 a49 a57
//   a2 a10 a18 a26 a34 a42 a50 a58
//   a3 a11 a19 a27 a35 a43 a51 a59
//   a4 a12 a20 a28 a36 a44 a52 a60
//   a5 a13 a21 a29 a37 a45 a53 a61
//   a6 a14 a22 a30 a38 a46 a54 a62
//   a7 a15 a23 a31 a39 a47 a55 a63
// with four roots: 1, s0, s1, s2
add.w r4, r0, #32   // set counter
vmov.w s11, r4

level_4_5_6_special:

    ldr.w r4, [r0, #-228]
    ldr.w r5, [r0, #-196]
    ldr.w r6, [r0, #-164]
    ldr.w r7, [r0, #-132]
    ldr.w r8, [r0, #-100]
    ldr.w r9, [r0, #-68]
    ldr.w r10, [r0, #-36]
    ldr.w r11, [r0, #-4]

    // level 4
    //  0<->32, 1;  8<->40, 1;
    // 16<->48, 1; 24<->56, 1;
    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11
    sub.w r8, r4, r8, lsl #1
    sub.w r9, r5, r9, lsl #1
    sub.w r10, r6, r10, lsl #1
    sub.w r11, r7, r11, lsl #1

    // level 5
    //  0<->16,  1;  8<->24,  1;
    // 32<->48, c0; 40<->56, c0;

    vmov.w r1, s0
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r6
    add r5, r7
    add r9, r11
    add r8, r10
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1
    sub.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1

    // level 6
    //   0<->8,  1; 16<->24, c0;
    // 32<->40, c1; 48<->56, c2;

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s1  // c1=s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    vmov.w r1, s2  // c2=s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1


    // save
    str.w r4, [r0, #-228]
    str.w r5, [r0, #-196]
    str.w r6, [r0, #-164]
    str.w r7, [r0, #-132]
    str.w r8, [r0, #-100]
    str.w r9, [r0, #-68]
    str.w r10, [r0, #-36]
    str.w r11, [r0, #-4]

    ldr.w r4, [r0, #1820]
    ldr.w r5, [r0, #1852]
    ldr.w r6, [r0, #1884]
    ldr.w r7, [r0, #1916]
    ldr.w r8, [r0, #1948]
    ldr.w r9, [r0, #1980]
    ldr.w r10, [r0, #2012]
    ldr.w r11, [r0, #2044]

    // level 4
    //  0<->32, 1;  8<->40, 1;
    // 16<->48, 1; 24<->56, 1;
    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11
    sub.w r8, r4, r8, lsl #1
    sub.w r9, r5, r9, lsl #1
    sub.w r10, r6, r10, lsl #1
    sub.w r11, r7, r11, lsl #1

    // level 5
    //  0<->16,  1;  8<->24,  1;
    // 32<->48, c0; 40<->56, c0;

    vmov.w r1, s0
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r6
    add r5, r7
    add r9, r11
    add r8, r10
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1
    sub.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1

    // level 6
    //   0<->8,  1; 16<->24, c0;
    // 32<->40, c1; 48<->56, c2;

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s1  // c1=s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    vmov.w r1, s2  // c2=s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1


    // save
    str.w r4, [r0, #1820]
    str.w r5, [r0, #1852]
    str.w r6, [r0, #1884]
    str.w r7, [r0, #1916]
    str.w r8, [r0, #1948]
    str.w r9, [r0, #1980]
    str.w r10, [r0, #2012]
    str.w r11, [r0, #2044]

    ldr.w r4, [r0, #3868]
    ldr.w r5, [r0, #3900]
    ldr.w r6, [r0, #3932]
    ldr.w r7, [r0, #3964]
    ldr.w r8, [r0, #3996]
    ldr.w r9, [r0, #4028]
    ldr.w r10, [r0, #4060]
    ldr.w r11, [r0, #4092]

    // level 4
    //  0<->32, 1;  8<->40, 1;
    // 16<->48, 1; 24<->56, 1;
    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11
    sub.w r8, r4, r8, lsl #1
    sub.w r9, r5, r9, lsl #1
    sub.w r10, r6, r10, lsl #1
    sub.w r11, r7, r11, lsl #1

    // level 5
    //  0<->16,  1;  8<->24,  1;
    // 32<->48, c0; 40<->56, c0;

    vmov.w r1, s0
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r6
    add r5, r7
    add r9, r11
    add r8, r10
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1
    sub.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1

    // level 6
    //   0<->8,  1; 16<->24, c0;
    // 32<->40, c1; 48<->56, c2;

    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s1  // c1=s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    vmov.w r1, s2  // c2=s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1


    // save
    str.w r4, [r0, #3868]
    str.w r5, [r0, #3900]
    str.w r6, [r0, #3932]
    str.w r7, [r0, #3964]
    str.w r8, [r0, #3996]
    str.w r9, [r0, #4028]
    str.w r10, [r0, #4060]
    str.w r11, [r0, #4092]

    add.w r0, #4
    vmov.w r4, s11
    cmp.w r4, r0
    bne.w level_4_5_6_special
    add.w r0, #224

add.w r1, r0, #1792   // outer iteration set counter
vmov.w s10, r1


// deal with remaining part 4_5_6
// Every time we load 7 roots to s3-s9
// and it will look like this
//     LEVEL 4:  s3
//     LEVEL 5:  s4 s5
//     LEVEL 6:  s6 s7 s8 s9
.align 2
normal_4_5_6_outer:
    vmov.w r1, s15
    vldm.w r1!, {s3-s9}
    vmov.w s15, r1

    add.w r4, r0, #32 // inner iteration set counter
    vmov.w s11, r4

    normal_4_5_6_inner:

        ldr.w r4, [r0, #-228]
        ldr.w r5, [r0, #-196]
        ldr.w r6, [r0, #-164]
        ldr.w r7, [r0, #-132]
        ldr.w r8, [r0, #-100]
        ldr.w r9, [r0, #-68]
        ldr.w r10, [r0, #-36]
        ldr.w r11, [r0, #-4]

        // level 4
        // a0<->a32, a8<->a40, a16<->a48, a24<->a56
        vmov.w r1, s3
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r8
        add r5, r9
        add r6, r10
        add r7, r11
        sub.w r8, r4, r8, lsl #1
        sub.w r9, r5, r9, lsl #1
        sub.w r10, r6, r10, lsl #1
        sub.w r11, r7, r11, lsl #1

        // level 5
        // a0<->a16, a8<->a24, a32<->a48, a40<->a56
        vmov.w r1, s4
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        vmov.w r1, s5
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r6
        add r5, r7
        add r8, r10
        add r9, r11
        sub.w r6, r4, r6, lsl #1
        sub.w r7, r5, r7, lsl #1
        sub.w r10, r8, r10, lsl #1
        sub.w r11, r9, r11, lsl #1

        // level 6
        // a0<->a8, a16<->a24, a32<->a40, a48<->a56
        vmov.w r1, s6
        montgomery_mul r5, r1, r12, r5, r14, r3, r2

        vmov.w r1, s7
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        vmov.w r1, s8
        montgomery_mul r9, r1, r12, r9, r14, r3, r2

        vmov.w r1, s9
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r5
        add r6, r7
        add r8, r9
        add r10, r11
        sub.w r7, r6, r7, lsl #1
        sub.w r5, r4, r5, lsl #1
        sub.w r9, r8, r9, lsl #1
        sub.w r11, r10, r11, lsl #1

        // save
        str.w r4, [r0, #-228]
        str.w r5, [r0, #-196]
        str.w r6, [r0, #-164]
        str.w r7, [r0, #-132]
        str.w r8, [r0, #-100]
        str.w r9, [r0, #-68]
        str.w r10, [r0, #-36]
        str.w r11, [r0, #-4]

        ldr.w r4, [r0, #1820]
        ldr.w r5, [r0, #1852]
        ldr.w r6, [r0, #1884]
        ldr.w r7, [r0, #1916]
        ldr.w r8, [r0, #1948]
        ldr.w r9, [r0, #1980]
        ldr.w r10, [r0, #2012]
        ldr.w r11, [r0, #2044]

        // level 4
        // a0<->a32, a8<->a40, a16<->a48, a24<->a56
        vmov.w r1, s3
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r8
        add r5, r9
        add r6, r10
        add r7, r11
        sub.w r8, r4, r8, lsl #1
        sub.w r9, r5, r9, lsl #1
        sub.w r10, r6, r10, lsl #1
        sub.w r11, r7, r11, lsl #1

        // level 5
        // a0<->a16, a8<->a24, a32<->a48, a40<->a56
        vmov.w r1, s4
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        vmov.w r1, s5
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r6
        add r5, r7
        add r8, r10
        add r9, r11
        sub.w r6, r4, r6, lsl #1
        sub.w r7, r5, r7, lsl #1
        sub.w r10, r8, r10, lsl #1
        sub.w r11, r9, r11, lsl #1

        // level 6
        // a0<->a8, a16<->a24, a32<->a40, a48<->a56
        vmov.w r1, s6
        montgomery_mul r5, r1, r12, r5, r14, r3, r2

        vmov.w r1, s7
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        vmov.w r1, s8
        montgomery_mul r9, r1, r12, r9, r14, r3, r2

        vmov.w r1, s9
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r5
        add r6, r7
        add r8, r9
        add r10, r11
        sub.w r7, r6, r7, lsl #1
        sub.w r5, r4, r5, lsl #1
        sub.w r9, r8, r9, lsl #1
        sub.w r11, r10, r11, lsl #1

        // save
        str.w r4, [r0, #1820]
        str.w r5, [r0, #1852]
        str.w r6, [r0, #1884]
        str.w r7, [r0, #1916]
        str.w r8, [r0, #1948]
        str.w r9, [r0, #1980]
        str.w r10, [r0, #2012]
        str.w r11, [r0, #2044]

        ldr.w r4, [r0, #3868]
        ldr.w r5, [r0, #3900]
        ldr.w r6, [r0, #3932]
        ldr.w r7, [r0, #3964]
        ldr.w r8, [r0, #3996]
        ldr.w r9, [r0, #4028]
        ldr.w r10, [r0, #4060]
        ldr.w r11, [r0, #4092]

        // level 4
        // a0<->a32, a8<->a40, a16<->a48, a24<->a56
        vmov.w r1, s3
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r8
        add r5, r9
        add r6, r10
        add r7, r11
        sub.w r8, r4, r8, lsl #1
        sub.w r9, r5, r9, lsl #1
        sub.w r10, r6, r10, lsl #1
        sub.w r11, r7, r11, lsl #1

        // level 5
        // a0<->a16, a8<->a24, a32<->a48, a40<->a56
        vmov.w r1, s4
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        vmov.w r1, s5
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r6
        add r5, r7
        add r8, r10
        add r9, r11
        sub.w r6, r4, r6, lsl #1
        sub.w r7, r5, r7, lsl #1
        sub.w r10, r8, r10, lsl #1
        sub.w r11, r9, r11, lsl #1

        // level 6
        // a0<->a8, a16<->a24, a32<->a40, a48<->a56
        vmov.w r1, s6
        montgomery_mul r5, r1, r12, r5, r14, r3, r2

        vmov.w r1, s7
        montgomery_mul r7, r1, r12, r7, r14, r3, r2

        vmov.w r1, s8
        montgomery_mul r9, r1, r12, r9, r14, r3, r2

        vmov.w r1, s9
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add r4, r5
        add r6, r7
        add r8, r9
        add r10, r11
        sub.w r7, r6, r7, lsl #1
        sub.w r5, r4, r5, lsl #1
        sub.w r9, r8, r9, lsl #1
        sub.w r11, r10, r11, lsl #1

        // save
        str.w r4, [r0, #3868]
        str.w r5, [r0, #3900]
        str.w r6, [r0, #3932]
        str.w r7, [r0, #3964]
        str.w r8, [r0, #3996]
        str.w r9, [r0, #4028]
        str.w r10, [r0, #4060]
        str.w r11, [r0, #4092]

        add.w r0, #4
        vmov.w r4, s11
        cmp.w r4, r0
        bne.w normal_4_5_6_inner

    add.w r0, #224
    vmov.w r4, s10
    cmp.w r4, r0
    bne.w normal_4_5_6_outer

sub.w r0, #2244

.align 2
_7_8_9:

add.w r4, r0, #2048 // set counter
vmov.w s14, r4

level_7_8_9_loop:
    vmov.w r1, s15
    vldm.w r1!, {s7-s13}
    vmov.w s15, r1

    ldr.w r4, [r0, #-32]
    ldr.w r5, [r0, #-28]
    ldr.w r6, [r0, #-24]
    ldr.w r7, [r0, #-20]
    ldr.w r8, [r0, #-16]
    ldr.w r9, [r0, #-12]
    ldr.w r10, [r0, #-8]
    ldr.w r11, [r0, #-4]

    vmov.w r1, s7
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11
    sub.w r8, r4, r8, lsl #1
    sub.w r9, r5, r9, lsl #1
    sub.w r10, r6, r10, lsl #1
    sub.w r11, r7, r11, lsl #1

    vmov.w r1, s8
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s9
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r6
    add r5, r7
    add r8, r10
    add r9, r11
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1
    sub.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1

    vmov.w r1, s10
    montgomery_mul r5, r1, r12, r5, r14, r3, r2

    vmov.w r1, s11
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s12
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    vmov.w r1, s13
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #-32]
    str.w r5, [r0, #-28]
    str.w r6, [r0, #-24]
    str.w r7, [r0, #-20]
    str.w r8, [r0, #-16]
    str.w r9, [r0, #-12]
    str.w r10, [r0, #-8]
    str.w r11, [r0, #-4]

    ldr.w r4, [r0, #2016]
    ldr.w r5, [r0, #2020]
    ldr.w r6, [r0, #2024]
    ldr.w r7, [r0, #2028]
    ldr.w r8, [r0, #2032]
    ldr.w r9, [r0, #2036]
    ldr.w r10, [r0, #2040]
    ldr.w r11, [r0, #2044]

    vmov.w r1, s7
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11
    sub.w r8, r4, r8, lsl #1
    sub.w r9, r5, r9, lsl #1
    sub.w r10, r6, r10, lsl #1
    sub.w r11, r7, r11, lsl #1

    vmov.w r1, s8
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s9
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r6
    add r5, r7
    add r8, r10
    add r9, r11
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1
    sub.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1

    vmov.w r1, s10
    montgomery_mul r5, r1, r12, r5, r14, r3, r2

    vmov.w r1, s11
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s12
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    vmov.w r1, s13
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #2016]
    str.w r5, [r0, #2020]
    str.w r6, [r0, #2024]
    str.w r7, [r0, #2028]
    str.w r8, [r0, #2032]
    str.w r9, [r0, #2036]
    str.w r10, [r0, #2040]
    str.w r11, [r0, #2044]

    ldr.w r4, [r0, #4064]
    ldr.w r5, [r0, #4068]
    ldr.w r6, [r0, #4072]
    ldr.w r7, [r0, #4076]
    ldr.w r8, [r0, #4080]
    ldr.w r9, [r0, #4084]
    ldr.w r10, [r0, #4088]
    ldr.w r11, [r0, #4092]

    vmov.w r1, s7
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r8
    add r5, r9
    add r6, r10
    add r7, r11
    sub.w r8, r4, r8, lsl #1
    sub.w r9, r5, r9, lsl #1
    sub.w r10, r6, r10, lsl #1
    sub.w r11, r7, r11, lsl #1

    vmov.w r1, s8
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s9
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r6
    add r5, r7
    add r8, r10
    add r9, r11
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1
    sub.w r10, r8, r10, lsl #1
    sub.w r11, r9, r11, lsl #1

    vmov.w r1, s10
    montgomery_mul r5, r1, r12, r5, r14, r3, r2

    vmov.w r1, s11
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    vmov.w r1, s12
    montgomery_mul r9, r1, r12, r9, r14, r3, r2

    vmov.w r1, s13
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add r4, r5
    add r6, r7
    add r8, r9
    add r10, r11
    sub.w r5, r4, r5, lsl #1
    sub.w r7, r6, r7, lsl #1
    sub.w r9, r8, r9, lsl #1
    sub.w r11, r10, r11, lsl #1

    str.w r4, [r0, #4064]
    str.w r5, [r0, #4068]
    str.w r6, [r0, #4072]
    str.w r7, [r0, #4076]
    str.w r8, [r0, #4080]
    str.w r9, [r0, #4084]
    str.w r10, [r0, #4088]
    str.w r11, [r0, #4092]

    add.w r0, #32
    vmov.w r1, s14
    cmp.w r1, r0
    bne.w level_7_8_9_loop

pop.w {r4-r12, pc}

