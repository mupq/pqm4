#ifndef MACROS_COMMON_S
#define MACROS_COMMON_S

/************************************************************
* Name:         barrett
*
* Description:  32-bit signed Barrett reduction
*
* Input:        a
*
* Symbols:      R = 2^32
*
* Constants:    Qbar = round(R / q), Q = q
*
* Output:       a = a - q round(a / q)
************************************************************/
.macro barrett a, Qbar, Q, tmp
    smmulr.w \tmp, \a, \Qbar
    mls.w \a, \tmp, \Q, \a
.endm

/************************************************************
* Name:         montgomery_mul
*
* Description:  32-bit signed Montgomery multiplication
*
* Input:        a, b
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       upper = a b R^{-1} mod^{+-} R
************************************************************/
.macro montgomery_mul lower, upper, a, b, Qprime, Q, tmp
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \Qprime
    smlal.w \lower, \upper, \tmp, \Q
.endm

/************************************************************
* Name:         central_reduce
*
* Description:  reduce to [-M / 2, M / 2)
*
* Input:        target
*
* Symbols:
*
* Constants:    Mhalf = MOD / 2, M = MOD
*
* Output:       target = target mod^{+-} R (strictly in [-M / 2, M / 2) )
************************************************************/
.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it ge
    subge \target, \M
    cmn \target, \Mhalf
    it lt
    addlt \target, \M
.endm

/************************************************************
* Name:         montgomery_mul_vec4
*
* Description:  4 sets of Montgomery multiplication by xi
*
* Input:        c0, c1, c2, c3, xi
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       c0 = c0 xi R^{-1} mod^{+-} R
*               c1 = c1 xi R^{-1} mod^{+-} R
*               c2 = c2 xi R^{-1} mod^{+-} R
*               c3 = c3 xi R^{-1} mod^{+-} R
************************************************************/
.macro montgomery_mul_vec4 c0, c1, c2, c3, xi, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi
    montgomery_mul \tmp0, \c0, \c0, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c1, \c1, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c2, \c2, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
.endm

/************************************************************
* Name:         montgomery_mul_vec8
*
* Description:  8 sets of Montgomery multiplication by xi
*
* Input:        c0, c1, c2, c3, c4, c5, c6, c7, xi
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       c0 = c0 xi R^{-1} mod^{+-} R
*               c1 = c1 xi R^{-1} mod^{+-} R
*               c2 = c2 xi R^{-1} mod^{+-} R
*               c3 = c3 xi R^{-1} mod^{+-} R
*               c4 = c4 xi R^{-1} mod^{+-} R
*               c5 = c5 xi R^{-1} mod^{+-} R
*               c6 = c6 xi R^{-1} mod^{+-} R
*               c7 = c7 xi R^{-1} mod^{+-} R
************************************************************/
.macro montgomery_mul_vec8 c0, c1, c2, c3, c4, c5, c6, c7, xi, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi
    montgomery_mul \tmp0, \c0, \c0, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c1, \c1, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c2, \c2, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c4, \c4, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
.endm

/************************************************************
* Name:         montgomery_mul_point8
*
* Description:  8 sets of point multiplication with
*               Montgomery multiplication
*
* Input:         c0,  c1,  c2,  c3,  c4,  c5,  c6,  c7,
*               xi0, xi1, xi2, xi3, xi4, xi5, xi6, xi7
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       c0 = c0 xi0 R^{-1} mod^{+-} R
*               c1 = c1 xi1 R^{-1} mod^{+-} R
*               c2 = c2 xi2 R^{-1} mod^{+-} R
*               c3 = c3 xi3 R^{-1} mod^{+-} R
*               c4 = c4 xi4 R^{-1} mod^{+-} R
*               c5 = c5 xi5 R^{-1} mod^{+-} R
*               c6 = c6 xi6 R^{-1} mod^{+-} R
*               c7 = c7 xi7 R^{-1} mod^{+-} R
************************************************************/
.macro montgomery_mul_point8 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, xi7, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul \tmp0, \c0, \c0, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi1
    montgomery_mul \tmp0, \c1, \c1, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \tmp0, \c2, \c2, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi3
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul \tmp0, \c4, \c4, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi7
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
.endm

