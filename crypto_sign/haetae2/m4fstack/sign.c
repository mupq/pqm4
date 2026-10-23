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
#include "api.h"
#include "sign_passes.h"
#include "packing.h"
#include "encoding.h"
#include "params.h"
#include "decompose.h"
#include "poly.h"
#include "polyfix.h"
#include "poly_sparsemul.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include <stdint.h>


/* -------------------------------------------------------------------------
 * Low-stack signing strategy:
 *   - Pass A: sample y, compute c = H(HighBits(A*round(y)), LSB(round(y0)), mu)
 *   - Pass B: re-sample the same y (same counter_start), compute z = y + (-1)^b * LN * (c*s)
 *             (sparse c*s for modes 2/3, NTT for the dense mode-5 challenge),
 *             and apply the rejection tests.
 *   - Pass C: re-sample y again (same counter_start), recompute Ay = A*round(y) mod 2q,
 *             build the hint using (Ay, z2), and pack the signature.
 *
 * This avoids keeping Ay or the full secret vectors alive across the rejection loop.
 * ------------------------------------------------------------------------- */



/* =========================================================================
 * Full-streaming signing.
 *
 * Design:
 *   - Row-streaming A*round(y): Pass A accumulates two rows of A*round(y)
 *     at a time (Pass C recomputes them one row at a time) while y1[j] is
 *     regenerated one poly at a time via hyperball_regen_single(); A1 is
 *     sampled on the fly.
 *   - No static workspace is used.
 *   - Pass A/B/C structure where every poly is regenerated from seed on
 *     demand and discarded immediately after use.
 * ========================================================================= */

/* Absorb an optional (possibly empty) input into an XOF state. */
static void xof256_absorb_opt(xof256_state *state, const uint8_t *in,
                              size_t inlen) {
    if (inlen > 0) {
        xof256_absorb(state, in, inlen);
    }
}

/*************************************************
 * Name:        sign_internal
 *
 * Description: Signing core shared by the context-string API and the
 *              KAT-style internal API.  The prefix pre = (pre1 || pre2) is
 *              absorbed in two pieces so that the context-string wrapper
 *              does not need a 256-byte copy of (ctxlen || ctx).
 *
 *              mu      = SHAKE256(pk || pre || m)           (64 bytes)
 *              seedbuf = SHAKE256(key || rnd || mu)         (64 bytes)
 *
 *              The rejection loop regenerates every masking polynomial from
 *              seedbuf on demand (Pass A: challenge, Pass B: rejection tests,
 *              Pass C: hint and packing); see sign_passes.c.
 *
 * Returns 0 (success)
 **************************************************/
