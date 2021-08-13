
#ifndef CT_BUTTERFLIES_I
#define CT_BUTTERFLIES_I

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

.macro _3_layer_CT_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    vmov.w \twiddle, \xi0
    montgomery_mul_32 \c4, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi1
    montgomery_mul_32 \c2, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    vmov.w \twiddle, \xi3
    montgomery_mul_32 \c1, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

.macro _3_layer_inv_CT_32 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    vmov.w \twiddle, \xi0
    montgomery_mul_32 \c1, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

    vmov.w \twiddle, \xi1
    montgomery_mul_32 \c2, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    vmov.w \twiddle, \xi3
    montgomery_mul_32 \c4, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi5
    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

.macro _3_layer_inv_CT_32_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    addSub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi4
    montgomery_mul_32 \c5, \twiddle, \Qprime, \Q, \tmp, \tmp2
    vmov.w \twiddle, \xi6
    montgomery_mul_32 \c7, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

/************************************************************
* Name:         _3_layer_butterfly_light_fast_first
*
* Description:  the odd butterflies for 3-layer
*               butterfly defined over X^8 - 1
*
* Input:        (c1, c3, c4, c6) = coefficients at odd positions;
*               (xi0, xi1, xi2, xi3, xi4, xi5, xi6) =
*               (  1,   1,  w_4,  1, w_8, w_4, w_8^3) in
*               Montgomery domain
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:
*               c1 = c1 + c4         + (c3 + c6)
*               c3 = c1 + c4         - (c3 + c6)
*               c5 = (c1 - c4) w_4   + (c3 - c6) w_8^3
*               c7 = (c1 - c4) w_8^3 + (c3 - c6) w_4^3
************************************************************/
.macro _3_layer_butterfly_light_fast_first c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    addSub2 \c1, \c4, \c3, \c6

    addSub \c1, \c3
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

/************************************************************
* Name:         _3_layer_butterfly_light_fast_second
*
* Description:  the even butterflies for 3-layer
*               butterfly defined over X^8 - 1, and the 2nd
*               layer of butterflies
*
* Input:        (c1, c3, c5, c7) = results of odd butterflies;
*               (c0, c2, c4, c6) = coefficients at even positions;
*               (xi0, xi1, xi2, xi3, xi4, xi5, xi6) =
*               (  1,   1,  w_4,  1, w_8, w_4, w_8^3) in
*               Montgomery domain
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       (bit-reversed order)
*               c0 = c0 + c4 + (c2 + c6)     + (c1 + c5 + (c3 + c7)    )
*               c1 = c0 + c4 + (c2 + c6)     - (c1 + c5 + (c3 + c7)    )
*               c2 = c0 + c4 - (c2 + c6)     + (c1 + c5 - (c3 + c7)    ) w_8
*               c3 = c0 + c4 - (c2 + c6)     - (c1 + c5 - (c3 + c7)    ) w_8
*               c4 = c0 - c4 + (c2 - c6) w_4 + (c1 - c5 + (c3 - c7) w_4) w_4
*               c5 = c0 - c4 + (c2 - c6) w_4 - (c1 - c5 + (c3 - c7) w_4) w_4
*               c6 = c0 - c4 - (c2 - c6) w_4 + (c1 - c5 - (c3 - c7) w_4) w_8^3
*               c7 = c0 - c4 - (c2 - c6) w_4 - (c1 - c5 - (c3 - c7) w_4) w_8^3
************************************************************/
.macro _3_layer_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    addSub2 \c0, \c4, \c2, \c6

    vmov.w \twiddle, \xi2
    montgomery_mul \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub2 \c0, \c2, \c4, \c6

    montgomery_mul \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

/************************************************************
* Name:         _3_layer_inv_butterfly_light_fast_first
*
* Description:  upper half of 3-layer inverse butterfly
*               defined over X^8 - 1
*
* Input:        (c4, c1, c6, c3) = coefficients on the upper half;
*               (xi0, xi1, xi2, xi3, xi4, xi5, xi6) =
*               (  1,  1,  w_4,   1, w_8, w_4, w_8^3) in
*               Montgomery domain
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:
*               c4 =  c4 + c1        + (c6 + c3)
*               c5 = (c4 - c1) w_4   + (c6 + c3) w_8^3
*               c6 =  c4 + c1        - (c6 + c3)
*               c7 = (c4 - c1) w_8^3 + (c6 + c3) w_4
************************************************************/
// 15
.macro _3_layer_inv_butterfly_light_fast_first c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    addSub2 \c4, \c1, \c6, \c3
    addSub1 \c4, \c6

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

/************************************************************
* Name:         _3_layer_inv_butterfly_light_fast_second
*
* Description:  lower half of 3-layer inverse butterfly
*               defined over X^8 - 1, and the 2nd
*               layer of butterflies
*
* Input:
*               (c4, c5, c6, c7) = results of the upper half;
*               (c0, c1, c2, c3) = coefficients on the lower half;
*               (xi0, xi1, xi2, xi3, xi4, xi5, xi6) =
*               (  1,  1,  w_4,   1, w_8, w_4, w_8^3) in
*               Montgomery domain
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       (normal order)
*               c0 =   c0 + c1     + (c2 + c3)         + (  c4 + c5     + (c6 + c7)       )
*               c1 =  (c0 - c1) w3 + (c2 - c3)  w4     + ( (c4 - c5) w5 + (c6 - c7) w6    )
*               c2 = ( c0 + c1     - (c2 + c3)) w1     + (( c4 + c5     - (c6 + c7)   ) w2)
*               c3 = ((c0 - c1) w3 - (c2 - c3)  w4) w1 + (((c4 - c5) w5 - (c6 - c7) w6) w2)
*               c4 =   c0 + c1     - (c2 + c3)         - (  c4 + c5     + (c6 + c7)       ) w0
*               c5 =  (c0 - c1) w3 + (c2 - c3)  w4     - ( (c4 - c5) w5 + (c6 - c7) w6    ) w0
*               c6 = ( c0 + c1     - (c2 + c3)) w1     - (( c4 + c5     - (c6 + c7)   ) w2) w0
*               c7 = ((c0 - c1) w3 - (c2 - c3)  w4) w1 - (((c4 - c5) w5 - (c6 - c7) w6) w2) w0
************************************************************/
// 19
.macro _3_layer_inv_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    addSub2 \c0, \c1, \c2, \c3

    vmov.w \twiddle, \xi2
    montgomery_mul_32 \c3, \twiddle, \Qprime, \Q, \tmp, \tmp2
    addSub2 \c0, \c2, \c1, \c3

    montgomery_mul_32 \c6, \twiddle, \Qprime, \Q, \tmp, \tmp2

    addSub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

#endif