/************************************************************
* Name:         add_sub
*
* Description:  inplace add-sub
*
* Input:        a, b
*
* Symbols:
*
* Constants:
*
* Output:       a = a + b
*               b = a - b
************************************************************/
.macro add_sub a, b
    add.w \a, \b
    sub.w \b, \a, \b, lsl #1
.endm

/************************************************************
* Name:         add_sub2
*
* Description:  2 sets of inplace add-sub
*
* Input:        a0, b0, a1, b1
*
* Symbols:
*
* Constants:
*
* Output:       a0 = a0 + b0
*               b0 = a0 - b0
*               a1 = a1 + b1
*               b1 = a1 - b1
************************************************************/
.macro add_sub2 a0, b0, a1, b1
    add \a0, \b0
    add \a1, \b1
    sub.w \b0, \a0, \b0, lsl #1
    sub.w \b1, \a1, \b1, lsl #1
.endm

/************************************************************
* Name:         add_sub4
*
* Description:  4 sets of inplace add-sub
*
* Input:        a0, b0, a1, b1, a2, b2, a3, b3
*
* Symbols:
*
* Constants:
*
* Output:       a0 = a0 + b0
*               b0 = a0 - b0
*               a1 = a1 + b1
*               b1 = a1 - b1
*               a2 = a2 + b2
*               b2 = a2 - b2
*               a3 = a3 + b3
*               b3 = a3 - b3
************************************************************/
.macro add_sub4 a0, b0, a1, b1, a2, b2, a3, b3
    add \a0, \b0
    add \a1, \b1
    add \a2, \b2
    add \a3, \b3
    sub.w \b0, \a0, \b0, lsl #1
    sub.w \b1, \a1, \b1, lsl #1
    sub.w \b2, \a2, \b2, lsl #1
    sub.w \b3, \a3, \b3, lsl #1
.endm

/************************************************************
* Name:         ldrstr4
*
* Description:  4 sets of memory operation of the same kind
*
* Input:        ldrstr, target,
*                 c0,   c1,   c2,   c3,
*               mem0, mem1, mem2, mem3
*
* Symbols:
*
* Constants:
*
* Output:       if ldrstr is of load type:
*                   c0 = target[mem0]
*                   c1 = target[mem1]
*                   c2 = target[mem2]
*                   c3 = target[mem3]
*               else if ldrstr is of store type:
*                   target[mem0] = c0
*                   target[mem1] = c1
*                   target[mem2] = c2
*                   target[mem3] = c3
*               else:
*                   undefined
************************************************************/
.macro ldrstr4 ldrstr, target, c0, c1, c2, c3, mem0, mem1, mem2, mem3
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
.endm

/************************************************************
* Name:         ldrstr4jump
*
* Description:  4 sets of memory operation of the same kind
*               with postfix update
*
* Input:        ldrstr, target, jump
*                 c0,   c1,   c2,   c3,
*               mem0, mem1, mem2, mem3
*
* Symbols:
*
* Constants:
*
* Output:       if ldrstr is of load type:
*                   c0 = target[mem0]
*                   c1 = target[mem1]
*                   c2 = target[mem2]
*                   c3 = target[mem3]
*               else if ldrstr is of store type:
*                   target[mem0] = c0
*                   target[mem1] = c1
*                   target[mem2] = c2
*                   target[mem3] = c3
*               else:
*                   undefined
*
*               and then:
*                   target = target + jump
************************************************************/
.macro ldrstr4jump ldrstr, target, c0, c1, c2, c3, mem1, mem2, mem3, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
    \ldrstr \c0, [\target], \jump
.endm

/************************************************************
* Name:         ldrstrvec
*
* Description:  8 sets of memory operation of the same kind
*
* Input:        ldrstr, target,
*                 c0,   c1,   c2,   c3,   c4,   c5,   c6,   c7,
*               mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7
*
* Symbols:
*
* Constants:
*
* Output:       if ldrstr is of load type:
*                   c0 = target[mem0]
*                   c1 = target[mem1]
*                   c2 = target[mem2]
*                   c3 = target[mem3]
*                   c4 = target[mem4]
*                   c5 = target[mem5]
*                   c6 = target[mem6]
*                   c7 = target[mem7]
*               else if ldrstr is of store type:
*                   target[mem0] = c0
*                   target[mem1] = c1
*                   target[mem2] = c2
*                   target[mem3] = c3
*                   target[mem4] = c4
*                   target[mem5] = c5
*                   target[mem6] = c6
*                   target[mem7] = c7
*               else:
*                   undefined
************************************************************/
.macro ldrstrvec ldrstr, target, c0, c1, c2, c3, c4, c5, c6, c7, mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
    \ldrstr \c4, [\target, \mem4]
    \ldrstr \c5, [\target, \mem5]
    \ldrstr \c6, [\target, \mem6]
    \ldrstr \c7, [\target, \mem7]
