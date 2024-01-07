#ifndef HAETAE_POLYMAT_H
#define HAETAE_POLYMAT_H

#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include <stdint.h>

#define expand_pk_matrix_elem HAETAE_NAMESPACE(expand_pk_matrix_elem)
void expand_pk_matrix_elem(poly *elem, const size_t row, const size_t column, const uint8_t pk[CRYPTO_PUBLICKEYBYTES]);

#define expand_pk_matrix_elem_frozen HAETAE_NAMESPACE(expand_pk_matrix_elem_frozen)
void expand_pk_matrix_elem_frozen(poly_frozen *elem, const size_t row, const size_t column, const uint8_t pk[CRYPTO_PUBLICKEYBYTES]);

#define polymatkl_expand HAETAE_NAMESPACE(polymatkl_expand)
void polymatkl_expand(polyvecl mat[K], const uint8_t rho[SEEDBYTES]);

#define polymatkm_expand HAETAE_NAMESPACE(polymatkm_expand)
void polymatkm_expand(polyvecm mat[K], const uint8_t rho[SEEDBYTES]);

#define polymatkm_pointwise_montgomery                                         \
    HAETAE_NAMESPACE(polymatkm_pointwise_montgomery)
void polymatkm_pointwise_montgomery(polyveck *t, const polyvecm mat[K],
                                    const polyvecm *v);

#define polymatkl_pointwise_montgomery                                         \
    HAETAE_NAMESPACE(polymatkl_pointwise_montgomery)
void polymatkl_pointwise_montgomery(polyveck *t, const polyvecl mat[K],
                                    const polyvecl *v);

#define polymatkl_double HAETAE_NAMESPACE(polymatkl_double)
void polymatkl_double(polyvecl mat[K]);

#endif
