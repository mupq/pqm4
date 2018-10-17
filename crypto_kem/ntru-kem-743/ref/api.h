/******************************************************************************
 * NTRU Cryptography Reference Source Code submitting to NIST call for
 * proposals for post quantum cryptography
 *
 * This code is written by Zhenfei Zhang @ OnboardSecurity, with additional
 * codes from public domain.
 *
 ******************************************************************************/
/*
 * api.h
 *
 *  Created on: Aug 29, 2017
 *      Author: zhenfei
 */

#ifndef API_H_
#define API_H_


#define TEST_PARAM_SET  NTRU_KEM_743
#define CRYPTO_SECRETKEYBYTES 1173   /* secret key length */
#define CRYPTO_PUBLICKEYBYTES 1023  /* public key length */
#define CRYPTO_BYTES 48             /* shared secret length */
#define CRYPTO_CIPHERTEXTBYTES 1023
#define CRYPTO_RANDOMBYTES 32       /* random input */
#define CRYPTO_ALGNAME "NTRU_KEM_743"

/* ebacs API: key gen */
int crypto_encrypt_keypair(
    unsigned char       *pk,
    unsigned char       *sk);

/* ebacs API: encryption */
int crypto_encrypt(
    unsigned char       *c,
    unsigned long long  *clen,
    const unsigned char *m,
    unsigned long long  mlen,
    const unsigned char *pk);

/* ebacs API: decryption */
int crypto_encrypt_open(
    unsigned char       *m,
    unsigned long long  *mlen,
    const unsigned char *c,
    unsigned long long  clen,
    const unsigned char *sk);


int crypto_kem_keypair(
    unsigned char       *pk,
    unsigned char       *sk);

int crypto_kem_enc(
    unsigned char       *ct,
    unsigned char       *ss,
    const unsigned char *pk);

int crypto_kem_dec(
    unsigned char       *ss,
    const unsigned char *ct,
    const unsigned char *sk);

#endif /* API_H_ */
