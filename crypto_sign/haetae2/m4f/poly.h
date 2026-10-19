// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_POLY_H
#define HAETAE_POLY_H

#include "params.h"

#include <stdint.h>

typedef struct {
  int32_t coeffs[HAETAE_N];
} poly;

#define poly_add HAETAE_NAMESPACE(poly_add)
void poly_add(poly *c, const poly *a, const poly *b);
#define poly_sub HAETAE_NAMESPACE(poly_sub)
void poly_sub(poly *c, const poly *a, const poly *b);
#define poly_pointwise_montgomery HAETAE_NAMESPACE(poly_pointwise_montgomery)
void poly_pointwise_montgomery(poly *c, const poly *a, const poly *b);

#define poly_reduce2q HAETAE_NAMESPACE(poly_reduce2q)
void poly_reduce2q(poly *a);
#define poly_freeze2q HAETAE_NAMESPACE(poly_freeze2q)
void poly_freeze2q(poly *a);
#define poly_freeze HAETAE_NAMESPACE(poly_freeze)
void poly_freeze(poly *a);

#define poly_highbits HAETAE_NAMESPACE(poly_highbits)
void poly_highbits(poly *a2, const poly *a);
#define poly_lowbits HAETAE_NAMESPACE(poly_lowbits)
void poly_lowbits(poly *a1, const poly *a);

#define poly_cneg HAETAE_NAMESPACE(poly_cneg)
void poly_cneg(poly *a, const uint8_t b);
#define poly_compose HAETAE_NAMESPACE(poly_compose)
void poly_compose(poly *a, const poly *ha, const poly *la);
#define poly_lsb HAETAE_NAMESPACE(poly_lsb)
void poly_lsb(poly *a0, const poly *a);

#define poly_uniform HAETAE_NAMESPACE(poly_uniform)
void poly_uniform(poly *a, const uint8_t seed[HAETAE_SEEDBYTES],
                  uint16_t nonce);
#define poly_uniform_eta HAETAE_NAMESPACE(poly_uniform_eta)
void poly_uniform_eta(poly *a, const uint8_t seed[HAETAE_CRHBYTES],
                      uint16_t nonce);
#define poly_challenge HAETAE_NAMESPACE(poly_challenge)
void poly_challenge(
    poly *c,
    const uint8_t highbits_lsb[HAETAE_POLYVECK_HIGHBITS_PACKEDBYTES +
                               HAETAE_POLYC_PACKEDBYTES],
    const uint8_t mu[HAETAE_SEEDBYTES]);

#define poly_decomposed_pack HAETAE_NAMESPACE(poly_decomposed_pack)
void poly_decomposed_pack(uint8_t *buf, const poly *a);
#define poly_decomposed_unpack HAETAE_NAMESPACE(poly_decomposed_unpack)
void poly_decomposed_unpack(poly *a, const uint8_t *buf);

#define poly_fromcrt HAETAE_NAMESPACE(poly_fromcrt)
void poly_fromcrt(poly *w, const poly *u, const poly *v);
#define poly_fromcrt0 HAETAE_NAMESPACE(poly_fromcrt0)
void poly_fromcrt0(poly *w, const poly *u);

#define poly_ntt HAETAE_NAMESPACE(poly_ntt)
void poly_ntt(poly *a);
#define poly_invntt_tomont HAETAE_NAMESPACE(poly_invntt_tomont)
void poly_invntt_tomont(poly *a);

#endif /* !HAETAE_POLY_H */
