

#include "macros.S"

.macro _6_ntt_100 c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    smull \c4, \c2, \c3, \omega1
    smlal \c4, \c2, \c5, \omega2
    mul \c1, \c4, \Mprime
    smlal \c4, \c2, \c1, \M

    add.w \c1, \c3, \c5
    add.w \c5, \c2, \c1

    sub.w \c4, \c0, \c5
    add.w \c5, \c5, \c0

    sub.w \c3, \c0, \c2
    add.w \c2, \c2, \c0

    add.w \c0, \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

.macro _6_ntt_011 c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    smull \c5, \c3, \c2, \omega1
    smlal \c5, \c3, \c4, \omega2
    mul \c0, \c5, \Mprime
    smlal \c5, \c3, \c0, \M

    add.w \c0, \c2, \c4
    add.w \c4, \c3, \c0

    add.w \c5, \c1, \c4
    neg.w \c5, \c5
    sub.w \c4, \c1, \c4

    add.w \c2, \c3, \c1
    sub.w \c3, \c3, \c1

    add.w \c0, \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

.macro _6_ntt_101 c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    montgomery_mul \c4, \omega1, \tmp0, \c5, \Mprime, \M, \c1

    add.w \c2, \c4, \c5

    sub.w \c2, \c0, \c2
    add.w \c5, \c5, \c0
    add.w \c0, \c0, \c4

    montgomery_mul \c3, \omega1, \c1, \tmp0, \Mprime, \M, \c4

    add.w \c4, \c3, \tmp0

    add.w \c0, \c0, \c3
    sub.w \c1, \c0, \c3, lsl #1

    add.w \c2, \c2, \tmp0
    sub.w \c3, \c2, \tmp0, lsl #1

    add.w \c5, \c5, \c4
    sub.w \c4, \c5, \c4, lsl #1

.endm

.macro _6_ntt_110 c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    montgomery_mul \c2, \omega1, \tmp0, \c3, \Mprime, \M, \c1

    add.w \c4, \c2, \c3

    sub.w \c4, \c0, \c4
    add.w \c3, \c3, \c0
    add.w \c0, \c0, \c2

    montgomery_mul \c5, \omega1, \c1, \tmp0, \Mprime, \M, \c2

    add.w \c2, \c5, \tmp0

    add.w \c0, \c0, \c5
    sub.w \c1, \c0, \c5, lsl #1

    add.w \c4, \c4, \tmp0
    sub.w \c5, \c4, \tmp0, lsl #1

    add.w \c3, \c3, \c2
    sub.w \c2, \c3, \c2, lsl #1

.endm

.macro _6_ntt_010 c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    montgomery_mul \c5, \omega1, \tmp0, \c4, \Mprime, \M, \c0

    add.w \c3, \c4, \c5

    sub.w \c3, \c1, \c3
    add.w \c4, \c4, \c1
    add.w \c1, \c1, \c5

    montgomery_mul \c2, \omega1, \c0, \tmp0, \Mprime, \M, \c5

    add.w \c5, \c2, \tmp0

    add.w \c0, \c2, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c2, \tmp0, \c3
    sub.w \c3, \c2, \c3, lsl #1

    sub.w \c4, \c4, \c5
    add.w \c5, \c4, \c5, lsl #1
    neg.w \c5, \c5

.endm

.macro _6_ntt_001 c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    montgomery_mul \c3, \omega1, \tmp0, \c2, \Mprime, \M, \c0

    add.w \c5, \c2, \c3

    sub.w \c5, \c1, \c5
    add.w \c2, \c2, \c1
    add.w \c1, \c1, \c3

    montgomery_mul \c4, \omega1, \c0, \tmp0, \Mprime, \M, \c3

    add.w \c3, \c4, \tmp0

    add.w \c0, \c4, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c4, \tmp0, \c5
    sub.w \c5, \c4, \c5, lsl #1

    sub.w \c2, \c2, \c3
    add.w \c3, \c2, \c3, lsl #1
    neg.w \c3, \c3

.endm

// ================================

.macro _6_ntt_100_small c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    mul \c2, \c3, \omega1
    mla \c2, \c5, \omega2, \c2

    add.w \c1, \c3, \c5
    add.w \c5, \c2, \c1

    sub.w \c4, \c0, \c5
    add.w \c5, \c5, \c0

    sub.w \c3, \c0, \c2
    add.w \c2, \c2, \c0

    add.w \c0, \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

.macro _6_ntt_011_small c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    mul \c3, \c2, \omega1
    mla \c3, \c4, \omega2, \c3

    add.w \c0, \c2, \c4
    add.w \c4, \c3, \c0

    add.w \c5, \c1, \c4
    neg.w \c5, \c5
    sub.w \c4, \c1, \c4

    add.w \c2, \c3, \c1
    sub.w \c3, \c3, \c1

    add.w \c0, \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

.macro _6_ntt_101_small c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    mul \c5, \c4, \omega1

    add.w \c2, \c4, \c5

    sub.w \c2, \c0, \c2
    add.w \c5, \c5, \c0
    add.w \c0, \c0, \c4

    mul \tmp0, \c3, \omega1

    add.w \c4, \c3, \tmp0

    add.w \c0, \c0, \c3
    sub.w \c1, \c0, \c3, lsl #1

    add.w \c2, \c2, \tmp0
    sub.w \c3, \c2, \tmp0, lsl #1

    add.w \c5, \c5, \c4
    sub.w \c4, \c5, \c4, lsl #1

.endm

.macro _6_ntt_110_small c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    mul \c3, \c2, \omega1

    add.w \c4, \c2, \c3

    sub.w \c4, \c0, \c4
    add.w \c3, \c3, \c0
    add.w \c0, \c0, \c2

    mul \tmp0, \c5, \omega1

    add.w \c2, \c5, \tmp0

    add.w \c0, \c0, \c5
    sub.w \c1, \c0, \c5, lsl #1

    add.w \c4, \c4, \tmp0
    sub.w \c5, \c4, \tmp0, lsl #1

    add.w \c3, \c3, \c2
    sub.w \c2, \c3, \c2, lsl #1

.endm

.macro _6_ntt_010_small c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    mul \c4, \c5, \omega1

    add.w \c3, \c4, \c5

    sub.w \c3, \c1, \c3
    add.w \c4, \c4, \c1
    add.w \c1, \c1, \c5

    mul \tmp0, \c2, \omega1

    add.w \c5, \c2, \tmp0

    add.w \c0, \c2, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c2, \tmp0, \c3
    sub.w \c3, \c2, \c3, lsl #1

    sub.w \c4, \c4, \c5
    add.w \c5, \c4, \c5, lsl #1
    neg.w \c5, \c5

.endm

.macro _6_ntt_001_small c0, c1, c2, c3, c4, c5, omega1, omega2, Mprime, M, tmp0

    mul \c2, \c3, \omega1

    add.w \c5, \c2, \c3

    sub.w \c5, \c1, \c5
    add.w \c2, \c2, \c1
    add.w \c1, \c1, \c3

    mul \tmp0, \c4, \omega1

    add.w \c3, \c4, \tmp0

    add.w \c0, \c4, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c4, \tmp0, \c5
    sub.w \c5, \c4, \c5, lsl #1

    sub.w \c2, \c2, \c3
    add.w \c3, \c2, \c3, lsl #1
    neg.w \c3, \c3

.endm


