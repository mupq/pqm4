

#ifndef MACROS_S
#define MACROS_S

#define LOOP

.macro barrett a, Qbar, Q, tmp
    smmulr.w \tmp, \a, \Qbar
    mls.w \a, \tmp, \Q, \a
.endm

.macro montgomery_mul a, b, lower, upper, Qprime, Q, tmp
    smull.w \lower, \upper, \a, \b
    mul.w \tmp, \lower, \Qprime
    smlal.w \lower, \upper, \tmp, \Q
.endm

.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it gt
    subgt \target, \M
    cmn \target, \Mhalf
    it lt
    addlt \target, \M
.endm

.macro montgomery_mul_vec4 c0, c1, c2, c3, xi, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi
    montgomery_mul \c0, \twiddle, \tmp0, \c0, \Qprime, \Q, \tmp1
    montgomery_mul \c1, \twiddle, \tmp0, \c1, \Qprime, \Q, \tmp1
    montgomery_mul \c2, \twiddle, \tmp0, \c2, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
.endm

.macro montgomery_mul_vec8 c0, c1, c2, c3, c4, c5, c6, c7, xi, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi
    montgomery_mul \c0, \twiddle, \tmp0, \c0, \Qprime, \Q, \tmp1
    montgomery_mul \c1, \twiddle, \tmp0, \c1, \Qprime, \Q, \tmp1
    montgomery_mul \c2, \twiddle, \tmp0, \c2, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    montgomery_mul \c4, \twiddle, \tmp0, \c4, \Qprime, \Q, \tmp1
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
.endm

.macro montgomery_mul_point4 c0, c1, c2, c3, xi0, xi1, xi2, xi3, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul \c0, \twiddle, \tmp0, \c0, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi1
    montgomery_mul \c1, \twiddle, \tmp0, \c1, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \c2, \twiddle, \tmp0, \c2, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi3
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
.endm

.macro montgomery_mul_point8 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, xi7, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul \c0, \twiddle, \tmp0, \c0, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi1
    montgomery_mul \c1, \twiddle, \tmp0, \c1, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \c2, \twiddle, \tmp0, \c2, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi3
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul \c4, \twiddle, \tmp0, \c4, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi7
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
.endm

.macro add_sub a, b
    add.w \a, \b
    sub.w \b, \a, \b, lsl #1
.endm

.macro add_sub2 a0, b0, a1, b1
    add \a0, \b0
    add \a1, \b1
    sub.w \b0, \a0, \b0, lsl #1
    sub.w \b1, \a1, \b1, lsl #1
.endm

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

.macro ldrstr4 ldrstr, target, c0, c1, c2, c3, mem0, mem1, mem2, mem3
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
.endm

.macro ldrstr4jump ldrstr, target, c0, c1, c2, c3, mem1, mem2, mem3, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
    \ldrstr \c0, [\target], \jump
.endm

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

.macro _3_layer_CT_butterfly c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \twiddle, \xi0
    montgomery_mul \c4, \twiddle, \tmp0, \c4, \Qprime, \Q, \tmp1
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi1
    montgomery_mul \c2, \twiddle, \tmp0, \c2, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    vmov.w \twiddle, \xi3
    montgomery_mul \c1, \twiddle, \tmp0, \c1, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

.macro _3_layer_CT_butterfly_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7

    vmov.w \twiddle, \xi2
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

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

.macro _3_layer_CT_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub2 \c0, \c4, \c2, \c6

    vmov.w \twiddle, \xi2
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c2, \c4, \c6

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm


.macro _3_layer_CT_butterfly_light_fast_half c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
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
    montgomery_mul \c2, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1
    add_sub2 \c0, \c2, \c1, \c3

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

.macro _3_layer_CT_butterfly_small_light_fast_half c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    vmov.w \tmp0, \tmp1, \xi5, \xi6

    mul \c5, \c1, \tmp0
    mla \c5, \c3, \tmp1, \c5

    mul \c7, \c1, \tmp1
    mla \c7, \c3, \tmp0, \c7

    vmov.w \twiddle, \xi4
    mul \c6, \c2, \twiddle
    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1
    add_sub2 \c0, \c2, \c1, \c3

    vmov.w \twiddle, \xi2
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
.endm

.macro _3_layer_GS_butterfly c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7
    vmov.w \twiddle, \xi3
    montgomery_mul \c1, \twiddle, \tmp0, \c1, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7
    vmov.w \twiddle, \xi1
    montgomery_mul \c2, \twiddle, \tmp0, \c2, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi2
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
    vmov.w \twiddle, \xi0
    montgomery_mul \c4, \twiddle, \tmp0, \c4, \Qprime, \Q, \tmp1
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
.endm

.macro _3_layer_GS_butterfly_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c2, \c1, \c3, \c4, \c6, \c5, \c7
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm


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

.macro _3_layer_GS_butterfly_light_fast_second c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1
    add_sub2 \c0, \c1, \c2, \c3

    vmov.w \twiddle, \xi2
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c2, \c1, \c3

    montgomery_mul r10, \twiddle, \tmp0, r10, \Qprime, \Q, \tmp1

    add_sub4 \c0, \c4, \c1, \c5, \c2, \c6, \c3, \c7
.endm

.macro _3_ntt c0, c1, c2, omega1, omega2, Mprime, M, tmp0, tmp1
    add.w \tmp0, \c1, \c2

    smull \tmp1, \c1, \c1, \omega1
    smlal \tmp1, \c1, \c2, \omega2
    mul \c2, \tmp1, \Mprime
    smlal \tmp1, \c1, \c2, \M

    add.w \c2, \c1, \tmp0

    add.w \c1, \c0

    rsb.w \c2, \c0
    add.w \c0, \tmp0

.endm




#endif





