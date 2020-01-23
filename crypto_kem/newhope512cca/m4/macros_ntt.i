#ifndef MACROS_NTT_I
#define MACROS_NTT_I

#include "macros.i"

.macro doublebutterfly tb1, tb2, a0, a1, twiddle, tmp, tmp2, q, qinv
  smulb\tb1 \tmp, \a1, \twiddle
  smult\tb2 \a1, \a1, \twiddle
  montgomery \q, \qinv, \tmp, \tmp2
  montgomery \q, \qinv, \a1, \tmp
  pkhtb \tmp2, \tmp, \tmp2, asr#16
  usub16 \a1, \a0, \tmp2
  uadd16 \a0, \a0, \tmp2
.endm

.macro two_doublebutterfly tb1, tb2, a0, a1, a2, a3, twiddle, tmp, tmp2, q, qinv
  doublebutterfly \tb1, \tb2, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doublebutterfly \tb1, \tb2, \a2, \a3, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

.macro doublebutterfly_first_stage a0, a1, twiddle, tmp, tmp2, q, qinv
  smultb \tmp, \a0, \twiddle
  smultb \tmp2, \a1, \twiddle
  pkhbt \a1, \a0, \a1, lsl#16
  montgomery \q, \qinv, \tmp, \a0  // twiddle is used as temp register
  montgomery \q, \qinv, \tmp2, \tmp
  pkhtb \tmp2, \tmp, \a0, asr#16  // twiddle is used as temp register
  usub16 \tmp, \a1, \tmp2
  uadd16 \tmp2, \a1, \tmp2
  pkhbt \a0, \tmp2, \tmp, lsl#16
  pkhtb \a1, \tmp, \tmp2, asr#16
.endm

#endif /* MACROS_NTT_I */
