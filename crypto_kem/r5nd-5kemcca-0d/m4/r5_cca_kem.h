//  r5_cca_kem.h
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#ifndef _R5_CCA_KEM_H_
#define _R5_CCA_KEM_H_

#include <stdint.h>

//  CCA KEM key generation
int r5_cca_kem_keygen(uint8_t *pk, uint8_t *sk);

//  CCA KEM encapsulate
int r5_cca_kem_encapsulate(uint8_t *ct, uint8_t *k, const uint8_t *pk);

//  CCA KEM ecapsulate
int r5_cca_kem_decapsulate(uint8_t *k, const uint8_t *ct, const uint8_t *sk);

#endif /* _R5_CCA_KEM_H_ */