.endm

/************************************************************
* Name:         ldrstrvecjump
*
* Description:  8 sets of memory operation of the same kind
*               with postfix update
*
* Input:        ldrstr, target, jump
*                 c0,   c1,   c2,   c3,   c4,   c5,   c6,   c7,
*               mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7
*
* Symbols:
*
* Constants:
*
* Output:       if ldrstr is of load type:
*                   c0 = target[mem0]
*                   c1 = target[mem1]
*                   c2 = target[mem2]
*                   c3 = target[mem3]
*                   c4 = target[mem4]
*                   c5 = target[mem5]
*                   c6 = target[mem6]
*                   c7 = target[mem7]
*               else if ldrstr is of store type:
*                   target[mem0] = c0
*                   target[mem1] = c1
*                   target[mem2] = c2
*                   target[mem3] = c3
*                   target[mem4] = c4
*                   target[mem5] = c5
*                   target[mem6] = c6
*                   target[mem7] = c7
*               else:
*                   undefined
*
*               and then:
*                   target = target + jump
************************************************************/
.macro ldrstrvecjump ldrstr, target, c0, c1, c2, c3, c4, c5, c6, c7, mem1, mem2, mem3, mem4, mem5, mem6, mem7, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
    \ldrstr \c4, [\target, \mem4]
    \ldrstr \c5, [\target, \mem5]
    \ldrstr \c6, [\target, \mem6]
    \ldrstr \c7, [\target, \mem7]
    \ldrstr \c0, [\target], \jump
.endm

/************************************************************
* Name:         _3_layer_CT_butterfly
*
* Description:  3-layer Cooley-Tukey butterfly
*               defined over X^8 - zeta^8
*
* Input:        (normal order)
*                 c0,  c1,  c2,  c3,  c4,  c5,  c6, c7;
*               (xi0, xi1, xi2, xi3, xi4, xi5, xi6) =
*               ( w0,  w1,  w2,  w3,  w4,  w5,  w6) in
*               Montgomery domain
*
* Symbols:      R = 2^32
*
* Constants:    Qprime = -MOD^{-1} mod^{+-} R, Q = MOD
*
* Output:       (bit-reversed order)
*               c0 = c0 + w0 c4 + (c2 + w0 c6) w1 + (c1 + w0 c5 + (c3 + w0 c7) w1) w3
*               c1 = c0 + w0 c4 + (c2 + w0 c6) w1 - (c1 + w0 c5 + (c3 + w0 c7) w1) w3
*               c2 = c0 + w0 c4 - (c2 + w0 c6) w1 + (c1 + w0 c5 - (c3 + w0 c7) w1) w4
*               c3 = c0 + w0 c4 - (c2 + w0 c6) w1 - (c1 + w0 c5 - (c3 + w0 c7) w1) w4
*               c4 = c0 - w0 c4 + (c2 - w0 c6) w2 + (c1 - w0 c5 + (c3 - w0 c7) w2) w5
*               c5 = c0 - w0 c4 + (c2 - w0 c6) w2 - (c1 - w0 c5 + (c3 - w0 c7) w2) w5
*               c6 = c0 - w0 c4 - (c2 - w0 c6) w2 + (c1 - w0 c5 - (c3 - w0 c7) w2) w6
*               c7 = c0 - w0 c4 - (c2 - w0 c6) w2 - (c1 - w0 c5 - (c3 - w0 c7) w2) w6
************************************************************/
.macro _3_layer_CT_butterfly c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul \tmp0, \c4, \c4, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi1
    montgomery_mul \tmp0, \c2, \c2, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    vmov.w \twiddle, \xi3
    montgomery_mul \tmp0, \c1, \c1, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

