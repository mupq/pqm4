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
#ifndef HAETAE_SIGN_PASSES_H
#define HAETAE_SIGN_PASSES_H

#include "config.h"
#include "params.h"
#include "poly.h"
#include "polyfix.h"
#include "fixpoint.h"
#include <stdint.h>
#include <stddef.h>

#define fs_passA_compute_challenge HAETAE_NAMESPACE(fs_passA_compute_challenge)
void fs_passA_compute_challenge(poly *c, poly *shared, uint8_t *b_out,
                                uint16_t *accepted_start_out,
                                uint16_t *next_counter_out,
                                fp96_76 *scaling_out,
                                const uint8_t seedbuf[CRHBYTES],
                                const uint8_t mu[CRHBYTES],
                                const uint8_t *pkbytes);

#define fs_passB_check_streaming HAETAE_NAMESPACE(fs_passB_check_streaming)
int fs_passB_check_streaming(const poly *c, poly *shared, uint8_t b,
                             const uint8_t seedbuf[CRHBYTES],
                             uint16_t counter_start, const fp96_76 *scaling,
                             const uint8_t *sk_s1_packed,
                             const uint8_t *sk_s2_packed);

#define fs_passC_hint_and_pack HAETAE_NAMESPACE(fs_passC_hint_and_pack)
int fs_passC_hint_and_pack(uint8_t *sig, size_t *siglen, poly *shared,
                           const poly *c, uint8_t b,
                           const uint8_t seedbuf[CRHBYTES],
                           uint16_t counter_start, const fp96_76 *scaling,
                           const uint8_t *pkbytes, const uint8_t *sk_s1_packed,
                           const uint8_t *sk_s2_packed);

#endif
