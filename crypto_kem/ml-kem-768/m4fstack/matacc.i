/******************************************************************************
 * Integrating the improved Plantard arithmetic into Kyber.
 *
 * Efficient Plantard arithmetic enables a faster Kyber implementation with the
 * same stack usage.
 *
 * See the paper at https://eprint.iacr.org/2022/956.pdf for more details.
 *
 * @author   Junhao Huang, BNU-HKBU United International College, Zhuhai, China
 *           jhhuang_nuaa@126.com
 *
 * @date     September 2022
 ******************************************************************************/
// q locates in the bottom half of the register
.macro plant_red_b q, qa, qinv, tmp
	mul \tmp, \tmp, \qinv     
	//tmp*qinv mod 2^2n/ 2^n; in high half
	smlatb \tmp, \tmp, \q, \qa
	// result in high half
.endm

.macro load_vals val0, val1, bufptr, tmp
  ldrh \val0, [\bufptr], #2
  ldrb \val1, [\bufptr], #1
  ubfx \tmp, \val0, #12, #4
  orr \val1, \tmp, \val1, lsl #4
  ubfx \val0, \val0, #0, #12
  ubfx \val1, \val1, #0, #12
.endm

// s17: bufptr; s26: state
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

      mov \rptr, \bufptr //bufptr
      movw \bptr, #1
      vmov \cptr, s26 // load state
      #ifndef nohash
      bl shake128_squeezeblocks
      #endif
      
      vmov r12, s16
      vmov \rptr, s18
      vmov \bptr, s19
      vmov \cptr, s20
      vmov \ctr, s21
      vmov \bufptr, s17
    2:
.endm

.macro doublebasemul_asm rptr, aptr, bptr, zetaptr, poly0, poly1, poly2, poly3, q, qa, qinv, tmp, tmp2, zeta
    ldr.w \poly0, [\aptr], #4
    ldr.w \poly1, [\bptr]
    ldr.w \poly2, [\aptr], #4
    ldr.w \poly3, [\bptr, #4]
    ldr.w \zeta, [\zetaptr], #4

    //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
    smulwt \tmp, \zeta, \poly1 
    // b_1*zeta*qinv*plant_const; in low half
    smlabb \tmp, \tmp, \q, \qa  
    // b_1*zeta
    smultt \tmp, \poly0, \tmp  
    //a_1*b_1*zeta <2^32
    smlabb \tmp, \poly0, \poly1, \tmp 
    // a1*b1*zeta+a0*b0
    plant_red_b \q, \qa, \qinv, \tmp
    // r[0] in upper half of tmp
    smuadx \tmp2, \poly0, \poly1 
    plant_red_b \q, \qa, \qinv, \tmp2
    // r[1] in upper half of tmp2
    pkhtb \tmp, \tmp2, \tmp, asr#16
    str \tmp, [\rptr], #4

    neg \zeta, \zeta

    //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
    smulwt \tmp, \zeta, \poly3 
    smlabb \tmp, \tmp, \q, \qa  
    smultt \tmp, \poly2, \tmp  
    smlabb \tmp, \poly2, \poly3, \tmp 
    plant_red_b \q, \qa, \qinv, \tmp
    // r[0] in upper half of tmp
    
    smuadx \tmp2, \poly2, \poly3 
    plant_red_b \q, \qa, \qinv, \tmp2
    // r[1] in upper half of tmp2
    pkhtb \tmp, \tmp2, \tmp, asr#16
    str \tmp, [\rptr], #4
.endm
// res replace poly2
.macro doublebasemul_asm_acc rptr, aptr, bptr, zetaptr, poly0, poly1, res, poly3, q, qa, qinv, tmp, tmp2, zeta
    ldr.w \poly0, [\aptr], #4
    ldr.w \poly1, [\bptr]
    ldr.w \poly3, [\bptr, #4]
    ldr.w \res, [\rptr]
    ldr.w \zeta, [\zetaptr], #4

    //basemul(r->coeffs + 4 * i, a->coeffs + 4 * i, b->coeffs + 4 * i, zetas[64 + i]);
    smulwt \tmp, \zeta, \poly1 
    // b_1*zeta*qinv*plant_const; in low half
    smlabb \tmp, \tmp, \q, \qa  
    // b_1*zeta
    smultt \tmp, \poly0, \tmp  
    //a_1*b_1*zeta <2^32
    smlabb \tmp, \poly0, \poly1, \tmp 
    // a1*b1*zeta+a0*b0
    plant_red_b \q, \qa, \qinv, \tmp
    // r[0] in upper half of tmp
    smuadx \tmp2, \poly0, \poly1 
    plant_red_b \q, \qa, \qinv, \tmp2
    // r[1] in upper half of tmp2
    pkhtb \tmp, \tmp2, \tmp, asr#16
    uadd16 \res, \res, \tmp
    str \res, [\rptr], #4

    neg \zeta, \zeta

    ldr.w \res, [\rptr]
    ldr \poly0, [\aptr], #4
    //basemul(r->coeffs + 4 * i + 2, a->coeffs + 4 * i + 2, b->coeffs + 4 * i + 2, - zetas[64 + i]);
    smulwt \tmp, \zeta, \poly3 
    smlabb \tmp, \tmp, \q, \qa  
    smultt \tmp, \poly0, \tmp  
    smlabb \tmp, \poly0, \poly3, \tmp 
    plant_red_b \q, \qa, \qinv, \tmp
    // r[0] in upper half of tmp
    
    smuadx \tmp2, \poly0, \poly3 
    plant_red_b \q, \qa, \qinv, \tmp2
    // r[1] in upper half of tmp2
    pkhtb \tmp, \tmp2, \tmp, asr#16
    uadd16 \res, \res, \tmp
    str \res, [\rptr], #4
.endm