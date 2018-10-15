/*
 * kem.c
 *
 *  Created on: Aug 29, 2017
 *      Author: zhenfei
 */
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "api.h"
#include "NTRUEncrypt.h"
#include "packing.h"
#include "crypto_hash_sha512.h"
#include "randombytes.h"

/* kem and encryption use a same key gen */
int crypto_kem_keypair(
    unsigned char *pk,
    unsigned char *sk)
{
    uint16_t    *F, *g, *h;
    PARAM_SET   *param;

    param   = get_param_set_by_id(TEST_PARAM_SET);

    /* memory for 3 ring elements: f, g and h */
    uint16_t mem[param->padN * 3];
    uint16_t buf[param->padN * 6];

    memset(mem,0,sizeof(uint16_t)*param->padN);

    F = mem;
    g = F   + param->padN;
    h = g   + param->padN;

    keygen(F,g,h,buf,param);

    /* pack h into pk */
    pack_public_key(pk, param, h);
    int i;
    for (i=0;i<param->packsk;i++)
        sk[i] =0;

    /* pack F,h into sk */
    pack_secret_key_CCA(sk, param, F, h);

    memset(mem,0, sizeof(uint16_t)*param->padN*3);
    memset(buf,0, sizeof(uint16_t)*param->padN*6);
    return 0;
}


int crypto_kem_enc(
    unsigned char *ct,
    unsigned char *ss,
    const unsigned char *pk)
{

    PARAM_SET   *param;
    uint16_t    *h, *cpoly;
    param   = get_param_set_by_id(pk[0]);


    if ( param->id!=NTRU_KEM_443 && param->id != NTRU_KEM_743)
    {
        printf("unsupported parameter sets\n");
        return -1;
    }

    uint16_t mem[param->padN*2];
    uint16_t buf[param->padN*6];
    unsigned char shared_secret[CRYPTO_BYTES + LENGTH_OF_HASH];


    h       = mem;
    cpoly   = h     + param->padN;


    memset(mem,0, sizeof(uint16_t)*param->padN*2);
    memset(buf,0, sizeof(uint16_t)*param->padN*6);
    memset(shared_secret, 0, CRYPTO_BYTES + LENGTH_OF_HASH);
    memset(ss, 0, CRYPTO_BYTES);

    /* randomly generate a string to be encapsulated */
    randombytes(shared_secret, CRYPTO_BYTES);
    unpack_public_key(pk,param, h);
    encrypt_cca(cpoly, (char*) shared_secret, CRYPTO_BYTES, h,  buf, param);
    pack_public_key (ct, param, cpoly);

    /* ss = Hash (shared_secret | h) */
    crypto_hash_sha512(shared_secret + CRYPTO_BYTES, (unsigned char*)h, sizeof(uint16_t)*param->padN);
    crypto_hash_sha512(shared_secret, shared_secret, LENGTH_OF_HASH + CRYPTO_BYTES);
    memcpy (ss, shared_secret, CRYPTO_BYTES);


    memset(mem,0, sizeof(uint16_t)*param->padN*2);
    memset(buf,0, sizeof(uint16_t)*param->padN*6);
    memset(shared_secret, 0, CRYPTO_BYTES + LENGTH_OF_HASH);
    return 0;
}


int crypto_kem_dec(
    unsigned char *ss,
    const unsigned char *ct,
    const unsigned char *sk)
{
    PARAM_SET   *param;
    uint16_t    *F, *cpoly, *h;
    unsigned long long  mlen;
    param   =   get_param_set_by_id(ct[0]);
    if ( param->id!=NTRU_KEM_443 && param->id != NTRU_KEM_743)
    {
        printf("unsupported parameter sets\n");
        return -1;
    }

    uint16_t mem[param->padN*3];
    uint16_t buf[param->padN*8];
    unsigned char shared_secret[CRYPTO_BYTES + LENGTH_OF_HASH];

    F       = mem;
    cpoly   = F     + param->padN;
    h       = cpoly + param->padN;


    memset(mem,0, sizeof(uint16_t)*param->padN*3);
    memset(buf,0, sizeof(uint16_t)*param->padN*8);
    memset(shared_secret, 0, CRYPTO_BYTES + LENGTH_OF_HASH);


    /* decapsulation process */
    unpack_public_key (ct, param, cpoly);
    if(unpack_secret_key_CCA (sk, param, F, h))
    {
        return -1;
    }

    mlen = decrypt_cca((char*) shared_secret,  F, h, cpoly,  buf, param);
    if (mlen!=CRYPTO_BYTES)
    {
        return -1;
    }

    /* deriving the session key */
    crypto_hash_sha512(shared_secret+CRYPTO_BYTES, (unsigned char*) h, sizeof(uint16_t)*param->padN);
    crypto_hash_sha512(shared_secret, shared_secret, LENGTH_OF_HASH + CRYPTO_BYTES);
    memcpy (ss, shared_secret, CRYPTO_BYTES);
    return 0;
}



