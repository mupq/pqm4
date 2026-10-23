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
#include "utils.h"


/*************************************************
 * Name:        generate_seed_from_one_source
 *
 * Description: Use SHAKE256 to generate a seed from one byte source.
 *
 * Arguments:   - uint8_t *seed:    pointer to buffer of seed to be generated
 *              - size_t seed_len:  desired length of the seed
 *              - const uint8_t *src: pointer to source to be absorbed
 *              - size_t src_len:  length of source
 *
 * Returns void
 **************************************************/
void generate_seed_from_one_source(uint8_t *seed, size_t seed_len,
		const uint8_t *src, size_t src_len) {
	xof256_state state;
	xof256_absorb_once(&state, src, src_len);
	xof256_squeeze(seed, seed_len, &state);
	return;
}
