// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_API_H
#define HAETAE_API_H

#include "params.h"

#include <stddef.h>
#include <stdint.h>

#define CRYPTO_ALGNAME HAETAE_CRYPTO_ALGNAME
#define CRYPTO_SECRETKEYBYTES HAETAE_CRYPTO_SECRETKEYBYTES
#define CRYPTO_PUBLICKEYBYTES HAETAE_CRYPTO_PUBLICKEYBYTES
#define CRYPTO_BYTES HAETAE_CRYPTO_BYTES

#define crypto_sign_keypair HAETAE_NAMESPACE(keypair)
int crypto_sign_keypair(uint8_t *vk, uint8_t *sk);

#define crypto_sign_keypair_internal HAETAE_NAMESPACE(keypair_internal)
int crypto_sign_keypair_internal(uint8_t *vk, uint8_t *sk,
                                 uint8_t seed[HAETAE_SEEDBYTES]);

#define crypto_sign_signature_internal HAETAE_NAMESPACE(signature_internal)
int crypto_sign_signature_internal(uint8_t *sig, size_t *siglen,
                                   const uint8_t *m, size_t mlen,
                                   const uint8_t *pre, size_t prelen,
                                   const uint8_t rnd[HAETAE_SEEDBYTES],
                                   const uint8_t *sk);

#define crypto_sign_signature_ctx HAETAE_NAMESPACE(signature_ctx)
int crypto_sign_signature_ctx(uint8_t *sig, size_t *siglen, const uint8_t *m,
                              size_t mlen, const uint8_t *ctx, size_t ctxlen,
                              const uint8_t *sk);

#define crypto_sign_ctx HAETAE_NAMESPACE(sign_ctx)
int crypto_sign_ctx(uint8_t *sm, size_t *smlen, const uint8_t *m, size_t mlen,
                    const uint8_t *ctx, size_t ctxlen, const uint8_t *sk);

#define crypto_sign_verify_internal HAETAE_NAMESPACE(verify_internal)
int crypto_sign_verify_internal(const uint8_t *sig, size_t siglen,
                                const uint8_t *m, size_t mlen,
                                const uint8_t *pre, size_t prelen,
                                const uint8_t *vk);

#define crypto_sign_verify_ctx HAETAE_NAMESPACE(verify_ctx)
int crypto_sign_verify_ctx(const uint8_t *sig, size_t siglen, const uint8_t *m,
                           size_t mlen, const uint8_t *ctx, size_t ctxlen,
                           const uint8_t *vk);

#define crypto_sign_open_ctx HAETAE_NAMESPACE(open_ctx)
int crypto_sign_open_ctx(uint8_t *m, size_t *mlen, const uint8_t *sm,
                         size_t smlen, const uint8_t *ctx, size_t ctxlen,
                         const uint8_t *vk);

/* pqm4/mupq API: the functions above with an empty context string. */
#define HAETAE_EMPTY_CTX ((const uint8_t *)"")
#define crypto_sign_signature(sig, siglen, m, mlen, sk)                        \
  crypto_sign_signature_ctx(sig, siglen, m, mlen, HAETAE_EMPTY_CTX, 0, sk)
#define crypto_sign(sm, smlen, m, mlen, sk)                                    \
  crypto_sign_ctx(sm, smlen, m, mlen, HAETAE_EMPTY_CTX, 0, sk)
#define crypto_sign_verify(sig, siglen, m, mlen, pk)                           \
  crypto_sign_verify_ctx(sig, siglen, m, mlen, HAETAE_EMPTY_CTX, 0, pk)
#define crypto_sign_open(m, mlen, sm, smlen, pk)                               \
  crypto_sign_open_ctx(m, mlen, sm, smlen, HAETAE_EMPTY_CTX, 0, pk)

#endif // HAETAE_API_H
