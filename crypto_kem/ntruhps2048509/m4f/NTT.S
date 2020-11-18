.macro montgomery_mul a, b, lower, upper, tmp, M_inv, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \M_inv
    smlal.w \lower, \upper, \tmp, \M
.endm

.macro add_sub a0, b_0, a1, b_1, a2, b_2, a3, b_3
    add \a0, \b_0
    add \a1, \b_1
    add \a2, \b_2
    add \a3, \b_3
    sub.w \b_0, \a0, \b_0, lsl #1
    sub.w \b_1, \a1, \b_1, lsl #1
    sub.w \b_2, \a2, \b_2, lsl #1
    sub.w \b_3, \a3, \b_3, lsl #1
.endm

.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it gt
    subgt \target, \M
    cmn \target, \Mhalf
    it lt
    addlt \target, \M
.endm

.syntax unified
.cpu cortex-m4

.align 2
.global NTT_1024
.type NTT_1024, %function

NTT_1024:
push.w {r4-r12, r14}
vpush.w {s16-s31}

tmp_root_table .req s24
tmp_inv_table  .req s24
tmp_mul_table  .req s24
tmp_r0         .req s25
outer_counter  .req s26
inner_counter  .req s27
ary_input1     .req s28
ary_input2     .req s29
tmp_ans        .req s30
tmp_lr         .req s31


