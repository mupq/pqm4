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

.macro coef_multiply_w_16bitx2_wbot ans, coef, w, qinv, q, tmp0, tmp1
    smulbb \tmp0, \w, \coef
    smulbt \tmp1, \w, \coef
    smmulr \ans, \tmp0, \qinv
    mls \tmp0, \ans, \q, \tmp0
    smmulr \ans, \tmp1, \qinv
    mls \tmp1, \ans, \q, \tmp1
    pkhbt \ans, \tmp0, \tmp1, lsl #16
.endm

.macro coef_multiply_w_16bitx2_wtop ans, coef, w, qinv, q, tmp0, tmp1
    smultb \tmp0, \w, \coef
    smultt \tmp1, \w, \coef
    smmulr \ans, \tmp0, \qinv
    mls \tmp0, \ans, \q, \tmp0
    smmulr \ans, \tmp1, \qinv
    mls \tmp1, \ans, \q, \tmp1
    pkhbt \ans, \tmp0, \tmp1, lsl #16
.endm

.macro permute_05_21_43 f05, f01, f23, f45
    pkhbt \f05, \f01, \f45
    pkhtb \f01, \f01, \f23
    pkhtb \f23, \f23, \f45
.endm

.macro polymul_6x6_c1_positive_cyclic result, f01, f23, f45, g01, g23, g45, qinv, q, tmp
    smuadx \result, \f01, \g01
    smladx \result, \f23, \g45, \result
    smladx \result, \f45, \g23, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c3_positive_cyclic result, f01, f23, f45, g01, g23, g45, qinv, q, tmp
    smuadx \result, \f01, \g23
    smladx \result, \f23, \g01, \result
    smladx \result, \f45, \g45, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c5_positive_cyclic result, f01, f23, f45, g01, g23, g45, qinv, q, tmp
    smuadx \result, \f01, \g45
    smladx \result, \f23, \g23, \result
    smladx \result, \f45, \g01, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c0_positive_cyclic result, f01, f23, f45, g05, g21, g43, qinv, q, tmp
    smuad \result, \f01, \g05
    smlad \result, \f23, \g43, \result
    smlad \result, \f45, \g21, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c2_positive_cyclic result, f01, f23, f45, g05, g21, g43, qinv, q, tmp
    smuad \result, \f01, \g21
    smlad \result, \f23, \g05, \result
    smlad \result, \f45, \g43, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c4_positive_cyclic result, f01, f23, f45, g05, g21, g43, qinv, q, tmp
    smuad \result, \f01, \g43
    smlad \result, \f23, \g21, \result
    smlad \result, \f45, \g05, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c1_negative_cyclic result, f01, f23, f45, g01, g23, g45, qinv, q, tmp
    smuadx \result, \f01, \g01
    smuadx \tmp, \f23, \g45
    smladx \tmp, \f45, \g23, \tmp
    sub.w \result, \result, \tmp
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c3_negative_cyclic result, f01, f23, f45, g01, g23, g45, qinv, q, tmp
    smuadx \result, \f01, \g23
    smladx \result, \f23, \g01, \result
    smuadx \tmp, \f45, \g45
    sub.w \result, \result, \tmp
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c5_negative_cyclic result, f01, f23, f45, g01, g23, g45, qinv, q, tmp
    smuadx \result, \f01, \g45
    smladx \result, \f23, \g23, \result
    smladx \result, \f45, \g01, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c0_negative_cyclic result, f01, f23, f45, g05, g21, g43, qinv, q, tmp
    smusd \result, \f01, \g05
    smuad \tmp, \f23, \g43
    smlad \tmp, \f45, \g21, \tmp
    sub.w \result, \result, \tmp
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c2_negative_cyclic result, f01, f23, f45, g05, g21, g43, qinv, q, tmp
    smuad \result, \f01, \g21
    smlsd \result, \f23, \g05, \result
    smuad \tmp, \f45, \g43
    sub.w \result, \result, \tmp
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro polymul_6x6_c4_negative_cyclic result, f01, f23, f45, g05, g21, g43, qinv, q, tmp
    smuad \result, \f01, \g43
    smlad \result, \f23, \g21, \result
    smlsd \result, \f45, \g05, \result
    smmulr \tmp, \result, \qinv
    mls \result, \tmp, \q, \result
