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

store_ptr         .req r0
tmp               .req r1
M                 .req r12
M_inv             .req r3
a_0               .req r4
a_1               .req r5
a_2               .req r6
a_3               .req r7
a_4               .req r8
a_5               .req r9
a_6               .req r10
a_7               .req r11
lower             .req r2
upper             .req r14

input_ptr         .req r7
counter           .req r4


tmp_input_ptr     .req s10
tmp_input_ptr2    .req s11
tmp_outer_counter .req s12
tmp_inner_counter .req s13
tmp_lr            .req s14
tmp_root_table    .req s15

loop_combined_8:
vmov.w tmp_lr, lr
loop_8:
// layer 1
vmov.w input_ptr, tmp_input_ptr
ldrsh.w a_0, [input_ptr, #516]
ldrsh.w a_1, [input_ptr, #132]
ldrsh.w a_2, [input_ptr, #1284]
ldrsh.w a_3, [input_ptr, #900]

// layer 2
vmov.w tmp, s3
mul.w a_6, tmp, a_2
mul.w a_7, tmp, a_3
sub.w a_4, a_6, a_0
add.w a_0, a_2
sub.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_2, a_0, a_2, lsl #1
sub.w a_3, a_1, a_3, lsl #1
sub.w a_6, a_4, a_6, lsl #1
add.w a_7, a_5, a_7, lsl #1

// layer 3
mul.w a_3, tmp, a_3
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
add a_4, a_5
add a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
// layer 1
vmov.w input_ptr, tmp_input_ptr
ldrsh.w a_0, [input_ptr, #6]
ldrsh.w a_1, [input_ptr, #1158]
ldrsh.w a_2, [input_ptr, #774]
ldrsh.w a_3, [input_ptr, #390]

// layer 2
vmov.w tmp, s3
mul.w a_6, tmp, a_2
mul.w a_7, tmp, a_3
sub.w a_4, a_0, a_6
add.w a_0, a_2
add.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_2, a_0, a_2, lsl #1
sub.w a_3, a_1, a_3, lsl #1
add.w a_6, a_4, a_6, lsl #1
sub.w a_7, a_5, a_7, lsl #1

// layer 3
mul.w a_3, tmp, a_3
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
add a_4, a_5
add a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #4]
str.w a_1, [store_ptr, #260]
str.w a_2, [store_ptr, #516]
str.w a_3, [store_ptr, #772]
str.w a_4, [store_ptr, #1028]
str.w a_5, [store_ptr, #1284]
str.w a_6, [store_ptr, #1540]
str.w a_7, [store_ptr, #1796]
// layer 1
vmov.w input_ptr, tmp_input_ptr
ldrsh.w a_0, [input_ptr, #1032]
ldrsh.w a_1, [input_ptr, #648]
ldrsh.w a_2, [input_ptr, #264]
add.w input_ptr, #6
vmov.w tmp_input_ptr, input_ptr

// layer 2
vmov.w tmp, s3
mul.w a_6, tmp, a_2
add.w a_4, a_0, a_6
add.w a_0, a_2
sub.w a_2, a_0, a_2, lsl #1
sub.w a_6, a_4, a_6, lsl #1

// layer 3
mul.w a_3, tmp, a_1
vmov.w tmp, s1
montgomery_mul a_1, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_1, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
sub a_4, a_5
sub a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
add.w a_5, a_4, a_5, lsl #1
add.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #8]
str.w a_1, [store_ptr, #264]
str.w a_2, [store_ptr, #520]
str.w a_3, [store_ptr, #776]
str.w a_4, [store_ptr, #1032]
str.w a_5, [store_ptr, #1288]
str.w a_6, [store_ptr, #1544]
str.w a_7, [store_ptr, #1800]
add.w store_ptr, #12

vmov.w counter, tmp_outer_counter
cmp.w store_ptr, counter
bne.w loop_8

vmov.w lr, tmp_lr
bx lr
remaing_type0_8:
vmov.w tmp_lr, lr
// layer 1
ldrsh.w a_0, [input_ptr, #0]
ldrsh.w a_1, [input_ptr, #1152]
ldrsh.w a_2, [input_ptr, #768]
ldrsh.w a_3, [input_ptr, #384]

// layer 2
vmov.w tmp, s3
mul.w a_6, tmp, a_2
mul.w a_7, tmp, a_3
sub.w a_4, a_0, a_6
add.w a_0, a_2
add.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_2, a_0, a_2, lsl #1
sub.w a_3, a_1, a_3, lsl #1
add.w a_6, a_4, a_6, lsl #1
sub.w a_7, a_5, a_7, lsl #1

// layer 3
mul.w a_3, tmp, a_3
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
add a_4, a_5
add a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
vmov.w lr, tmp_lr
bx lr
remaing_type1_8:
vmov.w tmp_lr, lr
// layer 1
ldrsh.w a_0, [input_ptr, #1026]
ldrsh.w a_1, [input_ptr, #642]
ldrsh.w a_2, [input_ptr, #258]

// layer 2
vmov.w tmp, s3
mul.w a_6, tmp, a_2
add.w a_4, a_0, a_6
add.w a_0, a_2
sub.w a_2, a_0, a_2, lsl #1
sub.w a_6, a_4, a_6, lsl #1

// layer 3
mul.w a_3, tmp, a_1
vmov.w tmp, s1
montgomery_mul a_1, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_1, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
sub a_4, a_5
sub a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
add.w a_5, a_4, a_5, lsl #1
add.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
vmov.w lr, tmp_lr
bx lr
remaing_type2_8:
vmov.w tmp_lr, lr
// layer 1
ldrsh.w a_0, [input_ptr, #588]
ldrsh.w a_1, [input_ptr, #204]
ldrsh.w a_3, [input_ptr, #972]

// layer 2
vmov.w tmp, s3
mul.w a_7, tmp, a_3
sub.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_3, a_1, a_3, lsl #1
add.w a_7, a_5, a_7, lsl #1

// layer 3
mul.w a_3, tmp, a_3
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add.w a_2, a_0, a_3
sub.w a_4, a_5, a_0
sub.w a_6, a_7, a_0
add.w a_0, a_1
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
vmov.w lr, tmp_lr
bx lr

// __asm_NTT_forward_16_small (int16 *input, int32 *root_table, int32 MOD,
//                   int32 M_inv, int32 output[3][512])
.global __asm_NTT_forward_16_small
.type __asm_NTT_forward_16_small, %function
__asm_NTT_forward_16_small:


vmov.w tmp_input_ptr, r0
vmov.w tmp_input_ptr2, r0
push.w {r4-r12, lr}
vldm.w r1!, {s0-s3}
ldr.w r0, [sp, #40]
vmov.w tmp_root_table, r1
mov.w r12, r2

add.w store_ptr, #8
add.w tmp, store_ptr, #144
vmov.w tmp_outer_counter, tmp
vmov.w input_ptr, tmp_input_ptr
add.w input_ptr, #0
vmov.w tmp_input_ptr, input_ptr
bl.w loop_combined_8

add.w store_ptr, #1896
add.w tmp, store_ptr, #156
vmov.w tmp_outer_counter, tmp
vmov.w input_ptr, tmp_input_ptr
add.w input_ptr, #-76
vmov.w tmp_input_ptr, input_ptr
bl.w loop_combined_8

add.w store_ptr, #1896
add.w tmp, store_ptr, #144
vmov.w tmp_outer_counter, tmp
vmov.w input_ptr, tmp_input_ptr
add.w input_ptr, #-76
vmov.w tmp_input_ptr, input_ptr
bl.w loop_combined_8

add.w store_ptr, #-2032
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #80
bl.w remaing_type1_8

add.w store_ptr, #-2208
vmov.w input_ptr, tmp_input_ptr2
bl.w remaing_type1_8

add.w store_ptr, #228
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #114
bl.w remaing_type1_8

add.w store_ptr, #-36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #96
bl.w remaing_type1_8

add.w store_ptr, #-24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #84
bl.w remaing_type1_8

add.w store_ptr, #48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #108
bl.w remaing_type1_8

add.w store_ptr, #-60
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #78
bl.w remaing_type1_8

add.w store_ptr, #48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #102
bl.w remaing_type1_8

add.w store_ptr, #4092
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #100
bl.w remaing_type1_8

add.w store_ptr, #-12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #94
bl.w remaing_type1_8

add.w store_ptr, #-24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #82
bl.w remaing_type1_8

add.w store_ptr, #84
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #124
bl.w remaing_type1_8

add.w store_ptr, #-72
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #88
bl.w remaing_type1_8

add.w store_ptr, #-4092
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #90
bl.w remaing_type1_8

add.w store_ptr, #2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #92
bl.w remaing_type1_8

add.w store_ptr, #2100
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #118
bl.w remaing_type1_8

add.w store_ptr, #-2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #116
bl.w remaing_type1_8

add.w store_ptr, #-36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #98
bl.w remaing_type1_8

add.w store_ptr, #2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #106
bl.w remaing_type1_8

add.w store_ptr, #-2040
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #110
bl.w remaing_type1_8

add.w store_ptr, #-12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #104
bl.w remaing_type1_8

add.w store_ptr, #1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #76
bl.w remaing_type1_8

add.w store_ptr, #72
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #112
bl.w remaing_type1_8

add.w store_ptr, #-4080
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #120
bl.w remaing_type1_8

add.w store_ptr, #2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #122
bl.w remaing_type1_8

add.w store_ptr, #1800
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #-2
bl.w remaing_type1_8

add.w store_ptr, #-1872
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #86
bl.w remaing_type1_8

add.w store_ptr, #56
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #116
bl.w remaing_type0_8

add.w store_ptr, #-72
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #80
bl.w remaing_type0_8

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #94
bl.w remaing_type0_8

add.w store_ptr, #-2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #92
bl.w remaing_type0_8

add.w store_ptr, #2112
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #124
bl.w remaing_type0_8

add.w store_ptr, #-12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #118
bl.w remaing_type0_8

add.w store_ptr, #-72
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #82
bl.w remaing_type0_8

add.w store_ptr, #-4092
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #84
bl.w remaing_type0_8

add.w store_ptr, #36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #102
bl.w remaing_type0_8

add.w store_ptr, #2088
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #122
bl.w remaing_type0_8

add.w store_ptr, #2028
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #112
bl.w remaing_type0_8

add.w store_ptr, #-48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #88
bl.w remaing_type0_8

add.w store_ptr, #-4092
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #90
bl.w remaing_type0_8

add.w store_ptr, #36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #108
bl.w remaing_type0_8

add.w store_ptr, #4092
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #106
bl.w remaing_type0_8

add.w store_ptr, #-2088
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #86
bl.w remaing_type0_8

add.w store_ptr, #-2220
vmov.w input_ptr, tmp_input_ptr2
bl.w remaing_type0_8

add.w store_ptr, #156
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #78
bl.w remaing_type0_8

add.w store_ptr, #96
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #126
bl.w remaing_type0_8

add.w store_ptr, #-12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #120
bl.w remaing_type0_8

add.w store_ptr, #4056
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #100
bl.w remaing_type0_8

add.w store_ptr, #-4068
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #114
bl.w remaing_type0_8

add.w store_ptr, #-36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #96
bl.w remaing_type0_8

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #110
bl.w remaing_type0_8

add.w store_ptr, #-24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #98
bl.w remaing_type0_8

add.w store_ptr, #2004
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #76
bl.w remaing_type0_8

add.w store_ptr, #-1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #104
bl.w remaing_type0_8

add.w store_ptr, #-4
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #26
bl.w remaing_type2_8

add.w store_ptr, #-2016
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #42
bl.w remaing_type2_8

add.w store_ptr, #1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #14
bl.w remaing_type2_8

add.w store_ptr, #2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #22
bl.w remaing_type2_8

add.w store_ptr, #36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #40
bl.w remaing_type2_8

add.w store_ptr, #-2124
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #2
bl.w remaing_type2_8

add.w store_ptr, #2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #4
bl.w remaing_type2_8

add.w store_ptr, #24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #16
bl.w remaing_type2_8

add.w store_ptr, #24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #28
bl.w remaing_type2_8

add.w store_ptr, #-2004
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #50
bl.w remaing_type2_8

add.w store_ptr, #2016
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #34
bl.w remaing_type2_8

add.w store_ptr, #-4092
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #36
bl.w remaing_type2_8

add.w store_ptr, #1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #8
bl.w remaing_type2_8

add.w store_ptr, #-2040
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #12
bl.w remaing_type2_8

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #18
bl.w remaing_type2_8

add.w store_ptr, #4056
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #-2
bl.w remaing_type2_8

add.w store_ptr, #-1980
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #32
bl.w remaing_type2_8

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #38
bl.w remaing_type2_8

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #44
bl.w remaing_type2_8

add.w store_ptr, #2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #46
bl.w remaing_type2_8

add.w store_ptr, #-72
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #10
bl.w remaing_type2_8

add.w store_ptr, #-4056
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #30
bl.w remaing_type2_8

add.w store_ptr, #-60
vmov.w input_ptr, tmp_input_ptr2
bl.w remaing_type2_8

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #6
bl.w remaing_type2_8

add.w store_ptr, #84
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #48
bl.w remaing_type2_8

add.w store_ptr, #1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #20
bl.w remaing_type2_8

add.w store_ptr, #-2040
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #24
bl.w remaing_type2_8

add.w store_ptr, #28
b.w _4_5_6

loop_combined_16:
vmov.w tmp_lr, lr
loop_16:
// layer 1
vmov.w input_ptr, tmp_input_ptr
ldrsh.w a_0, [input_ptr, #516]
ldrsh.w a_1, [input_ptr, #132]
ldrsh.w a_2, [input_ptr, #1284]
ldrsh.w a_3, [input_ptr, #900]
mov.w r1, #1024
mov.w r2, #2048
central_reduce a_0, r1, r2
central_reduce a_1, r1, r2
central_reduce a_2, r1, r2
central_reduce a_3, r1, r2

// layer 2
vmov.w tmp, s0
montgomery_mul a_2, tmp, lower, a_6, upper, M_inv, M
montgomery_mul a_3, tmp, lower, a_7, upper, M_inv, M
sub.w a_4, a_6, a_0
add.w a_0, a_2
sub.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_2, a_0, a_2, lsl #1
sub.w a_3, a_1, a_3, lsl #1
sub.w a_6, a_4, a_6, lsl #1
add.w a_7, a_5, a_7, lsl #1

// layer 3
montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
add a_4, a_5
add a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
// layer 1
vmov.w input_ptr, tmp_input_ptr
ldrsh.w a_0, [input_ptr, #6]
ldrsh.w a_1, [input_ptr, #1158]
ldrsh.w a_2, [input_ptr, #774]
ldrsh.w a_3, [input_ptr, #390]
mov.w r1, #1024
mov.w r2, #2048
central_reduce a_0, r1, r2
central_reduce a_1, r1, r2
central_reduce a_2, r1, r2
central_reduce a_3, r1, r2

// layer 2
vmov.w tmp, s0
montgomery_mul a_2, tmp, lower, a_6, upper, M_inv, M
montgomery_mul a_3, tmp, lower, a_7, upper, M_inv, M
sub.w a_4, a_0, a_6
add.w a_0, a_2
add.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_2, a_0, a_2, lsl #1
sub.w a_3, a_1, a_3, lsl #1
add.w a_6, a_4, a_6, lsl #1
sub.w a_7, a_5, a_7, lsl #1

// layer 3
montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
add a_4, a_5
add a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #4]
str.w a_1, [store_ptr, #260]
str.w a_2, [store_ptr, #516]
str.w a_3, [store_ptr, #772]
str.w a_4, [store_ptr, #1028]
str.w a_5, [store_ptr, #1284]
str.w a_6, [store_ptr, #1540]
str.w a_7, [store_ptr, #1796]
// layer 1
vmov.w input_ptr, tmp_input_ptr
ldrsh.w a_0, [input_ptr, #1032]
ldrsh.w a_1, [input_ptr, #648]
ldrsh.w a_2, [input_ptr, #264]
mov.w r1, #1024
mov.w r2, #2048
central_reduce a_0, r1, r2
central_reduce a_1, r1, r2
central_reduce a_2, r1, r2
add.w input_ptr, #6
vmov.w tmp_input_ptr, input_ptr

// layer 2
vmov.w tmp, s0
montgomery_mul a_2, tmp, lower, a_6, upper, M_inv, M
add.w a_4, a_0, a_6
add.w a_0, a_2
sub.w a_2, a_0, a_2, lsl #1
sub.w a_6, a_4, a_6, lsl #1

// layer 3
montgomery_mul a_1, tmp, lower, a_3, upper, M_inv, M
vmov.w tmp, s1
montgomery_mul a_1, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_1, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
sub a_4, a_5
sub a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
add.w a_5, a_4, a_5, lsl #1
add.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #8]
str.w a_1, [store_ptr, #264]
str.w a_2, [store_ptr, #520]
str.w a_3, [store_ptr, #776]
str.w a_4, [store_ptr, #1032]
str.w a_5, [store_ptr, #1288]
str.w a_6, [store_ptr, #1544]
str.w a_7, [store_ptr, #1800]
add.w store_ptr, #12

vmov.w counter, tmp_outer_counter
cmp.w store_ptr, counter
bne.w loop_16

vmov.w lr, tmp_lr
bx lr
remaing_type0_16:
vmov.w tmp_lr, lr
// layer 1
ldrsh.w a_0, [input_ptr, #0]
ldrsh.w a_1, [input_ptr, #1152]
ldrsh.w a_2, [input_ptr, #768]
ldrsh.w a_3, [input_ptr, #384]
mov.w r1, #1024
mov.w r2, #2048
central_reduce a_0, r1, r2
central_reduce a_1, r1, r2
central_reduce a_2, r1, r2
central_reduce a_3, r1, r2

// layer 2
vmov.w tmp, s0
montgomery_mul a_2, tmp, lower, a_6, upper, M_inv, M
montgomery_mul a_3, tmp, lower, a_7, upper, M_inv, M
sub.w a_4, a_0, a_6
add.w a_0, a_2
add.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_2, a_0, a_2, lsl #1
sub.w a_3, a_1, a_3, lsl #1
add.w a_6, a_4, a_6, lsl #1
sub.w a_7, a_5, a_7, lsl #1

// layer 3
montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
add a_4, a_5
add a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
vmov.w lr, tmp_lr
bx lr
remaing_type1_16:
vmov.w tmp_lr, lr
// layer 1
ldrsh.w a_0, [input_ptr, #1026]
ldrsh.w a_1, [input_ptr, #642]
ldrsh.w a_2, [input_ptr, #258]
mov.w r1, #1024
mov.w r2, #2048
central_reduce a_0, r1, r2
central_reduce a_1, r1, r2
central_reduce a_2, r1, r2

// layer 2
vmov.w tmp, s0
montgomery_mul a_2, tmp, lower, a_6, upper, M_inv, M
add.w a_4, a_0, a_6
add.w a_0, a_2
sub.w a_2, a_0, a_2, lsl #1
sub.w a_6, a_4, a_6, lsl #1

// layer 3
montgomery_mul a_1, tmp, lower, a_3, upper, M_inv, M
vmov.w tmp, s1
montgomery_mul a_1, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_1, tmp, lower, a_7, upper, M_inv, M
add a_0, a_1
add a_2, a_3
sub a_4, a_5
sub a_6, a_7
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
add.w a_5, a_4, a_5, lsl #1
add.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
vmov.w lr, tmp_lr
bx lr
remaing_type2_16:
vmov.w tmp_lr, lr
// layer 1
ldrsh.w a_0, [input_ptr, #588]
ldrsh.w a_1, [input_ptr, #204]
ldrsh.w a_3, [input_ptr, #972]
mov.w r1, #1024
mov.w r2, #2048
central_reduce a_0, r1, r2
central_reduce a_1, r1, r2
central_reduce a_3, r1, r2

// layer 2
vmov.w tmp, s0
montgomery_mul a_3, tmp, lower, a_7, upper, M_inv, M
sub.w a_5, a_1, a_7
add.w a_1, a_3
sub.w a_3, a_1, a_3, lsl #1
add.w a_7, a_5, a_7, lsl #1

// layer 3
montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
vmov.w tmp, s1
montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
vmov.w tmp, s2
montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M
add.w a_2, a_0, a_3
sub.w a_4, a_5, a_0
sub.w a_6, a_7, a_0
add.w a_0, a_1
sub.w a_1, a_0, a_1, lsl #1
sub.w a_3, a_2, a_3, lsl #1
sub.w a_5, a_4, a_5, lsl #1
sub.w a_7, a_6, a_7, lsl #1
str.w a_0, [store_ptr, #0]
str.w a_1, [store_ptr, #256]
str.w a_2, [store_ptr, #512]
str.w a_3, [store_ptr, #768]
str.w a_4, [store_ptr, #1024]
str.w a_5, [store_ptr, #1280]
str.w a_6, [store_ptr, #1536]
str.w a_7, [store_ptr, #1792]
vmov.w lr, tmp_lr
bx lr

// __asm_NTT_forward_16 (int16 *input, int32 *root_table, int32 MOD,
//                   int32 M_inv, int32 output[3][512])
.global __asm_NTT_forward_16
.type __asm_NTT_forward_16, %function
__asm_NTT_forward_16:


vmov.w tmp_input_ptr, r0
vmov.w tmp_input_ptr2, r0
push.w {r4-r12, lr}
vldm.w r1!, {s0-s3}
ldr.w r0, [sp, #40]
vmov.w tmp_root_table, r1
mov.w r12, r2

add.w store_ptr, #8
add.w tmp, store_ptr, #144
vmov.w tmp_outer_counter, tmp
vmov.w input_ptr, tmp_input_ptr
add.w input_ptr, #0
vmov.w tmp_input_ptr, input_ptr
bl.w loop_combined_16

add.w store_ptr, #1896
add.w tmp, store_ptr, #156
vmov.w tmp_outer_counter, tmp
vmov.w input_ptr, tmp_input_ptr
add.w input_ptr, #-76
vmov.w tmp_input_ptr, input_ptr
bl.w loop_combined_16

add.w store_ptr, #1896
add.w tmp, store_ptr, #144
vmov.w tmp_outer_counter, tmp
vmov.w input_ptr, tmp_input_ptr
add.w input_ptr, #-76
vmov.w tmp_input_ptr, input_ptr
bl.w loop_combined_16

add.w store_ptr, #-1960
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #116
bl.w remaing_type1_16

add.w store_ptr, #-2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #108
bl.w remaing_type1_16

add.w store_ptr, #4032
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #76
bl.w remaing_type1_16

add.w store_ptr, #84
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #118
bl.w remaing_type1_16

add.w store_ptr, #-2088
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #98
bl.w remaing_type1_16

add.w store_ptr, #-2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #84
bl.w remaing_type1_16

add.w store_ptr, #3924
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #-2
bl.w remaing_type1_16

add.w store_ptr, #-1884
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #80
bl.w remaing_type1_16

add.w store_ptr, #-2016
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #96
bl.w remaing_type1_16

add.w store_ptr, #-192
vmov.w input_ptr, tmp_input_ptr2
bl.w remaing_type1_16

add.w store_ptr, #2292
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #122
bl.w remaing_type1_16

add.w store_ptr, #-2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #114
bl.w remaing_type1_16

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #120
bl.w remaing_type1_16

add.w store_ptr, #4020
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #82
bl.w remaing_type1_16

add.w store_ptr, #-2028
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #92
bl.w remaing_type1_16

add.w store_ptr, #-2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #78
bl.w remaing_type1_16

add.w store_ptr, #24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #90
bl.w remaing_type1_16

add.w store_ptr, #24
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #102
bl.w remaing_type1_16

add.w store_ptr, #4068
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #88
bl.w remaing_type1_16

add.w store_ptr, #48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #112
bl.w remaing_type1_16

add.w store_ptr, #-2100
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #86
bl.w remaing_type1_16

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #100
bl.w remaing_type1_16

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #106
bl.w remaing_type1_16

add.w store_ptr, #-2040
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #110
bl.w remaing_type1_16

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #124
bl.w remaing_type1_16

add.w store_ptr, #-60
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #94
bl.w remaing_type1_16

add.w store_ptr, #-2028
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #104
bl.w remaing_type1_16

add.w store_ptr, #2000
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #82
bl.w remaing_type0_16

add.w store_ptr, #-4020
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #120
bl.w remaing_type0_16

add.w store_ptr, #1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #92
bl.w remaing_type0_16

add.w store_ptr, #2112
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #124
bl.w remaing_type0_16

add.w store_ptr, #-60
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #94
bl.w remaing_type0_16

add.w store_ptr, #48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #118
bl.w remaing_type0_16

add.w store_ptr, #-60
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #88
bl.w remaing_type0_16

add.w store_ptr, #-4044
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #114
bl.w remaing_type0_16

add.w store_ptr, #2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #116
bl.w remaing_type0_16

add.w store_ptr, #-2124
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #78
bl.w remaing_type0_16

add.w store_ptr, #36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #96
bl.w remaing_type0_16

add.w store_ptr, #2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #104
bl.w remaing_type0_16

add.w store_ptr, #-48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #80
bl.w remaing_type0_16

add.w store_ptr, #2112
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #112
bl.w remaing_type0_16

add.w store_ptr, #-2100
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #86
bl.w remaing_type0_16

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #100
bl.w remaing_type0_16

add.w store_ptr, #-4080
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #108
bl.w remaing_type0_16

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #122
bl.w remaing_type0_16

add.w store_ptr, #-2124
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #84
bl.w remaing_type0_16

add.w store_ptr, #-168
vmov.w input_ptr, tmp_input_ptr2
bl.w remaing_type0_16

add.w store_ptr, #2244
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #98
bl.w remaing_type0_16

add.w store_ptr, #-1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #126
bl.w remaing_type0_16

add.w store_ptr, #-48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #102
bl.w remaing_type0_16

add.w store_ptr, #4044
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #76
bl.w remaing_type0_16

add.w store_ptr, #60
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #106
bl.w remaing_type0_16

add.w store_ptr, #-2040
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #110
bl.w remaing_type0_16

add.w store_ptr, #-2088
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #90
bl.w remaing_type0_16

add.w store_ptr, #8
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #18
bl.w remaing_type2_16

add.w store_ptr, #-12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #12
bl.w remaing_type2_16

add.w store_ptr, #2124
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #50
bl.w remaing_type2_16

add.w store_ptr, #2016
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #34
bl.w remaing_type2_16

add.w store_ptr, #-48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #10
bl.w remaing_type2_16

add.w store_ptr, #60
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #40
bl.w remaing_type2_16

add.w store_ptr, #-48
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #16
bl.w remaing_type2_16

add.w store_ptr, #-4068
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #30
bl.w remaing_type2_16

add.w store_ptr, #2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #32
bl.w remaing_type2_16

add.w store_ptr, #1980
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #-2
bl.w remaing_type2_16

add.w store_ptr, #12
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #4
bl.w remaing_type2_16

add.w store_ptr, #-4056
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #24
bl.w remaing_type2_16

add.w store_ptr, #36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #42
bl.w remaing_type2_16

add.w store_ptr, #-84
vmov.w input_ptr, tmp_input_ptr2
bl.w remaing_type2_16

add.w store_ptr, #2076
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #14
bl.w remaing_type2_16

add.w store_ptr, #2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #22
bl.w remaing_type2_16

add.w store_ptr, #-2052
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #20
bl.w remaing_type2_16

add.w store_ptr, #36
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #38
bl.w remaing_type2_16

add.w store_ptr, #2064
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #46
bl.w remaing_type2_16

add.w store_ptr, #-2088
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #26
bl.w remaing_type2_16

add.w store_ptr, #-2004
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #48
bl.w remaing_type2_16

add.w store_ptr, #4056
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #28
bl.w remaing_type2_16

add.w store_ptr, #-4080
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #36
bl.w remaing_type2_16

add.w store_ptr, #1992
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #8
bl.w remaing_type2_16

add.w store_ptr, #72
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #44
bl.w remaing_type2_16

add.w store_ptr, #-2124
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #6
bl.w remaing_type2_16

add.w store_ptr, #2040
vmov.w input_ptr, tmp_input_ptr2
add.w input_ptr, #2
bl.w remaing_type2_16

add.w store_ptr, #-1976
b.w _4_5_6

.align 10   // 0x000
_4_5_6:

add.w r4, r0, #32   // set counter
vmov.w tmp_outer_counter, r4

level_4_5_6_special:

    ldr.w a_0, [store_ptr, #-228]
    ldr.w a_1, [store_ptr, #-196]
    ldr.w a_2, [store_ptr, #-164]
    ldr.w a_3, [store_ptr, #-132]
    ldr.w a_4, [store_ptr, #-100]
    ldr.w a_5, [store_ptr, #-68]
    ldr.w a_6, [store_ptr, #-36]
    ldr.w a_7, [store_ptr, #-4]

    // level 4
    //  0<->32, 1;  8<->40, 1;
    // 16<->48, 1; 24<->56, 1;
    add a_0, a_4
    add a_1, a_5
    add a_2, a_6
    add a_3, a_7
    sub.w a_4, a_0, a_4, lsl #1
    sub.w a_5, a_1, a_5, lsl #1
    sub.w a_6, a_2, a_6, lsl #1
    sub.w a_7, a_3, a_7, lsl #1

    // level 5
    //  0<->16,  1;  8<->24,  1;
    // 32<->48, c0; 40<->56, c0;

    vmov.w tmp, s0
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_2
    add a_1, a_3
    add a_5, a_7
    add a_4, a_6
    sub.w a_2, a_0, a_2, lsl #1
    sub.w a_3, a_1, a_3, lsl #1
    sub.w a_6, a_4, a_6, lsl #1
    sub.w a_7, a_5, a_7, lsl #1

    // level 6
    //   0<->8,  1; 16<->24, c0;
    // 32<->40, c1; 48<->56, c2;

    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M

    vmov.w tmp, s1  // c1=s1
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M

    vmov.w tmp, s2  // c2=s2
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_1
    add a_2, a_3
    add a_4, a_5
    add a_6, a_7
    sub.w a_1, a_0, a_1, lsl #1
    sub.w a_3, a_2, a_3, lsl #1
    sub.w a_5, a_4, a_5, lsl #1
    sub.w a_7, a_6, a_7, lsl #1


    // save
    str.w a_0, [r0, #-228]
    str.w a_1, [r0, #-196]
    str.w a_2, [r0, #-164]
    str.w a_3, [r0, #-132]
    str.w a_4, [r0, #-100]
    str.w a_5, [r0, #-68]
    str.w a_6, [r0, #-36]
    str.w a_7, [r0, #-4]

    ldr.w a_0, [store_ptr, #1820]
    ldr.w a_1, [store_ptr, #1852]
    ldr.w a_2, [store_ptr, #1884]
    ldr.w a_3, [store_ptr, #1916]
    ldr.w a_4, [store_ptr, #1948]
    ldr.w a_5, [store_ptr, #1980]
    ldr.w a_6, [store_ptr, #2012]
    ldr.w a_7, [store_ptr, #2044]

    // level 4
    //  0<->32, 1;  8<->40, 1;
    // 16<->48, 1; 24<->56, 1;
    add a_0, a_4
    add a_1, a_5
    add a_2, a_6
    add a_3, a_7
    sub.w a_4, a_0, a_4, lsl #1
    sub.w a_5, a_1, a_5, lsl #1
    sub.w a_6, a_2, a_6, lsl #1
    sub.w a_7, a_3, a_7, lsl #1

    // level 5
    //  0<->16,  1;  8<->24,  1;
    // 32<->48, c0; 40<->56, c0;

    vmov.w tmp, s0
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_2
    add a_1, a_3
    add a_5, a_7
    add a_4, a_6
    sub.w a_2, a_0, a_2, lsl #1
    sub.w a_3, a_1, a_3, lsl #1
    sub.w a_6, a_4, a_6, lsl #1
    sub.w a_7, a_5, a_7, lsl #1

    // level 6
    //   0<->8,  1; 16<->24, c0;
    // 32<->40, c1; 48<->56, c2;

    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M

    vmov.w tmp, s1  // c1=s1
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M

    vmov.w tmp, s2  // c2=s2
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_1
    add a_2, a_3
    add a_4, a_5
    add a_6, a_7
    sub.w a_1, a_0, a_1, lsl #1
    sub.w a_3, a_2, a_3, lsl #1
    sub.w a_5, a_4, a_5, lsl #1
    sub.w a_7, a_6, a_7, lsl #1


    // save
    str.w a_0, [r0, #1820]
    str.w a_1, [r0, #1852]
    str.w a_2, [r0, #1884]
    str.w a_3, [r0, #1916]
    str.w a_4, [r0, #1948]
    str.w a_5, [r0, #1980]
    str.w a_6, [r0, #2012]
    str.w a_7, [r0, #2044]

    ldr.w a_0, [store_ptr, #3868]
    ldr.w a_1, [store_ptr, #3900]
    ldr.w a_2, [store_ptr, #3932]
    ldr.w a_3, [store_ptr, #3964]
    ldr.w a_4, [store_ptr, #3996]
    ldr.w a_5, [store_ptr, #4028]
    ldr.w a_6, [store_ptr, #4060]
    ldr.w a_7, [store_ptr, #4092]

    // level 4
    //  0<->32, 1;  8<->40, 1;
    // 16<->48, 1; 24<->56, 1;
    add a_0, a_4
    add a_1, a_5
    add a_2, a_6
    add a_3, a_7
    sub.w a_4, a_0, a_4, lsl #1
    sub.w a_5, a_1, a_5, lsl #1
    sub.w a_6, a_2, a_6, lsl #1
    sub.w a_7, a_3, a_7, lsl #1

    // level 5
    //  0<->16,  1;  8<->24,  1;
    // 32<->48, c0; 40<->56, c0;

    vmov.w tmp, s0
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_2
    add a_1, a_3
    add a_5, a_7
    add a_4, a_6
    sub.w a_2, a_0, a_2, lsl #1
    sub.w a_3, a_1, a_3, lsl #1
    sub.w a_6, a_4, a_6, lsl #1
    sub.w a_7, a_5, a_7, lsl #1

    // level 6
    //   0<->8,  1; 16<->24, c0;
    // 32<->40, c1; 48<->56, c2;

    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M

    vmov.w tmp, s1  // c1=s1
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M

    vmov.w tmp, s2  // c2=s2
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_1
    add a_2, a_3
    add a_4, a_5
    add a_6, a_7
    sub.w a_1, a_0, a_1, lsl #1
    sub.w a_3, a_2, a_3, lsl #1
    sub.w a_5, a_4, a_5, lsl #1
    sub.w a_7, a_6, a_7, lsl #1


    // save
    str.w a_0, [r0, #3868]
    str.w a_1, [r0, #3900]
    str.w a_2, [r0, #3932]
    str.w a_3, [r0, #3964]
    str.w a_4, [r0, #3996]
    str.w a_5, [r0, #4028]
    str.w a_6, [r0, #4060]
    str.w a_7, [r0, #4092]

    add.w r0, #4
    vmov.w r4, tmp_outer_counter
    cmp.w r4, r0
    bne.w level_4_5_6_special
    add.w r0, #224

add.w r1, r0, #1792   // outer iteration set counter
vmov.w tmp_outer_counter, r1

.align 2
normal_4_5_6_outer:
    vmov.w r1, s15
    vldm.w r1!, {s3-s9}
    vmov.w s15, r1

    add.w r4, r0, #32 // inner iteration set counter
    vmov.w tmp_inner_counter, r4

    normal_4_5_6_inner:

        ldr.w a_0, [r0, #-228]
        ldr.w a_1, [r0, #-196]
        ldr.w a_2, [r0, #-164]
        ldr.w a_3, [r0, #-132]
        ldr.w a_4, [r0, #-100]
        ldr.w a_5, [r0, #-68]
        ldr.w a_6, [r0, #-36]
        ldr.w a_7, [r0, #-4]

        // level 4
        vmov.w tmp, s3
        montgomery_mul a_4, tmp, lower, a_4, upper, M_inv, M
        montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
        montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_4
        add a_1, a_5
        add a_2, a_6
        add a_3, a_7
        sub.w a_4, a_0, a_4, lsl #1
        sub.w a_5, a_1, a_5, lsl #1
        sub.w a_6, a_2, a_6, lsl #1
        sub.w a_7, a_3, a_7, lsl #1

        // level 5
        vmov.w tmp, s4
        montgomery_mul a_2, tmp, lower, a_2, upper, M_inv, M
        montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
        vmov.w tmp, s5
        montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_2
        add a_1, a_3
        add a_4, a_6
        add a_5, a_7
        sub.w a_2, a_0, a_2, lsl #1
        sub.w a_3, a_1, a_3, lsl #1
        sub.w a_6, a_4, a_6, lsl #1
        sub.w a_7, a_5, a_7, lsl #1

        // level 6
        vmov.w tmp, s6
        montgomery_mul a_1, tmp, lower, a_1, upper, M_inv, M
        vmov.w tmp, s7
        montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
        vmov.w tmp, s8
        montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
        vmov.w tmp, s9
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_1
        add a_2, a_3
        add a_4, a_5
        add a_6, a_7
        sub.w a_3, a_2, a_3, lsl #1
        sub.w a_1, a_0, a_1, lsl #1
        sub.w a_5, a_4, a_5, lsl #1
        sub.w a_7, a_6, a_7, lsl #1

        // save
        str.w a_0, [r0, #-228]
        str.w a_1, [r0, #-196]
        str.w a_2, [r0, #-164]
        str.w a_3, [r0, #-132]
        str.w a_4, [r0, #-100]
        str.w a_5, [r0, #-68]
        str.w a_6, [r0, #-36]
        str.w a_7, [r0, #-4]

        ldr.w a_0, [r0, #1820]
        ldr.w a_1, [r0, #1852]
        ldr.w a_2, [r0, #1884]
        ldr.w a_3, [r0, #1916]
        ldr.w a_4, [r0, #1948]
        ldr.w a_5, [r0, #1980]
        ldr.w a_6, [r0, #2012]
        ldr.w a_7, [r0, #2044]

        // level 4
        vmov.w tmp, s3
        montgomery_mul a_4, tmp, lower, a_4, upper, M_inv, M
        montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
        montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_4
        add a_1, a_5
        add a_2, a_6
        add a_3, a_7
        sub.w a_4, a_0, a_4, lsl #1
        sub.w a_5, a_1, a_5, lsl #1
        sub.w a_6, a_2, a_6, lsl #1
        sub.w a_7, a_3, a_7, lsl #1

        // level 5
        vmov.w tmp, s4
        montgomery_mul a_2, tmp, lower, a_2, upper, M_inv, M
        montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
        vmov.w tmp, s5
        montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_2
        add a_1, a_3
        add a_4, a_6
        add a_5, a_7
        sub.w a_2, a_0, a_2, lsl #1
        sub.w a_3, a_1, a_3, lsl #1
        sub.w a_6, a_4, a_6, lsl #1
        sub.w a_7, a_5, a_7, lsl #1

        // level 6
        vmov.w tmp, s6
        montgomery_mul a_1, tmp, lower, a_1, upper, M_inv, M
        vmov.w tmp, s7
        montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
        vmov.w tmp, s8
        montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
        vmov.w tmp, s9
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_1
        add a_2, a_3
        add a_4, a_5
        add a_6, a_7
        sub.w a_3, a_2, a_3, lsl #1
        sub.w a_1, a_0, a_1, lsl #1
        sub.w a_5, a_4, a_5, lsl #1
        sub.w a_7, a_6, a_7, lsl #1

        // save
        str.w a_0, [r0, #1820]
        str.w a_1, [r0, #1852]
        str.w a_2, [r0, #1884]
        str.w a_3, [r0, #1916]
        str.w a_4, [r0, #1948]
        str.w a_5, [r0, #1980]
        str.w a_6, [r0, #2012]
        str.w a_7, [r0, #2044]

        ldr.w a_0, [r0, #3868]
        ldr.w a_1, [r0, #3900]
        ldr.w a_2, [r0, #3932]
        ldr.w a_3, [r0, #3964]
        ldr.w a_4, [r0, #3996]
        ldr.w a_5, [r0, #4028]
        ldr.w a_6, [r0, #4060]
        ldr.w a_7, [r0, #4092]

        // level 4
        vmov.w tmp, s3
        montgomery_mul a_4, tmp, lower, a_4, upper, M_inv, M
        montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
        montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_4
        add a_1, a_5
        add a_2, a_6
        add a_3, a_7
        sub.w a_4, a_0, a_4, lsl #1
        sub.w a_5, a_1, a_5, lsl #1
        sub.w a_6, a_2, a_6, lsl #1
        sub.w a_7, a_3, a_7, lsl #1

        // level 5
        vmov.w tmp, s4
        montgomery_mul a_2, tmp, lower, a_2, upper, M_inv, M
        montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
        vmov.w tmp, s5
        montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_2
        add a_1, a_3
        add a_4, a_6
        add a_5, a_7
        sub.w a_2, a_0, a_2, lsl #1
        sub.w a_3, a_1, a_3, lsl #1
        sub.w a_6, a_4, a_6, lsl #1
        sub.w a_7, a_5, a_7, lsl #1

        // level 6
        vmov.w tmp, s6
        montgomery_mul a_1, tmp, lower, a_1, upper, M_inv, M
        vmov.w tmp, s7
        montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
        vmov.w tmp, s8
        montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
        vmov.w tmp, s9
        montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

        add a_0, a_1
        add a_2, a_3
        add a_4, a_5
        add a_6, a_7
        sub.w a_3, a_2, a_3, lsl #1
        sub.w a_1, a_0, a_1, lsl #1
        sub.w a_5, a_4, a_5, lsl #1
        sub.w a_7, a_6, a_7, lsl #1

        // save
        str.w a_0, [r0, #3868]
        str.w a_1, [r0, #3900]
        str.w a_2, [r0, #3932]
        str.w a_3, [r0, #3964]
        str.w a_4, [r0, #3996]
        str.w a_5, [r0, #4028]
        str.w a_6, [r0, #4060]
        str.w a_7, [r0, #4092]

        add.w r0, #4
        vmov.w r4, tmp_inner_counter
        cmp.w r4, r0
        bne.w normal_4_5_6_inner

    add.w r0, #224
    vmov.w r4, tmp_outer_counter
    cmp.w r4, r0
    bne.w normal_4_5_6_outer

sub.w r0, #2244

.align 2
_7_8_9:

add.w r4, r0, #2048 // set counter
vmov.w s14, r4

level_7_8_9_loop:
    vmov.w tmp, s15
    vldm.w tmp!, {s7-s13}
    vmov.w s15, tmp

    ldr.w a_0, [r0, #-32]
    ldr.w a_1, [r0, #-28]
    ldr.w a_2, [r0, #-24]
    ldr.w a_3, [r0, #-20]
    ldr.w a_4, [r0, #-16]
    ldr.w a_5, [r0, #-12]
    ldr.w a_6, [r0, #-8]
    ldr.w a_7, [r0, #-4]

    vmov.w tmp, s7
    montgomery_mul a_4, tmp, lower, a_4, upper, M_inv, M
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_4
    add a_1, a_5
    add a_2, a_6
    add a_3, a_7
    sub.w a_4, a_0, a_4, lsl #1
    sub.w a_5, a_1, a_5, lsl #1
    sub.w a_6, a_2, a_6, lsl #1
    sub.w a_7, a_3, a_7, lsl #1

    vmov.w tmp, s8
    montgomery_mul a_2, tmp, lower, a_2, upper, M_inv, M
    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
    vmov.w tmp, s9
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_2
    add a_1, a_3
    add a_4, a_6
    add a_5, a_7
    sub.w a_2, a_0, a_2, lsl #1
    sub.w a_3, a_1, a_3, lsl #1
    sub.w a_6, a_4, a_6, lsl #1
    sub.w a_7, a_5, a_7, lsl #1

    vmov.w tmp, s10
    montgomery_mul a_1, tmp, lower, a_1, upper, M_inv, M
    vmov.w tmp, s11
    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
    vmov.w tmp, s12
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
    vmov.w tmp, s13
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_1
    add a_2, a_3
    add a_4, a_5
    add a_6, a_7
    sub.w a_1, a_0, a_1, lsl #1
    sub.w a_3, a_2, a_3, lsl #1
    sub.w a_5, a_4, a_5, lsl #1
    sub.w a_7, a_6, a_7, lsl #1

    str.w a_0, [r0, #-32]
    str.w a_1, [r0, #-28]
    str.w a_2, [r0, #-24]
    str.w a_3, [r0, #-20]
    str.w a_4, [r0, #-16]
    str.w a_5, [r0, #-12]
    str.w a_6, [r0, #-8]
    str.w a_7, [r0, #-4]

    ldr.w a_0, [r0, #2016]
    ldr.w a_1, [r0, #2020]
    ldr.w a_2, [r0, #2024]
    ldr.w a_3, [r0, #2028]
    ldr.w a_4, [r0, #2032]
    ldr.w a_5, [r0, #2036]
    ldr.w a_6, [r0, #2040]
    ldr.w a_7, [r0, #2044]

    vmov.w tmp, s7
    montgomery_mul a_4, tmp, lower, a_4, upper, M_inv, M
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_4
    add a_1, a_5
    add a_2, a_6
    add a_3, a_7
    sub.w a_4, a_0, a_4, lsl #1
    sub.w a_5, a_1, a_5, lsl #1
    sub.w a_6, a_2, a_6, lsl #1
    sub.w a_7, a_3, a_7, lsl #1

    vmov.w tmp, s8
    montgomery_mul a_2, tmp, lower, a_2, upper, M_inv, M
    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
    vmov.w tmp, s9
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_2
    add a_1, a_3
    add a_4, a_6
    add a_5, a_7
    sub.w a_2, a_0, a_2, lsl #1
    sub.w a_3, a_1, a_3, lsl #1
    sub.w a_6, a_4, a_6, lsl #1
    sub.w a_7, a_5, a_7, lsl #1

    vmov.w tmp, s10
    montgomery_mul a_1, tmp, lower, a_1, upper, M_inv, M
    vmov.w tmp, s11
    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
    vmov.w tmp, s12
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
    vmov.w tmp, s13
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_1
    add a_2, a_3
    add a_4, a_5
    add a_6, a_7
    sub.w a_1, a_0, a_1, lsl #1
    sub.w a_3, a_2, a_3, lsl #1
    sub.w a_5, a_4, a_5, lsl #1
    sub.w a_7, a_6, a_7, lsl #1

    str.w a_0, [r0, #2016]
    str.w a_1, [r0, #2020]
    str.w a_2, [r0, #2024]
    str.w a_3, [r0, #2028]
    str.w a_4, [r0, #2032]
    str.w a_5, [r0, #2036]
    str.w a_6, [r0, #2040]
    str.w a_7, [r0, #2044]

    ldr.w a_0, [r0, #4064]
    ldr.w a_1, [r0, #4068]
    ldr.w a_2, [r0, #4072]
    ldr.w a_3, [r0, #4076]
    ldr.w a_4, [r0, #4080]
    ldr.w a_5, [r0, #4084]
    ldr.w a_6, [r0, #4088]
    ldr.w a_7, [r0, #4092]

    vmov.w tmp, s7
    montgomery_mul a_4, tmp, lower, a_4, upper, M_inv, M
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_4
    add a_1, a_5
    add a_2, a_6
    add a_3, a_7
    sub.w a_4, a_0, a_4, lsl #1
    sub.w a_5, a_1, a_5, lsl #1
    sub.w a_6, a_2, a_6, lsl #1
    sub.w a_7, a_3, a_7, lsl #1

    vmov.w tmp, s8
    montgomery_mul a_2, tmp, lower, a_2, upper, M_inv, M
    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
    vmov.w tmp, s9
    montgomery_mul a_6, tmp, lower, a_6, upper, M_inv, M
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_2
    add a_1, a_3
    add a_4, a_6
    add a_5, a_7
    sub.w a_2, a_0, a_2, lsl #1
    sub.w a_3, a_1, a_3, lsl #1
    sub.w a_6, a_4, a_6, lsl #1
    sub.w a_7, a_5, a_7, lsl #1

    vmov.w tmp, s10
    montgomery_mul a_1, tmp, lower, a_1, upper, M_inv, M
    vmov.w tmp, s11
    montgomery_mul a_3, tmp, lower, a_3, upper, M_inv, M
    vmov.w tmp, s12
    montgomery_mul a_5, tmp, lower, a_5, upper, M_inv, M
    vmov.w tmp, s13
    montgomery_mul a_7, tmp, lower, a_7, upper, M_inv, M

    add a_0, a_1
    add a_2, a_3
    add a_4, a_5
    add a_6, a_7
    sub.w a_1, a_0, a_1, lsl #1
    sub.w a_3, a_2, a_3, lsl #1
    sub.w a_5, a_4, a_5, lsl #1
    sub.w a_7, a_6, a_7, lsl #1

    str.w a_0, [r0, #4064]
    str.w a_1, [r0, #4068]
    str.w a_2, [r0, #4072]
    str.w a_3, [r0, #4076]
    str.w a_4, [r0, #4080]
    str.w a_5, [r0, #4084]
    str.w a_6, [r0, #4088]
    str.w a_7, [r0, #4092]

    add.w r0, #32
    vmov.w tmp, s14
    cmp.w tmp, r0
    bne.w level_7_8_9_loop

pop.w {r4-r12, pc}

