/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
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
/* Full-streaming signing passes, split into a separate translation unit.
 *
 * Rationale: keeping these passes in their own TU (and NOT enabling LTO)
 * prevents the compiler from inlining them into the driver in sign.c.
 * Each pass therefore gets its own stack frame that is reclaimed on return,
 * so the signing peak stays at max(pass) instead of sum(pass), as a
 * structural (language/linker-level) property rather than a compiler inlining hint. */
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
#include <string.h>

/* ---- per-poly helpers (also in verify.c as static) ---- */
static void fs_poly_highbits_hint_one(poly *w, const poly *v) {
    for (size_t j = 0; j < N; j++) {
        decompose_hint(&w->coeffs[j], v->coeffs[j]);
    }
}

#if (HAETAE_MODE == 5)
/*
 * Mode 5 uses a dense binary challenge c, so c*s is computed with the NTT:
 *   z <- z + k * (c*s),  acc <- acc + sum_j (z_old + 2*k*(c*s))_j^2
 * s is overwritten (NTT -> pointwise -> INTT); c_ntt must be in NTT domain.
 * The accumulation is branch-free because it depends on the secret key.
 */
static uint64_t polyfix_addmul_ntt_inplace_acc2(polyfix *z, poly *s,
                                                const poly *c_ntt, int32_t k,
                                                uint64_t acc) {
    poly_ntt(s);
    poly_pointwise_montgomery(s, c_ntt, s);
    poly_invntt_tomont(s);

    for (unsigned j = 0; j < N; ++j) {
        const int32_t y = z->coeffs[j];
        const int32_t t = (int32_t)((int64_t)k * (int64_t)s->coeffs[j]);
        const int32_t znew = y + t;
        const int32_t u = y + (int32_t)((uint32_t)t << 1);
        acc += (uint64_t)((int64_t)u * (int64_t)u);
        z->coeffs[j] = znew;
    }
    return acc;
}
#endif


/* ---- fs_passA: row-streaming Ay computation + challenge ---- */
/*
 * The hyperball norm check of SampleHyperball is merged into the 2-row batch
 * loop: ||y||^2 is accumulated while y is regenerated for A*round(y), which
 * saves a separate pass over the L+K polynomials.  If the check fails, the
 * work for this candidate is discarded and the next nonce window is used,
 * exactly as in the reference rejection loop.
 */
