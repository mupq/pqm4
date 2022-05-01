
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
        vmov s2, \bufptr
        vmov s3, \q
        vmov s4, \ctr
        vmov s5, \val1
        \func \rptr, \bptr, \cptr, \zetaptr, \bufptr, \k, \q, \val0, \qqinv, \qqinv, \tmp, \tmp2, \tmp3, \val1, \ctr
        vmov \bufptr, s2
        vmov \q, s3
        vmov \ctr, s4
        vmov \val1, s5

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
        vmov s2, \bufptr
        vmov s3, \q
        vmov s4, \ctr
        \func \rptr, \bptr, \cptr, \zetaptr, \bufptr, \k, \q, \val0, \qqinv, \qqinv, \tmp, \tmp2, \tmp3, \val1, \ctr
        vmov \bufptr, s2
        vmov \q, s3
        vmov \ctr, s4

        add \ctr, #1
        
        movw \k, #0
    2:
.endm

.macro montgomery q, qinv, a, tmp
  smulbt \tmp, \a, \qinv
  smlabb \tmp, \q, \tmp, \a
.endm

.macro doublebasemul_asm_cache_16_32 rptr_tmp, aptr, bptr, zetaptr, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, res, aprimeptr, zeta
  vmov \aprimeptr, s11
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]
  ldrh \zeta, [\zetaptr], #2

  smultb \tmp2, \poly0, \zeta
  montgomery \q, \qinv, \tmp2, \tmp
  pkhbt \tmp, \poly0, \tmp
  str \tmp, [\aprimeptr], #4 // store (poly0_t*zeta || poly0_b) for later re-use
  smultt \tmp2, \tmp, \poly1
  smlabb \tmp2, \poly0, \poly1, \tmp2

  smuadx \tmp, \poly0, \poly1
  
  str.w \tmp, [\rptr_tmp, #4]
  str \tmp2, [\rptr_tmp], #8

  neg \zeta, \zeta

  smultb \tmp, \poly2, \zeta
  montgomery \q, \qinv, \tmp, \tmp2
  pkhbt \tmp2, \poly2, \tmp2
  str \tmp2, [\aprimeptr], #4 // store (poly2_t*zeta || poly2_b) for later re-use
  
  smultt \tmp2, \tmp2, \poly3
  smlabb \tmp2, \poly2, \poly3, \tmp2

  smuadx \tmp, \poly2, \poly3
  str.w \tmp, [\rptr_tmp, #4]
  str \tmp2, [\rptr_tmp], #8
  vmov s11, \aprimeptr
.endm 

.macro doublebasemul_asm_acc_cache_32_32 rptr_tmp, aptr, bptr, zetaptr, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, res, aprimeptr, zeta
  vmov \aprimeptr, s11
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]
  ldr \res, [\rptr_tmp]
  ldrh \zeta, [\zetaptr], #2

  smultb \tmp, \poly0, \zeta
  montgomery \q, \qinv, \tmp, \tmp2
  pkhbt \tmp2, \poly0, \tmp2
  str \tmp2, [\aprimeptr], #4 // store (poly0_t*zeta || poly0_b) for later re-use
  smlatt \tmp2, \tmp2, \poly1, \res
  smlabb \res, \poly0, \poly1, \tmp2
  str \res, [\rptr_tmp], #4

  ldr.w \res, [\rptr_tmp]
  smladx \res, \poly0, \poly1, \res
  
  str.w \res, [\rptr_tmp], #4
  
  neg \zeta, \zeta

  ldr \res, [\rptr_tmp]
  smultb \tmp, \poly2, \zeta
  montgomery \q, \qinv, \tmp, \tmp2
  pkhbt \tmp2, \poly2, \tmp2
  str \tmp2, [\aprimeptr], #4 // store (poly2_t*zeta || poly2_b) for later re-use
  smlatt \tmp2, \tmp2, \poly3, \res
  smlabb \res, \poly2, \poly3, \tmp2
  str.w \res, [\rptr_tmp], #4

  ldr.w \res, [\rptr_tmp]
  smladx \res, \poly2, \poly3, \res

  str \res, [\rptr_tmp], #4
  vmov s11, \aprimeptr
.endm

.macro doublebasemul_asm_acc_cache_32_16 rptr_tmp, aptr, bptr, zetaptr, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, res, aprimeptr, zeta
  vmov \aprimeptr, s11
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]
  ldr \res, [\rptr_tmp], #4
  ldrh \zeta, [\zetaptr], #2
  
  smultb \tmp, \poly0, \zeta
  montgomery \q, \qinv, \tmp, \tmp2
  pkhbt \tmp2, \poly0, \tmp2
  str \tmp2, [\aprimeptr], #4 // store (poly0_t*zeta || poly0_b) for later re-use
  smlatt \tmp2, \tmp2, \poly1, \res
  smlabb \tmp, \poly0, \poly1, \tmp2

  montgomery \q, \qinv, \tmp, \tmp2
  ldr.w \tmp, [\rptr_tmp], #4
  smladx \tmp, \poly0, \poly1, \tmp

  montgomery \q, \qinv, \tmp, \poly0
  
  pkhtb \res, \poly0, \tmp2, asr#16
  vmov \poly0, s12
  str \res, [\poly0], #4
  
  neg \zeta, \zeta

  smultb \tmp, \poly2, \zeta
  montgomery \q, \qinv, \tmp, \tmp2
  pkhbt \tmp2, \poly2, \tmp2
  ldr \res, [\rptr_tmp], #4
  str \tmp2, [\aprimeptr], #4 // store (poly2_t*zeta || poly2_b) for later re-use
  smlatt \tmp2, \tmp2, \poly3, \res
  smlabb \tmp, \poly2, \poly3, \tmp2
  
  montgomery \q, \qinv, \tmp, \tmp2

  ldr \res, [\rptr_tmp], #4
  smladx \res, \poly2, \poly3, \res

  montgomery \q, \qinv, \res, \tmp

  pkhtb \res, \tmp, \tmp2, asr#16
  str \res, [\poly0], #4
  vmov s12, \poly0
  vmov s11, \aprimeptr
