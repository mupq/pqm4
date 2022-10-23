
// q locates in the bottom half of the register
.macro plant_red_b q, qa, qinv, tmp
	mul \tmp, \tmp, \qinv     
	//tmp*qinv mod 2^2n/ 2^n; in high half
	smlatb \tmp, \tmp, \q, \qa
	// result in high half
.endm

// Checks if val0 is suitable and multiplies with values from bptr using func 
.macro first_if func, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
  // if (val0 < KYBER_Q)
  cmp.w \val0, \q
  bhs.w 2f
    strh \val0, [\cptr], #2
    add \k, #1
    cmp.w \k, #4
    bne.w 2f
        sub \cptr, #4*2
        vmov s18, \bufptr
        vmov s19, \ctr
        vmov s20, \val1
        \func \rptr, \bptr, \cptr, \zetaptr, \bufptr, \k, \val0, \val1, \q, \qa, \qinv, \tmp, \tmp2, \ctr
        vmov \bufptr, s18
        vmov \ctr, s19
        vmov \val1, s20

        add \ctr, #1
        
        movw \k, #0
    2:
.endm

// Checks if val1 is suitable and multiplies with values from bptr using func 
.macro second_if func, tmp, tmp2, val0, val1, rptr, bptr, cptr, bufptr, zetaptr, k, q, qa, qinv, ctr
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
        vmov s19, \ctr
        \func \rptr, \bptr, \cptr, \zetaptr, \bufptr, \k, \val0, \val1, \q, \qa, \qinv, \tmp, \tmp2, \ctr
        vmov \bufptr, s18
        vmov \ctr, s19

        add \ctr, #1
        
        movw \k, #0
    2:
.endm

