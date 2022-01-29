#include "ntt.h"
#include "poly.h"
#include "polyvec.h"
#include "symmetric.h"
#include "matacc.h"

void matacc_cache32(poly* r, const polyvec *b, polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed) {
  unsigned char buf[XOF_BLOCKBYTES+2];
  xof_state state;
  int16_t c[4];
  int32_t r_tmp[KYBER_N]; // stores intermediate accumulated values to save reductions
  int j = 0;
  unsigned int buflen;

  // 16-32
  buflen = XOF_BLOCKBYTES;
  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm_cache_16_32(r_tmp, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs, &buflen);

  // 32-32 KYBER_K - 2 times
  for(j=1;j<KYBER_K - 1;j++) {
    buflen = XOF_BLOCKBYTES;
    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);

    matacc_asm_cache_32_32(r_tmp, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs, &buflen);
  }

  // 32-16
  buflen = XOF_BLOCKBYTES;
  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm_cache_32_16(r->coeffs, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs, r_tmp, &buflen);
}

void matacc_opt32(poly* r, const polyvec *b, const polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed) {
  unsigned char buf[XOF_BLOCKBYTES+2];
  xof_state state;
  int16_t c[4];
  int32_t r_tmp[KYBER_N]; // stores intermediate accumulated values to save reductions
  int j = 0;
  unsigned int buflen;
  // 16-32
  buflen = XOF_BLOCKBYTES;
  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm_opt_16_32(r_tmp, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs, &buflen);
  
  // 32-32 KYBER_K - 2 times
  for(j=1;j<KYBER_K - 1;j++) {
    buflen = XOF_BLOCKBYTES;
    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);

    matacc_asm_opt_32_32(r_tmp, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs, &buflen);
  }

  // 32-16
  buflen = XOF_BLOCKBYTES;
  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm_opt_32_16(r->coeffs, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs, r_tmp, &buflen);
}
