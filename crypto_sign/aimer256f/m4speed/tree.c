// SPDX-License-Identifier: MIT

#include "tree.h"
#include "hash.h"
#include <stddef.h>
#include <stdint.h>
#include <string.h>

//  Example of tree for [N = 8]
//  x
//  d = 0: 1
//  d = 1: 2         3
//  d = 2: 4   5     6     7
//  d = 3: 8 9 10 11 12 13 14 15

void expand_trees(uint8_t nodes[AIMER_T][2 * AIMER_N - 1][AIMER_SEED_SIZE],
                  const uint8_t salt[AIMER_SALT_SIZE])
{
  size_t rep, index;
  uint8_t buffer[AIMER_SEED_SIZE + 2];

  hash_instance ctx, ctx_;
  hash_init_prefix(&ctx_, HASH_PREFIX_4);
  hash_update(&ctx_, salt, AIMER_SALT_SIZE);

  for (rep = 0; rep < AIMER_T; rep++)
  {
    buffer[0] = (uint8_t)(rep);
    for (index = 1; index < AIMER_N; index++)
    {
      buffer[1] = (uint8_t)(index);
      memcpy(buffer + 2, nodes[rep][index - 1], AIMER_SEED_SIZE);

      hash_ctx_clone(&ctx, &ctx_);
      hash_update(&ctx, buffer, AIMER_SEED_SIZE + 2);
      hash_final(&ctx);
      hash_squeeze(&ctx, nodes[rep][2 * index - 1], AIMER_SEED_SIZE << 1);
      hash_ctx_release(&ctx);
    }
  }
  hash_ctx_release(&ctx_);
}

void reveal_all_but(uint8_t reveal_path[AIMER_LOGN][AIMER_SEED_SIZE],
                    const uint8_t nodes[2 * AIMER_N - 1][AIMER_SEED_SIZE],
                    size_t cover_index)
{
  size_t index = cover_index + AIMER_N;
  for (size_t depth = 0; depth < AIMER_LOGN; depth++)
  {
    // index ^ 1 is sibling index
    memcpy(reveal_path[depth], nodes[(index ^ 1) - 1], AIMER_SEED_SIZE);

    // go to parent node
    index >>= 1;
  }
}

void reconstruct_tree(uint8_t nodes[2 * AIMER_N - 2][AIMER_SEED_SIZE],
                      const uint8_t salt[AIMER_SALT_SIZE],
                      const uint8_t reveal_path[AIMER_LOGN][AIMER_SEED_SIZE],
                      size_t rep_index,
                      size_t cover_index)
{
  size_t index, depth, path;
  uint8_t buffer[AIMER_SEED_SIZE + 2];

  hash_instance ctx, ctx_;
  hash_init_prefix(&ctx_, HASH_PREFIX_4);
  hash_update(&ctx_, salt, AIMER_SALT_SIZE);

  for (depth = 1; depth < AIMER_LOGN; depth++)
  {
    path = ((cover_index + AIMER_N) >> (AIMER_LOGN - depth)) ^ 1;
    memcpy(nodes[path - 2], reveal_path[AIMER_LOGN - depth], AIMER_SEED_SIZE);

    for (index = (1U << depth); index < (2U << depth); index++)
    {
      buffer[0] = (uint8_t)(rep_index);
      buffer[1] = (uint8_t)(index);
      memcpy(buffer + 2, nodes[index - 2], AIMER_SEED_SIZE);

      hash_ctx_clone(&ctx, &ctx_);
      hash_update(&ctx, buffer, AIMER_SEED_SIZE + 2);
      hash_final(&ctx);
      hash_squeeze(&ctx, nodes[2 * index - 2], AIMER_SEED_SIZE << 1);
      hash_ctx_release(&ctx);
    }
  }
  hash_ctx_release(&ctx_);

  path = ((cover_index + AIMER_N) >> (AIMER_LOGN - depth)) ^ 1;
  memcpy(nodes[path - 2], reveal_path[AIMER_LOGN - depth], AIMER_SEED_SIZE);
}