static int sign_internal(uint8_t *sig, size_t *siglen, const uint8_t *m,
                         size_t mlen, const uint8_t *pre1, size_t pre1len,
                         const uint8_t *pre2, size_t pre2len,
                         const uint8_t rnd[SEEDBYTES], const uint8_t *sk) {
    uint8_t seedbuf[CRHBYTES];
    uint8_t mu[CRHBYTES];
    xof256_state state;

    const uint8_t *pkbytes = sk;
    const uint8_t *sk_s1_packed = sk + CRYPTO_PUBLICKEYBYTES;
    const uint8_t *sk_s2_packed = sk_s1_packed + M * POLYETA_PACKEDBYTES;
    const uint8_t *key = sk_s2_packed + K * POLY2ETA_PACKEDBYTES;

    /* mu = H(pk || pre || m) */
    xof256_init(&state);
    xof256_absorb(&state, pkbytes, CRYPTO_PUBLICKEYBYTES);
    xof256_absorb_opt(&state, pre1, pre1len);
    xof256_absorb_opt(&state, pre2, pre2len);
    xof256_absorb_opt(&state, m, mlen);
    xof256_finalize(&state);
    xof256_squeeze(mu, CRHBYTES, &state);

    /* seedbuf = H(key || rnd || mu) */
    xof256_init(&state);
    xof256_absorb(&state, key, SEEDBYTES);
    xof256_absorb(&state, rnd, SEEDBYTES);
    xof256_absorb(&state, mu, CRHBYTES);
    xof256_finalize(&state);
    xof256_squeeze(seedbuf, CRHBYTES, &state);

    /* Rejection sampling loop. */
    uint16_t counter = 0;
    poly shared_buf;  /* shared across passA/B/C to avoid redundant poly locals */

    for (;;) {
        uint16_t accepted_start = 0;
        uint8_t b = 0;
        poly c;
        fp96_76 scaling; /* cached: computed once in passA, reused by passB/C */

        fs_passA_compute_challenge(&c, &shared_buf, &b, &accepted_start, &counter,
                                   &scaling,
                                   seedbuf, mu, pkbytes);

        /* Pass B/C use accepted_start (not counter) to regenerate y.
         * counter has advanced past the accepted window for the next
         * outer iteration.  scaling is cached from passA to avoid
         * redundant hyperball_pass1_scaling recomputations. */
        if (fs_passB_check_streaming(&c, &shared_buf, b, seedbuf, accepted_start,
                                     &scaling,
                                     sk_s1_packed, sk_s2_packed)) {
            continue; /* reject */
        }

        if (fs_passC_hint_and_pack(sig, siglen, &shared_buf, &c, b,
                                   seedbuf, accepted_start,
                                   &scaling,
                                   pkbytes, sk_s1_packed, sk_s2_packed)) {
            continue; /* encoding failed => reject */
        }

        return 0;
    }
}

/*************************************************
 * Name:        crypto_sign_signature_internal
 *
 * Description: Deterministic signing core with an explicit prefix string and
 *              randomness (HAETAE 1.2.0 SignInternal); used for KATs.
 *
 * Returns 0 (success)
 **************************************************/
int crypto_sign_signature_internal(uint8_t *sig, size_t *siglen,
                                   const uint8_t *m, size_t mlen,
                                   const uint8_t *pre, size_t prelen,
                                   const uint8_t rnd[SEEDBYTES],
                                   const uint8_t *sk) {
    return sign_internal(sig, siglen, m, mlen, pre, prelen, NULL, 0, rnd, sk);
}

/*************************************************
 * Name:        crypto_sign_signature_ctx
 *
 * Description: Computes a signature with context string ctx
 *              (HAETAE 1.2.0 Sign): pre = (ctxlen || ctx), rnd random.
 *
 * Returns 0 (success) or -1 (invalid context string)
 **************************************************/
int crypto_sign_signature_ctx(uint8_t *sig, size_t *siglen, const uint8_t *m,
                              size_t mlen, const uint8_t *ctx, size_t ctxlen,
                              const uint8_t *sk) {
    uint8_t rnd[SEEDBYTES];
    uint8_t ctxlen_byte;

    if (ctxlen > 255 || (ctx == NULL && ctxlen > 0)) {
        return -1;
    }
    ctxlen_byte = (uint8_t)ctxlen;
    randombytes(rnd, SEEDBYTES);
    return sign_internal(sig, siglen, m, mlen, &ctxlen_byte, 1, ctx, ctxlen,
                         rnd, sk);
}

/*************************************************
 * Name:        crypto_sign_ctx
 *
 * Description: Computes a signed message sm = (sig || m); sm may equal m.
 *
 * Returns 0 (success) or -1 (invalid context string; *smlen is set to 0)
 **************************************************/
int crypto_sign_ctx(uint8_t *sm, size_t *smlen, const uint8_t *m, size_t mlen,
                    const uint8_t *ctx, size_t ctxlen, const uint8_t *sk) {
    size_t i;

    if (ctxlen > 255 || (ctx == NULL && ctxlen > 0)) {
        *smlen = 0;
        return -1;
    }
    for (i = 0; i < mlen; ++i) {
        sm[CRYPTO_BYTES + mlen - 1 - i] = m[mlen - 1 - i];
    }
    int ret = crypto_sign_signature_ctx(sm, smlen, sm + CRYPTO_BYTES, mlen,
                                        ctx, ctxlen, sk);
    *smlen += mlen;
    return ret;
}
