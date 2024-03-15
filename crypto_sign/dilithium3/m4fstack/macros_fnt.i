// 2
.macro ldrstr2 ldrstr, target, c0, c1, mem0, mem1
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
.endm

// 2
.macro ldrstr2jump ldrstr, target, c0, c1, mem1, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c0, [\target], \jump
.endm

// 4
.macro ldrstr4 ldrstr, target, c0, c1, c2, c3, mem0, mem1, mem2, mem3
    \ldrstr \c0, [\target, \mem0]
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
.endm

// 4
.macro ldrstr4jump ldrstr, target, c0, c1, c2, c3, mem1, mem2, mem3, jump
    \ldrstr \c1, [\target, \mem1]
    \ldrstr \c2, [\target, \mem2]
    \ldrstr \c3, [\target, \mem3]
    \ldrstr \c0, [\target], \jump
.endm

// 8
.macro ldrstrvec ldrstr, target, c0, c1, c2, c3, c4, c5, c6, c7, mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7
    ldrstr4 \ldrstr, \target, \c0, \c1, \c2, \c3, \mem0, \mem1, \mem2, \mem3
    ldrstr4 \ldrstr, \target, \c4, \c5, \c6, \c7, \mem4, \mem5, \mem6, \mem7
.endm

// 8
.macro ldrstrvecjump ldrstr, target, c0, c1, c2, c3, c4, c5, c6, c7, mem1, mem2, mem3, mem4, mem5, mem6, mem7, jump
    ldrstr4 \ldrstr, \target, \c4, \c5, \c6, \c7, \mem4, \mem5, \mem6, \mem7
    ldrstr4jump \ldrstr, \target, \c0, \c1, \c2, \c3, \mem1, \mem2, \mem3, \jump
.endm



.macro addSub1 c0, c1
    add.w \c0, \c1
    sub.w \c1, \c0, \c1, lsl #1
.endm

.macro addSub2 c0, c1, c2, c3
    add \c0, \c1
    add \c2, \c3
    sub.w \c1, \c0, \c1, lsl #1
    sub.w \c3, \c2, \c3, lsl #1
.endm

.macro addSub4 c0, c1, c2, c3, c4, c5, c6, c7
    add \c0, \c1
    add \c2, \c3
    add \c4, \c5
    add \c6, \c7
    sub.w \c1, \c0, \c1, lsl #1
    sub.w \c3, \c2, \c3, lsl #1
    sub.w \c5, \c4, \c5, lsl #1
    sub.w \c7, \c6, \c7, lsl #1
.endm

// 2
.macro barrett_32 a, Qbar, Q, tmp
    smmulr.w \tmp, \a, \Qbar
    mls.w \a, \tmp, \Q, \a
.endm

.macro FNT_CT_butterfly c0, c1, logW
    add.w \c0, \c0, \c1, lsl #\logW
    sub.w \c1, \c0, \c1, lsl #(\logW+1)
.endm

.macro shift_subAdd c0, c1, shlv
    sub.w \c0, \c0, \c1, lsl #(\shlv)
    add.w \c1, \c0, \c1, lsl #(\shlv+1)
.endm

.macro FNT_CT_ibutterfly c0, c1, shlv
    shift_subAdd \c0, \c1, \shlv
.endm

// 46
.macro _3_layer_CT_32_FNT c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp, tmp2
    vmov.w \twiddle, \xi0

    // c0, c1, c2, c3, c4, c5, c6, c7, c8
    // 0,4
    mla \tmp, \c4, \twiddle, \c0
    mls \c4, \c4, \twiddle, \c0

    // 1,5
    mla \c0, \c5, \twiddle, \c1
    mls \c5, \c5, \twiddle, \c1

    // 2,6
    mla \c1, \c6, \twiddle, \c2
    mls \c6, \c6, \twiddle, \c2

    // 3,7
    mla \c2, \c7, \twiddle, \c3
    mls \c7, \c7, \twiddle, \c3

    // tmp, c0, c1, c2, c4, c5, c6, c7

    barrett_32 \tmp, \Qprime, \Q, \c3
    barrett_32 \c0, \Qprime, \Q, \c3
    barrett_32 \c1, \Qprime, \Q, \c3
    barrett_32 \c2, \Qprime, \Q, \c3
    barrett_32 \c4, \Qprime, \Q, \c3
    barrett_32 \c5, \Qprime, \Q, \c3
    barrett_32 \c6, \Qprime, \Q, \c3
    barrett_32 \c7, \Qprime, \Q, \c3

    vmov.w \twiddle, \xi1
    // 0,2
    mla \tmp2, \c1, \twiddle, \tmp
    mls \c3, \c1, \twiddle, \tmp

    // 1,3
    mla \tmp, \c2, \twiddle, \c0
    mls \c0, \c2, \twiddle, \c0

    vmov.w \twiddle, \xi2

    // 4,6
    mla \c2, \c6, \twiddle, \c4
    mls \c1, \c6, \twiddle, \c4

    // 5,7
    mla \c6, \c7, \twiddle, \c5
    mls \c7, \c7, \twiddle, \c5

    // tmp2, tmp, c3, c0 | c2, c6, c1, c7

    // 4,5
    vmov.w \twiddle, \xi5
    mla \c4, \c6, \twiddle, \c2
    mls \c5, \c6, \twiddle, \c2

    // 6,7
    vmov.w \twiddle, \xi6
    mla \c6, \c7, \twiddle, \c1
    mls \c7, \c7, \twiddle, \c1

    // 2,3
    vmov.w \twiddle, \xi4
    mla \c2, \c0, \twiddle, \c3
    mls \c3, \c0, \twiddle, \c3

    // 0,1
    vmov.w \twiddle, \xi3
    mla \c0, \tmp, \twiddle, \tmp2
    mls \c1, \tmp, \twiddle, \tmp2
.endm