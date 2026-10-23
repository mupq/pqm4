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
#ifndef CONFIG_H
#define CONFIG_H

#define HAETAE_MODE 3

#if HAETAE_MODE == 2
#define CRYPTO_ALGNAME "haetae_mode2"
#define HAETAE_NAMESPACE(s) cryptolab_haetae_mode2_m4fstack_##s
#elif HAETAE_MODE == 3
#define CRYPTO_ALGNAME "haetae_mode3"
#define HAETAE_NAMESPACE(s) cryptolab_haetae_mode3_m4fstack_##s
#elif HAETAE_MODE == 5
#define CRYPTO_ALGNAME "haetae_mode5"
#define HAETAE_NAMESPACE(s) cryptolab_haetae_mode5_m4fstack_##s
#else
#error "HAETAE_MODE must be 2, 3 or 5"
#endif

#endif /* CONFIG_H */
