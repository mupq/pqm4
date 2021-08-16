.syntax unified
.cpu cortex-m4
.thumb

#include "bitslice.inc"
#include "madd_bitsliced.inc"

//extern void gf16mat_prod_16_32_normal_normal_asm(uint32_t *c, uint32_t *a, uint32_t *b);
.global gf16mat_prod_18_32_normal_normal_asm
.type gf16mat_prod_18_32_normal_normal_asm, %function
.align 2
gf16mat_prod_18_32_normal_normal_asm:
    push {r4-r11, r14}
    c_ptr .req r0
    a_ptr .req r1
    b_ptr .req r2
    mat0    .req r0
    mat1    .req r2
    mat2    .req r10
    mat3    .req r12
    b_32     .req r5
    tmp0    .req r6
    tmp1    .req r7
    tmp2    .req r8
    tmp3    .req r9
    accu0    .req r3
    accu1    .req r11
    accu2    .req r4
    accu3    .req r14

    one      .req s0
    ctr1     .req s1

    push.w {c_ptr}
    push.w {b_ptr}
    mov.w accu0, #0
    mov.w accu1, #0
    mov.w accu2, #0
    mov.w accu3, #0
    vmov one, #0.5
    vmov ctr1, #2
    1:
        pop.w {b_ptr}
        ldr.w b_32, [b_ptr], #4
        push.w {b_ptr}
        .set kk, 0
        .rept 8
            ldr.w tmp1, [a_ptr, #4]
            ldr.w tmp2, [a_ptr, #8]
            ldr.w tmp3, [a_ptr, #12]
            ldr.w tmp0, [a_ptr], #18
            // bitslice on the fly
            bitslice mat0, mat1, mat2, mat3, tmp0, tmp1, tmp2, tmp3
            madd_bitsliced accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, b_32, tmp0, tmp1, tmp2, tmp3
            .if kk != 7
            lsr.w b_32, b_32, #4
            .endif
            .set kk, kk+1
        .endr
    vsub.f32 ctr1, ctr1, one
    vcmp.f32 ctr1, #0.0
    vmrs apsr_nzcv, FPSCR
    bhi.w 1b

    pop.w {b_ptr}
    pop.w {c_ptr}
    // un-bitslice on the fly
    bitslice tmp0, tmp1, tmp2, tmp3, accu0, accu1, accu2, accu3
    str.w tmp0, [c_ptr]
    str.w tmp1, [c_ptr, #4]
    str.w tmp2, [c_ptr, #8]
    str.w tmp3, [c_ptr, #12]

    sub b_ptr, #16
    sub a_ptr, #8*4*18-16
    mov.w accu0, #0
    mov.w accu1, #0
    mov.w accu2, #0
    mov.w accu3, #0
    push.w {c_ptr}
    push.w {b_ptr}

    vmov one, #0.5
    vmov ctr1, #2
    1:
        pop.w {b_ptr}
        ldr.w b_32, [b_ptr], #4
        push.w {b_ptr}
        .set kk, 0
        .rept 8
            ldrh.w tmp0, [a_ptr], #18
            // bitslice on the fly
            bitslice_single mat0, mat1, mat2, mat3, tmp0
            madd_bitsliced accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, b_32, tmp0, tmp1, tmp2, tmp3
            .if kk != 7
            lsr.w b_32, b_32, #4
            .endif
            .set kk, kk+1
        .endr
    vsub.f32 ctr1, ctr1, one
    vcmp.f32 ctr1, #0.0
    vmrs apsr_nzcv, FPSCR
    bhi.w 1b

    pop.w {b_ptr}
    pop.w {c_ptr}
    unbitslice_single tmp0, accu0, accu1, accu2, accu3
    strh.w tmp0, [c_ptr, #16]

    pop.w {r4-r11, pc}