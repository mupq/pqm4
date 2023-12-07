
/**
 * @file api.h
 * @brief NIST SIGN API
 */

#ifndef SIG_PERK_API_H
#define SIG_PERK_API_H

#include <stddef.h>
#include "parameters.h"

#define CRYPTO_ALGNAME "PERK"

#define CRYPTO_PUBLICKEYBYTES PUBLIC_KEY_BYTES
#define CRYPTO_SECRETKEYBYTES PRIVATE_KEY_BYTES
#define CRYPTO_BYTES          SIGNATURE_BYTES

// As a technicality, the public key is appended to the secret key in order to respect the NIST API.
// Without this constraint, CRYPTO_SECRETKEYBYTES would be defined as SECURITY_BYTES

int crypto_sign_keypair(unsigned char *pk, unsigned char *sk);
int crypto_sign(unsigned char *sm, size_t *smlen, const unsigned char *m, size_t mlen, const unsigned char *sk);
int crypto_sign_open(unsigned char *m, size_t *mlen, const unsigned char *sm, size_t smlen, const unsigned char *pk);

#endif
