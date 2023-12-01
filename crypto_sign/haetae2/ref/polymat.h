#ifndef HAETAE_POLYMAT_H
#define HAETAE_POLYMAT_H

#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include <stdint.h>

#define polymatkl_expand HAETAE_NAMESPACE(polymatkl_expand)
void polymatkl_expand(polyvecl mat[K], const uint8_t rho[SEEDBYTES]);

#define polymatkl_expand_frozen HAETAE_NAMESPACE(polymatkl_expand_frozen)
void polymatkl_expand_frozen(polyvecl_frozen mat[K], const uint8_t rho[SEEDBYTES]);

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

#define polymatkl_pointwise_montgomery_frozen                                         \
    HAETAE_NAMESPACE(polymatkl_pointwise_montgomery_frozen)
void polymatkl_pointwise_montgomery_frozen(polyveck *t, const polyvecl_frozen mat[K],
                                           const polyvecl *v);

#define polymatkl_double HAETAE_NAMESPACE(polymatkl_double)
void polymatkl_double(polyvecl mat[K]);

#define polymatkl_double_frozen HAETAE_NAMESPACE(polymatkl_double_frozen)
void polymatkl_double_frozen(polyvecl_frozen mat[K]);

#endif
