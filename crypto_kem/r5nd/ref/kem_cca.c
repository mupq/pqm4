//  kem_cca.c
//  2018-06-17  Markku-Juhani O. Saarinen <mjos@iki.fi>

//  CCA Versions of KEM functionality

#include "api.h"

#ifndef NOFO_CPA

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "encrypt.h"
#include "xof_hash.h"
#include "randombytes.h"

// CCA-KEM KeyGen()

int crypto_kem_keypair(uint8_t *pk, uint8_t *sk) 
{
    uint8_t z[PARAMS_SS_SIZE];

    /* Generate the base key pair */
    generate_keypair(pk, sk);

    /* Append z and pk to sk */
    randombytes(z, PARAMS_SS_SIZE);
    memcpy(sk + PARAMS_SK_SIZE, z, PARAMS_SS_SIZE);
    memcpy(sk + PARAMS_SK_SIZE + PARAMS_SS_SIZE, pk, PARAMS_PK_SIZE);

    return 0;
}

// CCA-KEM Encaps()

int crypto_kem_enc(uint8_t *ct, uint8_t *ss, const uint8_t *pk) 
{
    uint8_t hash_in[PARAMS_SS_SIZE + PARAMS_CT_SIZE + PARAMS_SS_SIZE];
    uint8_t m[PARAMS_SS_SIZE];
    uint8_t l_g_rho[3][PARAMS_SS_SIZE];

    randombytes(m, PARAMS_SS_SIZE);     // generate random m

    memcpy(hash_in, m, PARAMS_SS_SIZE); // G: (l | g | rho) = h(m | pk);
    memcpy(hash_in + PARAMS_SS_SIZE, pk, PARAMS_PK_SIZE);
    XOF_hash(l_g_rho, hash_in, PARAMS_SS_SIZE + PARAMS_PK_SIZE,
            3 * PARAMS_SS_SIZE);

    /* Encrypt  */
    encrypt_rho(ct, m, l_g_rho[2], pk); // m: c = (U,v)

    /* Append g: c = (U,v,g) */
    memcpy(ct + PARAMS_CT_SIZE, l_g_rho[1], PARAMS_SS_SIZE);

    /* K = H(l, c) */
    memcpy(hash_in, l_g_rho[0], PARAMS_SS_SIZE);
    memcpy(hash_in + PARAMS_SS_SIZE, 
        ct, PARAMS_CT_SIZE + PARAMS_SS_SIZE);
    XOF_hash(ss, hash_in, 
        PARAMS_SS_SIZE + PARAMS_CT_SIZE + PARAMS_SS_SIZE, 
        PARAMS_SS_SIZE);

    return 0;
}

// constant time comparison; return nonzero if not equal

static uint8_t ct_memcmp(const void *a, const void *b, size_t len)
{
    const uint8_t *a8 = (const uint8_t *) a;
    const uint8_t *b8 = (const uint8_t *) b;
    uint8_t flag = 0;
    size_t i;
 
    for (i = 0; i < len; i++) {
        flag |= a8[i] ^ b8[i];
    }
 
    return flag;
}

// conditional move; overwrite d with a if flag is nonzero

static void ct_cmov(void *d, const void * a, uint8_t flag, size_t len)
{
    uint8_t *d8 = (uint8_t *) d;
    const uint8_t *a8 = (const uint8_t *) a;
    size_t i;

    flag = -((flag | -flag) >> 7);          // 0x00 or 0xFF

    for (i = 0; i < len; i++) {
        d8[i] ^= flag & (d8[i] ^ a8[i]);
    }
}

// CCA-KEM Decaps()

int crypto_kem_dec(uint8_t *ss, const uint8_t *ct, const uint8_t *sk) 
{
    uint8_t hash_in[PARAMS_SS_SIZE + PARAMS_CT_SIZE + PARAMS_SS_SIZE];
    uint8_t m[PARAMS_SS_SIZE];
    uint8_t l_g_rho[3][PARAMS_SS_SIZE];
    uint8_t c[PARAMS_CT_SIZE + PARAMS_SS_SIZE];
    uint8_t fail;
 
    decrypt(m, ct, sk);                 // decrypt m'

    memcpy(hash_in, m, PARAMS_SS_SIZE);
    memcpy(hash_in + PARAMS_SS_SIZE,    // (L | g | rho) = h(m | pk)
        sk + PARAMS_SK_SIZE + PARAMS_SS_SIZE, PARAMS_PK_SIZE);
    XOF_hash(l_g_rho, hash_in, PARAMS_SS_SIZE + PARAMS_PK_SIZE,
            3 * PARAMS_SS_SIZE);

    encrypt_rho(c, m, l_g_rho[2],       // Encrypt m: c' = (U',v')
        sk + PARAMS_SK_SIZE + PARAMS_SS_SIZE); // pk

    // c' = (U',v',g') 
    memcpy(c + PARAMS_CT_SIZE, l_g_rho[1], PARAMS_SS_SIZE);

    // K = H(l', c')
    memcpy(hash_in, l_g_rho[0], PARAMS_SS_SIZE);
    // verification ok ?
    fail = ct_memcmp(ct, c, PARAMS_CT_SIZE + PARAMS_SS_SIZE);
    // K = H(z, c')
    ct_cmov(hash_in, sk + PARAMS_SK_SIZE, fail, PARAMS_SS_SIZE);
    
    memcpy(hash_in + PARAMS_SS_SIZE, c, PARAMS_CT_SIZE + PARAMS_SS_SIZE);
    XOF_hash(ss, hash_in, 
        PARAMS_SS_SIZE + PARAMS_CT_SIZE + PARAMS_SS_SIZE, 
        PARAMS_SS_SIZE);

    return 0;
}

#endif /* NOFO_CPA */
