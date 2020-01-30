#ifndef MACROS_INVNTT_I
#define MACROS_INVNTT_I

#include "macros.i"

.macro doubleinvbutterfly_last_stage a0, a1, twiddle, tmp ,tmp2, q, qinv
  pkhbt \tmp, \a0, \a1, lsl#16
  pkhtb \tmp2, \a1, \a0, asr#16
  uadd16 \a1, \tmp, \tmp2
  usub16 \tmp2, \tmp, \tmp2
  smulbt \tmp, \a1, \twiddle
  smultt \a1, \a1, \twiddle
  montgomery \q, \qinv, \a1, \a0
  montgomery \q, \qinv, \tmp, \a1
  pkhtb \a1, \a0, \a1, asr#16
  smulbb \a0, \twiddle, \tmp2
  smulbt \tmp2, \twiddle, \tmp2
  montgomery \q, \qinv, \tmp2, \tmp
  montgomery \q, \qinv, \a0, \tmp2
  pkhbt \a0, \a1, \tmp2
  pkhtb \a1, \tmp, \a1, asr#16
.endm

.macro doubleinvbutterfly tb1, tb2, a0, a1, twiddle, tmp, tmp2, q, qinv
  usub16 \tmp, \a0, \a1
  uadd16 \a0, \a0, \a1

  smulb\tb1 \a1, \tmp, \twiddle
  smult\tb2 \tmp, \tmp, \twiddle
  montgomery \q, \qinv, \a1, \tmp2
  montgomery \q, \qinv, \tmp, \a1
  pkhtb \a1, \a1, \tmp2, asr#16
.endm

.macro two_doubleinvbutterfly tb1, tb2, a0, a1, a2, a3, twiddle, tmp, tmp2, q, qinv
  doubleinvbutterfly \tb1, \tb2, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doubleinvbutterfly \tb1, \tb2, \a2, \a3, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

#endif /* MACROS_INVNTT_I */
