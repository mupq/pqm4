// GF256 multiplication for uint32_t (i.e., 4 elements packed into one register)

// 36 cycles
.macro gf256_madd_precompb fbx0, fbx1, fbx2,fbx3, fbx4, fbx5, fbx6, fbx7, bb, c01010101, pconst, tmp1
    // bx^0
    vmov.w \fbx0, \bb

    // bx^1
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx1, \bb

    // bx^2
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx2, \bb

    // bx^3
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx3, \bb

    // bx^4
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx4, \bb

    // bx^5
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx5, \bb

    // bx^6
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx6, \bb

    // bx^7
    and.w \tmp1, \c01010101, \bb, lsr #7
    eor.w \bb, \bb, \tmp1, lsl #7
    mul.w \tmp1, \tmp1, \pconst
    eor.w \bb, \tmp1, \bb, lsl#1
    vmov.w \fbx7, \bb
.endm


// 13 cc
.macro gf256_madd_inner k, num, acc0, acc1, acc2, acc3, aa0, aa1, aa2, aa3, fbx, c01010101, tmp0, tmp1
    vmov.w \tmp1, \fbx

    and.w \tmp0, \c01010101, \aa0, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc0, \acc0, \tmp0

    .if \num >= 2
    and.w \tmp0, \c01010101, \aa1, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc1, \acc1, \tmp0
    .endif

    .if \num >= 3
    and.w \tmp0, \c01010101, \aa2, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc2, \acc2, \tmp0
    .endif

    .if \num >= 4
    and.w \tmp0, \c01010101, \aa3, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc3, \acc3, \tmp0
    .endif
.endm

// 13*8 = 104 cc
.macro gf256_madd num, acc0, acc1, acc2, acc3, aa0, aa1, aa2, aa3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, c01010101, tmp0, tmp1
    gf256_madd_inner #0, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx0, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #1, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx1, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #2, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx2, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #3, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx3, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #4, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx4, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #5, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx5, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #6, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx6, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #7, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx7, \c01010101, \tmp0, \tmp1
.endm


// 13 cc
.macro gf256_madd_x4_inner k, idx, num, acc0, acc1, acc2, acc3, aa0, aa1, aa2, aa3, fbx, c01010101, tmp0, tmp1
    vmov.w \tmp1, \fbx
    ubfx.w \tmp1, \tmp1, \idx*8, #8

    and.w \tmp0, \c01010101, \aa0, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc0, \acc0, \tmp0

    .if \num >= 2
    and.w \tmp0, \c01010101, \aa1, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc1, \acc1, \tmp0
    .endif

    .if \num >= 3
    and.w \tmp0, \c01010101, \aa2, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc2, \acc2, \tmp0
    .endif

    .if \num >= 4
    and.w \tmp0, \c01010101, \aa3, lsr\k
    mul.w \tmp0, \tmp1, \tmp0
    eor.w \acc3, \acc3, \tmp0
    .endif
.endm

// 13*8 = 104 cc
.macro gf256_madd_x4 num, idx, acc0, acc1, acc2, acc3, aa0, aa1, aa2, aa3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, c01010101, tmp0, tmp1
    gf256_madd_x4_inner #0, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx0, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #1, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx1, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #2, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx2, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #3, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx3, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #4, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx4, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #5, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx5, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #6, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx6, \c01010101, \tmp0, \tmp1
    gf256_madd_x4_inner #7, \idx, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx7, \c01010101, \tmp0, \tmp1
.endm



.macro gf256_mul_inner k, num, acc0, acc1, acc2, acc3, aa0, aa1, aa2, aa3, fbx, c01010101, tmp0, tmp1
    vmov.w \tmp1, \fbx

    and.w \tmp0, \c01010101, \aa0, lsr\k
    mul.w \acc0, \tmp1, \tmp0


    .if \num >= 2
    and.w \tmp0, \c01010101, \aa1, lsr\k
    mul.w \acc1, \tmp1, \tmp0
    .endif

    .if \num >= 3
    and.w \tmp0, \c01010101, \aa2, lsr\k
    mul.w \acc2, \tmp1, \tmp0
    .endif

    .if \num >= 4
    and.w \tmp0, \c01010101, \aa3, lsr\k
    mul.w \acc3, \tmp1, \tmp0
    .endif
.endm


.macro gf256_mul_u32 num, acc0, acc1, acc2, acc3, aa0, aa1, aa2, aa3, fbx0, fbx1, fbx2, fbx3, fbx4, fbx5, fbx6, fbx7, c01010101, tmp0, tmp1
    gf256_mul_inner #0, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx0, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #1, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx1, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #2, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx2, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #3, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx3, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #4, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx4, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #5, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx5, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #6, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx6, \c01010101, \tmp0, \tmp1
    gf256_madd_inner #7, \num, \acc0, \acc1, \acc2, \acc3, \aa0, \aa1, \aa2, \aa3, \fbx7, \c01010101, \tmp0, \tmp1
.endm
