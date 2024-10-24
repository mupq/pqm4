// SPDX-License-Identifier: MIT

#ifndef TREE_H
#define TREE_H

#include "params.h"
#include "hash.h"
#include <stddef.h>
#include <stdint.h>

#define pre_expand_trees AIMER_NAMESPACE(pre_expand_trees)
void pre_expand_trees(uint8_t pre_nodes[AIMER_T][2 * PRE_TREE_IDX - 1][AIMER_SEED_SIZE],
                      const hash_instance *ctx_tree,
                      const uint8_t root_seeds[AIMER_T][AIMER_SEED_SIZE]);

#define expand_tree AIMER_NAMESPACE(expand_tree)
void expand_tree(uint8_t nodes[2 * AIMER_N - 1][AIMER_SEED_SIZE],
                 const hash_instance *ctx_tree,
                 size_t rep_index);

#define reveal_all_but AIMER_NAMESPACE(reveal_all_but)
void reveal_all_but(uint8_t reveal_path[AIMER_LOGN][AIMER_SEED_SIZE],
                    const uint8_t nodes[2 * AIMER_N - 1][AIMER_SEED_SIZE],
                    size_t cover_index);

#define reconstruct_tree AIMER_NAMESPACE(reconstruct_tree)
void reconstruct_tree(uint8_t nodes[2 * AIMER_N - 2][AIMER_SEED_SIZE],
                      const uint8_t salt[AIMER_SALT_SIZE],
                      const uint8_t reveal_path[AIMER_LOGN][AIMER_SEED_SIZE],
                      size_t rep_index,
                      size_t cover_index);

#endif // TREE_H
