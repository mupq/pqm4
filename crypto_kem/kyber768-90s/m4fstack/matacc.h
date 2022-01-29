#ifndef MATACC_H
#define MATACC_H
#include "poly.h"
#include "polyvec.h"
#include "symmetric.h"

extern void matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, unsigned int *buflen);
extern void matacc_asm_acc(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, unsigned int *buflen);

void matacc(poly* r, const polyvec *b, unsigned char i, const unsigned char *seed, int transposed);
#endif