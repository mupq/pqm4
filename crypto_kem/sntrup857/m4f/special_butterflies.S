
#include "macros.S"

.macro _3_layer_CT_butterfly_type_1010 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi4
    montgomery_mul \c2, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1

    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add_sub2 \c0, \c2, \c5, \c7

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    sub \c4, \c5
    sub \c6, \c7
    add.w \c5, \c4, \c5, lsl #1
    add.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_0101 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    add.w \c0, \c4, \c6
    sub.w \c2, \c0, \c6, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add.w \c5, \c1, \c7
    sub.w \c7, \c5, \c7, lsl #1

    add_sub2 \c4, \c6 \c1, \c3

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    rsb \c4, \c5
    rsb \c6, \c7
    sub.w \c5, \c4, \c5, lsl #1
    sub.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_0110 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi4
    montgomery_mul \c2, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1

    add.w \c0, \c4, \c2
    sub.w \c2, \c0, \c2, lsl #1

    mov.w \c5, \c1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    rsb \c4, \c6
    sub \c5, \c7
    sub.w \c6, \c4, \c6, lsl #1
    add.w \c7, \c5, \c7, lsl #1

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

.macro _3_layer_CT_butterfly_type_1001 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    mov.w \c4, \c0

    add.w \c0, \c4, \c6
    sub.w \c2, \c0, \c6, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add.w \c1, \c5, \c3
    sub.w \c3, \c1, \c3, lsl #1

    sub \c4, \c6
    rsb \c5, \c7
    add.w \c6, \c4, \c6, lsl #1
    sub.w \c7, \c5, \c7, lsl #1

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

.macro _3_layer_CT_butterfly_type_0100 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    add.w \c0, \c4, \c6
    sub.w \c2, \c0, \c6, lsl #1

    mov.w \c5, \c1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c6, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add \c4, \c6
    sub \c5, \c7
    sub.w \c6, \c4, \c6, lsl #1
    add.w \c7, \c5, \c7, lsl #1

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    rsb \c4, \c5
    rsb \c6, \c7
    sub.w \c5, \c4, \c5, lsl #1
    sub.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_0010 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi4
    montgomery_mul \c2, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1

    add.w \c0, \c4, \c2
    sub.w \c2, \c0, \c2, lsl #1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    rsb \c4, \c6
    add \c5, \c7
    sub.w \c6, \c4, \c6, lsl #1
    sub.w \c7, \c5, \c7, lsl #1

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    sub \c4, \c5
    sub \c6, \c7
    add.w \c5, \c4, \c5, lsl #1
    add.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_1011 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi4
    montgomery_mul \c2, \twiddle, \tmp0, \c6, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1

    add.w \c1, \c5, \c3
    sub.w \c3, \c1, \c3, lsl #1

    add \c0, \c2
    rsb \c5, \c7
    sub.w \c2, \c0, \c2, lsl #1
    sub.w \c7, \c5, \c7, lsl #1

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

.macro _3_layer_CT_butterfly_type_1101 c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    mov.w \c2, \c6

    vmov.w \twiddle, \xi4
    montgomery_mul \c2, \twiddle, \tmp0, \c4, \Qprime, \Q, \tmp1
    montgomery_mul \c3, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1

    add.w \c6, \c0, \c4
    sub.w \c4, \c6, \c4, lsl #1

    add.w \c5, \c1, \c7
    sub.w \c7, \c5, \c7, lsl #1

    add_sub2 \c0, \c2, \c1, \c3

    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

// butterflies for small inputs

