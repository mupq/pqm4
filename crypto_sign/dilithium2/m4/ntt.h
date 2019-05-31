#ifndef NTT_H
#define NTT_H

#include <stdint.h>

void ntt(uint32_t p[N]);
void invntt_frominvmont(uint32_t p[N]);

void ntt_asm(uint32_t *p);
void inv_ntt_asm(uint32_t *p);

extern const uint32_t zetas_asm[N];
extern const uint32_t zetas_inv_asm[N];

#endif