void
fs_passA_compute_challenge(poly *c,
                           poly *shared,
                           uint8_t *b_out,
                           uint16_t *accepted_start_out,
                           uint16_t *next_counter_out,
                           fp96_76 *scaling_out,
                           const uint8_t seedbuf[CRHBYTES],
                           const uint8_t mu[CRHBYTES],
                           const uint8_t *pkbytes) {

    const uint8_t *rhoprime = pkbytes; /* seed = first SEEDBYTES of pk */
    const uint64_t norm_bound = (uint64_t)B0SQ * (uint64_t)LN * (uint64_t)LN;
    polyfix ytmp;
    poly *trow1 = shared;
    fp96_76 scaling;
    uint16_t nonce_start = *next_counter_out;
    uint16_t end_nonce;

    /*
     * Combined hyperball acceptance + Ay computation loop.
     * On a norm failure (rare: under 0.1% of the iterations in host runs of
     * 1000 signatures per parameter set), the Ay work is discarded and we
     * retry with a new nonce.
     */
    for (;;) {
        end_nonce = hyperball_pass1_scaling(&scaling, seedbuf, nonce_start);
        const uint16_t counter_start = nonce_start;

        uint64_t sqnorm = 0;
        uint8_t y0_parity[POLYC_PACKEDBYTES];
        memset(y0_parity, 0, sizeof(y0_parity));

        xof256_state xof;
        xof256_init(&xof);

        for (unsigned rr = 0; rr < K; rr += 2) {
        const unsigned r0 = rr;
        const unsigned r1 = rr + 1;
        const int have_r1 = (r1 < K);

        memset(c, 0, sizeof(poly));
        if (have_r1) memset(trow1, 0, sizeof(poly));

        for (unsigned j = 0; j < L; j++) {
            const size_t len = (j < 2) ? (N + 1) : N;
            hyperball_regen_single(&ytmp, seedbuf,
                                   counter_start + (uint16_t)j, len, &scaling);

            /* Extract y0 parity (only on first batch, first column). */
            /* Hyperball norm of the fixed-point y1[j] (before rounding),
             * accumulated once (rr == 0) as in SampleHyperball. */
            if (rr == 0) {
                for (unsigned n = 0; n < N; n++)
                    sqnorm += (uint64_t)((int64_t)ytmp.coeffs[n] *
                                         (int64_t)ytmp.coeffs[n]);
            }
            if (rr == 0 && j == 0) {
                for (unsigned n = 0; n < N; n++) {
                    int32_t r = fix_round(ytmp.coeffs[n]);
                    const uint8_t bit = (uint8_t)(r & 1);
                    y0_parity[n >> 3] |= (uint8_t)(bit << (n & 7));
                    ytmp.coeffs[n] = r;
                }
            } else {
                polyfix_round_inplace(&ytmp);
            }

            poly_ntt((poly *)&ytmp);

            /* Accumulate into c (row r0). */
            if (j == 0) {
                poly col0_scratch;
#if D == 1
                {
                    const uint8_t *bptr = pkbytes + SEEDBYTES;
                    polyq_unpack(&col0_scratch, bptr + r0 * POLYQ_PACKEDBYTES);
                    poly_uniform(c, rhoprime, (K << 8) + M + r0);
                    for (unsigned k = 0; k < N; k++) {
                        int32_t x = c->coeffs[k] - (col0_scratch.coeffs[k] << 1);
                        x += (int32_t)(2 * Q);
                        if (x >= Q) x -= Q;
                        if (x >= Q) x -= Q;
                        x <<= 1;
                        if (x >= Q) x -= Q;
                        col0_scratch.coeffs[k] = x;
                    }
                    poly_ntt(&col0_scratch);
                }
                poly_pointwise_montgomery(c, &col0_scratch, (poly *)&ytmp);
#elif D == 0
                polyq_unpack(&col0_scratch, pkbytes + SEEDBYTES + r0 * POLYQ_PACKEDBYTES);
                poly_pointwise_montgomery(c, &col0_scratch, (poly *)&ytmp);
#else
#error "Not yet implemented."
#endif
                /* Accumulate into trow1 (row r1) using same NTT(ytmp). */
                if (have_r1) {
#if D == 1
                    {
                        const uint8_t *bptr = pkbytes + SEEDBYTES;
                        polyq_unpack(&col0_scratch, bptr + r1 * POLYQ_PACKEDBYTES);
                        poly_uniform(trow1, rhoprime, (K << 8) + M + r1);
                        for (unsigned k = 0; k < N; k++) {
                            int32_t x = trow1->coeffs[k] - (col0_scratch.coeffs[k] << 1);
                            x += (int32_t)(2 * Q);
                            if (x >= Q) x -= Q;
                            if (x >= Q) x -= Q;
                            x <<= 1;
                            if (x >= Q) x -= Q;
                            col0_scratch.coeffs[k] = x;
                        }
                        poly_ntt(&col0_scratch);
                    }
                    poly_pointwise_montgomery(trow1, &col0_scratch, (poly *)&ytmp);
#elif D == 0
                    polyq_unpack(&col0_scratch, pkbytes + SEEDBYTES + r1 * POLYQ_PACKEDBYTES);
                    poly_pointwise_montgomery(trow1, &col0_scratch, (poly *)&ytmp);
#endif
                }
            } else {
                const uint16_t nonce_r0 = (uint16_t)((r0 << 8) + (j - 1));
                poly_uniform_frozen_double_pointwise_montgomery_addto(
                    c, rhoprime, nonce_r0, (poly *)&ytmp);
                if (have_r1) {
                    const uint16_t nonce_r1 = (uint16_t)((r1 << 8) + (j - 1));
                    poly_uniform_frozen_double_pointwise_montgomery_addto(
                        trow1, rhoprime, nonce_r1, (poly *)&ytmp);
                }
            }
        }

        /* ---- Process row r0: y2[r0] regen + Ay fixup ---- */
        poly_invntt_tomont(c);
        {
            const size_t len = ((L + r0) < 2) ? (N + 1) : N;
            hyperball_regen_single(&ytmp, seedbuf,
                                   counter_start + (uint16_t)(L + r0), len, &scaling);
            /* Hyperball norm of the fixed-point y2[r0] (before rounding). */
            for (unsigned n = 0; n < N; n++)
                sqnorm += (uint64_t)((int64_t)ytmp.coeffs[n] *
                                     (int64_t)ytmp.coeffs[n]);
            polyfix_round_inplace(&ytmp);
            for (unsigned n = 0; n < N; n++)
                c->coeffs[n] += 2 * ytmp.coeffs[n];
        }
        if (r0 == 0) {
            for (unsigned n = 0; n < N; n++) {
                const int32_t xq = c->coeffs[n];
                const uint8_t bit = (uint8_t)((y0_parity[n >> 3] >> (n & 7)) & 1);
                c->coeffs[n] = xq + (Q & -((xq ^ (int32_t)bit) & 1));
            }
        } else {
            poly_fromcrt0(c, c);
        }
        poly_freeze2q(c);
        {
            fs_poly_highbits_hint_one(c, c);
            uint8_t row_buf[POLY_HIGHBITS_PACKEDBYTES];
            poly_pack_highbits(row_buf, c);
            xof256_absorb(&xof, row_buf, POLY_HIGHBITS_PACKEDBYTES);
        }

        /* ---- Process row r1 (if exists) ---- */
        if (have_r1) {
            poly_invntt_tomont(trow1);
            {
                const size_t len = ((L + r1) < 2) ? (N + 1) : N;
                hyperball_regen_single(&ytmp, seedbuf,
                                       counter_start + (uint16_t)(L + r1), len, &scaling);
                /* Hyperball norm of the fixed-point y2[r1] (before rounding). */
                for (unsigned n = 0; n < N; n++)
                    sqnorm += (uint64_t)((int64_t)ytmp.coeffs[n] *
                                         (int64_t)ytmp.coeffs[n]);
                polyfix_round_inplace(&ytmp);
                for (unsigned n = 0; n < N; n++)
                    trow1->coeffs[n] += 2 * ytmp.coeffs[n];
            }
            poly_fromcrt0(trow1, trow1);  /* r1 >= 1 always */
            poly_freeze2q(trow1);
            {
                fs_poly_highbits_hint_one(trow1, trow1);
                uint8_t row_buf[POLY_HIGHBITS_PACKEDBYTES];
                poly_pack_highbits(row_buf, trow1);
                xof256_absorb(&xof, row_buf, POLY_HIGHBITS_PACKEDBYTES);
            }
        }
    } /* end 2-row batch loop */

    /* Hyperball acceptance (SampleHyperball): ||y||^2 <= B0^2 in the
     * fixed-point scale LN, checked after all rows have been processed. */
    if (sqnorm <= norm_bound) {
        /* Norm passed — finalize challenge hash and exit retry loop. */
        xof256_absorb(&xof, y0_parity, POLYC_PACKEDBYTES);
        xof256_absorb(&xof, mu, SEEDBYTES);
        xof256_finalize(&xof);
        poly_challenge_from_xof(c, &xof);

        /* Derive b from the end nonce. */
        {
            uint8_t tmp[CRHBYTES + 2];
            for (unsigned i = 0; i < CRHBYTES; i++)
                tmp[i] = seedbuf[i];
            tmp[CRHBYTES + 0] = (uint8_t)(end_nonce >> 0);
            tmp[CRHBYTES + 1] = (uint8_t)(end_nonce >> 8);
            shake256(b_out, 1, tmp, CRHBYTES + 2);
        }

        *accepted_start_out = nonce_start;
        *next_counter_out   = end_nonce;
        *scaling_out        = scaling;
        return;
    }

    /* Norm failed — advance nonce and retry. */
    nonce_start = end_nonce;

    } /* end hyperball acceptance retry loop */
}

