// SPDX-License-Identifier: MIT

#include "hash.h"
#include "keccakf1600.h"
#include <stddef.h>
#include <stdint.h>

static void shake256_inc_skip_squeeze(shake256incctx *state, size_t outlen)
{
  size_t i;

  for (i = 0; i < outlen && i < state->ctx[25]; i++)
  {
    continue;
  }
  outlen -= i;
  state->ctx[25] -= i;

  while (outlen > 0)
  {
    KeccakF1600_StatePermute(state->ctx);

    for (i = 0; i < outlen && i < SHAKE256_RATE; i++)
    {
      continue;
    }
    outlen -= i;
    state->ctx[25] = SHAKE256_RATE - i;
  }
}

void hash_init(hash_instance *ctx)
{
  shake256_inc_init(ctx);
}

void hash_init_prefix(hash_instance *ctx, uint8_t prefix)
{
  shake256_inc_init(ctx);
  shake256_inc_absorb(ctx, &prefix, sizeof(prefix));
}

void hash_update(hash_instance *ctx, const uint8_t *data, size_t data_len)
{
  shake256_inc_absorb(ctx, data, data_len);
}

void hash_final(hash_instance *ctx)
{
  shake256_inc_finalize(ctx);
}

void hash_squeeze(hash_instance *ctx, uint8_t *buffer, size_t buffer_len)
{
  shake256_inc_squeeze(buffer, buffer_len, ctx);
}

void hash_skip_squeeze(hash_instance *ctx, size_t buffer_len)
{
  shake256_inc_skip_squeeze(ctx, buffer_len);
}

void hash_ctx_clone(hash_instance *ctx_dest, const hash_instance *ctx_src)
{
  shake256_inc_ctx_clone(ctx_dest, ctx_src);
}

void hash_ctx_release(hash_instance *ctx)
{
  shake256_inc_ctx_release(ctx);
}
