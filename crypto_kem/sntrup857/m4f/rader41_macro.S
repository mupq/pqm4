#ifndef RADER41M
#define RADER41M
.macro barrett_reduce tar, qinv, q, tmp
    smmulr \tmp, \tar, \qinv
    mls \tar, \tmp, \q, \tar
.endm

.macro montgomery_reduce tar, reduce_coef_qinvbot_qtop, tmp
    smulbb \tmp, \tar, \reduce_coef_qinvbot_qtop
    smlabt \tar, \tmp, \reduce_coef_qinvbot_qtop, \tar
.endm

@ polymul 10x10
.macro permute_09_21_43_65_87 f09, f01, f23, f45, f67, f89
    pkhbt \f09, \f01, \f89
    pkhtb \f01, \f01, \f23
    pkhtb \f23, \f23, \f45
    pkhtb \f45, \f45, \f67
    pkhtb \f67, \f67, \f89
.endm

.macro polymul_10x10_positive_cyclic_c1 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89
    smuadx \result, \f01, \g01
    smladx \result, \f23, \g89, \result
    smladx \result, \f45, \g67, \result
    smladx \result, \f67, \g45, \result
    smladx \result, \f89, \g23, \result
.endm

.macro polymul_10x10_positive_cyclic_c3 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89
    smuadx \result, \f01, \g23
    smladx \result, \f23, \g01, \result
    smladx \result, \f45, \g89, \result
    smladx \result, \f67, \g67, \result
    smladx \result, \f89, \g45, \result
.endm

.macro polymul_10x10_positive_cyclic_c5 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89
    smuadx \result, \f01, \g45
    smladx \result, \f23, \g23, \result
    smladx \result, \f45, \g01, \result
    smladx \result, \f67, \g89, \result
    smladx \result, \f89, \g67, \result
.endm

.macro polymul_10x10_positive_cyclic_c7 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89
    smuadx \result, \f01, \g67
    smladx \result, \f23, \g45, \result
    smladx \result, \f45, \g23, \result
    smladx \result, \f67, \g01, \result
    smladx \result, \f89, \g89, \result
.endm

.macro polymul_10x10_positive_cyclic_c9 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89
    smuadx \result, \f01, \g89
    smladx \result, \f23, \g67, \result
    smladx \result, \f45, \g45, \result
    smladx \result, \f67, \g23, \result
    smladx \result, \f89, \g01, \result
.endm

.macro polymul_10x10_positive_cyclic_c0 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87
    smuad \result, \f01, \g09
    smlad \result, \f23, \g87, \result
    smlad \result, \f45, \g65, \result
    smlad \result, \f67, \g43, \result
    smlad \result, \f89, \g21, \result
.endm

.macro polymul_10x10_positive_cyclic_c2 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87
    smuad \result, \f01, \g21
    smlad \result, \f23, \g09, \result
    smlad \result, \f45, \g87, \result
    smlad \result, \f67, \g65, \result
    smlad \result, \f89, \g43, \result
.endm

.macro polymul_10x10_positive_cyclic_c4 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87
    smuad \result, \f01, \g43
    smlad \result, \f23, \g21, \result
    smlad \result, \f45, \g09, \result
    smlad \result, \f67, \g87, \result
    smlad \result, \f89, \g65, \result
.endm

.macro polymul_10x10_positive_cyclic_c6 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87
    smuad \result, \f01, \g65
    smlad \result, \f23, \g43, \result
    smlad \result, \f45, \g21, \result
    smlad \result, \f67, \g09, \result
    smlad \result, \f89, \g87, \result
.endm

.macro polymul_10x10_positive_cyclic_c8 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87
    smuad \result, \f01, \g87
    smlad \result, \f23, \g65, \result
    smlad \result, \f45, \g43, \result
    smlad \result, \f67, \g21, \result
    smlad \result, \f89, \g09, \result
.endm

.macro polymul_10x10_negative_cyclic_c1 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89, tmp
    smuadx \result, \f01, \g01
    smuadx \tmp, \f23, \g89
    smladx \tmp, \f45, \g67, \tmp
    smladx \tmp, \f67, \g45, \tmp
    smladx \tmp, \f89, \g23, \tmp
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c3 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89, tmp
    smuadx \result, \f01, \g23
    smladx \result, \f23, \g01, \result
    smuadx \tmp, \f45, \g89
    smladx \tmp, \f67, \g67, \tmp
    smladx \tmp, \f89, \g45, \tmp
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c5 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89, tmp
    smuadx \result, \f01, \g45
    smladx \result, \f23, \g23, \result
    smladx \result, \f45, \g01, \result
    smuadx \tmp, \f67, \g89
    smladx \tmp, \f89, \g67, \tmp
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c7 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89, tmp
    smuadx \result, \f01, \g67
    smladx \result, \f23, \g45, \result
    smladx \result, \f45, \g23, \result
    smladx \result, \f67, \g01, \result
    smuadx \tmp, \f89, \g89
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c9 result, f01, f23, f45, f67, f89, g01, g23, g45, g67, g89, tmp
    smuadx \result, \f01, \g89
    smladx \result, \f23, \g67, \result
    smladx \result, \f45, \g45, \result
    smladx \result, \f67, \g23, \result
    smladx \result, \f89, \g01, \result
.endm

.macro polymul_10x10_negative_cyclic_c0 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87, tmp
    smusd \result, \f01, \g09
    smuad \tmp, \f23, \g87
    smlad \tmp, \f45, \g65, \tmp
    smlad \tmp, \f67, \g43, \tmp
    smlad \tmp, \f89, \g21, \tmp
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c2 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87, tmp
    smuad \result, \f01, \g21
    smlsd \result, \f23, \g09, \result
    smuad \tmp, \f45, \g87
    smlad \tmp, \f67, \g65, \tmp
    smlad \tmp, \f89, \g43, \tmp
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c4 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87, tmp
    smuad \result, \f01, \g43
    smlad \result, \f23, \g21, \result
    smlsd \result, \f45, \g09, \result
    smuad \tmp, \f67, \g87
    smlad \tmp, \f89, \g65, \tmp
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c6 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87, tmp
    smuad \result, \f01, \g65
    smlad \result, \f23, \g43, \result
    smlad \result, \f45, \g21, \result
    smlsd \result, \f67, \g09, \result
    smuad \tmp, \f89, \g87
    sub.w \result, \result, \tmp
.endm

.macro polymul_10x10_negative_cyclic_c8 result, f01, f23, f45, f67, f89, g09, g21, g43, g65, g87, tmp
    smuad \result, \f01, \g87
    smlad \result, \f23, \g65, \result
    smlad \result, \f45, \g43, \result
    smlad \result, \f67, \g21, \result
    smlsd \result, \f89, \g09, \result
.endm

#endif