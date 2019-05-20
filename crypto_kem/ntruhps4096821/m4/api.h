#ifndef API_H
#define API_H

#include <stdint.h>

#define CRYPTO_SECRETKEYBYTES 1590
#define CRYPTO_PUBLICKEYBYTES 1230
#define CRYPTO_CIPHERTEXTBYTES 1230
#define CRYPTO_BYTES 32

#define CRYPTO_ALGNAME "NTRU-HPS4096821"

int crypto_kem_keypair(uint8_t *pk, uint8_t *sk);

int crypto_kem_enc(uint8_t *c, uint8_t *k, const uint8_t *pk);

int crypto_kem_dec(uint8_t *k, const uint8_t *c, const uint8_t *sk);

#endif
