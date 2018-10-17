//  kem_cpa.c
//  2018-06-17  Markku-Juhani O. Saarinen <mjos@iki.fi>

//  CPA Versions of KEM functionality

#include "api.h"

#ifdef NOFO_CPA

#include <stdlib.h>
#include <string.h>

#include "encrypt.h"
#include "xof_hash.h"
#include "randombytes.h"

// CPA-KEM KeyGen()

int crypto_kem_keypair(uint8_t *pk, uint8_t *sk) 
{
    generate_keypair(pk, sk);

    return 0;
}

// CPA-KEM Encaps()

int crypto_kem_enc(uint8_t *ct, uint8_t *ss, const uint8_t *pk) 
{
    uint8_t hash_input[PARAMS_SS_SIZE + CRYPTO_CIPHERTEXTBYTES];
    uint8_t m[PARAMS_SS_SIZE];
    uint8_t rho[PARAMS_SS_SIZE];

    /* Generate a random m */
    randombytes(m, PARAMS_SS_SIZE);   
    randombytes(rho, PARAMS_SS_SIZE);
    encrypt_rho(ct, m, rho, pk);

    /* K = H(m, c) */
    memcpy(hash_input, m, PARAMS_SS_SIZE);
    memcpy(hash_input + PARAMS_SS_SIZE, ct, CRYPTO_CIPHERTEXTBYTES);
    XOF_hash(ss, hash_input, PARAMS_SS_SIZE + CRYPTO_CIPHERTEXTBYTES,
        PARAMS_SS_SIZE);

    return 0;
}

// CPA-KEM Decaps()

int crypto_kem_dec(uint8_t *ss, const uint8_t *ct, const uint8_t *sk) 
{
    uint8_t hash_input[PARAMS_SS_SIZE + CRYPTO_CIPHERTEXTBYTES];
    uint8_t m[PARAMS_SS_SIZE];

    /* Decrypt m */
    decrypt(m, ct, sk);

    /* K = H(m, c) */
    memcpy(hash_input, m, PARAMS_SS_SIZE);
    memcpy(hash_input + PARAMS_SS_SIZE, ct, CRYPTO_CIPHERTEXTBYTES);
    XOF_hash(ss, hash_input, PARAMS_SS_SIZE + CRYPTO_CIPHERTEXTBYTES, 
        PARAMS_SS_SIZE);

    return 0;
}

#endif /* NOFO_CPA */