.macro doublebasemul_asm_cache_16_32 rptr_tmp, aptr, bptr, zetaptr, poly0, poly1, tmp, tmp2, q, qa, qinv, res, aprimeptr, zeta
  vmov \aprimeptr, s27
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \zeta, [\zetaptr], #4

  smulwt \tmp, \zeta, \poly0
  smlabb \tmp, \tmp, \q, \qa
  pkhbt \tmp, \poly0, \tmp
  str \tmp, [\aprimeptr], #4 // store (poly0_t*zeta || poly0_b) for later re-use
  smultt \tmp2, \tmp, \poly1
  smlabb \tmp2, \poly0, \poly1, \tmp2

  smuadx \tmp, \poly0, \poly1
  
  str.w \tmp, [\rptr_tmp, #4]
  str \tmp2, [\rptr_tmp], #8

  neg \zeta, \zeta

  ldr \poly0, [\aptr], #4
  ldr.w \poly1, [\bptr, #4]

  smulwt \tmp, \zeta, \poly0
  smlabb \tmp, \tmp, \q, \qa
  pkhbt \tmp, \poly0, \tmp
  str \tmp, [\aprimeptr], #4 // store (poly2_t*zeta || poly2_b) for later re-use
  smultt \tmp2, \tmp, \poly1
  smlabb \tmp2, \poly0, \poly1, \tmp2

  smuadx \tmp, \poly0, \poly1
  str.w \tmp, [\rptr_tmp, #4]
  str \tmp2, [\rptr_tmp], #8
  vmov s27, \aprimeptr
.endm 

.macro doublebasemul_asm_acc_cache_32_32 rptr_tmp, aptr, bptr, zetaptr, poly0, poly1, tmp, tmp2, q, qa, qinv, res, aprimeptr, zeta
  vmov \aprimeptr, s27
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  
  ldr \res, [\rptr_tmp]
  ldr \zeta, [\zetaptr], #4

  smulwt \tmp, \zeta, \poly0
  smlabb \tmp, \tmp, \q, \qa
  pkhbt \tmp, \poly0, \tmp
  str \tmp, [\aprimeptr], #4 // store (poly0_t*zeta || poly0_b) for later re-use
  smlatt \tmp, \tmp, \poly1, \res
  smlabb \res, \poly0, \poly1, \tmp
  str \res, [\rptr_tmp], #4

  ldr.w \res, [\rptr_tmp]
  smladx \res, \poly0, \poly1, \res
  
  str.w \res, [\rptr_tmp], #4
  
  neg \zeta, \zeta

  ldr \poly0, [\aptr], #4
  ldr.w \poly1, [\bptr, #4]
  ldr \res, [\rptr_tmp]
  smulwt \tmp, \zeta, \poly0
  smlabb \tmp, \tmp, \q, \qa
  pkhbt \tmp, \poly0, \tmp
  str \tmp, [\aprimeptr], #4 // store (poly2_t*zeta || poly2_b) for later re-use
  smlatt \tmp, \tmp, \poly1, \res
  smlabb \res, \poly0, \poly1, \tmp
  str.w \res, [\rptr_tmp], #4

  ldr.w \res, [\rptr_tmp]
  smladx \res, \poly0, \poly1, \res

  str \res, [\rptr_tmp], #4
  vmov s27, \aprimeptr
.endm

.macro doublebasemul_asm_acc_cache_32_16 rptr_tmp, aptr, bptr, zetaptr, poly0, poly1, tmp, tmp2, q, qa, qinv, res, aprimeptr, zeta
  vmov \aprimeptr, s27
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  
  ldr \res, [\rptr_tmp], #4
  ldr \zeta, [\zetaptr], #4
  
  smulwt \tmp, \zeta, \poly0
  smlabb \tmp, \tmp, \q, \qa
  pkhbt \tmp, \poly0, \tmp
  str \tmp, [\aprimeptr], #4 // store (poly0_t*zeta || poly0_b) for later re-use
  smlatt \tmp, \tmp, \poly1, \res
  smlabb \tmp2, \poly0, \poly1, \tmp

  plant_red_b \q, \qa, \qinv, \tmp2
  ldr.w \tmp, [\rptr_tmp], #4
  smladx \tmp, \poly0, \poly1, \tmp

  plant_red_b \q, \qa, \qinv, \tmp
  
  pkhtb \res, \tmp, \tmp2, asr#16
  vmov \tmp2, s28
  str \res, [\tmp2], #4
  
  neg \zeta, \zeta

  ldr \poly0, [\aptr], #4
  ldr.w \poly1, [\bptr, #4]

  smulwt \tmp, \zeta, \poly0
  smlabb \tmp, \tmp, \q, \qa
  pkhbt \tmp, \poly0, \tmp
  ldr \res, [\rptr_tmp], #4
  str \tmp, [\aprimeptr], #4 // store (poly2_t*zeta || poly2_b) for later re-use
  smlatt \tmp, \tmp, \poly1, \res
  smlabb \tmp, \poly0, \poly1, \tmp
  
  plant_red_b \q, \qa, \qinv, \tmp

  ldr \res, [\rptr_tmp], #4
  smladx \res, \poly0, \poly1, \res

  plant_red_b \q, \qa, \qinv, \res

  pkhtb \res, \res, \tmp, asr#16

  str \res, [\tmp2], #4
  vmov s28, \tmp2
  vmov s27, \aprimeptr
.endm

.macro load_vals val0, val1, bufptr, tmp
  ldrh \val0, [\bufptr], #2
  ldrb \val1, [\bufptr], #1
  ubfx \tmp, \val0, #12, #4
  orr \val1, \tmp, \val1, lsl #4
  ubfx \val0, \val0, #0, #12
  ubfx \val1, \val1, #0, #12
.endm

.macro doublebasemul_asm_opt_16_32 rptr_tmp, aptr, bptr, tmp3, poly0, poly1, poly2, poly3, q, qa, qinv, tmp, aprimeptr, tmp2
  vmov \aprimeptr, s27
  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]

  ldr.w \tmp2, [\aprimeptr], #4 // load cached value
  
  // (poly0_t * zeta) * poly1_t + poly0_b * poly1_b
  smuad \tmp, \tmp2, \poly1

  // poly1_t * poly0_b + poly1_b * poly0_t
  smuadx \tmp3, \poly0, \poly1
    
  str \tmp, [\rptr_tmp], #4
  str \tmp3, [\rptr_tmp], #4

  ldr \tmp, [\aprimeptr], #4 // load cached value

  smuad \tmp2, \tmp, \poly3

  smuadx \tmp3, \poly2, \poly3

  str.w \tmp2, [\rptr_tmp], #4
  str.w \tmp3, [\rptr_tmp], #4
  vmov s27, \aprimeptr
.endm 

.macro doublebasemul_asm_acc_opt_32_32 rptr_tmp, aptr, bptr, tmp2, poly0, poly1, poly2, poly3, q, qa, qinv, res, aprimeptr, tmp
  vmov \aprimeptr, s27
  ldr.w \poly0, [\aptr], #4
  ldr.w \poly1, [\bptr]
  ldr.w \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]

  ldr.w \res, [\rptr_tmp]
  ldr.w \tmp, [\rptr_tmp, #4]

  ldr \tmp2, [\aprimeptr], #4 // load cached value

  // (poly0_t * zeta) * poly1_t + poly0_b * poly0_t + res
  smlad \res, \tmp2, \poly1, \res

  // poly1_t * poly0_b + poly1_b * poly0_t + res
  smladx \tmp, \poly0, \poly1, \tmp

  str.w \tmp, [\rptr_tmp, #4]
  str.w \res, [\rptr_tmp], #8

  ldr \tmp2, [\aprimeptr], #4 // load cached value
  ldr \res, [\rptr_tmp]
  ldr \tmp, [\rptr_tmp, #4] 
    
  smlad \res, \tmp2, \poly3, \res

  smladx \tmp, \poly2, \poly3, \tmp

  str.w \tmp, [\rptr_tmp, #4]
  str \res, [\rptr_tmp], #8
  
  vmov s27, \aprimeptr
.endm 

.macro doublebasemul_asm_acc_opt_32_16 rptr_tmp, aptr, bptr, tmp2, poly0, poly1, poly2, poly3, q, qa, qinv, res, aprimeptr, tmp
  vmov \aprimeptr, s27

  ldr \poly0, [\aptr], #4
  ldr \poly1, [\bptr]
  ldr \poly2, [\aptr], #4
  ldr.w \poly3, [\bptr, #4]

  ldr.w \tmp, [\rptr_tmp, #4]
  ldr \res, [\rptr_tmp], #8

  ldr \tmp2, [\aprimeptr], #4 // load cached value

  // (poly0_t * zeta) * poly1_t + poly0_b * poly0_t + res
  smlad \res, \tmp2, \poly1, \res
  plant_red_b \q, \qa, \qinv, \res

  // poly1_t * poly0_b + poly1_b * poly0_t + res
  smladx \tmp, \poly0, \poly1, \tmp
  plant_red_b \q, \qa, \qinv, \tmp

  pkhtb \res, \tmp, \res, asr#16
  vmov \poly0, s28
  str \res, [\poly0], #4
    
  ldr \tmp2, [\aprimeptr], #4 // load cached value
  ldr.w \tmp, [\rptr_tmp, #4]
  ldr \res, [\rptr_tmp], #8

  smlad \res, \tmp2, \poly3, \res

  plant_red_b \q, \qa, \qinv, \res

  smladx \tmp, \poly2, \poly3, \tmp

  plant_red_b \q, \qa, \qinv, \tmp

  pkhtb \res, \tmp, \res, asr#16
  str \res, [\poly0], #4
  vmov s28, \poly0
  vmov s27, \aprimeptr
.endm 
