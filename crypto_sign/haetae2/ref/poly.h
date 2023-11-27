// clang-format off
#ifndef HAETAE_POLY_H
#define HAETAE_POLY_H

#include "params.h"
#include "reduce.h"
#include "sampler.h"
#include <stdint.h>

typedef struct {
    int32_t coeffs[N];
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
#define poly_compose HAETAE_NAMESPACE(poly_compose)
void poly_compose(poly *a, const poly *ha, const poly *la);
#define poly_lsb HAETAE_NAMESPACE(poly_lsb)
void poly_lsb(poly *a0, const poly *a);

#define poly_uniform HAETAE_NAMESPACE(poly_uniform)
void poly_uniform(poly *a, const uint8_t seed[SEEDBYTES], uint16_t nonce);
#define poly_uniform_eta HAETAE_NAMESPACE(poly_uniform_eta)
void poly_uniform_eta(poly *a, const uint8_t seed[CRHBYTES], uint16_t nonce);
#define poly_challenge HAETAE_NAMESPACE(poly_challenge)
void poly_challenge(poly *c, const uint8_t highbits_lsb[POLYVECK_HIGHBITS_PACKEDBYTES + POLYC_PACKEDBYTES], const uint8_t mu[SEEDBYTES]);

#define poly_decomposed_pack HAETAE_NAMESPACE(poly_decomposed_pack)
void poly_decomposed_pack(uint8_t *buf, const poly *a);
#define poly_decomposed_unpack HAETAE_NAMESPACE(poly_decomposed_unpack)
void poly_decomposed_unpack(poly *a, const uint8_t *buf);

#define poly_pack_highbits HAETAE_NAMESPACE(poly_pack_highbits)
void poly_pack_highbits(uint8_t *buf, const poly *a);

#define poly_pack_lsb HAETAE_NAMESPACE(poly_pack_lsb)
void poly_pack_lsb(uint8_t *buf, const poly *a);

#define polyq_pack HAETAE_NAMESPACE(polyq_pack)
void polyq_pack(uint8_t *r, const poly *a);
#define polyq_unpack HAETAE_NAMESPACE(polyq_unpack)
void polyq_unpack(poly *r, const uint8_t *a);

#define polyeta_pack HAETAE_NAMESPACE(polyeta_pack)
void polyeta_pack(uint8_t *r, const poly *a);
#define polyeta_unpack HAETAE_NAMESPACE(polyeta_unpack)
void polyeta_unpack(poly *r, const uint8_t *a);
#define poly2eta_pack HAETAE_NAMESPACE(poly2eta_pack)
void poly2eta_pack(uint8_t *r, const poly *a);
#define poly2eta_unpack HAETAE_NAMESPACE(poly2eta_unpack)
void poly2eta_unpack(poly *r, const uint8_t *a);

#define poly_fromcrt HAETAE_NAMESPACE(poly_fromcrt)
void poly_fromcrt(poly *w, const poly *u, const poly *v);
#define poly_fromcrt0 HAETAE_NAMESPACE(poly_fromcrt0)
void poly_fromcrt0(poly *w, const poly *u);

#define poly_ntt HAETAE_NAMESPACE(poly_ntt)
void poly_ntt(poly *a);
#define poly_invntt_tomont HAETAE_NAMESPACE(poly_invntt_tomont)
void poly_invntt_tomont(poly *a);

#endif
// clang-format on
