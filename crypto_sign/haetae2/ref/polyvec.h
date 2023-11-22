// clang-format off
#ifndef HAETAE_POLYVEC_H
#define HAETAE_POLYVEC_H

#include "params.h"
#include "poly.h"
#include <stdint.h>

/* Vectors of polynomials of length K */
typedef struct {
    poly vec[K];
} polyveck;

#define polyveck_add HAETAE_NAMESPACE(polyveck_add)
void polyveck_add(polyveck *w, const polyveck *u, const polyveck *v);
#define polyveck_sub HAETAE_NAMESPACE(polyveck_sub)
void polyveck_sub(polyveck *w, const polyveck *u, const polyveck *v);
#define polyveck_double HAETAE_NAMESPACE(polyveck_double)
void polyveck_double(polyveck *b);

#define polyveck_reduce2q HAETAE_NAMESPACE(polyveck_reduce2q)
void polyveck_reduce2q(polyveck *v);
#define polyveck_freeze2q HAETAE_NAMESPACE(polyveck_freeze2q)
void polyveck_freeze2q(polyveck *v);
#define polyveck_freeze HAETAE_NAMESPACE(polyveck_freeze)
void polyveck_freeze(polyveck *v);

#define polyveck_uniform_eta HAETAE_NAMESPACE(polyveck_uniform_eta)
void polyveck_uniform_eta(polyveck *v, const uint8_t seed[CRHBYTES], uint16_t nonce);
#define polyveck_expand HAETAE_NAMESPACE(polyveck_expand)
void polyveck_expand(polyveck *v, const uint8_t seed[SEEDBYTES]);

#define polyveck_ntt HAETAE_NAMESPACE(polyveck_ntt)
void polyveck_ntt(polyveck *x);

#define polyveck_invntt_tomont HAETAE_NAMESPACE(polyveck_invntt_tomont)
void polyveck_invntt_tomont(polyveck *x);

#define polyveck_double_negate HAETAE_NAMESPACE(polyveck_double_negate)
void polyveck_double_negate(polyveck *x);

#define polyveck_frommont HAETAE_NAMESPACE(polyveck_frommont)
void polyveck_frommont(polyveck *x);

#define polyveck_poly_pointwise_montgomery HAETAE_NAMESPACE(polyveck_poly_pointwise_montgomery)
void polyveck_poly_pointwise_montgomery(polyveck *w, const polyveck *u, const poly *v);

#define polyveck_poly_fromcrt HAETAE_NAMESPACE(polyveck_poly_fromcrt)
void polyveck_poly_fromcrt(polyveck *w, const polyveck *u, const poly *v);

#define polyveck_highbits_hint HAETAE_NAMESPACE(polyveck_highbits_hint)
void polyveck_highbits_hint(polyveck *w, const polyveck *v);

#define polyveck_pack_highbits HAETAE_NAMESPACE(polyveck_pack_highbits)
void polyveck_pack_highbits(uint8_t *buf, const polyveck *v);

#define polyveck_cneg HAETAE_NAMESPACE(polyveck_cneg)
void polyveck_cneg(polyveck *v, const uint8_t b);

#define polyveck_caddDQ2ALPHA HAETAE_NAMESPACE(polyveck_caddDQ2ALPHA)
void polyveck_caddDQ2ALPHA(polyveck *h);

#define polyveck_csubDQ2ALPHA HAETAE_NAMESPACE(polyveck_csubDQ2ALPHA)
void polyveck_csubDQ2ALPHA(polyveck *v);

#define polyveck_mul_alpha HAETAE_NAMESPACE(polyveck_mul_alpha)
void polyveck_mul_alpha(polyveck *v, const polyveck *u);

#define polyveck_div2 HAETAE_NAMESPACE(polyveck_div2)
void polyveck_div2(polyveck *v);

#define polyveck_caddq HAETAE_NAMESPACE(polyveck_caddq)
void polyveck_caddq(polyveck *v);

#define polyveck_decompose_vk HAETAE_NAMESPACE(polyveck_decompose_vk)
void polyveck_decompose_vk(polyveck *v0, polyveck *v);

#define polyveck_sqnorm2 HAETAE_NAMESPACE(polyveck_sqnorm2)
uint64_t polyveck_sqnorm2(const polyveck *b);

/* Vectors of polynomials of length L */
typedef struct {
    poly vec[L];
} polyvecl;

#define polyvecl_cneg HAETAE_NAMESPACE(polyvecl_cneg)
void polyvecl_cneg(polyvecl *v, const uint8_t b);

#define polyvecl_sqnorm2 HAETAE_NAMESPACE(polyvecl_sqnorm2)
uint64_t polyvecl_sqnorm2(const polyvecl *a);

#define polyvecl_ntt HAETAE_NAMESPACE(polyvecl_ntt)
void polyvecl_ntt(polyvecl *x);

#define polyvecl_highbits HAETAE_NAMESPACE(polyvecl_highbits)
void polyvecl_highbits(polyvecl *v2, const polyvecl *v);
#define polyvecl_lowbits HAETAE_NAMESPACE(polyvecl_lowbits)
void polyvecl_lowbits(polyvecl *v2, const polyvecl *v);

#define polyvecl_pointwise_acc_montgomery HAETAE_NAMESPACE(polyvecl_pointwise_acc_montgomery)
void polyvecl_pointwise_acc_montgomery(poly *w,
                                       const polyvecl *u,
                                       const polyvecl *v);


/* Vectors of polynomials of length M */
typedef struct {
  poly vec[M];
} polyvecm;

#define polyvecm_ntt HAETAE_NAMESPACE(polyvecm_ntt)
void polyvecm_ntt(polyvecm *x);

#define polyvecmk_uniform_eta HAETAE_NAMESPACE(polyvecmk_uniform_eta)
void polyvecmk_uniform_eta(polyvecm *u, polyveck *v, const uint8_t seed[CRHBYTES], uint16_t nonce);

#define polyvecm_pointwise_acc_montgomery HAETAE_NAMESPACE(polyvecm_pointwise_acc_montgomery)
void polyvecm_pointwise_acc_montgomery(poly *w,
                                       const polyvecm *u,
                                       const polyvecm *v);

#define polyvecmk_sqsing_value HAETAE_NAMESPACE(polyvecmk_sqsing_value)
int64_t polyvecmk_sqsing_value(const polyvecm *s1, const polyveck *s2);

#define polyvecmk_sing_value HAETAE_NAMESPACE(polyvecmk_sing_value)
int64_t polyvecmk_sing_value(const polyvecm *s1, const polyveck *s2);

#endif
//clang-format on