.macro _3_layer_CT_butterfly_type_1010_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c2, \twiddle

    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    mul.w \c7, \c7, \twiddle

    add_sub2 \c0, \c2, \c5, \c7

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    sub \c4, \c5
    sub \c6, \c7
    add.w \c5, \c4, \c5, lsl #1
    add.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_0101_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    add.w \c0, \c4, \c6
    sub.w \c2, \c0, \c6, lsl #1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c6, \twiddle
    mul.w \c7, \c3, \twiddle

    add.w \c5, \c1, \c7
    sub.w \c7, \c5, \c7, lsl #1

    add_sub2 \c4, \c6 \c1, \c3

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    rsb \c4, \c5
    rsb \c6, \c7
    sub.w \c5, \c4, \c5, lsl #1
    sub.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_0110_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c2, \twiddle

    add.w \c0, \c4, \c2
    sub.w \c2, \c0, \c2, lsl #1

    mov.w \c5, \c1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    mul.w \c7, \c7, \twiddle

    rsb \c4, \c6
    sub \c5, \c7
    sub.w \c6, \c4, \c6, lsl #1
    add.w \c7, \c5, \c7, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

.macro _3_layer_CT_butterfly_type_1001_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    mov.w \c4, \c0

    add.w \c0, \c4, \c6
    sub.w \c2, \c0, \c6, lsl #1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c6, \twiddle
    mul.w \c7, \c3, \twiddle

    add.w \c1, \c5, \c3
    sub.w \c3, \c1, \c3, lsl #1

    sub \c4, \c6
    rsb \c5, \c7
    add.w \c6, \c4, \c6, lsl #1
    sub.w \c7, \c5, \c7, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

.macro _3_layer_CT_butterfly_type_0100_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    add.w \c0, \c4, \c6
    sub.w \c2, \c0, \c6, lsl #1

    mov.w \c5, \c1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c6, \twiddle
    mul.w \c7, \c7, \twiddle

    add \c4, \c6
    sub \c5, \c7
    sub.w \c6, \c4, \c6, lsl #1
    add.w \c7, \c5, \c7, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    rsb \c4, \c5
    rsb \c6, \c7
    sub.w \c5, \c4, \c5, lsl #1
    sub.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_0010_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c2, \twiddle

    add.w \c0, \c4, \c2
    sub.w \c2, \c0, \c2, lsl #1

    add.w \c1, \c5, \c7
    sub.w \c3, \c1, \c7, lsl #1

    mul.w \c7, \c7, \twiddle

    rsb \c4, \c6
    add \c5, \c7
    sub.w \c6, \c4, \c6, lsl #1
    sub.w \c7, \c5, \c7, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub2 \c0, \c1, \c2, \c3

    sub \c4, \c5
    sub \c6, \c7
    add.w \c5, \c4, \c5, lsl #1
    add.w \c7, \c6, \c7, lsl #1

.endm

.macro _3_layer_CT_butterfly_type_1011_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    vmov.w \twiddle, \xi2
    mul.w \c6, \c2, \twiddle
    mul.w \c7, \c3, \twiddle

    add.w \c4, \c0, \c6
    sub.w \c6, \c4, \c6, lsl #1

    add.w \c1, \c5, \c3
    sub.w \c3, \c1, \c3, lsl #1

    add \c0, \c2
    rsb \c5, \c7
    sub.w \c2, \c0, \c2, lsl #1
    sub.w \c7, \c5, \c7, lsl #1

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm

.macro _3_layer_CT_butterfly_type_1101_small c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi1, xi2, xi3, xi4, xi5, xi6, twiddle, Qprime, Q, tmp0, tmp1

    mov.w \c2, \c6

    vmov.w \twiddle, \xi2
    mul.w \c4, \c2, \twiddle
    mul.w \c7, \c3, \twiddle

    add.w \c6, \c0, \c4
    sub.w \c4, \c6, \c4, lsl #1

    add.w \c5, \c1, \c7
    sub.w \c7, \c5, \c7, lsl #1

    add_sub2 \c0, \c2, \c1, \c3

    vmov.w \twiddle, \xi4
    montgomery_mul \c3, \twiddle, \tmp0, \c3, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi5
    montgomery_mul \c5, \twiddle, \tmp0, \c5, \Qprime, \Q, \tmp1
    vmov.w \twiddle, \xi6
    montgomery_mul \c7, \twiddle, \tmp0, \c7, \Qprime, \Q, \tmp1
    add_sub4 \c0, \c1, \c2, \c3, \c4, \c5, \c6, \c7

.endm
