.endm

.macro permute_07_21_43_65 f07, f01, f23, f45, f67
    pkhbt \f07, \f01, \f67
    pkhtb \f01, \f01, \f23
    pkhtb \f23, \f23, \f45
    pkhtb \f45, \f45, \f67
.endm

.macro polymul_8x8_c0 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smulbb \ans, \f01, \g07
.endm

.macro polymul_8x8_c1 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f01, \g01
.endm

.macro polymul_8x8_c2 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smuad \ans, \f01, \g21
    smlabb \ans, \f23, \g07, \ans
.endm

.macro polymul_8x8_c3 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f01, \g23
    smladx \ans, \f23, \g01, \ans
.endm

.macro polymul_8x8_c4 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smuad \ans, \f01, \g43
    smlad \ans, \f23, \g21, \ans
    smlabb \ans, \f45, \g07, \ans
.endm

.macro polymul_8x8_c5 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f01, \g45
    smladx \ans, \f23, \g23, \ans
    smladx \ans, \f45, \g01, \ans
.endm

.macro polymul_8x8_c6 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smuad \ans, \f01, \g65
    smlad \ans, \f23, \g43, \ans
    smlad \ans, \f45, \g21, \ans
    smlabb \ans, \f67, \g07, \ans
.endm

.macro polymul_8x8_c7 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f01, \g67
    smladx \ans, \f23, \g45, \ans
    smladx \ans, \f45, \g23, \ans
    smladx \ans, \f67, \g01, \ans
.endm

.macro polymul_8x8_c8 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smultt \ans, \f01, \g07
    smlad \ans, \f23, \g65, \ans
    smlad \ans, \f45, \g43, \ans
    smlad \ans, \f67, \g21, \ans
.endm

.macro polymul_8x8_c9 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f23, \g67
    smladx \ans, \f45, \g45, \ans
    smladx \ans, \f67, \g23, \ans
.endm

.macro polymul_8x8_c10 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smultt \ans, \f23, \g07
    smlad \ans, \f45, \g65, \ans
    smlad \ans, \f67, \g43, \ans
.endm

.macro polymul_8x8_c11 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f45, \g67
    smladx \ans, \f67, \g45, \ans
.endm

.macro polymul_8x8_c12 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smultt \ans, \f45, \g07
    smlad \ans, \f67, \g65, \ans
.endm

.macro polymul_8x8_c13 ans, f01, f23, f45, f67, g01, g23, g45, g67
    smuadx \ans, \f67, \g67
.endm

.macro polymul_8x8_c14 ans, f01, f23, f45, f67, g07, g21, g43, g65
    smultt \ans, \f67, \g07
.endm

.macro permute_03_21 f03, f01, f23
    pkhbt \f03, \f01, \f23
    pkhtb \f01, \f01, \f23
.endm

.macro polymul_4x4_c0 ans, f01, f23, g03, g21
    smulbb \ans, \f01, \g03
.endm

.macro polymul_4x4_c2 ans, f01, f23, g03, g21
    smuad \ans, \f01, \g21
    smlabb \ans, \f23, \g03, \ans
.endm

.macro polymul_4x4_c4 ans, f01, f23, g03, g21
    smultt \ans, \f01, \g03
    smlad \ans, \f23, \g21, \ans
.endm

.macro polymul_4x4_c6 ans, f01, f23, g03, g21
    smultt \ans, \f23, \g03
.endm

.macro polymul_4x4_c1 ans, f01, f23, g01, g23
    smuadx \ans, \f01, \g01
.endm

.macro polymul_4x4_c3 ans, f01, f23, g01, g23
    smuadx \ans, \f01, \g23
    smladx \ans, \f23, \g01, \ans
.endm

.macro polymul_4x4_c5 ans, f01, f23, g01, g23
    smuadx \ans, \f23, \g23
.endm

#endif