
#ifndef BUTTERFLIES_I
#deifne BUTTERFLIES_I

#include "macros.i"

.macro doublebutterfly_16 tb, a0, a1, twiddle, QQprime, tmp, tmp2
    smulb\tb \tmp, \a1, \twiddle
    smult\tb \a1, \a1, \twiddle
    montgomery_16 \tmp, \QQprime, \tmp2
    montgomery_16 \a1, \QQprime, \tmp2
    pkhtb \tmp, \a1, \tmp, asr #16
    ssub16.w \a1, \a0, \tmp
    sadd16.w \a0, \a0, \tmp
.endm

.macro _3_layer_double_CT_16 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi12, xi34, xi56, twiddle, QQprime, tmp, tmp2
    vmov.w \twiddle, \xi0
    doublebutterfly_16 t, \c0, \c4, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c1, \c5, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c2, \c6, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c3, \c7, \twiddle, \QQprime, \tmp, \tmp2

    vmov.w \twiddle, \xi12
    doublebutterfly_16 b, \c0, \c2, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 b, \c1, \c3, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c4, \c6, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c5, \c7, \twiddle, \QQprime, \tmp, \tmp2

    vmov.w \twiddle, \xi34
    doublebutterfly_16 b, \c0, \c1, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c2, \c3, \twiddle, \QQprime, \tmp, \tmp2
    vmov.w \twiddle, \xi56
    doublebutterfly_16 b, \c4, \c5, \twiddle, \QQprime, \tmp, \tmp2
    doublebutterfly_16 t, \c6, \c7, \twiddle, \QQprime, \tmp, \tmp2
.endm

.macro _3_layer_CT_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul_32 \c4, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi1
    montgomery_mul_32 \c2, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    vmov.w \twiddle, \xi3
    montgomery_mul_32 \c1, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

.macro _3_layer_CT_light_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

// 26
.macro _3_layer_CT_light_1111_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \tmp0, \tmp1, \xi5, \xi6

    smull \c4, \c5, \c1, \tmp0
    smlal \c4, \c5, \c3, \tmp1
    mul \twiddle, \c4, \Qprime
    smlal \c4, \c5, \twiddle, \Q

    smull \c6, \c7, \c1, \tmp1
    smlal \c6, \c7, \c3, \tmp0
    mul \twiddle, \c6, \Qprime
    smlal \c6, \c7, \twiddle, \Q

    vmov.w \twiddle, \xi2
    montgomery_mul_des_32 \tmp0, \c6, \c2, \twiddle, \Qprime, \Q, \tmp1
    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1
    add_sub2 \c0, \c2, \c1, \c3

    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

// 18
.macro _3_layer_CT_light_small_1111_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \tmp0, \tmp1, \xi5, \xi6

    mul \c5, \c1, \tmp0
    mla \c5, \c3, \tmp1, \c5

    mul \c7, \c1, \tmp1
    mla \c7, \c3, \tmp0, \c7

    vmov.w \twiddle, \xi2
    mul \c6, \c2, \twiddle
    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1
    add_sub2 \c0, \c2, \c1, \c3

    mul \c3, \c3, \twiddle
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

// 61
.macro _3_layer_inv_CT_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul_32 \c1, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

    vmov.w \twiddle, \xi1
    montgomery_mul_32 \c2, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    vmov.w \twiddle, \xi3
    montgomery_mul_32 \c4, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

// 36
.macro _3_layer_inv_CT_light_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

.macro _3_layer_butterfly_light_fast_first c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    add_sub2 \c1, \c4, \c3, \c6

    add_sub1 \c1, \c3
    vmov.w \tmp, \tmp2, \xi5, \xi6

    smull.w \c0, \c5, \c4, \tmp
    smlal.w \c0, \c5, \c6, \tmp2
    mul.w \twiddle, \c0, \Qprime
    smlal.w \c0, \c5, \twiddle, \Q

    smull.w \c2, \c7, \c4, \tmp2
    smlal.w \c2, \c7, \c6, \tmp
    mul.w \twiddle, \c2, \Qprime
    smlal.w \c2, \c7, \twiddle, \Q
.endm

.macro _3_layer_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    add_sub2 \c0, \c4, \c2, \c6

    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    add_sub2 \c0, \c2, \c4, \c6

    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

// 15
.macro _3_layer_inv_butterfly_light_fast_first c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    add_sub2 \c4, \c1, \c6, \c3
    add_sub1 \c4, \c6

    vmov.w \tmp, \xi4
    vmov.w \tmp2, \xi6

    smull.w \c0, \c5, \c1, \tmp
    smlal.w \c0, \c5, \c3, \tmp2
    mul.w \twiddle, \c0, \Qprime
    smlal.w \c0, \c5, \twiddle, \Q

    smull.w \c2, \c7, \c1, \tmp2
    smlal.w \c2, \c7, \c3, \tmp
    mul.w \twiddle, \c2, \Qprime
    smlal.w \c2, \c7, \twiddle, \Q
.endm

// 19
.macro _3_layer_inv_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    add_sub2 \c0, \c1, \c2, \c3

    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    add_sub2 \c0, \c2, \c1, \c3

    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

.macro _3_layer_inv_GS_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
    vmov.w \twiddle, \xi3
    montgomery_mul_32 \c1, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1

    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7
    vmov.w \twiddle, \xi1
    montgomery_mul_32 \c2, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
    vmov.w \twiddle, \xi0
    montgomery_mul_32 \c4, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1

.endm

.macro _3_layer_inv_GS_light_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp0, \tmp1

    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp0, \tmp1
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp0, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

.endm

// 8
.macro _3_ntt c0, c1, c2, omega1, omega2, Qprime, Q, tmp0, tmp1
    add.w \tmp0, \c1, \c2

    smull \tmp1, \c1, \c1, \omega1
    smlal \tmp1, \c1, \c2, \omega2
    mul \c2, \tmp1, \Qprime
    smlal \tmp1, \c1, \c2, \Q

    add.w \c2, \c1, \tmp0

    rsb.w \c2, \c0

    add \c1, \c0
    add \c0, \tmp0
.endm

#endif