/* ---- fs_passB: fully streaming rejection check ---- */
int
fs_passB_check_streaming(const poly *c,
                         poly *shared,
                         uint8_t b,
                         const uint8_t seedbuf[CRHBYTES],
                         uint16_t counter_start,
                         const fp96_76 *scaling,
                         const uint8_t *sk_s1_packed,
                         const uint8_t *sk_s2_packed) {

    const uint64_t bound0 = (uint64_t)B0SQ * (uint64_t)LN * (uint64_t)LN;
    const uint64_t bound1 = (uint64_t)B1SQ * (uint64_t)LN * (uint64_t)LN;
    uint64_t acc1 = 0;
    uint64_t acc2 = 0;
#if (HAETAE_MODE != 5)
    (void)shared; /* scratch only needed for the mode-5 NTT challenge */
#endif
    const int32_t sgn = 1 - 2 * (int32_t)(b & 1); /* (-1)^b, branch-free */

#if (HAETAE_MODE == 2) || (HAETAE_MODE == 3)
    uint16_t idx[TAU];
    int8_t   sgns[TAU];
    unsigned w = poly_c_to_sparse(idx, sgns, TAU, c);
#endif

    /* Process each poly one at a time and discard immediately. */
    polyfix ytmp;
    poly stmp;

    /* z1[0] = y1[0] + sgn*LN*c (no secret key involved) */
    hyperball_regen_single(&ytmp, seedbuf, counter_start + 0,
                           N + 1, scaling);
    for (unsigned j = 0; j < N; j++) {
        const int32_t y = ytmp.coeffs[j];
        const int32_t t = (int32_t)((int64_t)sgn * (int64_t)LN * (int64_t)c->coeffs[j]);
        const int32_t z = y + t;
        const int32_t u_val = y + (int32_t)((uint32_t)t << 1);

        acc1 += (uint64_t)((int64_t)z * (int64_t)z);
        acc2 += (uint64_t)((int64_t)u_val * (int64_t)u_val);
    }



#if (HAETAE_MODE == 5)
    /* Precompute NTT of challenge into shared buffer. */
    poly *c_ntt = shared;
    for (unsigned j = 0; j < N; j++) c_ntt->coeffs[j] = c->coeffs[j];
    poly_ntt(c_ntt);
#endif

    /* z1[i] for i = 1..L-1 */
    for (unsigned i = 1; i < L; i++) {
        const size_t len = (i < 2) ? (N + 1) : N;
        hyperball_regen_single(&ytmp, seedbuf,
                               counter_start + (uint16_t)i, len, scaling);
        polyeta_unpack(&stmp, sk_s1_packed + (i - 1) * POLYETA_PACKEDBYTES);

#if (HAETAE_MODE == 5)
        acc2 = polyfix_addmul_ntt_inplace_acc2(
            &ytmp, &stmp, c_ntt,
            (int32_t)((int64_t)sgn * (int64_t)LN),
            acc2);
#else
        acc2 = polyfix_addmul_sparse_inplace_acc2(
            &ytmp, &stmp, idx, sgns, w,
            (int32_t)((int64_t)sgn * (int64_t)LN),
            acc2);
#endif
        /* accumulate ||z1[i]||^2 */
        for (unsigned j = 0; j < N; j++) {
            acc1 += (uint64_t)((int64_t)ytmp.coeffs[j] * (int64_t)ytmp.coeffs[j]);
        }
    }

    /* z2[i] for i = 0..K-1 */
    for (unsigned i = 0; i < K; i++) {
        const size_t len = ((L + i) < 2) ? (N + 1) : N;
        hyperball_regen_single(&ytmp, seedbuf,
                               counter_start + (uint16_t)(L + i), len, scaling);

#if D == 1
        poly2eta_unpack(&stmp, sk_s2_packed + i * POLY2ETA_PACKEDBYTES);
#elif D == 0
        polyeta_unpack(&stmp, sk_s2_packed + i * POLYETA_PACKEDBYTES);
#else
#error "Not yet implemented."
#endif

#if (HAETAE_MODE == 5)
        acc2 = polyfix_addmul_ntt_inplace_acc2(
            &ytmp, &stmp, c_ntt,
            (int32_t)((int64_t)sgn * (int64_t)LN),
            acc2);
#else
        acc2 = polyfix_addmul_sparse_inplace_acc2(
            &ytmp, &stmp, idx, sgns, w,
            (int32_t)((int64_t)sgn * (int64_t)LN),
            acc2);
#endif
        for (unsigned j = 0; j < N; j++) {
            acc1 += (uint64_t)((int64_t)ytmp.coeffs[j] * (int64_t)ytmp.coeffs[j]);
        }
    }

    /* Rejection tests. */
    {
        uint64_t reject1 = (bound1 - acc1) >> 63;
        reject1 &= 1;

        uint64_t reject2 = (acc2 - bound0) >> 63;
        reject2 &= 1;
        reject2 &= (b & 0x2) >> 1;

        return (int)(reject1 | reject2);
    }
}

