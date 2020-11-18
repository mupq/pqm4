.macro montgomery_mul a, b, lower, upper, tmp, Mprime, M
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \Mprime
    smlal.w \lower, \upper, \tmp, \M
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

final_table:
    .word 3365569 @ MOD
    .word 1682784 @ MOD/2
    .word 1205062335 @ M_inv
    .word 1204317 @ R2inv576

// void final_pack (int load[9*192], short store[821]);
.global final_pack
.type final_pack, %function
final_pack:
    push.w {r4-r12, lr}

    load_ptr      .req r0
    store_ptr     .req r1
    M             .req r4
    M_inv         .req r12
    M_half        .req r5
    R2inv576      .req r14
    lower         .req r9
    tmp           .req r8
    a_0           .req r2
    a_1           .req r3
    a_2           .req r6
    a_3           .req r7
    a_p           .req r8
    a_p_plus_1    .req r9
    a_p_plus_2    .req r10
    a_p_plus_3    .req r11
    counter       .req r7

    adr.w lr, final_table
    ldm.w lr, {M, M_half, M_inv, R2inv576}

    // set counter
    add.w counter, load_ptr, #3280
    vmov.w s7, counter

    final_pack_loop:

        ldr.w a_p, [load_ptr, #3284]
        ldr.w a_p_plus_1, [load_ptr, #3288]
        ldr.w a_p_plus_2, [load_ptr, #3292]
        ldr.w a_p_plus_3, [load_ptr, #3296]
        ldr.w a_1, [load_ptr, #4]
        ldr.w a_2, [load_ptr, #8]
        ldr.w a_3, [load_ptr, #12]
        ldr.w a_0, [load_ptr], #16

        add a_0, a_p
        add a_1, a_p_plus_1
        add a_2, a_p_plus_2
        add a_3, a_p_plus_3

        montgomery_mul a_0, R2inv576, lower, a_0, tmp, M_inv, M
        montgomery_mul a_1, R2inv576, lower, a_1, tmp, M_inv, M
        montgomery_mul a_2, R2inv576, lower, a_2, tmp, M_inv, M
        montgomery_mul a_3, R2inv576, lower, a_3, tmp, M_inv, M
        central_reduce a_0, M_half, M
        central_reduce a_1, M_half, M
        central_reduce a_2, M_half, M
        central_reduce a_3, M_half, M

        pkhbt.w a_0, a_0, a_1, lsl #16
        pkhbt.w a_2, a_2, a_3, lsl #16
        and a_0, 0x0fff0fff
        and a_2, 0x0fff0fff

        str.w a_2, [store_ptr, #4]
        str.w a_0, [store_ptr], #8


        ldr.w a_p, [load_ptr, #3284]
        ldr.w a_p_plus_1, [load_ptr, #3288]
        ldr.w a_p_plus_2, [load_ptr, #3292]
        ldr.w a_p_plus_3, [load_ptr, #3296]
        ldr.w a_1, [load_ptr, #4]
        ldr.w a_2, [load_ptr, #8]
        ldr.w a_3, [load_ptr, #12]
        ldr.w a_0, [load_ptr], #16

        add a_0, a_p
        add a_1, a_p_plus_1
        add a_2, a_p_plus_2
        add a_3, a_p_plus_3

        montgomery_mul a_0, R2inv576, lower, a_0, tmp, M_inv, M
        montgomery_mul a_1, R2inv576, lower, a_1, tmp, M_inv, M
        montgomery_mul a_2, R2inv576, lower, a_2, tmp, M_inv, M
        montgomery_mul a_3, R2inv576, lower, a_3, tmp, M_inv, M
        central_reduce a_0, M_half, M
        central_reduce a_1, M_half, M
        central_reduce a_2, M_half, M
        central_reduce a_3, M_half, M

        pkhbt.w a_0, a_0, a_1, lsl #16
        pkhbt.w a_2, a_2, a_3, lsl #16
        and a_0, 0x0fff0fff
        and a_2, 0x0fff0fff

        str.w a_2, [store_ptr, #4]
        str.w a_0, [store_ptr], #8


        ldr.w a_p, [load_ptr, #3284]
        ldr.w a_p_plus_1, [load_ptr, #3288]
        ldr.w a_p_plus_2, [load_ptr, #3292]
        ldr.w a_p_plus_3, [load_ptr, #3296]
        ldr.w a_1, [load_ptr, #4]
        ldr.w a_2, [load_ptr, #8]
        ldr.w a_3, [load_ptr, #12]
        ldr.w a_0, [load_ptr], #16

        add a_0, a_p
        add a_1, a_p_plus_1
        add a_2, a_p_plus_2
        add a_3, a_p_plus_3

        montgomery_mul a_0, R2inv576, lower, a_0, tmp, M_inv, M
        montgomery_mul a_1, R2inv576, lower, a_1, tmp, M_inv, M
        montgomery_mul a_2, R2inv576, lower, a_2, tmp, M_inv, M
        montgomery_mul a_3, R2inv576, lower, a_3, tmp, M_inv, M
        central_reduce a_0, M_half, M
        central_reduce a_1, M_half, M
        central_reduce a_2, M_half, M
        central_reduce a_3, M_half, M

        pkhbt.w a_0, a_0, a_1, lsl #16
        pkhbt.w a_2, a_2, a_3, lsl #16
        and a_0, 0x0fff0fff
        and a_2, 0x0fff0fff

        str.w a_2, [store_ptr, #4]
        str.w a_0, [store_ptr], #8


        ldr.w a_p, [load_ptr, #3284]
        ldr.w a_p_plus_1, [load_ptr, #3288]
        ldr.w a_p_plus_2, [load_ptr, #3292]
        ldr.w a_p_plus_3, [load_ptr, #3296]
        ldr.w a_1, [load_ptr, #4]
        ldr.w a_2, [load_ptr, #8]
        ldr.w a_3, [load_ptr, #12]
        ldr.w a_0, [load_ptr], #16

        add a_0, a_p
        add a_1, a_p_plus_1
        add a_2, a_p_plus_2
        add a_3, a_p_plus_3

        montgomery_mul a_0, R2inv576, lower, a_0, tmp, M_inv, M
        montgomery_mul a_1, R2inv576, lower, a_1, tmp, M_inv, M
        montgomery_mul a_2, R2inv576, lower, a_2, tmp, M_inv, M
        montgomery_mul a_3, R2inv576, lower, a_3, tmp, M_inv, M
        central_reduce a_0, M_half, M
        central_reduce a_1, M_half, M
        central_reduce a_2, M_half, M
        central_reduce a_3, M_half, M

        pkhbt.w a_0, a_0, a_1, lsl #16
        pkhbt.w a_2, a_2, a_3, lsl #16
        and a_0, 0x0fff0fff
        and a_2, 0x0fff0fff

        str.w a_2, [store_ptr, #4]
        str.w a_0, [store_ptr], #8


        ldr.w a_p, [load_ptr, #3284]
        ldr.w a_p_plus_1, [load_ptr, #3288]
        ldr.w a_p_plus_2, [load_ptr, #3292]
        ldr.w a_p_plus_3, [load_ptr, #3296]
        ldr.w a_1, [load_ptr, #4]
        ldr.w a_2, [load_ptr, #8]
        ldr.w a_3, [load_ptr, #12]
        ldr.w a_0, [load_ptr], #16

        add a_0, a_p
        add a_1, a_p_plus_1
        add a_2, a_p_plus_2
        add a_3, a_p_plus_3

        montgomery_mul a_0, R2inv576, lower, a_0, tmp, M_inv, M
        montgomery_mul a_1, R2inv576, lower, a_1, tmp, M_inv, M
        montgomery_mul a_2, R2inv576, lower, a_2, tmp, M_inv, M
        montgomery_mul a_3, R2inv576, lower, a_3, tmp, M_inv, M
        central_reduce a_0, M_half, M
        central_reduce a_1, M_half, M
        central_reduce a_2, M_half, M
        central_reduce a_3, M_half, M

        pkhbt.w a_0, a_0, a_1, lsl #16
        pkhbt.w a_2, a_2, a_3, lsl #16
        and a_0, 0x0fff0fff
        and a_2, 0x0fff0fff

        str.w a_2, [store_ptr, #4]
        str.w a_0, [store_ptr], #8



        vmov.w counter, s7
        cmp.w counter, load_ptr
        bne.w final_pack_loop

        ldr.w a_0, [load_ptr]

        montgomery_mul a_0, R2inv576, lower, a_0, tmp, M_inv, M
        central_reduce a_0, M_half, M
        and.w a_0, 0x0fff0fff

        strh.w a_0, [store_ptr]

    pop.w {r4-r12, pc}

