#ifndef API_H 
#define API_H

#include "params.h"

#define CRYPTO_ALGNAME "NTRU-KEM-HRSS17"

#define CRYPTO_SECRETKEYBYTES NTRU_SECRETKEYBYTES
#define CRYPTO_PUBLICKEYBYTES NTRU_PUBLICKEYBYTES
#define CRYPTO_CIPHERTEXTBYTES NTRU_CIPHERTEXTBYTES
#define CRYPTO_BYTES NTRU_SHAREDKEYBYTES

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);

int crypto_kem_enc(unsigned char *c, unsigned char *k, const unsigned char *pk);

int crypto_kem_dec(unsigned char *k, const unsigned char *c, const unsigned char *sk);

#endif