/*
 * fs_passC1: reverse-order row-streaming Ay rebuild + hint computation +
 * streaming rANS encode.
 *
 * polyveck hint_store is ELIMINATED.  Instead we keep a single poly Ay_row
 * accumulator and feed each hint coefficient directly into the rANS encoder
 * in reverse order (i=K-1..0, j=N-1..0).
 *
 *   Phase 1: Rebuild Ay_row via column-streaming (A1 sampled on the fly)
 *   Phase 2: invNTT + 2*round(y2[i]) + CRT fix + freeze
 *   Phase 3: Compute z2fix_i, derive hint[i], caddDQ2ALPHA per-coeff,
 *            feed into rANS encoder in reverse-j order
 *
 * y0_parity: needed only for row 0's CRT fix.  In reverse order row 0 is
 * the last iteration.  y0_parity is computed during row 0's Phase 1 (j==0)
 * and consumed in the same row's Phase 2.
 */
static int
fs_passC1_compute_and_encode_hint(uint8_t *h_encoded, uint16_t *h_enc_size_out,
                                  poly *shared,
                                  const poly *c, uint8_t b,
                                  const uint8_t seedbuf[CRHBYTES],
                                  uint16_t counter_start,
                                  const fp96_76 *scaling,
                                  const uint8_t *pkbytes,
                                  const uint8_t *sk_s2_packed)
{
    const int32_t sgn = 1 - 2 * (int32_t)(b & 1); /* (-1)^b, branch-free */

    const uint8_t *rhoprime = pkbytes; /* seed = first SEEDBYTES of pk */

#if (HAETAE_MODE == 2) || (HAETAE_MODE == 3)
    uint16_t idx_c[TAU];
    int8_t sgns_c[TAU];
    unsigned wc = poly_c_to_sparse(idx_c, sgns_c, TAU, c);
#endif

    /*
     * Scratch workspace — shared across sequential phases within each row.
     *
     *   wp         — polyfix ytmp (Ay rebuild + y2 regen) / poly stmp (hint phase)
     *   scratch_u  — polyfix z2fix_i (hint phase; as_poly is not used)
     */
    union
    {
        polyfix as_fix;
        poly as_poly;
    } wp;
    union
    {
        polyfix z2fix_i;
        poly as_poly;
    } scratch_u;

    /* Ay_row: single-row accumulator, reuses driver-allocated shared buffer. */
    poly *Ay_row = shared;

    /* Streaming rANS encoder — uses h_encoded as working buffer directly. */
    encode_h_stream_ctx enc_ctx;
    encode_h_stream_init(&enc_ctx, h_encoded, BASE_ENC_H + 256);

    /* y0 parity for CRT fix on row 0 — computed during row 0's j==0 regen. */
    uint8_t y0_parity[POLYC_PACKEDBYTES];

    /* === Reverse-order row-streaming: i = K-1 .. 0 === */
    for (int i = (int)K - 1; i >= 0; i--)
    {

        /* --- Phase 1: Ay rebuild in Ay_row via column-streaming --- */
        memset(Ay_row, 0, sizeof(poly));

        for (unsigned j = 0; j < L; j++)
        {
            const size_t len = (j < 2) ? (N + 1) : N;
            hyperball_regen_single(&wp.as_fix, seedbuf,
                                   counter_start + (uint16_t)j, len, scaling);

            /* Extract y0 parity (only on row 0, column 0). */
            if (i == 0 && j == 0)
            {
                memset(y0_parity, 0, sizeof(y0_parity));
                for (unsigned n = 0; n < N; n++)
                {
                    int32_t r = fix_round(wp.as_fix.coeffs[n]);
                    const uint8_t bit = (uint8_t)(r & 1);
                    y0_parity[n >> 3] |= (uint8_t)(bit << (n & 7));
                    wp.as_poly.coeffs[n] = r;
                }
            }
            else
            {
                polyfix_round_inplace(&wp.as_fix);
            }

            poly_ntt(&wp.as_poly);

            if (j == 0)
            {
#if D == 1
                {
                    /* col0 = NTT(2*(a_r - 2*b_r)): in-place in Ay_row. */
                    const uint8_t *bptr = pkbytes + SEEDBYTES;
                    polyq_unpack(Ay_row, bptr + (unsigned)i * POLYQ_PACKEDBYTES);
                    for (unsigned k = 0; k < N; k++)
                    {
                        int32_t x = (int32_t)(2 * Q) - (Ay_row->coeffs[k] << 1);
                        if (x >= (int32_t)Q)
                            x -= Q;
                        if (x >= (int32_t)Q)
                            x -= Q;
                        Ay_row->coeffs[k] = x;
                    }
                    poly_uniform_add(Ay_row, rhoprime, (K << 8) + M + (unsigned)i);
                    for (unsigned k = 0; k < N; k++)
                    {
                        int32_t x = Ay_row->coeffs[k] << 1;
                        if (x >= (int32_t)Q)
                            x -= Q;
                        Ay_row->coeffs[k] = x;
                    }
                    poly_ntt(Ay_row);
                    poly_pointwise_montgomery(Ay_row, Ay_row, &wp.as_poly);
                }
#elif D == 0
                /* Fused unpack + pointwise: no scratch poly. */
                polyq_unpack_pointwise_montgomery(Ay_row,
                                                  pkbytes + SEEDBYTES + (unsigned)i * POLYQ_PACKEDBYTES, &wp.as_poly);
#else
#error "Not yet implemented."
#endif
            }
            else
            {
                /* Subsequent columns: fused sample + multiply, no scratch. */
                const uint16_t nonce = (uint16_t)(((unsigned)i << 8) + (j - 1));
                poly_uniform_frozen_double_pointwise_montgomery_addto(
                    Ay_row, rhoprime, nonce, &wp.as_poly);
            }
        }

        /* --- Phase 2: invNTT + 2*round(y2[i]) + CRT fix + freeze --- */
        poly_invntt_tomont(Ay_row);

        {
            const size_t len = ((L + (unsigned)i) < 2) ? (N + 1) : N;
            hyperball_regen_single(&wp.as_fix, seedbuf,
                                   counter_start + (uint16_t)(L + (unsigned)i), len, scaling);
            polyfix_round_inplace(&wp.as_fix);
            for (unsigned n = 0; n < N; n++)
            {
                Ay_row->coeffs[n] += 2 * wp.as_poly.coeffs[n];
            }
        }

        if (i == 0)
        {
            for (unsigned n = 0; n < N; n++)
            {
                const int32_t xq = Ay_row->coeffs[n];
                const uint8_t bit = (uint8_t)((y0_parity[n >> 3] >> (n & 7)) & 1);
                Ay_row->coeffs[n] = xq + (Q & -((xq ^ (int32_t)bit) & 1));
            }
        }
        else
        {
            poly_fromcrt0(Ay_row, Ay_row);
        }
        poly_freeze2q(Ay_row);

        /* --- Phase 3: compute z2fix_i, derive hint[i], feed rANS encoder --- */
        {
            const size_t len = ((L + (unsigned)i) < 2) ? (N + 1) : N;
            hyperball_regen_single(&scratch_u.z2fix_i, seedbuf,
                                   counter_start + (uint16_t)(L + (unsigned)i), len, scaling);

#if D == 1
            poly2eta_unpack(&wp.as_poly, sk_s2_packed + (unsigned)i * POLY2ETA_PACKEDBYTES);
#elif D == 0
            polyeta_unpack(&wp.as_poly, sk_s2_packed + (unsigned)i * POLYETA_PACKEDBYTES);
#else
#error "Not yet implemented."
#endif

            /* Fused c*s + accumulate into z2fix_i — no separate cs buffer. */
            {
                const int32_t scale = (int32_t)((int64_t)sgn * (int64_t)LN);
#if (HAETAE_MODE == 5)
                for (unsigned ii = 0; ii < N; ++ii)
                {
                    if (c->coeffs[ii] == 0)
                        continue;
                    for (unsigned j = 0; j < N; ++j)
                    {
                        int k = (int)j - (int)ii;
                        if (k >= 0)
                            scratch_u.z2fix_i.coeffs[j] += scale * wp.as_poly.coeffs[k];
                        else
                            scratch_u.z2fix_i.coeffs[j] -= scale * wp.as_poly.coeffs[k + N];
                    }
                }
#else
                for (unsigned t = 0; t < wc; t++)
                {
                    const unsigned sh = (unsigned)idx_c[t];
                    const int32_t cs = (int32_t)sgns_c[t] * scale;
                    for (unsigned j = 0; j < N; j++)
                    {
                        unsigned dst = j + sh;
                        if (dst < N)
                            scratch_u.z2fix_i.coeffs[dst] += cs * wp.as_poly.coeffs[j];
                        else
                            scratch_u.z2fix_i.coeffs[dst - N] -= cs * wp.as_poly.coeffs[j];
                    }
                }
#endif
            }

            /* h[i] = HighBits(Ay) - HighBits(Ay - 2*round(z2fix_i))
             * Reuse wp.as_poly as scratch for the subtracted vector. */
            polyfix_round(&wp.as_poly, &scratch_u.z2fix_i);
            for (unsigned j = 0; j < N; j++)
            {
                wp.as_poly.coeffs[j] = Ay_row->coeffs[j] - 2 * wp.as_poly.coeffs[j];
            }
            poly_freeze2q(&wp.as_poly);

            /* HighBits of both vectors */
            for (unsigned j = 0; j < N; j++)
            {
                decompose_hint(&wp.as_poly.coeffs[j], wp.as_poly.coeffs[j]);
            }
            fs_poly_highbits_hint_one(Ay_row, Ay_row);

            /* hint[i][j] = HighBits(Ay) - HighBits(Ay - 2*round(z2fix))
             * + inline caddDQ2ALPHA per coefficient
             * Feed rANS encoder in reverse-j order. */
            for (int j = (int)N - 1; j >= 0; j--)
            {
                int32_t h_val = Ay_row->coeffs[j] - wp.as_poly.coeffs[j];
                /* Inline caddDQ2ALPHA: h_val += (h_val >> 31) & ((DQ - 2) / ALPHA_HINT) */
                h_val += (h_val >> 31) & ((DQ - 2) / ALPHA_HINT);
                encode_h_stream_put(&enc_ctx, h_val);
            }
        }
    }

    /* --- Finish streaming encode --- */
    {
        uint16_t sz = encode_h_stream_finish(&enc_ctx);
        if (sz == 0 || sz < BASE_ENC_H || (uint16_t)(sz - BASE_ENC_H) > 255)
        {
            return 1;
        }
        *h_enc_size_out = sz;
    }

    return 0;
}

