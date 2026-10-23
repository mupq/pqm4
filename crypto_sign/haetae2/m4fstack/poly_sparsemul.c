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
/*
 * poly_sparsemul.c
 *
 * Low-stack helpers for HAETAE signing:
 *   - Extract a sparse representation of the challenge polynomial c (dense poly -> (idx,sgn) list).
 *   - Compute (c * s) in R_q = Z_q[x]/(x^N + 1) using only negacyclic shifts (no NTT).
 *   - (Optional) Update a fixed-point polynomial y in-place with z = y + scale*(c*s),
 *     while simultaneously accumulating the "2z - y" squared-norm accumulator (acc2).
 *
 * Rationale:
 *   The HAETAE challenge c of modes 2 and 3 has TAU coefficients equal to 1
 *   and all others 0 (the helpers also accept Q-1 as -1), so
 *     c(x)s(x) = sum_{k=1..TAU} sgn_k * x^{idx_k} * s(x)   (mod x^N+1)
 *   and multiplication by x^{idx_k} is a negacyclic rotation with a sign flip on wrap.
 *   Coefficients remain small (no wrap modulo q) when s has small coefficients.
 *
 * This file is pure C and intended for Cortex-M4 / low-stack builds.
 */

#include <stdint.h>
#include <stddef.h>

#include "poly_sparsemul.h"
#include "params.h"
#include "poly.h"
#include "polyfix.h"

/*
 * Normalize a challenge coefficient to {-1,0,+1}: 0 and 1 (the HAETAE
 * challenge) are kept, Q-1 is read as -1, and any other value (a literal -1
 * included) gives 0.
 */
static inline int8_t c_coeff_to_pm1(int32_t v) {
    if (v == 0) return 0;
    if (v == 1) return +1;
    if ((uint32_t)v == (uint32_t)(Q - 1)) return -1;
    return 0;
}

/*
 * Extract sparse list (idx[], sgn[]) from dense challenge polynomial c.
 *
 * - idx[] holds positions in [0, N-1]
 * - sgn[] holds +/-1 (int8_t)
 * - max_w >= 1 is the maximum number of nonzero entries to record (typically
 *   TAU; with max_w = 0 the first nonzero entry would still be written)
 *
 * Returns:
 *   w = number of entries recorded (<= max_w).
 *
 * NOTE:
 *   If c is guaranteed to have exactly TAU nonzeros, w should equal TAU.
 */
unsigned poly_c_to_sparse(uint16_t *idx, int8_t *sgn, unsigned max_w, const poly *c) {
    unsigned w = 0;
    for (unsigned i = 0; i < N; i++) {
        int8_t s = c_coeff_to_pm1(c->coeffs[i]);
        if (!s) continue;

        idx[w] = (uint16_t)i;
        sgn[w] = s;
        if (++w == max_w) break;
    }
    return w;
}

/*
 * In-place low-stack update:
 *   y <- y + scale * (c*s)
 * and accumulate
 *   u = y_old + 2*scale*(c*s)  (i.e., 2z - y_old)
 *   acc2 <- acc2 + sum_i u_i^2
 * The accumulation of u (which depends on the secret key) is branch-free;
 * the loops branch only on the challenge positions idx[].
 *
 * Arguments:
 *   - y:      fixed-point poly (updated in place)
 *   - s:      small secret poly (eta)
 *   - idx,sgn,w: sparse challenge representation
 *   - scale:  typically (sgn_from_b * LN)
 *   - acc2:   current accumulator (caller maintains it)
 *
 * Returns:
 *   updated acc2.
 *
 * Notes:
 *   - This avoids allocating a temporary poly "tmp" on the stack.
 *   - Complexity: O(w*N). For small w (tau) this is acceptable.
 */
uint64_t polyfix_addmul_sparse_inplace_acc2(polyfix *y, const poly *s,
                                           const uint16_t *idx, const int8_t *sgn,
                                           unsigned w,
                                           int32_t scale,
                                           uint64_t acc2) {
    for (unsigned i = 0; i < N; i++) {
        int32_t sum = 0;

        /* Compute coefficient i of (c*s) in negacyclic ring. */
        for (unsigned k = 0; k < w; k++) {
            const unsigned sh = (unsigned)idx[k];
            const int32_t ck = (int32_t)sgn[k]; /* +/-1 */

            /* coefficient i of x^sh*s:
             * if i >= sh:  + s[i - sh]
             * else:       - s[i - sh + N]
             */
            if (i >= sh) {
                sum += ck * s->coeffs[i - sh];
            } else {
                sum -= ck * s->coeffs[i - sh + N];
            }
        }

        /* t = scale * (c*s)[i] */
        const int32_t y0 = y->coeffs[i];
        const int32_t t  = (int32_t)((int64_t)scale * (int64_t)sum);
        const int32_t z  = y0 + t;

        /* u = 2z - y = y + 2t */
        const int32_t u  = y0 + (int32_t)((uint32_t)t << 1);

        acc2 += (uint64_t)((int64_t)u * (int64_t)u);

        y->coeffs[i] = z;
    }

    return acc2;
}
