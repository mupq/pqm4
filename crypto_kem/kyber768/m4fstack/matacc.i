.macro montgomery q, qinv, a, tmp
  smulbt \tmp, \a, \qinv
  smlabb \tmp, \q, \tmp, \a
.endm

.macro load_vals val0, val1, bufptr, tmp
  ldrh \val0, [\bufptr], #2
  ldrb \val1, [\bufptr], #1
  ubfx \tmp, \val0, #12, #4
  orr \val1, \tmp, \val1, lsl #4
  ubfx \val0, \val0, #0, #12
  ubfx \val1, \val1, #0, #12
.endm

// Checks if val0 is suitable and multiplies with values from bptr using func 
.macro first_if func, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
// if (val0 < KYBER_Q)
    cmp.w \val0, \q
    bhs.w 2f
        strh \val0, [\cptr], #2
        add \k, #1
        cmp.w \k, #4
        bne.w 2f
            sub \cptr, #4*2
            vmov s18, \bufptr
            vmov s19, \q
            vmov s20, \ctr
            vmov s21, \val1
            \func \rptr, \bptr, \cptr, \zetaptr, \bufptr, \k, \q, \val0, \qqinv, \qqinv, \tmp, \tmp2, \tmp3, \val1, \ctr
            vmov \bufptr, s18
            vmov \q, s19
            vmov \ctr, s20
            vmov \val1, s21

            add ctr, #1
            
            movw k, #0
    2:
.endm

// Checks if val1 is suitable and multiplies with values from bptr using func 
.macro second_if func, tmp, tmp2, tmp3, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qqinv, ctr
// if (val1 < KYBER_Q && ctr < KYBER_N/4)
    cmp.w \val1, \q
    bhs.w 2f
        cmp.w \ctr, #256/4
        bge.w 2f
            strh \val1, [\cptr], #2
            add \k, #1
            cmp.w \k, #4
            bne.w 2f
                sub \cptr, #4*2
                vmov s18, \bufptr
                vmov s19, \q
                vmov s20, \ctr
                \func \rptr, \bptr, \cptr, \zetaptr, \bufptr, \k, \q, \val0, \qqinv, \qqinv, \tmp, \tmp2, \tmp3, \val1, \ctr
                vmov \bufptr, s18
                vmov \q, s19
                vmov \ctr, s20

                add \ctr, #1
                
                movw \k, #0
    2:
.endm

.macro third_if tmp, tmp2, rptr, bptr, cptr, bufptr, ctr
// if (pos + 3 > buflen && ctr < KYBER_N/4)
  vmov \tmp, s17
  add \tmp, #168 // XOF_BLOCKBYTES=168
  add \tmp2, \bufptr, #3
  cmp.w \tmp2, \tmp  // pos + 3 > buflen
  ble.w 2f
    cmp.w \ctr, #256/4
    bge.w 2f
      vmov \bufptr, s17

      vmov s16, r12
      vmov s18, \rptr
      vmov s19, \bptr
      vmov s20, \cptr
      vmov s21, \ctr

      mov \rptr, \bufptr
      movw \bptr, #1
      vmov \cptr, s26 // load state
      bl kyber_shake128_squeezeblocks
      
      vmov r12, s16
      vmov \rptr, s18
      vmov \bptr, s19
      vmov \cptr, s20
      vmov \ctr, s21
      vmov \bufptr, s17
    2:
.endm

.macro doublebasemul_asm rptr, aptr, bptr, zetaptr, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, tmp3, res, zeta
    ldr \poly0, [\aptr], #4
    ldr \poly1, [\bptr]
    ldr \poly2, [\aptr], #4
    ldr.w \poly3, [\bptr, #4]
    ldrh \zeta, [\zetaptr], #2

    smultt \tmp, \poly0, \poly1
    montgomery \q, \qinv, \tmp, \tmp2
    smultb \tmp2, \tmp2, \zeta
    smlabb \tmp2, \poly0, \poly1, \tmp2
    montgomery \q, \qinv, \tmp2, \tmp

    smuadx \tmp2, \poly0, \poly1
    montgomery \q, \qinv, \tmp2, \tmp3

    pkhtb \tmp, \tmp3, \tmp, asr#16
    str \tmp, [\rptr], #4

    neg \zeta, \zeta

    smultt \tmp, \poly2, \poly3
    montgomery \q, \qinv, \tmp, \tmp2
    smultb \tmp2, \tmp2, \zeta
    smlabb \tmp2, \poly2, \poly3, \tmp2
    montgomery \q, \qinv, \tmp2, \tmp

    smuadx \tmp2, \poly2, \poly3
    montgomery \q, \qinv, \tmp2, \tmp3

    pkhtb \tmp, \tmp3, \tmp, asr#16
    str \tmp, [\rptr], #4
.endm

.macro doublebasemul_asm_acc rptr, aptr, bptr, zetaptr, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, tmp3, res, zeta
    ldr \poly0, [\aptr], #4
    ldr \poly1, [\bptr]
    ldr \poly2, [\aptr], #4
    ldr.w \poly3, [\bptr, #4]
    ldr.w \res, [\rptr]
    ldrh \zeta, [\zetaptr], #2

    smultt \tmp, \poly0, \poly1
    montgomery \q, \qinv, \tmp, \tmp2
    smultb \tmp2, \tmp2, \zeta
    smlabb \tmp2, \poly0, \poly1, \tmp2
    montgomery \q, \qinv, \tmp2, \tmp

    smuadx \tmp2, \poly0, \poly1
    montgomery \q, \qinv, \tmp2, \tmp3

    pkhtb \tmp, \tmp3, \tmp, asr#16
    uadd16 \res, \res, \tmp
    str \res, [\rptr], #4

    neg \zeta, \zeta

    ldr.w \res, [\rptr]

    smultt \tmp, \poly2, \poly3
    montgomery \q, \qinv, \tmp, \tmp2
    smultb \tmp2, \tmp2, \zeta
    smlabb \tmp2, \poly2, \poly3, \tmp2
    montgomery \q, \qinv, \tmp2, \tmp

    smuadx \tmp2, \poly2, \poly3
    montgomery \q, \qinv, \tmp2, \tmp3

    pkhtb \tmp, \tmp3, \tmp, asr#16
    uadd16 \res, \res, \tmp
    str \res, [\rptr], #4
.endm