vldr.w ary_input2, [sp, #104]
vldr.w s8, [sp, #108]
vldr.w tmp_ans, [sp, #112]
vldr.w s9, [sp, #116]
vldm.w r1!, {s0-s7}
vmov.w tmp_root_table, r1
vmov.w ary_input1, r0

// allocate NTTd array using sp
sub.w sp, #8192
mov.w r0, sp
vpush.w {s9} @ save inv_table
vpush.w {s8} @ save mul_table

bl.w _1_2_3_4_big
add.w r0, #3840 // adjust r0

bl.w _1_2_3_4_small
sub.w r0, #4352 // adjust r0

bl.w _5_6_7_8
vmov.w r1, tmp_root_table
sub.w r1, 960
vmov.w tmp_root_table, r1

bl.w _5_6_7_8
sub.w r0, #8192 // adjust r0

bl.w my_mul // do mul and inverse


.align 2
_1_2_3_4_big:
vmov.w tmp_lr, lr

add.w r12, r0, #244 // set counter
vmov.w inner_counter, r12

.align 2
loop_1_2_3_4_big:
    vmov.w r1, ary_input1
    ldrsh.w r4, [r1, #128]
    ldrsh.w r5, [r1, #384]
    ldrsh.w r6, [r1, #640]
    ldrsh.w r7, [r1, #896]

    mov.w r12, 2048
    mov.w r1, 1024
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // level 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2
    montgomery_mul r7, r1, r12, r11, r14, r3, r2
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    // level 4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s0
    montgomery_mul r5, r1, r12, r5, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    vmov.w r1, s3
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s5
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    vmov.w s16, s17, r4, r5
    vmov.w s18, s19, r6, r7
    vmov.w s20, s21, r8, r9
    vmov.w s22, s23, r10, r11

    vmov.w r1, ary_input1
    ldrsh.w r5, [r1, #256]
    ldrsh.w r6, [r1, #512]
    ldrsh.w r7, [r1, #768]
    ldrsh.w r4, [r1], #2
    vmov.w ary_input1, r1

    mov.w r12, 2048
    mov.w r1, 1024
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // level 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2
    montgomery_mul r7, r1, r12, r11, r14, r3, r2
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, r14, s18, s19
    add.w r6, r12                         @ a256
    sub.w r12, r6, r12, lsl #1   @ a320
    add.w r7, r14                         @ a384
    sub.w r14, r7, r14, lsl #1   @ a448
    vmov.w r1, s20
    add.w r8, r1                             @ a512
    sub.w r1, r8, r1, lsl #1           @ a576

    str.w r6, [r0, #1024]
    str.w r12, [r0, #1280]
    str.w r7, [r0, #1536]
    str.w r14, [r0, #1792]
    str.w r8, [r0, #2048]
    str.w r1, [r0, #2304]

    vmov.w r1, s23
    add.w r11, r1                             @ a896
    sub.w r1, r11, r1, lsl #1           @ a960
    vmov.w r6, r7, s21, s22
    add.w r9, r6                               @ a640
    sub.w r6, r9, r6, lsl #1               @ a704
    add.w r10, r7                               @ a768
    sub.w r7, r10, r7, lsl #1               @ a832
    vmov.w r12, r14, s16, s17
    add.w r4, r12                           @ a0
    sub.w r12, r4, r12, lsl #1     @ a64
    add.w r5, r14                         @ a128
    sub.w r14, r5, r14, lsl #1   @ a192

    str.w r12, [r0, #256]
    str.w r5, [r0, #512]
    str.w r14, [r0, #768]
    str.w r10, [r0, #3072]
    str.w r7, [r0, #3328]
    str.w r9, [r0, #2560]
    str.w r6, [r0, #2816]
    str.w r11, [r0, #3584]
    str.w r1, [r0, #3840]
    str.w r4, [r0], #4

    vmov.w r4, inner_counter
    cmp.w r4, r0
    bne.w loop_1_2_3_4_big

add.w r12, r0, #12 // set counter
vmov.w inner_counter, r12

// remaining
.align 2
loop_1_2_3_4_big_remaining:
    vmov.w r1, ary_input1
    ldrsh.w r4, [r1, #128]
    ldrsh.w r5, [r1, #384]
    ldrsh.w r6, [r1, #640]
    mov.w r7, #0

    mov.w r12, 2048
    mov.w r1, 1024
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12

    // level 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2
    montgomery_mul r7, r1, r12, r11, r14, r3, r2
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    // level 4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s0
    montgomery_mul r5, r1, r12, r5, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    vmov.w r1, s3
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s5
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    vmov.w s16, s17, r4, r5
    vmov.w s18, s19, r6, r7
    vmov.w s20, s21, r8, r9
    vmov.w s22, s23, r10, r11

    vmov.w r1, ary_input1
    ldrsh.w r5, [r1, #256]
    ldrsh.w r6, [r1, #512]
    ldrsh.w r7, [r1, #768]
    ldrsh.w r4, [r1], #2
    vmov.w ary_input1, r1

    mov.w r12, 2048
    mov.w r1, 1024
    central_reduce r4, r1, r12
    central_reduce r5, r1, r12
    central_reduce r6, r1, r12
    central_reduce r7, r1, r12

    // level 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2
    montgomery_mul r7, r1, r12, r11, r14, r3, r2
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, r14, s18, s19
    add.w r6, r12                         @ a256
    sub.w r12, r6, r12, lsl #1   @ a320
    add.w r7, r14                         @ a384
    sub.w r14, r7, r14, lsl #1   @ a448
    vmov.w r1, s20
    add.w r8, r1                             @ a512
    sub.w r1, r8, r1, lsl #1           @ a576

    str.w r6, [r0, #1024]
    str.w r12, [r0, #1280]
    str.w r7, [r0, #1536]
    str.w r14, [r0, #1792]
    str.w r8, [r0, #2048]
    str.w r1, [r0, #2304]

    vmov.w r1, s23
    add.w r11, r1                             @ a896
    sub.w r1, r11, r1, lsl #1           @ a960
    vmov.w r6, r7, s21, s22
    add.w r9, r6                               @ a640
    sub.w r6, r9, r6, lsl #1               @ a704
    add.w r10, r7                               @ a768
    sub.w r7, r10, r7, lsl #1               @ a832
    vmov.w r12, r14, s16, s17
    add.w r4, r12                           @ a0
    sub.w r12, r4, r12, lsl #1     @ a64
    add.w r5, r14                         @ a128
    sub.w r14, r5, r14, lsl #1   @ a192

    str.w r12, [r0, #256]
    str.w r5, [r0, #512]
    str.w r14, [r0, #768]
    str.w r10, [r0, #3072]
    str.w r7, [r0, #3328]
    str.w r9, [r0, #2560]
    str.w r6, [r0, #2816]
    str.w r11, [r0, #3584]
    str.w r1, [r0, #3840]
    str.w r4, [r0], #4

    vmov.w r4, inner_counter
    cmp.w r4, r0
    bne.w loop_1_2_3_4_big_remaining

vmov.w lr, tmp_lr
bx lr

.align 2
_1_2_3_4_small:
vmov.w tmp_lr, lr

add.w r12, r0, #244 // set counter
vmov.w inner_counter, r12

.align 2
loop_1_2_3_4_small:
    vmov.w r1, ary_input2
    ldrsh.w r4, [r1, #128]
    ldrsh.w r5, [r1, #384]
    ldrsh.w r6, [r1, #640]
    ldrsh.w r7, [r1, #896]

    // level 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2
    montgomery_mul r7, r1, r12, r11, r14, r3, r2
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    // level 4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s0
    montgomery_mul r5, r1, r12, r5, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    vmov.w r1, s3
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s5
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    vmov.w s16, s17, r4, r5
    vmov.w s18, s19, r6, r7
    vmov.w s20, s21, r8, r9
    vmov.w s22, s23, r10, r11

    vmov.w r1, ary_input2
    ldrsh.w r5, [r1, #256]
    ldrsh.w r6, [r1, #512]
    ldrsh.w r7, [r1, #768]
    ldrsh.w r4, [r1], #2
    vmov.w ary_input2, r1

    // level 2
    vmov.w r1, s7
    mul.w r10, r1, r6
    mul.w r11, r1, r7
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    mul.w r7, r1, r7
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, r14, s18, s19
    add.w r6, r12                         @ a256
    sub.w r12, r6, r12, lsl #1   @ a320
    add.w r7, r14                         @ a384
    sub.w r14, r7, r14, lsl #1   @ a448
    vmov.w r1, s20
    add.w r8, r1                             @ a512
    sub.w r1, r8, r1, lsl #1           @ a576

    str.w r6, [r0, #1024]
    str.w r12, [r0, #1280]
    str.w r7, [r0, #1536]
    str.w r14, [r0, #1792]
    str.w r8, [r0, #2048]
    str.w r1, [r0, #2304]

    vmov.w r1, s23
    add.w r11, r1                             @ a896
    sub.w r1, r11, r1, lsl #1           @ a960
    vmov.w r6, r7, s21, s22
    add.w r9, r6                               @ a640
    sub.w r6, r9, r6, lsl #1               @ a704
    add.w r10, r7                               @ a768
    sub.w r7, r10, r7, lsl #1               @ a832
    vmov.w r12, r14, s16, s17
    add.w r4, r12                           @ a0
    sub.w r12, r4, r12, lsl #1     @ a64
    add.w r5, r14                         @ a128
    sub.w r14, r5, r14, lsl #1   @ a192

    str.w r12, [r0, #256]
    str.w r5, [r0, #512]
    str.w r14, [r0, #768]
    str.w r10, [r0, #3072]
    str.w r7, [r0, #3328]
    str.w r9, [r0, #2560]
    str.w r6, [r0, #2816]
    str.w r11, [r0, #3584]
    str.w r1, [r0, #3840]
    str.w r4, [r0], #4

    vmov.w r4, inner_counter
    cmp.w r4, r0
    bne.w loop_1_2_3_4_small

add.w r12, r0, #12 // set counter
vmov.w inner_counter, r12

// remaining
.align 2
loop_1_2_3_4_small_remaining:
    vmov.w r1, ary_input2
    ldrsh.w r4, [r1, #128]
    ldrsh.w r5, [r1, #384]
    ldrsh.w r6, [r1, #640]
    mov.w r7, #0

    // level 2
    vmov.w r1, s0
    montgomery_mul r6, r1, r12, r10, r14, r3, r2
    montgomery_mul r7, r1, r12, r11, r14, r3, r2
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    // level 4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2
    vmov.w r1, s0
    montgomery_mul r5, r1, r12, r5, r14, r3, r2
    vmov.w r1, s1
    montgomery_mul r6, r1, r12, r6, r14, r3, r2
    vmov.w r1, s3
    montgomery_mul r8, r1, r12, r8, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s5
    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    vmov.w s16, s17, r4, r5
    vmov.w s18, s19, r6, r7
    vmov.w s20, s21, r8, r9
    vmov.w s22, s23, r10, r11

    vmov.w r1, ary_input2
    ldrsh.w r5, [r1, #256]
    ldrsh.w r6, [r1, #512]
    ldrsh.w r7, [r1, #768]
    ldrsh.w r4, [r1], #2
    vmov.w ary_input2, r1

    // level 2
    vmov.w r1, s7
    mul.w r10, r1, r6
    mul.w r11, r1, r7
    add.w r8, r4, r10
    sub.w r10, r8, r10, lsl #1
    add.w r9, r5, r11
    sub.w r11, r9, r11, lsl #1
    add r4, r6
    add r5, r7
    sub.w r6, r4, r6, lsl #1
    sub.w r7, r5, r7, lsl #1

    // level 3
    mul.w r7, r1, r7
    vmov.w r1, s1
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r12, r14, s18, s19
    add.w r6, r12                         @ a256
    sub.w r12, r6, r12, lsl #1   @ a320
    add.w r7, r14                         @ a384
    sub.w r14, r7, r14, lsl #1   @ a448
    vmov.w r1, s20
    add.w r8, r1                             @ a512
    sub.w r1, r8, r1, lsl #1           @ a576

    str.w r6, [r0, #1024]
    str.w r12, [r0, #1280]
    str.w r7, [r0, #1536]
    str.w r14, [r0, #1792]
    str.w r8, [r0, #2048]
    str.w r1, [r0, #2304]

    vmov.w r1, s23
    add.w r11, r1                             @ a896
    sub.w r1, r11, r1, lsl #1           @ a960
    vmov.w r6, r7, s21, s22
    add.w r9, r6                               @ a640
    sub.w r6, r9, r6, lsl #1               @ a704
    add.w r10, r7                               @ a768
    sub.w r7, r10, r7, lsl #1               @ a832
    vmov.w r12, r14, s16, s17
    add.w r4, r12                           @ a0
    sub.w r12, r4, r12, lsl #1     @ a64
    add.w r5, r14                         @ a128
    sub.w r14, r5, r14, lsl #1   @ a192

    str.w r12, [r0, #256]
    str.w r5, [r0, #512]
    str.w r14, [r0, #768]
    str.w r10, [r0, #3072]
    str.w r7, [r0, #3328]
    str.w r9, [r0, #2560]
    str.w r6, [r0, #2816]
    str.w r11, [r0, #3584]
    str.w r1, [r0, #3840]
    str.w r4, [r0], #4

    vmov.w r4, inner_counter
    cmp.w r4, r0
    bne.w loop_1_2_3_4_small_remaining

vmov.w lr, tmp_lr
bx lr

.align 2
_5_6_7_8:
vmov.w tmp_lr, lr

add.w r1, r0, #4096   // outer iteration set counter
vmov.w outer_counter, r1

.align 2
normal_5_6_7_8_outer:
    vmov.w r1, tmp_root_table
    vldm.w r1!, {s0-s14}
    vmov.w tmp_root_table, r1

    add.w r4, r0, #16 // inner iteration set counter
    vmov.w inner_counter, r4

    normal_5_6_7_8_inner:
        ldr r4, [r0, #0]
        ldr r5, [r0, #32]
        ldr r6, [r0, #64]
        ldr r7, [r0, #96]
        ldr.w r8, [r0, #128]
        ldr.w r9, [r0, #160]
        ldr.w r10, [r0, #192]
        ldr.w r11, [r0, #224]

        // level 5
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 6
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 7
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w s16, s17, r4, r5
        vmov.w s18, s19, r6, r7
        vmov.w s20, s21, r8, r9
        vmov.w s22, s23, r10, r11

        ldr r4, [r0, #16]
        ldr r5, [r0, #48]
        ldr r6, [r0, #80]
        ldr r7, [r0, #112]
        ldr.w r8, [r0, #144]
        ldr.w r9, [r0, #176]
        ldr.w r10, [r0, #208]
        ldr.w r11, [r0, #240]

        // level 5
        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        // level 6
        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        // level 7
        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        // level 8
        vmov.w r1, s7
        montgomery_mul r4, r1, r12, r4, r14, r3, r2
        vmov.w r1, s8
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s9
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        vmov.w r1, s10
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s11
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        vmov.w r1, s12
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s13
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        vmov.w r1, s14
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        vmov.w r12, r14, s18, s19
        add.w r12, r6                          @ a16
        sub.w r6, r12, r6, lsl #1           @ a20
        add.w r14, r7                          @ a24
        sub.w r7, r14, r7, lsl #1           @ a28
        vmov.w r1, s20
        add.w r1, r8                              @ a32
        sub.w r8, r1, r8, lsl #1               @ a36

        str.w r12, [r0, #64]
        str.w r6, [r0, #80]
        str.w r14, [r0, #96]
        str.w r7, [r0, #112]
        str.w r1, [r0, #128]
        str.w r8, [r0, #144]

        vmov.w r12, r14, s21, s22
        add.w r12, r9                          @ a40
        sub.w r9, r12, r9, lsl #1           @ a44
        add.w r14, r10                          @ a48
        sub.w r10, r14, r10, lsl #1           @ a52
        vmov.w r1, s23
        add.w r1, r11                              @ a56
        sub.w r11, r1, r11, lsl #1               @ a60
        vmov.w r6, r7, s16, s17
        add.w r6, r4                                  @ a0
        sub.w r4, r6, r4, lsl #1                    @ a4
        add.w r7, r5                                  @ a8
        sub.w r5, r7, r5, lsl #1                    @ a12

        str.w r12, [r0, #160]
        str.w r9, [r0, #176]
        str.w r14, [r0, #192]
        str.w r10, [r0, #208]
        str.w r4, [r0, #16]
        str.w r7, [r0, #32]
        str.w r5, [r0, #48]
        str.w r1, [r0, #224]
        str.w r11, [r0, #240]
        str.w r6, [r0], #4

        vmov.w r4, inner_counter
        cmp.w r4, r0
        bne.w normal_5_6_7_8_inner

    add.w r0, #240
    vmov.w r4, outer_counter
    cmp.w r4, r0
    bne.w normal_5_6_7_8_outer

vmov.w lr, tmp_lr
bx lr

.align 2
my_mul:
    upper          .req r12
    lower          .req r14
    tmp1           .req r0
    root           .req r1

    M              .req r2
    M_inv          .req r3
    a_0            .req r4
    a_1            .req r5
    a_2            .req r6
    a_3            .req r7
    b_0            .req r8
    b_1            .req r9
    b_2            .req r10
    b_3            .req r11
    counter        .req r6
    mul_table      .req r12

    add.w r0, #128  // adjust r0 to access two polys
    add.w counter, r0, #4096  // set counter
    vmov.w outer_counter, counter
    vmov.w tmp_r0, r0
    vpop.w {tmp_mul_table}

    my_multiply:

        vmov.w mul_table, r0, tmp_mul_table, tmp_r0
        ldr.w a_0, [r0, #-128]
        ldr.w a_1, [r0, #-124]
        ldr.w a_2, [r0, #-120]
        ldr.w a_3, [r0, #-116]
        ldr.w b_0, [r0, #3968]
        ldr.w b_1, [r0, #3972]
        ldr.w b_2, [r0, #3976]
        ldr.w b_3, [r0, #3980]
        ldr.w root, [mul_table], #4
        vmov.w tmp_mul_table, mul_table

        // for c0 = a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        smull.w lower, upper, a_1, b_3
        smlal.w lower, upper, a_2, b_2
        smlal.w lower, upper, a_3, b_1       @ a_1b_3 + a_2b_2 + a_3b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_1b_3 + a_2b_2 + a_3b_1)
        smlal.w lower, upper, a_0, b_0       @ a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s0, upper

        // for c1 = a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        smull.w lower, upper, a_2, b_3
        smlal.w lower, upper, a_3, b_2       @ a_2b_3 + a_3b_2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_2b_3 + a_3b_2)
        smlal.w lower, upper, a_0, b_1
        smlal.w lower, upper, a_1, b_0       @ a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s1, upper

        // for c2 = a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        smull.w lower, upper, a_3, b_3       @ a_3b_3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_3b_3)
        smlal.w lower, upper, a_0, b_2
        smlal.w lower, upper, a_1, b_1
        smlal.w lower, upper, a_2, b_0       @ a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s2, upper

        // for c3 = a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        smull.w lower, upper, a_0, b_3
        smlal.w lower, upper, a_3, b_0
        smlal.w lower, upper, a_1, b_2
        smlal.w lower, upper, a_2, b_1       @ a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s3, upper

        vmov.w mul_table, r0, tmp_mul_table, tmp_r0
        ldr.w a_0, [r0, #-112]
        ldr.w a_1, [r0, #-108]
        ldr.w a_2, [r0, #-104]
        ldr.w a_3, [r0, #-100]
        ldr.w b_0, [r0, #3984]
        ldr.w b_1, [r0, #3988]
        ldr.w b_2, [r0, #3992]
        ldr.w b_3, [r0, #3996]
        neg.w root, root

        // for c0 = a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        smull.w lower, upper, a_1, b_3
        smlal.w lower, upper, a_2, b_2
        smlal.w lower, upper, a_3, b_1       @ a_1b_3 + a_2b_2 + a_3b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_1b_3 + a_2b_2 + a_3b_1)
        smlal.w lower, upper, a_0, b_0       @ a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s4, upper

        // for c1 = a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        smull.w lower, upper, a_2, b_3
        smlal.w lower, upper, a_3, b_2       @ a_2b_3 + a_3b_2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_2b_3 + a_3b_2)
        smlal.w lower, upper, a_0, b_1
        smlal.w lower, upper, a_1, b_0       @ a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s5, upper

        // for c2 = a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        smull.w lower, upper, a_3, b_3       @ a_3b_3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_3b_3)
        smlal.w lower, upper, a_0, b_2
        smlal.w lower, upper, a_1, b_1
        smlal.w lower, upper, a_2, b_0       @ a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s6, upper

        // for c3 = a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        smull.w lower, upper, a_0, b_3
        smlal.w lower, upper, a_3, b_0
        smlal.w lower, upper, a_1, b_2
        smlal.w lower, upper, a_2, b_1       @ a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s7, upper

        vmov.w mul_table, r0, tmp_mul_table, tmp_r0
        ldr.w a_0, [r0, #-96]
        ldr.w a_1, [r0, #-92]
        ldr.w a_2, [r0, #-88]
        ldr.w a_3, [r0, #-84]
        ldr.w b_0, [r0, #4000]
        ldr.w b_1, [r0, #4004]
        ldr.w b_2, [r0, #4008]
        ldr.w b_3, [r0, #4012]
        ldr.w root, [mul_table], #4
        vmov.w tmp_mul_table, mul_table

        // for c0 = a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        smull.w lower, upper, a_1, b_3
        smlal.w lower, upper, a_2, b_2
        smlal.w lower, upper, a_3, b_1       @ a_1b_3 + a_2b_2 + a_3b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_1b_3 + a_2b_2 + a_3b_1)
        smlal.w lower, upper, a_0, b_0       @ a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s8, upper

        // for c1 = a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        smull.w lower, upper, a_2, b_3
        smlal.w lower, upper, a_3, b_2       @ a_2b_3 + a_3b_2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_2b_3 + a_3b_2)
        smlal.w lower, upper, a_0, b_1
        smlal.w lower, upper, a_1, b_0       @ a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s9, upper

        // for c2 = a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        smull.w lower, upper, a_3, b_3       @ a_3b_3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_3b_3)
        smlal.w lower, upper, a_0, b_2
        smlal.w lower, upper, a_1, b_1
        smlal.w lower, upper, a_2, b_0       @ a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s10, upper

        // for c3 = a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        smull.w lower, upper, a_0, b_3
        smlal.w lower, upper, a_3, b_0
        smlal.w lower, upper, a_1, b_2
        smlal.w lower, upper, a_2, b_1       @ a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s11, upper

        vmov.w mul_table, r0, tmp_mul_table, tmp_r0
        ldr.w a_0, [r0, #-80]
        ldr.w a_1, [r0, #-76]
        ldr.w a_2, [r0, #-72]
        ldr.w a_3, [r0, #-68]
        ldr.w b_0, [r0, #4016]
        ldr.w b_1, [r0, #4020]
        ldr.w b_2, [r0, #4024]
        ldr.w b_3, [r0, #4028]
        neg.w root, root

        // for c0 = a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        smull.w lower, upper, a_1, b_3
        smlal.w lower, upper, a_2, b_2
        smlal.w lower, upper, a_3, b_1       @ a_1b_3 + a_2b_2 + a_3b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_1b_3 + a_2b_2 + a_3b_1)
        smlal.w lower, upper, a_0, b_0       @ a_0b_0 + root*(a_1b_3 + a_2b_2 + a_3b_1)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s12, upper

        // for c1 = a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        smull.w lower, upper, a_2, b_3
        smlal.w lower, upper, a_3, b_2       @ a_2b_3 + a_3b_2
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_2b_3 + a_3b_2)
        smlal.w lower, upper, a_0, b_1
        smlal.w lower, upper, a_1, b_0       @ a_0b_1 + a_1b_0 + root*(a_2b_3 + a_3b_2)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M
        vmov.w s13, upper

        // for c2 = a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        smull.w lower, upper, a_3, b_3       @ a_3b_3
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M        @ reduction
        smull.w lower, upper, upper, root    @ root*(a_3b_3)
        smlal.w lower, upper, a_0, b_2
        smlal.w lower, upper, a_1, b_1
        smlal.w lower, upper, a_2, b_0       @ a_0b_2 + a_2b_0 + a_1b_1 + root*(a_3b_3)
        mul.w tmp1, lower, M_inv
        smlal.w lower, upper, tmp1, M


        // for c3 = a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        smull.w lower, a_0, a_0, b_3
        smlal.w lower, a_0, a_3, b_0
        smlal.w lower, a_0, a_1, b_2
        smlal.w lower, a_0, a_2, b_1       @ a_0b_3 + a_3b_0 + a_1b_2 + a_2b_1
        mul.w tmp1, lower, M_inv
        smlal.w lower, a_0, tmp1, M

        vmov.w r0, tmp_r0
        vstr.w s0, [r0, #-128]
        vstr.w s1, [r0, #-124]
        vstr.w s2, [r0, #-120]
        vstr.w s3, [r0, #-116]
        vstr.w s4, [r0, #-112]
        vstr.w s5, [r0, #-108]
        vstr.w s6, [r0, #-104]
        vstr.w s7, [r0, #-100]
        vstr.w s8, [r0, #-96]
        vstr.w s9, [r0, #-92]
        vstr.w s10, [r0, #-88]
        vstr.w s11, [r0, #-84]
        vstr.w s12, [r0, #-80]
        vstr.w s13, [r0, #-76]
        str.w upper, [r0, #-72]
        str.w a_0, [r0, #-68]

        add.w r0, #64
        vmov.w tmp_r0, r0

        vmov.w counter, outer_counter
        cmp.w counter, r0
        bne.w my_multiply

sub.w r0, #4224 // reset pointer
vpop.w {tmp_inv_table}

_8_7_6:
add.w r12, r0, #4096 // set counter
vmov.w outer_counter, r12

.align 2
loop_8_7_6:
    vmov.w r1, tmp_inv_table
    vldm.w r1!, {s0-s6}
    vmov.w tmp_inv_table, r1

    add.w r12, r0, #16
    vmov.w inner_counter, r12
    inner_loop_8_7_6:

        ldr r4, [r0, #0]
        ldr r5, [r0, #16]
        ldr r6, [r0, #32]
        ldr r7, [r0, #48]
        ldr.w r8, [r0, #64]
        ldr.w r9, [r0, #80]
        ldr.w r10, [r0, #96]
        ldr.w r11, [r0, #112]

        // level 8
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 7
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 6
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str r4, [r0, #0]
        str r5, [r0, #16]
        str r6, [r0, #32]
        str r7, [r0, #48]
        str.w r8, [r0, #64]
        str.w r9, [r0, #80]
        str.w r10, [r0, #96]
        str.w r11, [r0, #112]

        ldr r4, [r0, #4]
        ldr r5, [r0, #20]
        ldr r6, [r0, #36]
        ldr r7, [r0, #52]
        ldr.w r8, [r0, #68]
        ldr.w r9, [r0, #84]
        ldr.w r10, [r0, #100]
        ldr.w r11, [r0, #116]

        // level 8
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 7
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 6
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str r4, [r0, #4]
        str r5, [r0, #20]
        str r6, [r0, #36]
        str r7, [r0, #52]
        str.w r8, [r0, #68]
        str.w r9, [r0, #84]
        str.w r10, [r0, #100]
        str.w r11, [r0, #116]

        add.w r0, #8
        vmov.w r4, inner_counter
        cmp.w r4, r0
        bne.w inner_loop_8_7_6

    add.w r0, #112
    vmov.w r4, outer_counter
    cmp.w r4, r0
    bne.w loop_8_7_6

sub.w r0, #4096 // reset pointer

.align 2
_5_4_3:

add.w r1, r0, #128   // outer iteration set counter
vmov.w outer_counter, r1

vmov.w r1, tmp_inv_table
vldm.w r1!, {s0-s6}
vmov.w tmp_inv_table, r1

special_5_4_3:

    ldr.w r4, [r0, #0]
    ldr.w r5, [r0, #128]
    ldr.w r6, [r0, #256]
    ldr.w r7, [r0, #384]
    ldr.w r8, [r0, #512]
    ldr.w r9, [r0, #640]
    ldr.w r10, [r0, #768]
    ldr.w r11, [r0, #896]

    // level 6
    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r1, s5
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // level 5
    add_sub r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    // level 4
    add_sub r4, r8, r5, r9, r6, r10, r7, r11

    // save
    str.w r4, [r0, #0]
    str.w r5, [r0, #128]
    str.w r6, [r0, #256]
    str.w r7, [r0, #384]
    str.w r8, [r0, #512]
    str.w r9, [r0, #640]
    str.w r10, [r0, #768]
    str.w r11, [r0, #896]

    ldr.w r4, [r0, #4]
    ldr.w r5, [r0, #132]
    ldr.w r6, [r0, #260]
    ldr.w r7, [r0, #388]
    ldr.w r8, [r0, #516]
    ldr.w r9, [r0, #644]
    ldr.w r10, [r0, #772]
    ldr.w r11, [r0, #900]

    // level 6
    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r1, s5
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // level 5
    add_sub r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    // level 4
    add_sub r4, r8, r5, r9, r6, r10, r7, r11

    // save
    str.w r4, [r0, #4]
    str.w r5, [r0, #132]
    str.w r6, [r0, #260]
    str.w r7, [r0, #388]
    str.w r8, [r0, #516]
    str.w r9, [r0, #644]
    str.w r10, [r0, #772]
    str.w r11, [r0, #900]

    ldr.w r4, [r0, #8]
    ldr.w r5, [r0, #136]
    ldr.w r6, [r0, #264]
    ldr.w r7, [r0, #392]
    ldr.w r8, [r0, #520]
    ldr.w r9, [r0, #648]
    ldr.w r10, [r0, #776]
    ldr.w r11, [r0, #904]

    // level 6
    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r1, s5
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // level 5
    add_sub r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    // level 4
    add_sub r4, r8, r5, r9, r6, r10, r7, r11

    // save
    str.w r4, [r0, #8]
    str.w r5, [r0, #136]
    str.w r6, [r0, #264]
    str.w r7, [r0, #392]
    str.w r8, [r0, #520]
    str.w r9, [r0, #648]
    str.w r10, [r0, #776]
    str.w r11, [r0, #904]

    ldr.w r4, [r0, #12]
    ldr.w r5, [r0, #140]
    ldr.w r6, [r0, #268]
    ldr.w r7, [r0, #396]
    ldr.w r8, [r0, #524]
    ldr.w r9, [r0, #652]
    ldr.w r10, [r0, #780]
    ldr.w r11, [r0, #908]

    // level 6
    add_sub r4, r5, r6, r7, r8, r9, r10, r11

    vmov.w r1, s5
    montgomery_mul r9, r1, r12, r9, r14, r3, r2
    vmov.w r1, s6
    montgomery_mul r11, r1, r12, r11, r14, r3, r2
    vmov.w r1, s4
    montgomery_mul r7, r1, r12, r7, r14, r3, r2

    // level 5
    add_sub r4, r6, r5, r7, r8, r10, r9, r11

    montgomery_mul r10, r1, r12, r10, r14, r3, r2
    montgomery_mul r11, r1, r12, r11, r14, r3, r2

    // level 4
    add_sub r4, r8, r5, r9, r6, r10, r7, r11

    // save
    str.w r4, [r0, #12]
    str.w r5, [r0, #140]
    str.w r6, [r0, #268]
    str.w r7, [r0, #396]
    str.w r8, [r0, #524]
    str.w r9, [r0, #652]
    str.w r10, [r0, #780]
    str.w r11, [r0, #908]

    add.w r0, #16
    vmov.w r4, outer_counter
    cmp.w r4, r0
    bne.w special_5_4_3

add.w r0, #896

add.w r1, r0, #3072   // outer iteration set counter
vmov.w outer_counter, r1

.align 2
normal_5_4_3_outer:
    vmov.w r1, tmp_inv_table
    vldm.w r1!, {s0-s6}
    vmov.w tmp_inv_table, r1

    add.w r4, r0, #128 // inner iteration set counter
    vmov.w inner_counter, r4

    normal_5_4_3_inner:

        ldr.w r4, [r0, #0]
        ldr.w r5, [r0, #128]
        ldr.w r6, [r0, #256]
        ldr.w r7, [r0, #384]
        ldr.w r8, [r0, #512]
        ldr.w r9, [r0, #640]
        ldr.w r10, [r0, #768]
        ldr.w r11, [r0, #896]

        // level 6
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 5
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 4
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str.w r4, [r0, #0]
        str.w r5, [r0, #128]
        str.w r6, [r0, #256]
        str.w r7, [r0, #384]
        str.w r8, [r0, #512]
        str.w r9, [r0, #640]
        str.w r10, [r0, #768]
        str.w r11, [r0, #896]

        ldr.w r4, [r0, #4]
        ldr.w r5, [r0, #132]
        ldr.w r6, [r0, #260]
        ldr.w r7, [r0, #388]
        ldr.w r8, [r0, #516]
        ldr.w r9, [r0, #644]
        ldr.w r10, [r0, #772]
        ldr.w r11, [r0, #900]

        // level 6
        add_sub r4, r5, r6, r7, r8, r9, r10, r11

        vmov.w r1, s3
        montgomery_mul r5, r1, r12, r5, r14, r3, r2
        vmov.w r1, s4
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s5
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        vmov.w r1, s6
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 5
        add_sub r4, r6, r5, r7, r8, r10, r9, r11

        vmov.w r1, s1
        montgomery_mul r6, r1, r12, r6, r14, r3, r2
        montgomery_mul r7, r1, r12, r7, r14, r3, r2
        vmov.w r1, s2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // level 4
        add_sub r4, r8, r5, r9, r6, r10, r7, r11

        vmov.w r1, s0
        montgomery_mul r8, r1, r12, r8, r14, r3, r2
        montgomery_mul r9, r1, r12, r9, r14, r3, r2
        montgomery_mul r10, r1, r12, r10, r14, r3, r2
        montgomery_mul r11, r1, r12, r11, r14, r3, r2

        // save
        str.w r4, [r0, #4]
        str.w r5, [r0, #132]
        str.w r6, [r0, #260]
        str.w r7, [r0, #388]
        str.w r8, [r0, #516]
        str.w r9, [r0, #644]
        str.w r10, [r0, #772]
        str.w r11, [r0, #900]

        add.w r0, #8
        vmov.w r4, inner_counter
        cmp.w r4, r0
        bne.w normal_5_4_3_inner

    add.w r0, #896
    vmov.w r4, outer_counter
    cmp.w r4, r0
    bne.w normal_5_4_3_outer

sub.w r0, #4096 // reset pointer

input_ptr    .req r0
M            .req r2
M_inv        .req r3
M_half       .req r1
a_i          .req r4
a_i_plus_256 .req r5
a_i_plus_512 .req r6
a_i_plus_768 .req r7
store_ptr    .req r8
tmp          .req r9
R2inv256     .req r10
mask         .req r11

vmov.w store_ptr, tmp_ans

// s0,  s1,  s2,  s3 -->   a0,   a256,  a512,  a768
// s4,  s5,  s6,  s7 -->   a1,   a257,  a513,  a769
// s8,  s9, s10, s11 -->   a2,   a258,  a514,  a770

// calculate a0, a256, a512, a768
// calculate a1, a257, a513, a769
// calculate a2, a258, a514, a770

vmov.w r1, tmp_inv_table
vldr.w s13, [r1]
ldr.w R2inv256, [r1, #4]
ldr.w a_i_plus_256, [input_ptr, #1024]
ldr.w a_i_plus_512, [input_ptr, #2048]
ldr.w a_i_plus_768, [input_ptr, #3072]
ldr.w a_i, [input_ptr, #0]
add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1
vmov.w s0, s1, a_i, a_i_plus_256
vmov.w s2, s3, a_i_plus_512, a_i_plus_768

ldr.w a_i_plus_256, [input_ptr, #1028]
ldr.w a_i_plus_512, [input_ptr, #2052]
ldr.w a_i_plus_768, [input_ptr, #3076]
ldr.w a_i, [input_ptr, #4]
add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1
vmov.w s4, s5, a_i, a_i_plus_256
vmov.w s6, s7, a_i_plus_512, a_i_plus_768

ldr.w a_i_plus_256, [input_ptr, #1032]
ldr.w a_i_plus_512, [input_ptr, #2056]
ldr.w a_i_plus_768, [input_ptr, #3080]
ldr.w a_i, [input_ptr, #8]
add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1
vmov.w s8, s9, a_i, a_i_plus_256
vmov.w s10, s11, a_i_plus_512, a_i_plus_768

add.w input_ptr, #12
add.w store_ptr, #6

// caculate (a3, a259, a515, a771)~(a251, a507, a763, a1019)
add.w counter, r0, 996
vmov.w inner_counter, counter
mov.w M_half, M, asr #1

mov.w mask, 2047

final_pack_loop:
    ldr.w a_i, [input_ptr, #8]
    ldr.w a_i_plus_256, [input_ptr, #1032]
    ldr.w a_i_plus_512, [input_ptr, #2056]
    ldr.w a_i_plus_768, [input_ptr, #3080]

    add a_i, a_i_plus_256
    add a_i_plus_512, a_i_plus_768
    sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
    sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
    vmov.w tmp, s13
    montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
    add a_i, a_i_plus_512
    add a_i_plus_256, a_i_plus_768
    sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
    sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

    vmov.w tmp, upper, s10, s11
    add a_i, tmp
    add a_i_plus_256, upper
    montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
    montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
    central_reduce a_i, M_half, M
    central_reduce a_i_plus_256, M_half, M
    and.w a_i, a_i, mask
    and.w a_i_plus_256, a_i_plus_256, mask
    strh.w a_i, [store_ptr, #4]
    strh.w a_i_plus_256, [store_ptr, #516]
    vmov.w s10, s11, a_i_plus_512, a_i_plus_768 @ save out

    ldr.w a_i, [input_ptr, #4]
    ldr.w a_i_plus_256, [input_ptr, #1028]
    ldr.w a_i_plus_512, [input_ptr, #2052]
    ldr.w a_i_plus_768, [input_ptr, #3076]

    add a_i, a_i_plus_256
    add a_i_plus_512, a_i_plus_768
    sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
    sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
    vmov.w tmp, s13
    montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
    add a_i, a_i_plus_512
    add a_i_plus_256, a_i_plus_768
    sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
    sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

    vmov.w tmp, upper, s6, s7
    add a_i, tmp
    add a_i_plus_256, upper
    montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
    montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
    central_reduce a_i, M_half, M
    central_reduce a_i_plus_256, M_half, M
    and.w a_i, a_i, mask
    and.w a_i_plus_256, a_i_plus_256, mask
    strh.w a_i, [store_ptr, #2]
    strh.w a_i_plus_256, [store_ptr, #514]
    vmov.w s6, s7, a_i_plus_512, a_i_plus_768 @ save out

    ldr.w a_i_plus_256, [input_ptr, #1024]
    ldr.w a_i_plus_512, [input_ptr, #2048]
    ldr.w a_i_plus_768, [input_ptr, #3072]
    ldr.w a_i, [input_ptr], #12

    add a_i, a_i_plus_256
    add a_i_plus_512, a_i_plus_768
    sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
    sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
    vmov.w tmp, s13
    montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
    add a_i, a_i_plus_512
    add a_i_plus_256, a_i_plus_768
    sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
    sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

    vmov.w tmp, upper, s2, s3
    add a_i, tmp
    add a_i_plus_256, upper
    montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
    montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
    central_reduce a_i, M_half, M
    central_reduce a_i_plus_256, M_half, M
    and.w a_i, a_i, mask
    and.w a_i_plus_256, a_i_plus_256, mask
    strh.w a_i_plus_256, [store_ptr, #512]
    strh.w a_i, [store_ptr], #6
    vmov.w s2, s3, a_i_plus_512, a_i_plus_768 @ save out

    vmov.w counter, inner_counter
    cmp.w counter, input_ptr
    bne.w final_pack_loop

sub.w store_ptr, 504

// 252 508 764 1020
ldr.w a_i, [input_ptr, #0]
ldr.w a_i_plus_256, [input_ptr, #1024]
ldr.w a_i_plus_512, [input_ptr, #2048]
ldr.w a_i_plus_768, [input_ptr, #3072]

add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

vmov.w tmp, upper, s2, s3
add a_i, tmp
add a_i_plus_256, upper
montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
central_reduce a_i, M_half, M
central_reduce a_i_plus_256, M_half, M
and.w a_i, a_i, mask
and.w a_i_plus_256, a_i_plus_256, mask
strh.w a_i, [store_ptr, #504]
strh.w a_i_plus_256, [store_ptr, #1016]
vmov.w s2, s3, a_i_plus_512, a_i_plus_768 @ save out

// 253 509 765 1021
ldr.w a_i, [input_ptr, #4]
ldr.w a_i_plus_256, [input_ptr, #1028]
ldr.w a_i_plus_512, [input_ptr, #2052]
ldr.w a_i_plus_768, [input_ptr, #3076]

add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

vmov.w tmp, s6
add a_i, tmp
montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
central_reduce a_i, M_half, M
and.w a_i, a_i, mask
strh.w a_i, [store_ptr, #506]

vmov.w tmp, upper, s0, s1
add.w a_i_plus_256, tmp
add.w a_i_plus_512, upper
montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
montgomery_mul a_i_plus_512, R2inv256, lower, a_i_plus_512, tmp, M_inv, M
central_reduce a_i_plus_256, M_half, M
central_reduce a_i_plus_512, M_half, M
and.w a_i_plus_256, a_i_plus_256, mask
and.w a_i_plus_512, a_i_plus_512, mask
strh.w a_i_plus_256, [store_ptr, #0]
strh.w a_i_plus_512, [store_ptr, #512]

// 254 510 766 1022
ldr.w a_i, [input_ptr, #8]
ldr.w a_i_plus_256, [input_ptr, #1032]
ldr.w a_i_plus_512, [input_ptr, #2056]
ldr.w a_i_plus_768, [input_ptr, #3080]

add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

vmov.w tmp, s10
add a_i, tmp
montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
central_reduce a_i, M_half, M
and.w a_i, a_i, mask
strh.w a_i, [store_ptr, #508]

vmov.w tmp, upper, s4, s5
add.w a_i_plus_256, tmp
add.w a_i_plus_512, upper
montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
montgomery_mul a_i_plus_512, R2inv256, lower, a_i_plus_512, tmp, M_inv, M
central_reduce a_i_plus_256, M_half, M
central_reduce a_i_plus_512, M_half, M
and.w a_i_plus_256, a_i_plus_256, mask
and.w a_i_plus_512, a_i_plus_512, mask
strh.w a_i_plus_256, [store_ptr, #2]
strh.w a_i_plus_512, [store_ptr, #514]

// 255 511 767 1023
ldr.w a_i, [input_ptr, #12]
ldr.w a_i_plus_256, [input_ptr, #1036]
ldr.w a_i_plus_512, [input_ptr, #2060]
ldr.w a_i_plus_768, [input_ptr, #3084]

add a_i, a_i_plus_256
add a_i_plus_512, a_i_plus_768
sub.w a_i_plus_256, a_i, a_i_plus_256, lsl #1
sub.w a_i_plus_768, a_i_plus_512, a_i_plus_768, lsl #1
vmov.w tmp, s13
montgomery_mul a_i_plus_768, tmp, lower, a_i_plus_768, upper, M_inv, M
add a_i, a_i_plus_512
add a_i_plus_256, a_i_plus_768
sub.w a_i_plus_512, a_i, a_i_plus_512, lsl #1
sub.w a_i_plus_768, a_i_plus_256, a_i_plus_768, lsl #1

vmov.w tmp, s2
add a_i, tmp
montgomery_mul a_i, R2inv256, lower, a_i, tmp, M_inv, M
central_reduce a_i, M_half, M
and.w a_i, a_i, mask
strh.w a_i, [store_ptr, #510]

vmov.w tmp, upper, s8, s9
add.w a_i_plus_256, tmp
add.w a_i_plus_512, upper
montgomery_mul a_i_plus_256, R2inv256, lower, a_i_plus_256, tmp, M_inv, M
montgomery_mul a_i_plus_512, R2inv256, lower, a_i_plus_512, tmp, M_inv, M
central_reduce a_i_plus_256, M_half, M
central_reduce a_i_plus_512, M_half, M
and.w a_i_plus_256, a_i_plus_256, mask
and.w a_i_plus_512, a_i_plus_512, mask
strh.w a_i_plus_256, [store_ptr, #4]
strh.w a_i_plus_512, [store_ptr, #516]

add.w sp, #8192
vpop.w {s16-s31}
pop.w {r4-r12, pc}

