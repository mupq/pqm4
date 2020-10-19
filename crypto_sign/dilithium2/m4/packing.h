#ifndef PACKING_H
#define PACKING_H

#include "params.h"
#include "polyvec.h"

#include <stddef.h>

void pack_pk(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
                                      const unsigned char rho[SEEDBYTES], const polyveck *t1);
void pack_pk_rho(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
                 const unsigned char rho[SEEDBYTES]);
void pack_pk_t1(unsigned char pk[CRYPTO_PUBLICKEYBYTES],
             const poly *t1,
             const size_t idx);
void pack_sk(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                      const unsigned char rho[SEEDBYTES],
                                      const unsigned char key[SEEDBYTES],
                                      const unsigned char tr[CRHBYTES],
                                      const polyvecl *s1,
                                      const polyveck *s2,
                                      const polyveck *t0);

void pack_sk_rho(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                 const unsigned char rho[SEEDBYTES]);
void pack_sk_key(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                 const unsigned char key[SEEDBYTES]);
void pack_sk_tr(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const unsigned char tr[SEEDBYTES]);
void pack_sk_s1(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s1_elem,
                const size_t idx);
void pack_sk_s2(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *s2_elem,
                const size_t idx);
void pack_sk_t0(unsigned char sk[CRYPTO_SECRETKEYBYTES],
                const poly *t0_elem,
                const size_t idx);

#define pack_sig DILITHIUM_NAMESPACE(_pack_sig)
void pack_sig(unsigned char sig[CRYPTO_BYTES],
              const polyvecl *z, const polyveck *h, const poly *c);
#define pack_sig_z DILITHIUM_NAMESPACE(_pack_sig_z)
void pack_sig_z(unsigned char sig[CRYPTO_BYTES],
                const poly *z_elem,
                const size_t idx);
#define pack_sig_h DILITHIUM_NAMESPACE(_pack_sig_h)
void pack_sig_h(unsigned char sig[CRYPTO_BYTES],
                const poly *h_elem,
                const size_t idx,
                size_t *hints_written);
#define pack_sig_h_zero DILITHIUM_NAMESPACE(_pack_sig_h_zero)
void pack_sig_h_zero(unsigned char sig[CRYPTO_BYTES],
                size_t *hints_written);
#define pack_sig_c DILITHIUM_NAMESPACE(_pack_sig_c)
void pack_sig_c(unsigned char sig[CRYPTO_BYTES],
                const poly *c);

void unpack_pk(unsigned char rho[SEEDBYTES], polyveck *t1,
                                        const unsigned char pk[CRYPTO_PUBLICKEYBYTES]);
const unsigned char *getoffset_pk_rho(const unsigned char pk[CRYPTO_PUBLICKEYBYTES]);
void unpack_pk_t1(poly *t1, size_t idx, const unsigned char pk[CRYPTO_PUBLICKEYBYTES]);
void unpack_sk(unsigned char rho[SEEDBYTES],
                                        unsigned char key[SEEDBYTES],
                                        unsigned char tr[CRHBYTES],
                                        polyvecl *s1,
                                        polyveck *s2,
                                        polyveck *t0,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
void unpack_sk_rho(unsigned char rho[SEEDBYTES],
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
const uint8_t *getoffset_sk_rho(const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
void unpack_sk_key(unsigned char key[SEEDBYTES],
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
const uint8_t *getoffset_sk_key(const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
void unpack_sk_tr(unsigned char tr[CRHBYTES],
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
const uint8_t *getoffset_sk_tr(const unsigned char sk[CRYPTO_SECRETKEYBYTES]);
void unpack_sk_s1(poly *s1_elem,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                        const size_t idx);
void unpack_sk_s2(poly *s2_elem,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                        const size_t idx);
void unpack_sk_t0(poly *t0_elem,
                                        const unsigned char sk[CRYPTO_SECRETKEYBYTES],
                                        const size_t idx);
int unpack_sig(polyvecl *z, polyveck *h, poly *c,
                                        const unsigned char sig[CRYPTO_BYTES]);
int unpack_sig_z(polyvecl *z, const unsigned char sig[CRYPTO_BYTES]);
int unpack_sig_h(poly *h, size_t idx, const unsigned char sig[CRYPTO_BYTES]);
int unpack_sig_c(poly *c, const unsigned char sig[CRYPTO_BYTES]);

#endif
