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

void pre_expand_trees(uint8_t pre_nodes[AIMER_T][2 * PRE_TREE_IDX - 1][AIMER_SEED_SIZE],
                      const hash_instance *ctx_tree,
                      const uint8_t root_seeds[AIMER_T][AIMER_SEED_SIZE])
{
  size_t rep_index, node_index;
  uint8_t buffer[AIMER_SEED_SIZE + 2];

  hash_instance ctx;

  for (rep_index = 0; rep_index < AIMER_T; rep_index++)
  {
    memcpy(pre_nodes[rep_index][0], root_seeds[rep_index], AIMER_SEED_SIZE);
    buffer[0] = (uint8_t)(rep_index);
    for (node_index = 1; node_index < PRE_TREE_IDX; node_index++)
    {
      buffer[1] = (uint8_t)(node_index);
      memcpy(buffer + 2, pre_nodes[rep_index][node_index - 1], AIMER_SEED_SIZE);

      hash_ctx_clone(&ctx, ctx_tree);
      hash_update(&ctx, buffer, AIMER_SEED_SIZE + 2);
      hash_final(&ctx);
      hash_squeeze(&ctx, pre_nodes[rep_index][2 * node_index - 1], AIMER_SEED_SIZE << 1);
      hash_ctx_release(&ctx);
    }
  }
}

void expand_tree(uint8_t nodes[2 * AIMER_N - 1][AIMER_SEED_SIZE],
                 const hash_instance *ctx_tree,
                 size_t rep_index)
{
  size_t index;
  uint8_t buffer[AIMER_SEED_SIZE + 2];

  hash_instance ctx;

  buffer[0] = (uint8_t)(rep_index);
  for (index = PRE_TREE_IDX; index < AIMER_N; index++)
  {
    buffer[1] = (uint8_t)(index);
    memcpy(buffer + 2, nodes[index - 1], AIMER_SEED_SIZE);

    hash_ctx_clone(&ctx, ctx_tree);
    hash_update(&ctx, buffer, AIMER_SEED_SIZE + 2);
    hash_final(&ctx);
    hash_squeeze(&ctx, nodes[2 * index - 1], AIMER_SEED_SIZE << 1);
    hash_ctx_release(&ctx);
  }
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
