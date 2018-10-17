//  api.h
//  2018-06-30  Markku-Juhani O. Saarinen <mjos@iki.fi>

#ifndef _API_H_
#define _API_H_

/* define default parameter set */

#define R5ND_3KEM

#include "params.h"


/*
    This is the API defined by NIST for PQC KEMs.

    Public key:     unsigned char pk[CRYPTO_PUBLICKEYBYTES];
    Secret key:     unsigned char sk[CRYPTO_SECRETKEYBYTES];
    Ciphertext:     unsigned char ct[CRYPTO_CIPHERTEXTBYTES];
    Shared secret:  unsigned char ss[CRYPTO_BYTES];

    The functions always return 0. In case of decryption error the shared
    secrets from crypto_kem_enc() and crypto_kem_dec() simply won't match.
*/

// Key generation: (pk, sk) = KeyGen()

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);

// Encapsulate: (ct, ss) = Encaps(pk)

int crypto_kem_enc(unsigned char *ct, unsigned char *ss, 
                   const unsigned char *pk);

// Decapsulate: ss = Decaps(ct, sk)

int crypto_kem_dec(unsigned char *ss, 
                   const unsigned char *ct, const unsigned char *sk);

#endif /* _API_H_ */