/* ---- fs_passC phase 2: compute z1 and pack (without hint) ---- */
/*
 * Ultra-low-stack variant: process z1 one poly at a time, in reverse order.
 * Lowbits are packed directly to sig; highbits are fed one coefficient at a
 * time to the streaming rANS encoder (no HB(z1) array), whose output is
 * copied into sig at the end.
 */
static int
fs_passC2_z1_and_pack_nohint(uint8_t *sig,
                             poly *shared,
                             const poly *c,
                             uint8_t b,
                             const uint8_t seedbuf[CRHBYTES],
                             uint16_t counter_start,
                             const fp96_76 *scaling,
                             const uint8_t *sk_s1_packed,
                             uint16_t *hbz1_size_out)
{
    const int32_t sgn = 1 - 2 * (int32_t)(b & 1); /* (-1)^b, branch-free */

#if (HAETAE_MODE == 2) || (HAETAE_MODE == 3)
    uint16_t idx_c[TAU];
    int8_t sgns_c[TAU];
    unsigned wc = poly_c_to_sparse(idx_c, sgns_c, TAU, c);
#endif

    /* Reverse-order streaming: hb_z1 array eliminated.
     * LB is packed at known offset (p + N*i), HB is fed to rANS in reverse. */
    encode_hb_z1_stream_ctx hb_ctx;
    encode_hb_z1_stream_init(&hb_ctx);

    /* Init signature buffer. */
    memset(sig, 0, CRYPTO_BYTES);
    uint8_t *p = sig;

    /* Encode challenge c. */
    for (size_t ii = 0; ii < N; ii++)
    {
        p[ii / 8] |= (uint8_t)(c->coeffs[ii] << (ii % 8));
    }
    p += N / 8;

    /* Process z1 in reverse order for streaming HB encode.
     * LB is packed at position p + N*i (order-independent). */
    {
        poly z1tmp;
        poly *stmp = shared;

        for (int i = (int)L - 1; i >= 0; i--)
        {
            const size_t len = ((unsigned)i < 2) ? (N + 1) : N;
            hyperball_regen_single((polyfix *)&z1tmp, seedbuf,
                                   counter_start + (uint16_t)i, len, scaling);

            if (i == 0)
            {
                for (unsigned j = 0; j < N; j++)
                {
                    z1tmp.coeffs[j] += (int32_t)((int64_t)sgn * (int64_t)LN *
                                                 (int64_t)c->coeffs[j]);
                }
            }
            else
            {
                polyeta_unpack(stmp, sk_s1_packed + (i - 1) * POLYETA_PACKEDBYTES);

                const int32_t scale = (int32_t)((int64_t)sgn * (int64_t)LN);
#if (HAETAE_MODE == 5)
                for (unsigned ii = 0; ii < N; ++ii)
                {
                    if (c->coeffs[ii] == 0) continue;
                    for (unsigned j = 0; j < N; ++j)
                    {
                        int k = (int)j - (int)ii;
                        if (k >= 0) z1tmp.coeffs[j] += scale * stmp->coeffs[k];
                        else        z1tmp.coeffs[j] -= scale * stmp->coeffs[k + N];
                    }
                }
#else
                for (unsigned t = 0; t < wc; t++)
                {
                    const unsigned sh = (unsigned)idx_c[t];
                    const int32_t cs_val = (int32_t)sgns_c[t] * scale;
                    for (unsigned j = 0; j < N; j++)
                    {
                        unsigned dst = j + sh;
                        if (dst < N) z1tmp.coeffs[dst] += cs_val * stmp->coeffs[j];
                        else         z1tmp.coeffs[dst - N] -= cs_val * stmp->coeffs[j];
                    }
                }
#endif
            }

            polyfix_round_inplace((polyfix *)&z1tmp);

            /* Decompose: LB packed to sig at correct offset, HB to streaming encoder. */
            for (int j = (int)N - 1; j >= 0; j--)
            {
                int32_t hb, lb;
                decompose_z1(&hb, &lb, z1tmp.coeffs[j]);
                z1tmp.coeffs[j] = lb;
                encode_hb_z1_stream_put(&hb_ctx, (int8_t)hb);
            }
            poly_decomposed_pack(p + N * i, &z1tmp);
        }
    }
    p += L * N;

    if ((size_t)(p - sig) + 2 > CRYPTO_BYTES)
        return 1;
    p += 2;

    /* Finish streaming HB encode. */
    {
        uint16_t size_enc_hb_z1 = encode_hb_z1_stream_finish(&hb_ctx, p,
                                                              CRYPTO_BYTES - (size_t)(p - sig));
        if (size_enc_hb_z1 == 0) return 1;
        if (size_enc_hb_z1 < BASE_ENC_HB_Z1) return 1;
        if ((uint16_t)(size_enc_hb_z1 - BASE_ENC_HB_Z1) > 255) return 1;
        *hbz1_size_out = size_enc_hb_z1;
    }

    return 0;
}

