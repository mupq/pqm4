.syntax unified
.cpu cortex-m4
.thumb
#include "asm_params.h"

.macro multiply_P1t_right_m4f_asm nrows, ncols, cols
    .set m_vec_limbs, ((M + 15)/16)
    // cols=O
    // MAYO1: 8, MAYO2: 17, MAYO3: 10
    .if \cols != 8 && \cols != 17 && \cols != 10
    error
    .endif
    word0 .req r10
    word1 .req r11
    .set col_size, ((\cols+7)/8)


    aaa0 .req r4
    aaa1 .req r5
    idx0 .req r6
    idx1 .req r7
    bbb0 .req r8
    bbb1 .req r9
    bbb2 .req r12

    .if \cols == 10
    push.w {r4-r11,r14}
    aaa2 .req r14
    .elseif \cols == 17
    push.w {r4-r11,r14}
    aaa2 .req r7
    .else
    push.w {r4-r11}
    aaa2 .req r7
    .endif

    .if \cols == 17
    mov.w r14, #12
    .endif

    vmov.w s0, r3

    mov.w r12, m_vec_limbs*8
    mul.w r3, r3, r12

    .rept (M+7)/8
    ldr.w word0, [r2], #4
    .set i, 0
    .rept 8
    ubfx.w idx0, word0, #4*i, #4

    .if \cols == 8
    ldr.w aaa0, [r0]
    ldr.w bbb0, [r1, idx0, lsl#2]
    eor.w aaa0, bbb0
    str.w aaa0, [r0], #4
    .endif

    .if \cols ==17
    mla.w idx0, idx0, r14, r1
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w aaa2, [r0, #8]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    ldr.w bbb2, [idx0, #8]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    eor.w aaa2, bbb2
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    str.w aaa2, [r0], #4
    .endif


    .if \cols == 10
    add.w idx0, r1, idx0, lsl#3
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    .endif

    .set i, i+1
    .endr
    .endr

    cmp.w r3, #0
    beq.w 2f


    1:

    .rept (M+7)/8
    ldr.w word1, [r2, r3]
    ldr.w word0, [r2], #4

    .set i, 0
    .rept 8

    ubfx.w idx0, word0, #4*i, #4
    bfi.w idx0, word1, #4, #4
    ror.w word1, word1, #4

    .if \cols == 8
    ldr.w aaa0, [r0]
    ldr.w bbb0, [r1, idx0, lsl#2]
    eor.w aaa0, bbb0
    str.w aaa0, [r0], #4
    .endif

    .if \cols == 17
    mla.w idx0, idx0, r14, r1
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w aaa2, [r0, #8]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    ldr.w bbb2, [idx0, #8]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    eor.w aaa2, bbb2
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    str.w aaa2, [r0], #4
    .endif

    .if \cols == 10
    add.w idx0, r1, idx0, lsl#3
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    .endif

    .set i, i+1
    .endr
    .endr

    vmov.w r12, s0
    subs.w r12, #1
    vmov.w s0, r12
    bne.w 1b

    2:

    .if \cols == 10 || \cols == 17
    pop.w {r4-r11, pc}
    .else
    pop.w {r4-r11}
    bx lr
    .endif

    .unreq word0
    .unreq word1
    .unreq aaa0
    .unreq aaa1
    .unreq idx0
    .unreq idx1
    .unreq bbb0
    .unreq bbb1
    .unreq bbb2
    .unreq aaa2

.endm


.macro multiply_P1t_right_m4f_first_asm nrows, ncols, cols
    word0 .req r3
    .set col_size, ((\cols+7)/8)

    aaa0 .req r4
    aaa1 .req r5
    idx0 .req r6
    idx1 .req r7
    bbb0 .req r8
    bbb1 .req r9

    push.w {r4-r9}
    
    mov.w r12, \nrows

    1:

    .rept (M+7)/8
    ldr.w word0, [r2], #4
    .set i, 0
    .rept 8
    ubfx.w idx0, word0, #4*i, #4
    lsl.w idx0, #4

    add.w idx0, r1, idx0, lsl#3
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4

    .set i,i+1
    .endr
    .endr
    
    subs.w r12, #1
    bne.w 1b


        
    
    pop.w {r4-r9}
    bx lr

    .unreq word0
    .unreq aaa0
    .unreq aaa1
    .unreq idx0
    .unreq idx1
    .unreq bbb0
    .unreq bbb1

.endm

.macro multiply_P1_right_m4f_asm nrows, ncols, cols
    .set m_vec_limbs, ((M + 15)/16)
    // cols = K or O
    // O: MAYO1: 8,  MAYO2: 17, MAYO3: 10
    // K: MAYO1: 10, MAYO2: 4, MAYO3: 11
    .if \cols != 8 && \cols != 17 && \cols != 10 && \cols != 4 && \cols != 11
    error
    .endif
    word0 .req r3
    word1 .req r10



    aaa0 .req r4
    aaa1 .req r5
    idx0 .req r6
    idx1 .req r7
    bbb0 .req r8
    bbb1 .req r9
    bbb2 .req r12
    .if \cols == 10 || \cols == 11
    push.w {r4-r11,r14}
    aaa2 .req r14
    .elseif \cols == 17
    push.w {r4-r11,r14}
    aaa2 .req r7
    .else
    push.w {r4-r10}
    aaa2 .req r7
    .endif

    .if \cols == 17
    mov.w r14, #12
    .endif


    cmp.w r3, #0
    beq.w 2f

    vmov.w s0, r3

    mov.w r4, m_vec_limbs*8*(\ncols-2)
    vmov.w s1, r4

    1:
    .rept (M+7)/8

    ldr.w word1, [r2, m_vec_limbs*8]
    ldr.w word0, [r2], #4

    .set i, 0
    .rept 8
    ubfx.w idx0, word0, #4*i, #4
    bfi.w idx0, word1, #4, #4
    ror.w word1, word1, #4

 
    .if \cols == 8 || \cols == 4
    ldr.w aaa0, [r0]
    ldr.w bbb0, [r1, idx0, lsl#2]
    eor.w aaa0, bbb0
    str.w aaa0, [r0], #4
    .endif

    .if \cols == 17
    mla.w idx0, idx0, r14, r1

    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w aaa2, [r0, #8]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    ldr.w bbb2, [idx0, #8]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    eor.w aaa2, bbb2
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    str.w aaa2, [r0], #4
    .endif

    .if \cols == 10 || \cols == 11
    add.w idx0, r1, idx0, lsl#3
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    .endif
    .set i, i+1
    .endr
    .endr

    vmov.w r10, s1
    add.w r2, r10
    sub.w r10, m_vec_limbs*8
    vmov.w s1, r10

    vmov.w r10, s0
    subs.w r10, #1
    vmov.w s0, r10
    bne.w 1b

    2:

    add.w r2, m_vec_limbs*8

    .rept (M+7)/8
    ldr.w word0, [r2], #4
    .set i, 0
    .rept 8
    ubfx.w idx0, word0, #4*i, #4
    lsl.w idx0, #4

    .if \cols == 8 || \cols == 4
    ldr.w aaa0, [r0]
    ldr.w bbb0, [r1, idx0, lsl#2]
    eor.w aaa0, bbb0
    str.w aaa0, [r0], #4
    .endif

    .if \cols == 17
    mla.w idx0, idx0, r14, r1
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w aaa2, [r0, #8]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    ldr.w bbb2, [idx0, #8]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    eor.w aaa2, bbb2
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    str.w aaa2, [r0], #4
    .endif

    .if \cols == 10 || \cols == 11
    add.w idx0, r1, idx0, lsl#3
    ldr.w aaa0, [r0]
    ldr.w aaa1, [r0, #4]
    ldr.w bbb0, [idx0]
    ldr.w bbb1, [idx0, #4]
    eor.w aaa0, bbb0
    eor.w aaa1, bbb1
    str.w aaa0, [r0], #4
    str.w aaa1, [r0], #4
    .endif
    .set i, i+1
    .endr
    .endr



    .if \cols == 10 || \cols == 17 || \cols == 11
    pop.w {r4-r11, pc}
    .else
    pop.w {r4-r10}
    bx lr
    .endif

    .unreq word0
    .unreq word1
    .unreq aaa0
    .unreq aaa1
    .unreq idx0
    .unreq idx1
    .unreq bbb0
    .unreq bbb1
    .unreq bbb2
    .unreq aaa2

.endm

.global multiply_P1_right_m4f_V_V_O_asm
.type multiply_P1_right_m4f_V_V_O_asm, %function
.align 2
multiply_P1_right_m4f_V_V_O_asm:
    multiply_P1_right_m4f_asm V, V, O


.global multiply_P1_right_m4f_V_V_K_asm
.type multiply_P1_right_m4f_V_V_K_asm, %function
.align 2
multiply_P1_right_m4f_V_V_K_asm:
    multiply_P1_right_m4f_asm V, V, K


.global multiply_P1t_right_m4f_V_V_O_asm
.type multiply_P1t_right_m4f_V_V_O_asm, %function
.align 2
multiply_P1t_right_m4f_V_V_O_asm:
    multiply_P1t_right_m4f_asm V, V, O

.global multiply_P1t_right_m4f_first_V_V_O_asm
.type multiply_P1t_right_m4f_first_V_V_O_asm, %function
.align 2
multiply_P1t_right_m4f_first_V_V_O_asm:
    multiply_P1t_right_m4f_first_asm V, V, O


@ // multiply nibbles by x mod x^4 + x + 1
@ static inline uint64_t mul_by_x(uint64_t a){
@     static const uint64_t mask = 0x8888888888888888;
@     uint64_t temp = a & mask;
@     return (a << 1) ^ (temp >> 3) ^ (temp >> 2) ^ (temp << 1);
@ }


.macro mulx in, tmp
    and.w \tmp, \in, 0x88888888
    lsl.w \in, \in, #1
    eor.w \in, \in, \tmp, lsr#3
    eor.w \in, \in, \tmp, lsr#2
    eor.w \in, \in, \tmp, lsl#1
.endm



.global multiply_P1_right_m4f_O_asm2
.type multiply_P1_right_m4f_O_asm2, %function
.align 2
multiply_P1_right_m4f_O_asm2:
    push.w {r4-r7}
    .set o_size, ((O+7)/8)

    .rept o_size
        .set t, 0
        // contains only 4 elements need to pack it 
        ldr.w r5, [r1]
        ldr.w r6, [r1, #4]
        and.w r4, r5, #0xF
        ubfx.w r7, r5, #8, #4
        eor.w r4, r4, r7, lsl#4
        ubfx.w r7, r5, #16, #4
        eor.w r4, r4, r7, lsl#8
        ubfx.w r7, r5, #24, #4
        eor.w r4, r4, r7, lsl#12
        and.w r7, r6, #0xF
        eor.w r4, r4, r7, lsl#16
        ubfx.w r7, r6, #8, #4
        eor.w r4, r4, r7, lsl#20
        ubfx.w r7, r6, #16, #4
        eor.w r4, r4, r7, lsl#24
        ubfx.w r7, r6, #24, #4
        eor.w r4, r4, r7, lsl#28


        .rept 4
            .if t > 0
            mulx r4, r5
            .endif
            .rept (1<<t)
                ldr.w r5, [r0], #4*o_size
                eor.w r5, r4
                str.w r5, [r0, (1<<t)*4*o_size - 4*o_size]
            .endr

            sub.w r0, (1<<t)*4*o_size
            .set t,t+1
        .endr

        1:


        .set t, 4
        ldr.w r5, [r1, O]
        ldr.w r6, [r1, O+4]
        and.w r4, r5, #0xF
        ubfx.w r7, r5, #8, #4
        eor.w r4, r4, r7, lsl#4
        ubfx.w r7, r5, #16, #4
        eor.w r4, r4, r7, lsl#8
        ubfx.w r7, r5, #24, #4
        eor.w r4, r4, r7, lsl#12
        and.w r7, r6, #0xF
        eor.w r4, r4, r7, lsl#16
        ubfx.w r7, r6, #8, #4
        eor.w r4, r4, r7, lsl#20
        ubfx.w r7, r6, #16, #4
        eor.w r4, r4, r7, lsl#24
        ubfx.w r7, r6, #24, #4
        eor.w r4, r4, r7, lsl#28

        .rept 4
            .if t > 4
            mulx r4, r5
            .endif
            .rept (1<<t)/4
                ldr.w r6, [r0,#1*4*o_size]
                ldr.w r7, [r0,#2*4*o_size]
                ldr.w r12, [r0,#3*4*o_size]
                ldr.w r5, [r0], #4*4*o_size
                eor.w r5, r4
                eor.w r6, r4
                eor.w r7, r4
                eor.w r12, r4
                str.w r5, [r0, (1<<t)*4*o_size - 4*4*o_size]
                str.w r6, [r0, (1<<t)*4*o_size - 3*4*o_size]
                str.w r7, [r0, (1<<t)*4*o_size - 2*4*o_size]
                str.w r12, [r0, (1<<t)*4*o_size - 1*4*o_size]
            .endr

            sub.w r0, (1<<t)*4*o_size
            .set t,t+1
        .endr

        add.w r1, #8
        add.w r0, #4
    .endr

    pop.w {r4-r7}
    bx lr


.global multiply_P1_right_m4f_K_asm2_transposed
.type multiply_P1_right_m4f_K_asm2_transposed, %function
.align 2
multiply_P1_right_m4f_K_asm2_transposed:
   push.w {r4-r11}
    // K: MAYO1: 10, MAYO2: 4, MAYO3: 11
    .set o_size, ((K+7)/8)


    .rept o_size-1
        ldrb.w r4,  [r1, V*0]
        ldrb.w r5,  [r1, V*1]
        ldrb.w r6,  [r1, V*2]
        ldrb.w r7,  [r1, V*3]
        ldrb.w r8,  [r1, V*4]
        ldrb.w r9,  [r1, V*5]
        ldrb.w r10, [r1, V*6]
        ldrb.w r11, [r1, V*7]

        eor.w r4, r4, r5, lsl 1*4
        eor.w r4, r4, r6, lsl 2*4
        eor.w r4, r4, r7, lsl 3*4
        eor.w r4, r4, r8, lsl 4*4
        eor.w r4, r4, r9, lsl 5*4
        eor.w r4, r4, r10, lsl 6*4
        eor.w r4, r4, r11, lsl 7*4

    .set t, 0
    .rept 4
        .if t > 0
        mulx r4, r5
        .endif
        .rept (1<<t)
            ldr.w r5, [r0], #4*o_size
            eor.w r5, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*o_size]
        .endr
        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr


    ldrb.w r4,  [r1, V*0+1]
    ldrb.w r5,  [r1, V*1+1]
    ldrb.w r6,  [r1, V*2+1]
    ldrb.w r7,  [r1, V*3+1]
    ldrb.w r8,  [r1, V*4+1]
    ldrb.w r9,  [r1, V*5+1]
    ldrb.w r10, [r1, V*6+1]
    ldrb.w r11, [r1, V*7+1]

    eor.w r4, r4, r5, lsl 1*4
    eor.w r4, r4, r6, lsl 2*4
    eor.w r4, r4, r7, lsl 3*4
    eor.w r4, r4, r8, lsl 4*4
    eor.w r4, r4, r9, lsl 5*4
    eor.w r4, r4, r10, lsl 6*4
    eor.w r4, r4, r11, lsl 7*4

    .set t, 4
    .rept 4
        .if t > 4
        mulx r4, r5
        .endif
        .rept (1<<t)/4
            ldr.w r6, [r0,#1*4*o_size]
            ldr.w r7, [r0,#2*4*o_size]
            ldr.w r12, [r0,#3*4*o_size]
            ldr.w r5, [r0], #4*4*o_size
            eor.w r5, r4
            eor.w r6, r4
            eor.w r7, r4
            eor.w r12, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*4*o_size]
            str.w r6, [r0, (1<<t)*4*o_size - 3*4*o_size]
            str.w r7, [r0, (1<<t)*4*o_size - 2*4*o_size]
            str.w r12, [r0, (1<<t)*4*o_size - 1*4*o_size]
        .endr

        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr

    add.w r0, #4
    add.w r1, 8*V

    .endr

    .if K != 4 && K != 11 && K != 10
        error
    .endif
    .if K == 4
    // last element
    ldrb.w r4, [r1]
    ldrb.w r5, [r1, 1*V]
    ldrb.w r6, [r1, 2*V]
    ldrb.w r7, [r1, 3*V]

    eor.w r4, r4, r5, lsl 1*4
    eor.w r4, r4, r6, lsl 2*4
    eor.w r4, r4, r7, lsl 3*4

    .set t, 0
    .rept 4
        .if t > 0
        mulx r4, r5
        .endif
        .rept (1<<t)
            ldr.w r5, [r0], #4*o_size
            eor.w r5, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*o_size]
        .endr
        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr

    ldrb.w r4, [r1, #1]
    ldrb.w r5, [r1, V+1]
    ldrb.w r6, [r1, 2*V+1]
    ldrb.w r7, [r1, 3*V+1]

    eor.w r4, r4, r5, lsl 1*4
    eor.w r4, r4, r6, lsl 2*4
    eor.w r4, r4, r7, lsl 3*4

    .set t, 4
    .rept 4
        .if t > 4
        mulx r4, r5
        .endif
        .rept (1<<t)/4
            ldr.w r6, [r0,#1*4*o_size]
            ldr.w r7, [r0,#2*4*o_size]
            ldr.w r12, [r0,#3*4*o_size]
            ldr.w r5, [r0], #4*4*o_size
            eor.w r5, r4
            eor.w r6, r4
            eor.w r7, r4
            eor.w r12, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*4*o_size]
            str.w r6, [r0, (1<<t)*4*o_size - 3*4*o_size]
            str.w r7, [r0, (1<<t)*4*o_size - 2*4*o_size]
            str.w r12, [r0, (1<<t)*4*o_size - 1*4*o_size]
        .endr

        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr
    .endif


    .if K == 10
    // last elements
    ldrb.w r4, [r1]
    ldrb.w r5, [r1, 1*V]

    eor.w r4, r4, r5, lsl 1*4


    .set t, 0
    .rept 4
        .if t > 0
        mulx r4, r5
        .endif
        .rept (1<<t)
            ldr.w r5, [r0], #4*o_size
            eor.w r5, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*o_size]
        .endr
        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr

    ldrb.w r4, [r1, #1]
    ldrb.w r5, [r1, V+1]

    eor.w r4, r4, r5, lsl 1*4
    .set t, 4
    .rept 4
        .if t > 4
        mulx r4, r5
        .endif
        .rept (1<<t)/4
            ldr.w r6, [r0,#1*4*o_size]
            ldr.w r7, [r0,#2*4*o_size]
            ldr.w r12, [r0,#3*4*o_size]
            ldr.w r5, [r0], #4*4*o_size
            eor.w r5, r4
            eor.w r6, r4
            eor.w r7, r4
            eor.w r12, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*4*o_size]
            str.w r6, [r0, (1<<t)*4*o_size - 3*4*o_size]
            str.w r7, [r0, (1<<t)*4*o_size - 2*4*o_size]
            str.w r12, [r0, (1<<t)*4*o_size - 1*4*o_size]
        .endr

        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr
    .endif

    .if K == 11
    // last elements
    ldrb.w r4, [r1]
    ldrb.w r5, [r1, 1*V]
    ldrb.w r6, [r1, 2*V]

    eor.w r4, r4, r5, lsl 1*4
    eor.w r4, r4, r6, lsl 2*4


    .set t, 0
    .rept 4
        .if t > 0
        mulx r4, r5
        .endif
        .rept (1<<t)
            ldr.w r5, [r0], #4*o_size
            eor.w r5, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*o_size]
        .endr
        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr

    ldrb.w r4, [r1, #1]
    ldrb.w r5, [r1, V+1]
    ldrb.w r6, [r1, 2*V+1]

    eor.w r4, r4, r5, lsl 1*4
    eor.w r4, r4, r6, lsl 2*4

    .set t, 4
    .rept 4
        .if t > 4
        mulx r4, r5
        .endif
        .rept (1<<t)/4
            ldr.w r6, [r0,#1*4*o_size]
            ldr.w r7, [r0,#2*4*o_size]
            ldr.w r12, [r0,#3*4*o_size]
            ldr.w r5, [r0], #4*4*o_size
            eor.w r5, r4
            eor.w r6, r4
            eor.w r7, r4
            eor.w r12, r4
            str.w r5, [r0, (1<<t)*4*o_size - 4*4*o_size]
            str.w r6, [r0, (1<<t)*4*o_size - 3*4*o_size]
            str.w r7, [r0, (1<<t)*4*o_size - 2*4*o_size]
            str.w r12, [r0, (1<<t)*4*o_size - 1*4*o_size]
        .endr

        sub.w r0, (1<<t)*4*o_size
        .set t,t+1
    .endr
    .endif

    pop.w {r4-r11}
    bx lr