/************************************************************
* Name:         _3_layer_CT_butterfly_light
*
* Description:  3-layer Cooley-Tukey butterfly
*               defined over X^8 - 1
*
* Input:        (normal order)
*                 c0,  c1,  c2,  c3,  c4,  c5,  c6, c7;
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
.macro _3_layer_CT_butterfly_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi2
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \tmp0, \c7,\c7, \twiddle,  \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

/************************************************************
* Name:         _3_layer_CT_butterfly_light_fast_first
*
* Description:  the odd butterflies for 3-layer Cooley-Tukey
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
.macro _3_layer_CT_butterfly_light_fast_first c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub2 \c1, \c4, \c3, \c6

    add_sub \c1, \c3
    vmov.w \tmp0, \tmp1, \xi5, \xi6

    smull.w \c0, \c5, \c4, \tmp0
    smlal.w \c0, \c5, \c6, \tmp1
    mul.w \twiddle, \c0, \Qprime
    smlal.w \c0, \c5, \twiddle, \Q

    smull.w \c2, \c7, \c4, \tmp1
    smlal.w \c2, \c7, \c6, \tmp0
    mul.w \twiddle, \c2, \Qprime
    smlal.w \c2, \c7, \twiddle, \Q
.endm

/************************************************************
* Name:         _3_layer_CT_butterfly_light_fast_second
*
* Description:  the even butterflies for 3-layer Cooley-Tukey
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
.macro _3_layer_CT_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub2 \c0, \c4, \c2, \c6

    vmov.w \twiddle, \xi2
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c2, \c4, \c6

    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

/************************************************************
* Name:         _3_layer_GS_butterfly
*
* Description:  3-layer Gentleman-Sande butterfly
*               defined over X^8 - zeta^8
*
* Input:        (bit-reversed order)
*                 c0,  c1,  c2,  c3,  c4,  c5,  c6, c7;
*               (xi0, xi1, xi2, xi3, xi4, xi5, xi6) =
*               ( w0,  w1,  w2,  w3,  w4,  w5,  w6) in
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
.macro _3_layer_GS_butterfly c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
    vmov.w \twiddle, \xi3
    montgomery_mul \tmp0, \c1, \c1, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7
    vmov.w \twiddle, \xi1
    montgomery_mul \tmp0, \c2, \c2, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
    vmov.w \twiddle, \xi0
    montgomery_mul \tmp0, \c4, \c4, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1
.endm

/************************************************************
* Name:         _3_layer_GS_butterfly_light
*
* Description:  3-layer Gentleman-Sande butterfly
*               defined over X^8 - 1
*
* Input:        (bit-reversed order)
*                 c0,  c1,  c2,  c3,  c4,  c5,  c6, c7;
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
.macro _3_layer_GS_butterfly_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

    vmov.w \twiddle, \xi5
    montgomery_mul \tmp0, \c5, \c5, \twiddle, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1

    vmov.w \twiddle, \xi4
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7
    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1
    montgomery_mul \tmp0, \c7, \c7, \twiddle, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

/************************************************************
* Name:         _3_layer_GS_butterfly_light_fast_first
*
* Description:  upper half of 3-layer Gentleman-Sande butterfly
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
.macro _3_layer_GS_butterfly_light_fast_first c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub2 \c4, \c1, \c6, \c3
    add_sub \c4, \c6

    vmov.w \tmp0, \tmp1, \xi5, \xi6

    smull.w \c0, \c5, \c1, \tmp0
    smlal.w \c0, \c5, \c3, \tmp1
    mul.w \twiddle, \c0, \Qprime
    smlal.w \c0, \c5, \twiddle, \Q

    smull.w \c2, \c7, \c1, \tmp1
    smlal.w \c2, \c7, \c3, \tmp0
    mul.w \twiddle, \c2, \Qprime
    smlal.w \c2, \c7, \twiddle, \Q
.endm

/************************************************************
* Name:         _3_layer_GS_butterfly_light_fast_second
*
* Description:  lower half of 3-layer Gentleman-Sande butterfly
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
.macro _3_layer_GS_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub2 \c0, \c1, \c2, \c3

    vmov.w \twiddle, \xi2
    montgomery_mul \tmp0, \c3, \c3, \twiddle, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c2, \c1, \c3

    montgomery_mul \tmp0, \c6, \c6, \twiddle, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

#endif