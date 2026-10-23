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
 * poly_sparsemul.h
 *
 * Prototypes for low-stack sparse-challenge helpers.
 */
#ifndef POLY_SPARSEMUL_H
#define POLY_SPARSEMUL_H

#include <stdint.h>
#include "poly.h"
#include "polyfix.h"

#ifdef __cplusplus
extern "C" {
#endif

#define poly_c_to_sparse HAETAE_NAMESPACE(poly_c_to_sparse)
unsigned poly_c_to_sparse(uint16_t *idx, int8_t *sgn, unsigned max_w, const poly *c);

#define polyfix_addmul_sparse_inplace_acc2 HAETAE_NAMESPACE(polyfix_addmul_sparse_inplace_acc2)
uint64_t polyfix_addmul_sparse_inplace_acc2(polyfix *y, const poly *s,
                                           const uint16_t *idx, const int8_t *sgn,
                                           unsigned w,
                                           int32_t scale,
                                           uint64_t acc2);

#ifdef __cplusplus
}
#endif

#endif /* POLY_SPARSEMUL_H */
