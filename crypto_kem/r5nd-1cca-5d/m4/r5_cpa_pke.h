//  r5_cpa_phe.h
//  2019-10-29  Markku-Juhani O. Saarinen <mjos@pqshield.com>
//  Copyright (c) 2019, PQShield Ltd. All rights reserved.

#ifndef _R5_CPA_PKE_H_
#define _R5_CPA_PKE_H_

//  #include "../pqs_local.h"

//  CPA PKE key generation
PQS_OLOCAL int r5_cpa_pke_keygen(uint8_t * pk, uint8_t * sk);

//  CPA encrypt
PQS_OLOCAL int r5_cpa_pke_encrypt(uint8_t * ct, const uint8_t * pk,
								  const uint8_t * m, const uint8_t * rho);

//  CPA decrypt
PQS_OLOCAL int r5_cpa_pke_decrypt(uint8_t * m, const uint8_t * sk,
								  const uint8_t * ct);

#endif										/* _R5_CPA_PKE_H_ */
