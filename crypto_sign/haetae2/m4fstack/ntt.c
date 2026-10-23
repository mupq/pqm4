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
#include "ntt.h"
#include "ntt332.h"
#include <stdint.h>

/*
 * NTT / Inverse NTT: delegate to ARM Cortex-M4 assembly (ntt332.S), for the
 * same q = 64513, N = 256.  ntt() returns the same values as the reference C
 * code; invntt_tomont() returns congruent values in (-Q, Q), but for results
 * near +-Q/2 the representative can differ from the C code.  This does not
 * change any output: the callers reduce the result (KeyGen, A*y in Sign and
 * Verify) or, for c*s of mode 5 in Sign, the exact result is small
 * (|c*s| <= TAU), where both agree.
 */

void ntt(int32_t a[N]) {
    haetae_ntt332(a);
}

void invntt_tomont(int32_t a[N]) {
    haetae_invntt332_tomont(a);
}
