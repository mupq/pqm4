
#include "macros.i"

// 3-NTT(c0, c2, c4)
// 3-NTT(c1, c3, c5)
// 2-NTT(c0, c1)
// 2-NTT(c2, c3)
// 2-NTT(c4, c5)

// normal

// 12
.macro _6_ntt_100 c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    smull \c4, \c2, \c3, \omega1
    smlal \c4, \c2, \c5, \omega2
    mul \c1, \c4, \Qprime
    smlal \c4, \c2, \c1, \Q

    add.w \c1, \c3, \c5
    add.w \c5, \c2, \c1

    sub.w \c4, \c0, \c5
    add.w \c5, \c5, \c0

    sub.w \c3, \c0, \c2
    add.w \c2, \c2, \c0

    add.w \c0, \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

// 13
.macro _6_ntt_011 c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    smull \c5, \c3, \c2, \omega1
    smlal \c5, \c3, \c4, \omega2
    mul \c0, \c5, \Qprime
    smlal \c5, \c3, \c0, \Q

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

// 17
.macro _6_ntt_101 c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c5, \c4, \omega1, \Qprime, \Q, \c1

    add.w \c2, \c4, \c5

    sub.w \c2, \c0, \c2
    add.w \c5, \c5, \c0
    add.w \c0, \c0, \c4

    montgomery_mul_des_32 \c1, \tmp, \c3, \omega1, \Qprime, \Q, \c4

    add.w \c4, \c3, \tmp

    add.w \c0, \c0, \c3
    sub.w \c1, \c0, \c3, lsl #1

    add.w \c2, \c2, \tmp
    sub.w \c3, \c2, \tmp, lsl #1

    add.w \c5, \c5, \c4
    sub.w \c4, \c5, \c4, lsl #1

.endm

// 17
.macro _6_ntt_110 c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c3, \c2, \omega1, \Qprime, \Q, \c1

    add.w \c4, \c2, \c3

    sub.w \c4, \c0, \c4
    add.w \c3, \c3, \c0
    add.w \c0, \c0, \c2

    montgomery_mul_des_32 \c1, \tmp, \c5, \omega1, \Qprime, \Q, \c2

    add.w \c2, \c5, \tmp

    add.w \c0, \c0, \c5
    sub.w \c1, \c0, \c5, lsl #1

    add.w \c4, \c4, \tmp
    sub.w \c5, \c4, \tmp, lsl #1

    add.w \c3, \c3, \c2
    sub.w \c2, \c3, \c2, lsl #1

.endm

// 18
.macro _6_ntt_010 c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c4, \c5, \omega1, \Qprime, \Q, \c0

    add.w \c3, \c4, \c5

    sub.w \c3, \c1, \c3
    add.w \c4, \c4, \c1
    add.w \c1, \c1, \c5

    montgomery_mul_des_32 \c0, \tmp, \c2, \omega1, \Qprime, \Q, \c5

    add.w \c5, \c2, \tmp

    add.w \c0, \c2, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c2, \tmp, \c3
    sub.w \c3, \c2, \c3, lsl #1

    sub.w \c4, \c4, \c5
    add.w \c5, \c4, \c5, lsl #1
    neg.w \c5, \c5

.endm

// 18
.macro _6_ntt_001 c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c2, \c3, \omega1, \Qprime, \Q, \c0

    add.w \c5, \c2, \c3

    sub.w \c5, \c1, \c5
    add.w \c2, \c2, \c1
    add.w \c1, \c1, \c3

    montgomery_mul_des_32 \c0, \tmp, \c4, \omega1, \Qprime, \Q, \c3

    add.w \c3, \c4, \tmp

    add.w \c0, \c4, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c4, \tmp, \c5
    sub.w \c5, \c4, \c5, lsl #1

    sub.w \c2, \c2, \c3
    add.w \c3, \c2, \c3, lsl #1
    neg.w \c3, \c3

.endm

// small

.macro _6_ntt_100_small c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

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

// 13
.macro _6_ntt_011_small c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

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

// 17
.macro _6_ntt_101_small c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    mul \c5, \c4, \omega1

    add.w \c2, \c4, \c5

    sub.w \c2, \c0, \c2
    add.w \c5, \c5, \c0
    add.w \c0, \c0, \c4

    mul \tmp, \c3, \omega1

    add.w \c4, \c3, \tmp

    add.w \c0, \c0, \c3
    sub.w \c1, \c0, \c3, lsl #1

    add.w \c2, \c2, \tmp
    sub.w \c3, \c2, \tmp, lsl #1

    add.w \c5, \c5, \c4
    sub.w \c4, \c5, \c4, lsl #1

.endm

// 17
.macro _6_ntt_110_small c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    mul \c3, \c2, \omega1

    add.w \c4, \c2, \c3

    sub.w \c4, \c0, \c4
    add.w \c3, \c3, \c0
    add.w \c0, \c0, \c2

    mul \tmp, \c5, \omega1

    add.w \c2, \c5, \tmp

    add.w \c0, \c0, \c5
    sub.w \c1, \c0, \c5, lsl #1

    add.w \c4, \c4, \tmp
    sub.w \c5, \c4, \tmp, lsl #1

    add.w \c3, \c3, \c2
    sub.w \c2, \c3, \c2, lsl #1