/* ---- fs_passC: orchestrate phase 1 (Ay+hint) then phase 2 (z1+pack) ---- */
int
fs_passC_hint_and_pack(uint8_t *sig, size_t *siglen,
                       poly *shared,
                       const poly *c,
                       uint8_t b,
                       const uint8_t seedbuf[CRHBYTES],
                       uint16_t counter_start,
                       const fp96_76 *scaling,
                       const uint8_t *pkbytes,
                       const uint8_t *sk_s1_packed,
                       const uint8_t *sk_s2_packed) {
    /*
     * Stack layout: C1 and C2 run one after the other and their locals are
     * never live at the same time, so the compiler can reuse the space (as
     * separate frames, or as shared stack slots when it inlines both, which
     * GCC does at -O3):
     *   - fs_passC1_compute_and_encode_hint: unions wp/scratch_u for the
     *     row-streaming hint computation (Ay_row is the shared buffer) and
     *     the reverse-order streaming rANS encoding of h into h_encoded.
     *   - fs_passC2_z1_and_pack_nohint: z1 one polynomial at a time and the
     *     streaming rANS encoder for HB(z1).
     * Only h_encoded and the two sizes stay live across both phases.
     */
    uint8_t h_encoded[BASE_ENC_H + 256];
    uint16_t h_enc_size;
    uint16_t hbz1_size;

    /* Phase C1: recompute Ay + hint, encode hint (merged into one call). */
    if (fs_passC1_compute_and_encode_hint(h_encoded, &h_enc_size, shared, c, b,
                                           seedbuf, counter_start,
                                           scaling,
                                           pkbytes, sk_s2_packed)) {
        return 1;
    }

    /* Phase C2: compute z1, round, pack c + LB(z1) + HB(z1). */
    if (fs_passC2_z1_and_pack_nohint(sig, shared, c, b, seedbuf, counter_start,
                                      scaling,
                                      sk_s1_packed, &hbz1_size)) {
        return 1;
    }

    /* Append pre-encoded hint and write offset bytes. */
    if (pack_sig_finish_hint(sig, hbz1_size, h_encoded, h_enc_size)) {
        return 1;
    }

    *siglen = CRYPTO_BYTES;
    return 0;
}


