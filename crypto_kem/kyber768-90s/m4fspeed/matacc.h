#ifndef MATACC_H
#define MATACC_H
#include "poly.h"
#include "polyvec.h"
#include "symmetric.h"

extern void matacc_asm_cache_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, unsigned int *buflen);
extern void matacc_asm_cache_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, unsigned int *buflen);
extern void matacc_asm_cache_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, int16_t *aprimeptr, int32_t *r_tmp, unsigned int *buflen);
extern void matacc_asm_opt_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, unsigned int *buflen);
extern void matacc_asm_opt_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, unsigned int *buflen);
extern void matacc_asm_opt_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, int32_t *r_tmp, unsigned int *buflen);

void matacc_opt32(poly* r, const polyvec *b, const polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed);
void matacc_cache32(poly* r, const polyvec *b, polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed);
#endif