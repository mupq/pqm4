
#ifndef SCHOOLBOOKS_I
#define SCHOOLBOOKS_I

#include "macros.i"

// compute hi(out) = a0 b1 + a1 b0 + zeta(a2 b3 + b3 b2)
.macro c1_4x4_16 out, a1a0, a3a2, b1b0, b3b2, twiddle, QQprime, tmp
    smuadx \out, \a3a2, \b3b2
    montgomery_16 \out, \QQprime, \tmp
    smultb \out, \out, \twiddle
    smladx \out, \a1a0, \b1b0, \out
    montgomery_16 \out, \QQprime, \tmp
.endm

// compute hi(out) = a0 b3 + a1 b2 + a2 b1 + a3 b0
.macro c3_4x4_16 out, a1a0, a3a2, b1b0, b3b2, twiddle, QQprime, tmp
    smuadx \out, \a1a0, \b3b2
    smladx \out, \a3a2, \b1b0, \out
    montgomery_16 \out, \QQprime, \tmp
.endm

// compute hi(out) = a0 b2 + a1 b1 + a2 b0 + zeta a3 b3
.macro c2_4x4_16 out, a2a0, a3a1, b2b0, b3b1, twiddle, QQprime, tmp
    smultt \out, \a3a1, \b3b1
    montgomery_16 \out, \QQprime, \tmp
    smultb \out, \out, \twiddle
    smlabb \out, \a3a1, \b3b1, \out
    smladx \out, \a2a0, \b2b0, \out
    montgomery_16 \out, \QQprime, \tmp
.endm

// compute hi(out) = a0 b0 + zeta(a1 b3 + a2 b2 + a3 b1)
.macro c0_4x4_16 out, a2a0, a3a1, b2b0, b3b1, twiddle, QQprime, tmp
    smultt \out, \a2a0, \b2b0
    smladx \out, \a3a1, \b3b1, \out
    montgomery_16 \out, \QQprime, \tmp
    smultb \out, \out, \twiddle
    smlabb \out, \a2a0, \b2b0, \out
    montgomery_16 \out, \QQprime, \tmp
.endm

.macro c3_4x4_32 out, a0, a1, a2, a3, b0, b1, b2, b3, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a0, \b3
    smlal \tmp, \out, \a1, \b2
    smlal \tmp, \out, \a2, \b1
    smlal \tmp, \out, \a3, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm

.macro c2_4x4_32 out, a0, a1, a2, a3, b0, b1, b2, b3, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a3, \b3
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
    smull \tmp, \out, \out, \twiddle
    smlal \tmp, \out, \a0, \b2
    smlal \tmp, \out, \a1, \b1
    smlal \tmp, \out, \a2, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm

.macro c1_4x4_32 out, a0, a1, a2, a3, b0, b1, b2, b3, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a2, \b3
    smlal \tmp, \out, \a3, \b2
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
    smull \tmp, \out, \out, \twiddle
    smlal \tmp, \out, \a0, \b1
    smlal \tmp, \out, \a1, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm

.macro c0_4x4_32 out, a0, a1, a2, a3, b0, b1, b2, b3, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a1, \b3
    smlal \tmp, \out, \a2, \b2
    smlal \tmp, \out, \a3, \b1
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
    smull \tmp, \out, \out, \twiddle
    smlal \tmp, \out, \a0, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm

.macro c1_3x3_32 out, a0, a1, a2, b0, b1, b2, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a2, \b2
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
    smull \tmp, \out, \out, \twiddle
    smlal \tmp, \out, \a0, \b1
    smlal \tmp, \out, \a1, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm

.macro c2_3x3_32 out, a0, a1, a2, b0, b1, b2, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a0, \b2
    smlal \tmp, \out, \a1, \b1
    smlal \tmp, \out, \a2, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm

.macro c0_3x3_32 out, a0, a1, a2, b0, b1, b2, twiddle, Qprime, Q, tmp, tmp2
    smull \tmp, \out, \a1, \b2
    smlal \tmp, \out, \a2, \b1
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
    smull \tmp, \out, \out, \twiddle
    smlal \tmp, \out, \a0, \b0
    mul \tmp2, \tmp, \Qprime
    smlal \tmp, \out, \tmp2, \Q
.endm





#endif

