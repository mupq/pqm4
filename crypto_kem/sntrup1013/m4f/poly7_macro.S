#ifndef RADER13M
#define RADER13M

.macro crt16x2 free, a, b
    sadd16 \free, \a, \b
    ssub16 \b, \a, \b
.endm

.macro pack16x2 free, a, b
    pkhbt \free, \a, \b, lsl #16
    pkhtb \a, \b, \a, asr #16
.endm

.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.macro montgomery_reduce tar, reduce_coef_qinvbot_qtop, tmp
    smulbb \tmp, \tar, \reduce_coef_qinvbot_qtop
    smlabt \tar, \tmp, \reduce_coef_qinvbot_qtop, \tar
.endm

.macro polymul_7x7_c1 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smuadx \ans, \f01, \g01
.endm

.macro polymul_7x7_c3 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smuadx \ans, \f01, \g23
    smladx \ans, \f23, \g01, \ans
.endm

.macro polymul_7x7_c5 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smuadx \ans, \f01, \g45
    smladx \ans, \f23, \g23, \ans
    smladx \ans, \f45, \g01, \ans
.endm

.macro polymul_7x7_c7 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smultb \ans, \f01, \g6
    smladx \ans, \f23, \g45, \ans
    smladx \ans, \f45, \g23, \ans
    smlabt \ans, \f6, \g01, \ans
.endm

.macro polymul_7x7_c9 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smultb \ans, \f23, \g6
    smladx \ans, \f45, \g45, \ans
    smlabt \ans, \f6, \g23, \ans
.endm

.macro polymul_7x7_c11 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smultb \ans, \f45, \g6
    smlabt \ans, \f6, \g45, \ans
.endm

.macro polymul_7x7_c0 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f01, \g01
.endm

.macro polymul_7x7_c2 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f01, \g23
    smlatt \ans, \f01, \g01, \ans
    smlabb \ans, \f23, \g01, \ans
.endm

.macro polymul_7x7_c4 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f01, \g45
    smlatt \ans, \f01, \g23, \ans
    smlabb \ans, \f23, \g23, \ans
    smlatt \ans, \f23, \g01, \ans
    smlabb \ans, \f45, \g01, \ans
.endm

.macro polymul_7x7_c6 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f01, \g6
    smlatt \ans, \f01, \g45, \ans
    smlabb \ans, \f23, \g45, \ans
    smlatt \ans, \f23, \g23, \ans
    smlabb \ans, \f45, \g23, \ans
    smlatt \ans, \f45, \g01, \ans
    smlabb \ans, \f6, \g01, \ans
.endm

.macro polymul_7x7_c8 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f23, \g6
    smlatt \ans, \f23, \g45, \ans
    smlabb \ans, \f45, \g45, \ans
    smlatt \ans, \f45, \g23, \ans
    smlabb \ans, \f6, \g23, \ans
.endm

.macro polymul_7x7_c10 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f45, \g6
    smlatt \ans, \f45, \g45, \ans
    smlabb \ans, \f6, \g45, \ans
.endm

.macro polymul_7x7_c12 ans, f01, f23, f45, f6, g01, g23, g45, g6
    smulbb \ans, \f6, \g6
.endm

#endif