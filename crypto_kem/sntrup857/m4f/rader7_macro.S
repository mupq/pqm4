#ifndef RADER7M
#define RADER7M
.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.macro montgomery_reduce tar, reduce_coef_qinvbot_qtop, tmp
    smulbb \tmp, \tar, \reduce_coef_qinvbot_qtop
    smlabt \tar, \tmp, \reduce_coef_qinvbot_qtop, \tar
.endm

.macro permute_05_21_43 f05, f01, f23, f45
    pkhbt \f05, \f01, \f45
    pkhtb \f01, \f01, \f23
    pkhtb \f23, \f23, \f45
.endm

.macro polymul_6x6_positive_cyclic_c1 result, f01, f23, f45, g01, g23, g45
    smuadx \result, \f01, \g01
    smladx \result, \f23, \g45, \result
    smladx \result, \f45, \g23, \result
.endm

.macro polymul_6x6_positive_cyclic_c3 result, f01, f23, f45, g01, g23, g45
    smuadx \result, \f01, \g23
    smladx \result, \f23, \g01, \result
    smladx \result, \f45, \g45, \result
.endm

.macro polymul_6x6_positive_cyclic_c5 result, f01, f23, f45, g01, g23, g45
    smuadx \result, \f01, \g45
    smladx \result, \f23, \g23, \result
    smladx \result, \f45, \g01, \result
.endm

.macro polymul_6x6_positive_cyclic_c0 result, f01, f23, f45, g05, g21, g43
    smuad \result, \f01, \g05
    smlad \result, \f23, \g43, \result
    smlad \result, \f45, \g21, \result
.endm

.macro polymul_6x6_positive_cyclic_c2 result, f01, f23, f45, g05, g21, g43
    smuad \result, \f01, \g21
    smlad \result, \f23, \g05, \result
    smlad \result, \f45, \g43, \result
.endm

.macro polymul_6x6_positive_cyclic_c4 result, f01, f23, f45, g05, g21, g43
    smuad \result, \f01, \g43
    smlad \result, \f23, \g21, \result
    smlad \result, \f45, \g05, \result
.endm

#endif