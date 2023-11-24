
.macro gf16_madd_bitsliced accu0, accu1, accu2, accu3, mat0, mat1, mat2, mat3, b_32, tmp0, tmp1, tmp2, tmp3
    eor.w \tmp0, \mat0, \mat3          // tmp0 = a[0] ^ a[1]
    eor.w \tmp1, \mat2, \mat3          // tmp1 = a[2] ^ a[3]
    eor.w \tmp2, \mat1, \mat2          // tmp2 = a[1] ^ a[2]

    tst.w \b_32, #1
    nop.n
    itttt ne
    eorne.w \accu0, \accu0, \mat0      // out[0] ^= (b[0] & a[0])
    eorne.w \accu1, \accu1, \mat1      // out[1] ^= (b[0] & a[1])
    eorne.w \accu2, \accu2, \mat2      // out[2] ^= (b[0] & a[2])
    eorne.w \accu3, \accu3, \mat3      // out[3] ^= (b[0] & a[3])

    tst.w \b_32, #2
    nop.n
    itttt ne
    eorne.w \accu0, \accu0, \mat3      // out[0] ^= (b[1] & a[3])
    eorne.w \accu1, \accu1, \tmp0      // out[1] ^= (b[1] & (a[0] ^ a[3]))
    eorne.w \accu2, \accu2, \mat1      // out[2] ^= (b[1] & a[1])
    eorne.w \accu3, \accu3, \mat2      // out[3] ^= (b[1] & a[2])

    tst.w \b_32, #4
    nop.n
    itttt ne
    eorne.w \accu0, \accu0, \mat2      // out[0] ^= (b[2] & a[2])
    eorne.w \accu1, \accu1, \tmp1      // out[1] ^= (b[2] & (a[2] ^ a[3]))
    eorne.w \accu2, \accu2, \tmp0      // out[2] ^= (b[2] & (a[0] ^ a[3]))
    eorne.w \accu3, \accu3, \mat1      // out[3] ^= (b[2] & a[1])

    tst.w \b_32, #8
    nop.n
    itttt ne
    eorne.w \accu0, \accu0, \mat1      // out[0] ^= (b[3] & a[1])
    eorne.w \accu1, \accu1, \tmp2      // out[1] ^= (b[2] & (a[1] ^ a[2]))
    eorne.w \accu2, \accu2, \tmp1      // out[2] ^= (b[2] & (a[2] ^ a[3]))
    eorne.w \accu3, \accu3, \tmp0      // out[3] ^= (b[2] & (a[0] ^ a[1]))
.endm