.endm

// 18
.macro _6_ntt_010_small c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    mul \c4, \c5, \omega1

    add.w \c3, \c4, \c5

    sub.w \c3, \c1, \c3
    add.w \c4, \c4, \c1
    add.w \c1, \c1, \c5

    mul \tmp, \c2, \omega1

    add.w \c5, \c2, \tmp

    add.w \c0, \c2, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c2, \tmp, \c3
    sub.w \c3, \c2, \c3, lsl #1

    sub.w \c4, \c4, \c5
    add.w \c5, \c4, \c5, lsl #1
    neg.w \c5, \c5

.endm

// 18
.macro _6_ntt_001_small c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    mul \c2, \c3, \omega1

    add.w \c5, \c2, \c3

    sub.w \c5, \c1, \c5
    add.w \c2, \c2, \c1
    add.w \c1, \c1, \c3

    mul \tmp, \c4, \omega1

    add.w \c3, \c4, \tmp

    add.w \c0, \c4, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c4, \tmp, \c5
    sub.w \c5, \c4, \c5, lsl #1

    sub.w \c2, \c2, \c3
    add.w \c3, \c2, \c3, lsl #1
    neg.w \c3, \c3

.endm

// assuming c0, c1, c2, c3, tmp are low registers

// 12
.macro _6_ntt_100_low c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    smull \c4, \c2, \c3, \omega1
    smlal \c4, \c2, \c5, \omega2
    mul \c1, \c4, \Qprime
    smlal \c4, \c2, \c1, \Q

    add.w \c1, \c3, \c5
    add.w \c5, \c2, \c1

    sub.w \c4, \c0, \c5
    add.w \c5, \c5, \c0

    sub.w \c3, \c0, \c2
    add \c2, \c0

    add \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

// 13
.macro _6_ntt_011_low c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    smull \c5, \c3, \c2, \omega1
    smlal \c5, \c3, \c4, \omega2
    mul \c0, \c5, \Qprime
    smlal \c5, \c3, \c0, \Q

    add.w \c0, \c2, \c4
    add.w \c4, \c3, \c0

    add.w \c5, \c1, \c4
    neg.w \c5, \c5
    sub.w \c4, \c1, \c4

    add.w \c2, \c3, \c1
    subs.n \c3, \c1

    add \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1

.endm

// 17
.macro _6_ntt_101_low c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c5, \c4, \omega1, \Qprime, \Q, \c1

    add.w \c2, \c4, \c5

    add.w \c5, \c5, \c0
    subs.n \c2, \c0, \c2
    add \c0, \c4

    montgomery_mul_des_32 \c1, \tmp, \c3, \omega1, \Qprime, \Q, \c4

    add.w \c4, \c3, \tmp

    add \c0, \c3
    add \c2, \tmp
    sub.w \c1, \c0, \c3, lsl #1
    sub.w \c3, \c2, \tmp, lsl #1

    add.w \c5, \c5, \c4
    sub.w \c4, \c5, \c4, lsl #1

.endm

// 17
.macro _6_ntt_110_low c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c3, \c2, \omega1, \Qprime, \Q, \c1

    add.w \c4, \c2, \c3

    sub.w \c4, \c0, \c4
    add \c3, \c0
    add \c0, \c2

    montgomery_mul_des_32 \c1, \tmp, \c5, \omega1, \Qprime, \Q, \c2

    add.w \c2, \c5, \tmp

    add \c0, \c5
    add \c3, \c2

    sub.w \c1, \c0, \c5, lsl #1
    sub.w \c2, \c3, \c2, lsl #1

    add.w \c4, \c4, \tmp
    sub.w \c5, \c4, \tmp, lsl #1


.endm

// 18
.macro _6_ntt_010_low c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c4, \c5, \omega1, \Qprime, \Q, \c0

    add.w \c3, \c4, \c5

    add.w \c4, \c4, \c1
    subs.n \c3, \c1, \c3
    add \c1, \c5

    montgomery_mul_des_32 \c0, \tmp, \c2, \omega1, \Qprime, \Q, \c5

    add.w \c5, \c2, \tmp

    add \c0, \c2, \c1
    sub \c1, \c2, \c1

    add.w \c2, \tmp, \c3
    sub.w \c3, \c2, \c3, lsl #1

    sub.w \c4, \c4, \c5
    add.w \c5, \c4, \c5, lsl #1
    neg.w \c5, \c5

.endm

// 18
.macro _6_ntt_001_low c0, c1, c2, c3, c4, c5, omega1, omega2, Qprime, Q, tmp

    montgomery_mul_des_32 \tmp, \c2, \c3, \omega1, \Qprime, \Q, \c0

    add.w \c5, \c2, \c3

    sub.w \c5, \c1, \c5
    add \c2, \c1
    add \c1, \c3

    montgomery_mul_des_32 \c0, \tmp, \c4, \omega1, \Qprime, \Q, \c3

    add.w \c3, \c4, \tmp

    add.w \c0, \c4, \c1
    sub.w \c1, \c0, \c1, lsl #1

    add.w \c4, \tmp, \c5
    sub.w \c5, \c4, \c5, lsl #1

    neg \c3, \c3
    sub \c3, \c2
    add.w \c2, \c3, \c2, lsl #1

.endm























