// SPDX-License-Identifier: MIT

#ifndef HASH_H
#define HASH_H

#include "fips202.h"
#include "params.h"
#include <stddef.h>
#include <stdint.h>

static const uint8_t HASH_PREFIX_0 = 0;
static const uint8_t HASH_PREFIX_1 = 1;
static const uint8_t HASH_PREFIX_2 = 2;
static const uint8_t HASH_PREFIX_3 = 3;
static const uint8_t HASH_PREFIX_4 = 4;
static const uint8_t HASH_PREFIX_5 = 5;

typedef shake256incctx hash_instance;

#define hash_init AIMER_NAMESPACE(hash_init)
void hash_init(hash_instance *ctx);
#define hash_init_prefix AIMER_NAMESPACE(hash_init_prefix)
void hash_init_prefix(hash_instance *ctx, uint8_t prefix);
#define hash_update AIMER_NAMESPACE(hash_update)
void hash_update(hash_instance *ctx, const uint8_t *data, size_t data_len);
#define hash_final AIMER_NAMESPACE(hash_final)
void hash_final(hash_instance *ctx);
#define hash_squeeze AIMER_NAMESPACE(hash_squeeze)
void hash_squeeze(hash_instance *ctx, uint8_t *buffer, size_t buffer_len);
#define hash_skip_squeeze AIMER_NAMESPACE(hash_skip_squeeze)
void hash_skip_squeeze(hash_instance *ctx, size_t buffer_len);
#define hash_ctx_clone AIMER_NAMESPACE(hash_ctx_clone)
void hash_ctx_clone(hash_instance *ctx_dest, const hash_instance *ctx_src);
#define hash_ctx_release AIMER_NAMESPACE(hash_ctx_release)
void hash_ctx_release(hash_instance *ctx);

#endif // HASH_H
