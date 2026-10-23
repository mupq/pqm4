// SPDX-License-Identifier: MIT

#ifndef HAETAE_PACKING_H
#define HAETAE_PACKING_H

#include "params.h"
#include "polyvec.h"

#include <stdint.h>

#define pack_vk HAETAE_NAMESPACE(pack_vk)
void pack_vk(uint8_t vk[HAETAE_CRYPTO_PUBLICKEYBYTES], polyveck *b,
             const uint8_t seed[HAETAE_SEEDBYTES]);
#define unpack_vk HAETAE_NAMESPACE(unpack_vk)
void unpack_vk(polyvecl A[HAETAE_K],
               const uint8_t vk[HAETAE_CRYPTO_PUBLICKEYBYTES]);

#define pack_sk HAETAE_NAMESPACE(pack_sk)
void pack_sk(uint8_t sk[HAETAE_CRYPTO_SECRETKEYBYTES],
             const uint8_t vk[HAETAE_CRYPTO_PUBLICKEYBYTES], const polyvecm *s0,
             const polyveck *s1, const uint8_t key[HAETAE_SEEDBYTES]);
#define unpack_sk HAETAE_NAMESPACE(unpack_sk)
void unpack_sk(polyvecl A[HAETAE_K], polyvecm *s0, polyveck *s1, uint8_t *key,
               const uint8_t sk[HAETAE_CRYPTO_SECRETKEYBYTES]);

#define pack_sig HAETAE_NAMESPACE(pack_sig)
int pack_sig(uint8_t sig[HAETAE_CRYPTO_BYTES], const poly *c,
             const polyvecl *lowbits_z1, const polyvecl *highbits_z1,
             const polyveck *h);
#define unpack_sig HAETAE_NAMESPACE(unpack_sig)
int unpack_sig(poly *c, polyvecl *lowbits_z1, polyvecl *highbits_z1,
               polyveck *h, const uint8_t sig[HAETAE_CRYPTO_BYTES]);

#define pack_poly_q HAETAE_NAMESPACE(pack_poly_q)
void pack_poly_q(uint8_t *r, const poly *a);
#define unpack_poly_q HAETAE_NAMESPACE(unpack_poly_q)
void unpack_poly_q(poly *r, const uint8_t *a);

#define pack_poly_eta HAETAE_NAMESPACE(pack_poly_eta)
void pack_poly_eta(uint8_t *r, const poly *a);
#define unpack_poly_eta HAETAE_NAMESPACE(unpack_poly_eta)
void unpack_poly_eta(poly *r, const uint8_t *a);

#define pack_poly2_eta HAETAE_NAMESPACE(pack_poly2_eta)
void pack_poly2_eta(uint8_t *r, const poly *a);
#define unpack_poly2_eta HAETAE_NAMESPACE(unpack_poly2_eta)
void unpack_poly2_eta(poly *r, const uint8_t *a);

#define pack_vec_highbits HAETAE_NAMESPACE(pack_vec_highbits)
void pack_vec_highbits(uint8_t *buf, const polyveck *v);

#define pack_poly_highbits HAETAE_NAMESPACE(pack_poly_highbits)
void pack_poly_highbits(uint8_t *buf, const poly *a);

#define pack_poly_lsb HAETAE_NAMESPACE(pack_poly_lsb)
void pack_poly_lsb(uint8_t *buf, const poly *a);

#endif /* !HAETAE_PACKING_H */
