#ifndef STACK_H
#define STACK_H

#include "poly.h"
#include "smallpoly.h"
#include <stdint.h>
#include <stddef.h>
#include "fips202.h"

void poly_challenge_compress(uint8_t c[68], const poly *cp);
void poly_challenge_decompress(poly *cp, const uint8_t c[68]);


void poly_schoolbook(poly *c, const uint8_t ccomp[68], const uint8_t *t0);
void poly_schoolbook_t1(poly *c, const uint8_t ccomp[68], const uint8_t *t1);
void polyw_pack(uint8_t buf[3*256], poly *w);
void polyw_unpack(poly *w, const uint8_t buf[3*256]);
void polyw_pack_w1(uint8_t buf[3*256], uint8_t w1[POLYW1_PACKEDBYTES], const poly *w);
void poly_pointwise_montgomery_polyw(poly *c, const uint8_t buf[3*256]);

void polyw_add(uint8_t buf[3*256], poly *p);
void polyw_sub(poly* c, uint8_t buf[3*256], poly *a);

void unpack_sk_s1(smallpoly *a, const uint8_t *sk, size_t idx);
void unpack_sk_s2(smallpoly *a, const uint8_t *sk, size_t idx);

void poly_uniform_pointwise_montgomery_polywadd_stack(uint8_t wcomp[3*N], const poly *b, const uint8_t  seed[SEEDBYTES], uint16_t nonce, shake128incctx *state);
void poly_uniform_pointwise_montgomery_polywadd_block(uint8_t wcomp[3*N], const poly *b, const uint8_t seed[SEEDBYTES], uint16_t nonce, shake128incctx *state);
void poly_uniform_gamma1_keep(poly *a, uint8_t ypacked[POLYZ_PACKEDBYTES], const uint8_t seed[CRHBYTES], uint16_t nonce, shake256incctx *state);
int polyz_add_reduce_check_inplace(uint8_t zy[POLYZ_PACKEDBYTES], const smallpoly *cs1, int32_t bound);
int polyw_sub_cs2_check_r0(uint8_t wcomp[3*N], const smallpoly *cs2, int32_t bound);
void poly_challenge_extbuf(poly *c, const uint8_t seed[CTILDEBYTES], shake256incctx *state, uint8_t buf[68]);

/* For each 3-byte candidate t (little endian, low 23 bits) of buf with t < Q: w[ctr] += t*b[ctr]*2^-32 mod Q, ctr++.
 * Requires 0 <= ctr <= N, buflen % 3 == 0, w canonical (coefficients in [0,Q), 24-bit packed) and w, b, buf disjoint.
 * Stops when ctr reaches N; returns the new ctr. Uses unaligned halfword accesses. */
#define asm_rej_mulacc24 DILITHIUM_NAMESPACE(asm_rej_mulacc24)
unsigned int asm_rej_mulacc24(uint8_t w[3*N], const int32_t b[N], unsigned int ctr, const uint8_t *buf, unsigned int buflen);

int poly_make_hint_pack_stack(uint8_t *sig, unsigned int k, unsigned int *hints_written, const poly *ct0, const uint8_t w[768]);
int unpack_sig_h_indices(uint8_t h_i[OMEGA], unsigned int * number_of_hints, unsigned int idx, const unsigned char sig[CRYPTO_BYTES]);
void poly_use_hint_stack(poly *b, const poly *a, uint8_t h_i[OMEGA], unsigned int number_of_hints);

void pack_pk_rho(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
                 const unsigned char rho[SEEDBYTES]);

void pack_pk_t1(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
             const poly *t1,
             const unsigned int idx);

void pack_sk_s1(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s1_elem,
                const unsigned int idx);

void pack_sk_s2(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s2_elem,
                const unsigned int idx);

void pack_sk_t0(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *t0_elem,
                const unsigned int idx);

void pack_sk_rho(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                 const unsigned char rho[SEEDBYTES]);

void pack_sk_key(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                 const unsigned char key[SEEDBYTES]);

void pack_sk_tr(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const unsigned char tr[TRBYTES]);
#endif