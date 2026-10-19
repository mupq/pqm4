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
#ifndef HAETAE_POLYVEC_H
#define HAETAE_POLYVEC_H

#include "params.h"
#include "poly.h"
#include <stdint.h>

/* Squared largest singular value test of KeyGen, computed from the running
 * sum of squared FFT magnitudes of (s1, s2); see polyvec.c. */
#define polyvecmk_sqsing_value_min HAETAE_NAMESPACE(polyvecmk_sqsing_value_min)
int64_t polyvecmk_sqsing_value_min(int32_t *sum, poly *scratch);

#endif
