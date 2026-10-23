/*
 * Copyright 2026 YoungBeom Kim, Christine van Vredendaal, Gustavo Banegas, and Seog Chung Seo
 *
 * Based on ntt332.h of the earlier pqm4 HAETAE m4f implementation (pqm4
 * commit 564ac86, replaced by the new m4f): same prototypes, namespace
 * macros added.
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
#ifndef NTT332_H
#define NTT332_H

#include "params.h"
#include <stdint.h>

#if N != 256
#error "NTT332: Only N==256 is supported."
#endif

#define haetae_ntt332 HAETAE_NAMESPACE(ntt332)
void haetae_ntt332(int32_t poly[N]);
#define haetae_invntt332_tomont HAETAE_NAMESPACE(invntt332_tomont)
void haetae_invntt332_tomont(int32_t poly[N]);

#endif /* NTT332_H */
