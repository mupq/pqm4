//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.
//  Markku-Juhani O. Saarinen, Koninklijke Philips N.V.

#ifndef _R5_CPA_PKE_H_
#define _R5_CPA_PKE_H_

#include <stdint.h>

//  CPA PKE key generation
int r5_cpa_pke_keygen(uint8_t *pk, uint8_t *sk);

//  CPA encrypt
int r5_cpa_pke_encrypt(uint8_t *ct, const uint8_t *pk,
    const uint8_t *m, const uint8_t *rho);

//  CPA decrypt
int r5_cpa_pke_decrypt(uint8_t *m, const uint8_t *sk, const uint8_t *ct);

#endif /* _R5_CPA_PKE_H_ */
