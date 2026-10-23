/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
 *
 * Derived from the HAETAE reference implementation, Copyright (c) 2026
 * Team HAETAE, MIT License (see LICENSE).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#ifndef API_H
#define API_H

#include "config.h"

#include <stddef.h>
#include <stdint.h>

#if HAETAE_MODE == 2
#define CRYPTO_PUBLICKEYBYTES 992
#define CRYPTO_SECRETKEYBYTES 1408
#define CRYPTO_BYTES 1474
#elif HAETAE_MODE == 3
#define CRYPTO_PUBLICKEYBYTES 1472
#define CRYPTO_SECRETKEYBYTES 2112
#define CRYPTO_BYTES 2349
#elif HAETAE_MODE == 5
#define CRYPTO_PUBLICKEYBYTES 2080
#define CRYPTO_SECRETKEYBYTES 2752
#define CRYPTO_BYTES 2948
#endif

/* HAETAE 1.2.0 API (context strings, hedged signing); seed and rnd are
 * 32 bytes. */

#define crypto_sign_keypair HAETAE_NAMESPACE(keypair)
int crypto_sign_keypair(uint8_t *pk, uint8_t *sk);

#define crypto_sign_keypair_internal HAETAE_NAMESPACE(keypair_internal)
int crypto_sign_keypair_internal(uint8_t *pk, uint8_t *sk,
                                 const uint8_t seed[32]);

#define crypto_sign_signature_internal HAETAE_NAMESPACE(signature_internal)
int crypto_sign_signature_internal(uint8_t *sig, size_t *siglen,
                                   const uint8_t *m, size_t mlen,
                                   const uint8_t *pre, size_t prelen,
                                   const uint8_t rnd[32],
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
                                const uint8_t *pk);

#define crypto_sign_verify_ctx HAETAE_NAMESPACE(verify_ctx)
int crypto_sign_verify_ctx(const uint8_t *sig, size_t siglen, const uint8_t *m,
                           size_t mlen, const uint8_t *ctx, size_t ctxlen,
                           const uint8_t *pk);

/* On failure, *mlen is set to (size_t)-1 and the first smlen bytes of m are
 * cleared (m must provide room for smlen bytes, as in the reference). */
#define crypto_sign_open_ctx HAETAE_NAMESPACE(open_ctx)
int crypto_sign_open_ctx(uint8_t *m, size_t *mlen, const uint8_t *sm,
                         size_t smlen, const uint8_t *ctx, size_t ctxlen,
                         const uint8_t *pk);

/* pqm4/mupq API: the functions above with an empty context string. */
#define crypto_sign_signature(sig, siglen, m, mlen, sk)                        \
    crypto_sign_signature_ctx(sig, siglen, m, mlen, NULL, 0, sk)
#define crypto_sign(sm, smlen, m, mlen, sk)                                    \
    crypto_sign_ctx(sm, smlen, m, mlen, NULL, 0, sk)
#define crypto_sign_verify(sig, siglen, m, mlen, pk)                           \
    crypto_sign_verify_ctx(sig, siglen, m, mlen, NULL, 0, pk)
#define crypto_sign_open(m, mlen, sm, smlen, pk)                               \
    crypto_sign_open_ctx(m, mlen, sm, smlen, NULL, 0, pk)

#endif /* API_H */
