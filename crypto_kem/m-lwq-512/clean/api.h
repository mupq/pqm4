#ifndef API_H
#define API_H

#include "params.h"

#define CRYPTO_SECRETKEYBYTES  MLWQ_KEM_SECRETKEYBYTES
#define CRYPTO_PUBLICKEYBYTES  MLWQ_PUBLICKEYBYTES
#define CRYPTO_CIPHERTEXTBYTES MLWQ_CIPHERTEXTBYTES
#define CRYPTO_BYTES           MLWQ_SSBYTES

#define CRYPTO_ALGNAME "M-LWQ-512"

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);

int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk);

int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);

#endif