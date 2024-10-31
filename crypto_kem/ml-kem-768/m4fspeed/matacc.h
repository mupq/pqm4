#ifndef MATACC_H
#define MATACC_H
#include "poly.h"
#include "polyvec.h"
#include "symmetric.h"

extern void matacc_asm_cache_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t zetas[64], xof_state *state, int16_t *aprimeptr);
static inline void _matacc_asm_cache_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t _zetas[64], xof_state *state, int16_t *aprimeptr)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s16", "s17", "s18", "s19", "s20", "s21", "s26", "s27", "s28", "s29");
  matacc_asm_cache_16_32(r_tmp, b, c, buf, _zetas, state, aprimeptr);
}
#define matacc_asm_cache_16_32 _matacc_asm_cache_16_32

extern void matacc_asm_cache_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t zetas[64], xof_state *state, int16_t *aprimeptr);
static inline void _matacc_asm_cache_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t _zetas[64], xof_state *state, int16_t *aprimeptr)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s16", "s17", "s18", "s19", "s20", "s21", "s26", "s27", "s28", "s29");
  matacc_asm_cache_32_32(r_tmp, b, c, buf, _zetas, state, aprimeptr);
}
#define matacc_asm_cache_32_32 _matacc_asm_cache_32_32

extern void matacc_asm_cache_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t zetas[64], xof_state *state, int16_t *aprimeptr, const int32_t *r_tmp);
static inline void _matacc_asm_cache_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], const int32_t _zetas[64], xof_state *state, int16_t *aprimeptr, const int32_t *r_tmp)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s16", "s17", "s18", "s19", "s20", "s21", "s26", "s27", "s28", "s29");
  matacc_asm_cache_32_16(r, b, c, buf, _zetas, state, aprimeptr, r_tmp);
}
#define matacc_asm_cache_32_16 _matacc_asm_cache_32_16

extern void matacc_asm_opt_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr);
static inline void _matacc_asm_opt_16_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s16", "s17", "s18", "s19", "s20", "s21", "s26", "s27", "s28", "s29");
  matacc_asm_opt_16_32(r_tmp, b, c, buf, state, aprimeptr);
}
#define matacc_asm_opt_16_32 _matacc_asm_opt_16_32

extern void matacc_asm_opt_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr);
static inline void _matacc_asm_opt_32_32(int32_t *r_tmp, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s16", "s17", "s18", "s19", "s20", "s21", "s26", "s27", "s28", "s29");
  matacc_asm_opt_32_32(r_tmp, b, c, buf, state, aprimeptr);
}
#define matacc_asm_opt_32_32 _matacc_asm_opt_32_32

extern void matacc_asm_opt_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, const int32_t *r_tmp);
static inline void _matacc_asm_opt_32_16(int16_t *r, const int16_t *b, int16_t c[4], unsigned char buf[XOF_BLOCKBYTES+2], xof_state *state, const int16_t *aprimeptr, const int32_t *r_tmp)
{
  // floating point registers clobbered by assembly function
  asm volatile("" : : : "s16", "s17", "s18", "s19", "s20", "s21", "s26", "s27", "s28", "s29");
  matacc_asm_opt_32_16(r, b, c, buf, state, aprimeptr, r_tmp);
}
#define matacc_asm_opt_32_16 _matacc_asm_opt_32_16

void matacc_opt32(poly* r, const polyvec *b, const polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed);
void matacc_cache32(poly* r, const polyvec *b, polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed);
#endif