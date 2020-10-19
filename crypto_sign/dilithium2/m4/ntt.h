#ifndef NTT_H
#define NTT_H

#include "params.h"
#include <stdint.h>

#if PLATFORM == CORTEX_M3
extern const uint32_t zetas_asm[N];
extern const uint32_t zetas_inv_asm[N];

void ntt_asm_schoolbook(int32_t p[N], const uint32_t zetas_asm[N]);
void inv_ntt_asm_schoolbook(int32_t p[N], const uint32_t zetas_inv_asm[N]);
void poly_pointwise_invmontgomery_asm_mul(int32_t c[N], const int32_t a[N], const int32_t b[N]);
void poly_pointwise_acc_invmontgomery_asm_mul(int32_t c[N], const int32_t a[N], const int32_t b[N]);
#endif

extern const uint32_t zetas_interleaved_asm[N];
extern const uint32_t zetas_interleaved_inv_asm[N];
void ntt_asm_smull(int32_t p[N], const uint32_t zetas_asm[N]);
void inv_ntt_asm_smull(int32_t p[N], const uint32_t zetas_inv_asm[N]);

void poly_pointwise_invmontgomery_asm_smull(int32_t c[N], const int32_t a[N], const int32_t b[N]);
void poly_pointwise_acc_invmontgomery_asm_smull(int32_t c[N], const int32_t a[N], const int32_t b[N]);
void poly_reduce_asm(int32_t a[N]);
void poly_freeze_asm(int32_t a[N]);
void poly_csubq_asm(int32_t a[N]);

int rej_uniform_asm(int32_t *a,unsigned int len,const unsigned char *buf, unsigned int buflen);

#endif
