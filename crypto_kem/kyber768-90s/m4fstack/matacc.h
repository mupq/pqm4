#ifndef MATACC_H
#define MATACC_H
#include "poly.h"
#include "polyvec.h"
#include "symmetric.h"

extern void matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, unsigned int *buflen);
static inline void _matacc_asm(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t _zetas[64], xof_state *state, unsigned int *buflen)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s17", "s18", "s19", "s20", "s21", "s22", "s23", "s26", "s27");
  matacc_asm(r, b, c, buf,_zetas, state, buflen);
}
#define matacc_asm _matacc_asm

extern void matacc_asm_acc(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t zetas[64], xof_state *state, unsigned int *buflen);
static inline void _matacc_asm_acc(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int16_t _zetas[64], xof_state *state, unsigned int *buflen)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s17", "s18", "s19", "s20", "s21", "s22", "s23", "s26", "s27");
  matacc_asm_acc(r, b, c, buf,_zetas, state, buflen);
}
#define matacc_asm_acc _matacc_asm_acc

void matacc(poly* r, const polyvec *b, unsigned char i, const unsigned char *seed, int transposed);
#endif