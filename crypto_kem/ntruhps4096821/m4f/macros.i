

#ifndef MACROS_I
#define MACROS_I

#define LOOP

// 4
.macro central_reduce target, Mhalf, M
    cmp \target, \Mhalf
    it ge
    subge \target, \M
    cmn \target, \Mhalf
    it lt
    addlt \target, \M
.endm

// 2
.macro ldrstr2 ldrstr, target, c0, c1, mem0, mem1
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
.endm

// 2
.macro ldrstr2jump ldrstr, target, c0, c1, mem1, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c0, [\target], \jump
.endm

// 4
.macro ldrstr4 ldrstr, target, c0, c1, c2, c3, mem0, mem1, mem2, mem3
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
.endm

// 4
.macro ldrstr4jump ldrstr, target, c0, c1, c2, c3, mem1, mem2, mem3, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
    \ldrstr \c0, [\target], \jump
.endm

// 8
.macro ldrstr8 ldrstr, target, c0, c1, c2, c3, c4, c5, c6, c7, mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7
    ldrstr4 \ldrstr, \target, \c0, \c1, \c2, \c3, \mem0, \mem1, \mem2, \mem3
    ldrstr4 \ldrstr, \target, \c4, \c5, \c6, \c7, \mem4, \mem5, \mem6, \mem7
.endm

// 8
.macro ldrstr8jump ldrstr, target, c0, c1, c2, c3, c4, c5, c6, c7, mem1, mem2, mem3, mem4, mem5, mem6, mem7, jump
    ldrstr4 \ldrstr, \target, \c4, \c5, \c6, \c7, \mem4, \mem5, \mem6, \mem7
    ldrstr4jump \ldrstr, \target, \c0, \c1, \c2, \c3, \mem1, \mem2, \mem3, \jump
.endm

// 2
.macro add_sub1 c0, c1
    add.w \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1
.endm

// 3
.macro add_sub2 c0, c1, c2, c3
    add \c0, \c1
    add \c2, \c3
    sub.w \c1, \c0, \c1, lsl #1
    sub.w \c3, \c2, \c3, lsl #1
.endm

// 6
.macro add_sub4 c0, c1, c2, c3, c4, c5, c6, c7
    add \c0, \c1
    add \c2, \c3
    add \c4, \c5
    add \c6, \c7
    sub.w \c1, \c0, \c1, lsl #1
    sub.w \c3, \c2, \c3, lsl #1
    sub.w \c5, \c4, \c5, lsl #1
    sub.w \c7, \c6, \c7, lsl #1
.endm

.macro barrett_32 a, Qbar, Q, tmp
    smmulr \tmp, \a, \Qbar
    mls \a, \tmp, \Q, \a
.endm

// 3
.macro montgomery_mul_des_32 lower, upper, a, b, Qprime, Q, tmp
    smull \lower, \upper, \a, \b
    mul \tmp, \lower, \Qprime
    smlal \lower, \upper, \tmp, \Q
.endm

// 3
.macro montgomery_mul_32 a, b, Qprime, Q, tmp0, tmp1
    montgomery_mul_des_32 \tmp0, \a, \a, \b, \Qprime, \Q, \tmp1
.endm

// 2
.macro montgomery_des_16 des, a, QQprime, tmp
    smulbb \tmp, \a, \QQprime
    smlabt \des, \tmp, \QQprime, \a
.endm

// 2
.macro montgomery_16 a, QQprime, tmp
    montgomery_des_16 \a, \a, \QQprime, \tmp
.endm

// 7
.macro doublemontgomery_16 tb, a, twiddle, QQprime, tmp, tmp2
    smulb\tb \tmp, \a, \twiddle
    montgomery_16 \tmp, \QQprime, \tmp2
    smult\tb \a, \a, \twiddle
    montgomery_16 \a, \QQprime, \tmp2
    pkhtb \a, \a, \tmp, asr #16
.endm

// 28
.macro doublemontgomery_16_4 tb, c0, c1, c2, c3, multiplier, QQprime, tmp, tmp2
    doublemontgomery_16 \tb, \c0, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c1, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c2, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c3, \multiplier, \QQprime, \tmp, \tmp2
.endm

// 56
.macro doublemontgomery_16_8 tb, c0, c1, c2, c3, c4, c5, c6, c7 multiplier, QQprime, tmp, tmp2
    doublemontgomery_16 \tb, \c0, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c1, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c2, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c3, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c4, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c5, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c6, \multiplier, \QQprime, \tmp, \tmp2
    doublemontgomery_16 \tb, \c7, \multiplier, \QQprime, \tmp, \tmp2
.endm

#endif





