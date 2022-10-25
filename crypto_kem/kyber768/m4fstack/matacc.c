#include "ntt.h"
#include "poly.h"
#include "polyvec.h"
#include "symmetric.h"
#include "matacc.h"

/*************************************************
* Name:        matacc
*
* Description: Multiplies a row of A or A^T, generated on-the-fly,
*              with a vector of polynomials and accumulates into the result.
*
* Arguments:   - poly *r:                    pointer to output polynomial to accumulate in
*              - polyvec *b:                 pointer to input vector of polynomials to multiply with
*              - unsigned char i:            byte to indicate the index < KYBER_K of the row of A or A^T
*              - const unsigned char *seed:  pointer to the public seed used to generate A
*              - int transposed:             boolean indicatin whether A or A^T is generated
**************************************************/
void matacc(poly* r, const polyvec *b, unsigned char i, const unsigned char *seed, int transposed) {
  unsigned char buf[XOF_BLOCKBYTES+2];
  xof_state state;
  int16_t c[4];
  int j = 0;
  
  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm(r->coeffs, b->vec[j].coeffs, c, buf, zetas, &state);
  for(j=1;j<KYBER_K;j++) {

    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);
    matacc_asm_acc(r->coeffs, b->vec[j].coeffs, c, buf, zetas, &state);
  }
}