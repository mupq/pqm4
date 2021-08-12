#ifndef RADER11M
#define RADER11M

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

@ polymul 10x10
.macro permute10_09_21_43_65_87 f09, f01, f23, f45, f67, f89
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

@ polymul 8x8
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

@polymul 4x4
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

@ positive cyclic
.macro polymul_5x5_positive_cyclic_c0_bot ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smulbb \ans, \f0, \w01
    smlabb \ans, \f1, \w4_bot, \ans
    smlabt \ans, \f2, \w23, \ans
    smlabb \ans, \f3, \w23, \ans
    smlabt \ans, \f4, \w01, \ans
.endm

.macro polymul_5x5_positive_cyclic_c0_top ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smultb \ans, \f0, \w01
    smlatb \ans, \f1, \w4_bot, \ans
    smlatt \ans, \f2, \w23, \ans
    smlatb \ans, \f3, \w23, \ans
    smlatt \ans, \f4, \w01, \ans
.endm

.macro polymul_5x5_positive_cyclic_c1_bot ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smulbt \ans, \f0, \w01
    smlabb \ans, \f1, \w01, \ans
    smlabb \ans, \f2, \w4_bot, \ans
    smlabt \ans, \f3, \w23, \ans
    smlabb \ans, \f4, \w23, \ans
.endm

.macro polymul_5x5_positive_cyclic_c1_top ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smultt \ans, \f0, \w01
    smlatb \ans, \f1, \w01, \ans
    smlatb \ans, \f2, \w4_bot, \ans
    smlatt \ans, \f3, \w23, \ans
    smlatb \ans, \f4, \w23, \ans
.endm

.macro polymul_5x5_positive_cyclic_c2_bot ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smulbb \ans, \f0, \w23
    smlabt \ans, \f1, \w01, \ans
    smlabb \ans, \f2, \w01, \ans
    smlabb \ans, \f3, \w4_bot, \ans
    smlabt \ans, \f4, \w23, \ans
.endm

.macro polymul_5x5_positive_cyclic_c2_top ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smultb \ans, \f0, \w23
    smlatt \ans, \f1, \w01, \ans
    smlatb \ans, \f2, \w01, \ans
    smlatb \ans, \f3, \w4_bot, \ans
    smlatt \ans, \f4, \w23, \ans
.endm

.macro polymul_5x5_positive_cyclic_c3_bot ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smulbt \ans, \f0, \w23
    smlabb \ans, \f1, \w23, \ans
    smlabt \ans, \f2, \w01, \ans
    smlabb \ans, \f3, \w01, \ans
    smlabb \ans, \f4, \w4_bot, \ans
.endm

.macro polymul_5x5_positive_cyclic_c3_top ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smultt \ans, \f0, \w23
    smlatb \ans, \f1, \w23, \ans
    smlatt \ans, \f2, \w01, \ans
    smlatb \ans, \f3, \w01, \ans
    smlatb \ans, \f4, \w4_bot, \ans
.endm

.macro polymul_5x5_positive_cyclic_c4_bot ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smulbb \ans, \f0, \w4_bot
    smlabt \ans, \f1, \w23, \ans
    smlabb \ans, \f2, \w23, \ans
    smlabt \ans, \f3, \w01, \ans
    smlabb \ans, \f4, \w01, \ans
.endm

.macro polymul_5x5_positive_cyclic_c4_top ans, f0, f1, f2, f3, f4, w01, w23, w4_bot
    smultb \ans, \f0, \w4_bot
    smlatt \ans, \f1, \w23, \ans
    smlatb \ans, \f2, \w23, \ans
    smlatt \ans, \f3, \w01, \ans
    smlatb \ans, \f4, \w01, \ans
.endm

@ negative cyclic
.macro polymul_5x5_negative_cyclic_c0_bot ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smulbt \ans, \f0, \w0_top
    smulbt \tmp, \f1, \w34
    smlabb \tmp, \f2, \w34, \tmp
    smlabt \tmp, \f3, \w12, \tmp
    smlabb \tmp, \f4, \w12, \tmp
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c0_top ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smultt \ans, \f0, \w0_top
    smultt \tmp, \f1, \w34
    smlatb \tmp, \f2, \w34, \tmp
    smlatt \tmp, \f3, \w12, \tmp
    smlatb \tmp, \f4, \w12, \tmp
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c1_bot ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smulbb \ans, \f0, \w12
    smlabt \ans, \f1, \w0_top, \ans
    smulbt \tmp, \f2, \w34
    smlabb \tmp, \f3, \w34, \tmp
    smlabt \tmp, \f4, \w12, \tmp
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c1_top ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smultb \ans, \f0, \w12
    smlatt \ans, \f1, \w0_top, \ans
    smultt \tmp, \f2, \w34
    smlatb \tmp, \f3, \w34, \tmp
    smlatt \tmp, \f4, \w12, \tmp
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c2_bot ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smulbt \ans, \f0, \w12
    smlabb \ans, \f1, \w12, \ans
    smlabt \ans, \f2, \w0_top, \ans
    smulbt \tmp, \f3, \w34
    smlabb \tmp, \f4, \w34, \tmp
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c2_top ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smultt \ans, \f0, \w12
    smlatb \ans, \f1, \w12, \ans
    smlatt \ans, \f2, \w0_top, \ans
    smultt \tmp, \f3, \w34
    smlatb \tmp, \f4, \w34, \tmp
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c3_bot ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smulbb \ans, \f0, \w34
    smlabt \ans, \f1, \w12, \ans
    smlabb \ans, \f2, \w12, \ans
    smlabt \ans, \f3, \w0_top, \ans
    smulbt \tmp, \f4, \w34
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c3_top ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smultb \ans, \f0, \w34
    smlatt \ans, \f1, \w12, \ans
    smlatb \ans, \f2, \w12, \ans
    smlatt \ans, \f3, \w0_top, \ans
    smultt \tmp, \f4, \w34
    sub.w \ans, \ans, \tmp
.endm

.macro polymul_5x5_negative_cyclic_c4_bot ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smulbt \ans, \f0, \w34
    smlabb \ans, \f1, \w34, \ans
    smlabt \ans, \f2, \w12, \ans
    smlabb \ans, \f3, \w12, \ans
    smlabt \ans, \f4, \w0_top, \ans
.endm

.macro polymul_5x5_negative_cyclic_c4_top ans, f0, f1, f2, f3, f4, w12, w34, w0_top, tmp
    smultt \ans, \f0, \w34
    smlatb \ans, \f1, \w34, \ans
    smlatt \ans, \f2, \w12, \ans
    smlatb \ans, \f3, \w12, \ans
    smlatt \ans, \f4, \w0_top, \ans
.endm

#endif