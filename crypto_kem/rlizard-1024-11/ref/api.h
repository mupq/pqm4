#ifndef API_H
#define API_H

#include "params.h"

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);

#define PublicKey_A (LWE_N * 2)
#define PublicKey_B (LWE_N * 2)

#define CRYPTO_PUBLICKEYBYTES (PublicKey_A + PublicKey_B)
#define CRYPTO_SECRETKEYBYTES (LWE_N + (LWE_N / 8) + CRYPTO_PUBLICKEYBYTES)
#define CRYPTO_BYTES (LAMBDA / 4)

#ifdef RING_CATEGORY1
#define CRYPTO_CIPHERTEXTBYTES LWE_N + LWE_N + (LAMBDA / 4)
#endif
#if defined(RING_CATEGORY3_N1024) || defined(RING_CATEGORY3_N2048) || defined(RING_CATEGORY5)
#define CRYPTO_CIPHERTEXTBYTES (LWE_N * 2) + (LWE_N * 2) + (LAMBDA / 4)
#endif

#define CRYPTO_ALGNAME PARAMNAME

#endif