.endm

.macro load_vals val0, val1, bufptr, tmp
  ldrh \val0, [\bufptr], #2
  ldrb \val1, [\bufptr], #1
  ubfx \tmp, \val0, #12, #4
  orr \val1, \tmp, \val1, lsl #4
  ubfx \val0, \val0, #0, #12
  ubfx \val1, \val1, #0, #12
.endm

.macro doublebasemul_asm_opt_16_32 rptr_tmp, aptr, bptr, tmp3, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, res, aprimeptr, tmp4
  vmov \aprimeptr, s11
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]

  ldr.w \tmp2, [\aprimeptr], #4 // load cached value
  
  // (poly0_t * zeta) * poly1_t + poly0_b * poly0_t
  smuad \tmp, \tmp2, \poly1

  // poly1_t * poly0_b + poly1_b * poly0_t
  smuadx \tmp3, \poly0, \poly1
    
  ldr \tmp4, [\aprimeptr], #4 // load cached value
  str \tmp, [\rptr_tmp], #4
  str \tmp3, [\rptr_tmp], #4

  smuad \tmp2, \tmp4, \poly3

  smuadx \tmp3, \poly2, \poly3

  str.w \tmp2, [\rptr_tmp], #4
  str.w \tmp3, [\rptr_tmp], #4
  vmov s11, \aprimeptr
.endm 

.macro doublebasemul_asm_acc_opt_32_32 rptr_tmp, aptr, bptr, tmp3, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, res, aprimeptr, tmp4
  vmov \aprimeptr, s11
  ldr.w \poly0, [\aptr], #4
  ldr.w \poly1, [\bptr]
  ldr.w \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]

  ldr.w \res, [\rptr_tmp]
  ldr.w \tmp3, [\rptr_tmp, #4]

  ldr \tmp2, [\aprimeptr], #4 // load cached value

  // (poly0_t * zeta) * poly1_t + poly0_b * poly0_t + res
  smlad \res, \tmp2, \poly1, \res

  // poly1_t * poly0_b + poly1_b * poly0_t + res
  smladx \tmp3, \poly0, \poly1, \tmp3

  ldr \tmp2, [\aprimeptr], #4 // load cached value
  ldr \tmp4, [\rptr_tmp, #8]
  ldr \tmp, [\rptr_tmp, #12]
  str.w \tmp3, [\rptr_tmp, #4]
  str.w \res, [\rptr_tmp], #8
    
  smlad \tmp4, \tmp2, \poly3, \tmp4

  smladx \tmp, \poly2, \poly3, \tmp

  str.w \tmp, [\rptr_tmp, #4]
  str \tmp4, [\rptr_tmp], #8
  
  vmov s11, \aprimeptr
.endm 

.macro doublebasemul_asm_acc_opt_32_16 rptr_tmp, aptr, bptr, tmp3, poly0, poly1, poly2, poly3, q, qinv, tmp, tmp2, res, aprimeptr, tmp4
  vmov \aprimeptr, s11

  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]

  ldr.w \tmp3, [\rptr_tmp, #4]
  ldr \res, [\rptr_tmp], #8

  ldr \tmp2, [\aprimeptr], #4 // load cached value

  // (poly0_t * zeta) * poly1_t + poly0_b * poly0_t + res
  smlad \tmp, \tmp2, \poly1, \res
  montgomery \q, \qinv, \tmp, \res

  // poly1_t * poly0_b + poly1_b * poly0_t + res
  smladx \tmp, \poly0, \poly1, \tmp3
  montgomery \q, \qinv, \tmp, \tmp3

  pkhtb \res, \tmp3, \res, asr#16
  vmov \poly0, s12
  str \res, [\poly0], #4
    
  ldr \tmp2, [\aprimeptr], #4 // load cached value
  ldr.w \tmp3, [\rptr_tmp, #4]
  ldr \res, [\rptr_tmp], #8

  smlad \tmp2, \tmp2, \poly3, \res

  montgomery \q, \qinv, \tmp2, \res

  smladx \tmp, \poly2, \poly3, \tmp3

  montgomery \q, \qinv, \tmp, \tmp3

  pkhtb \res, \tmp3, \res, asr#16
  str \res, [\poly0], #4
  vmov s12, \poly0
  vmov s11, \aprimeptr
.endm 
