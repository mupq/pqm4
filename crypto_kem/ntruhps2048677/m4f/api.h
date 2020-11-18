#ifndef API_H
#define API_H

#include <stdint.h>

#define CRYPTO_SECRETKEYBYTES 1234
#define CRYPTO_PUBLICKEYBYTES 930
#define CRYPTO_CIPHERTEXTBYTES 930
#define CRYPTO_BYTES 32

#define CRYPTO_ALGNAME "NTRU-HPS2048677"

int crypto_kem_keypair(uint8_t *pk, uint8_t *sk);

int crypto_kem_enc(uint8_t *c, uint8_t *k, const uint8_t *pk);

int crypto_kem_dec(uint8_t *k, const uint8_t *c, const uint8_t *sk);

#endif
