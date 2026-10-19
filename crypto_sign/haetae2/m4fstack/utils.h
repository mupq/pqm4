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
#ifndef HAETAE_UTILS_H_
#define HAETAE_UTILS_H_

#include "config.h"
#include "params.h"
#include "fips202.h"
#include "symmetric.h"

#define generate_seed_from_one_source HAETAE_NAMESPACE(generate_seed_from_one_source)
void generate_seed_from_one_source(uint8_t *seed, size_t seed_len,
		const uint8_t *src, size_t src_len) ;

#endif
