// SPDX-License-Identifier: MIT

#ifndef HAETAE_POLYMAT_H
#define HAETAE_POLYMAT_H

#include "params.h"
#include "polyvec.h"

#include <stdint.h>

#define polymatkl_expand_matA HAETAE_NAMESPACE(polymatkl_expand_matA)
void polymatkl_expand_matA(polyvecl mat[HAETAE_K],
                           const uint8_t rho[HAETAE_SEEDBYTES]);

#define polymatkm_expand_matA HAETAE_NAMESPACE(polymatkm_expand_matA)
void polymatkm_expand_matA(polyvecm mat[HAETAE_K],
                           const uint8_t rho[HAETAE_SEEDBYTES]);

#define polymatkm_pointwise_montgomery                                         \
  HAETAE_NAMESPACE(polymatkm_pointwise_montgomery)
void polymatkm_pointwise_montgomery(polyveck *t, const polyvecm mat[HAETAE_K],
                                    const polyvecm *v);

#define polymatkl_pointwise_montgomery                                         \
  HAETAE_NAMESPACE(polymatkl_pointwise_montgomery)
void polymatkl_pointwise_montgomery(polyveck *t, const polyvecl mat[HAETAE_K],
                                    const polyvecl *v);

#define polymatkl_double HAETAE_NAMESPACE(polymatkl_double)
void polymatkl_double(polyvecl mat[HAETAE_K]);

#endif /* !HAETAE_POLYMAT_H */
