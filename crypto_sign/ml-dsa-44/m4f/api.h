#ifndef API_H
#define API_H

#include <stddef.h>
#include <stdint.h>
#include "params.h"

int crypto_sign_keypair(uint8_t *pk, uint8_t *sk);

int crypto_sign_signature_ctx(uint8_t *sig, size_t *siglen,
        const uint8_t *m, size_t mlen,
        const uint8_t *ctx, size_t ctxlen,
        const uint8_t *sk);

int crypto_sign_ctx(uint8_t *sm, size_t *smlen,
        const uint8_t *m, size_t mlen,
        const uint8_t *ctx, size_t ctxlen,
        const uint8_t *sk);

int crypto_sign_verify_ctx(const uint8_t *sig, size_t siglen,
        const uint8_t *m, size_t mlen,
        const uint8_t *ctx, size_t ctxlen,
        const uint8_t *pk);

int crypto_sign_open_ctx(uint8_t *m, size_t *mlen,
        const uint8_t *sm, size_t smlen,
        const uint8_t *ctx, size_t ctxlen,
        const uint8_t *pk);

#define crypto_sign_signature(sig, siglen, m, mlen, sk) crypto_sign_signature_ctx(sig, siglen, m, mlen, NULL, 0, sk)
#define crypto_sign(sm, smlen, m, mlen, sk) crypto_sign_ctx(sm, smlen, m, mlen, NULL, 0, sk)
#define crypto_sign_verify(sig, siglen, m, mlen, pk) crypto_sign_verify_ctx(sig, siglen, m, mlen, NULL, 0, pk)
#define crypto_sign_open(m, mlen, sm, smlen, pk) crypto_sign_open_ctx(m, mlen, sm, smlen, NULL, 0, pk)

#endif
