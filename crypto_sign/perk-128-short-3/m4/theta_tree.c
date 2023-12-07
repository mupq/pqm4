
/**
 * @file theta_tree.c
 * @brief Implementation of tree related functions
 */

#include "theta_tree.h"
#include <string.h>
#include "symmetric.h"

void sig_perk_expand_theta_tree(salt_t salt, perk_theta_seeds_tree_t theta_tree) {
    sig_perk_hash_state_t state;

    for (unsigned i = 0; i < (PARAM_N - 1); i++) {
        unsigned from = i;
        uint8_t idx = i;
        unsigned to = i * 2 + 1;
        sig_perk_hash_init(&state, salt, &idx, NULL);
        sig_perk_hash_update(&state, theta_tree[from], sizeof(theta_t));
        sig_perk_hash_final(&state, theta_tree[to], H3);
    }
}

void sig_perk_expand_theta_partial_tree(salt_t salt, perk_theta_seeds_tree_t partial_theta_tree,
                                        const theta_t partial_tree_seeds[THETA_TREE_LEVELS], const uint16_t alpha) {
    sig_perk_hash_state_t state;
    for (unsigned i = 0, l = 0, j = 0; i < (PARAM_N - 1); i++, j++) {
        unsigned N = (1U << l);
        if (j >= N) {  // increment level
            l++;
            j = 0;
        }
        unsigned from = i;
        uint8_t idx = i;
        unsigned to = i * 2 + 1;
        unsigned missing = (alpha >> (THETA_TREE_LEVELS - l));            // missing node for the level l
        unsigned is_right = (~alpha >> (THETA_TREE_LEVELS - 1 - l)) & 1;  // position in the level l + 1
        if (j == missing) {
            memcpy(partial_theta_tree[to + is_right], partial_tree_seeds[l], sizeof(theta_t));
        } else {
            sig_perk_hash_init(&state, salt, &idx, NULL);
            sig_perk_hash_update(&state, partial_theta_tree[from], sizeof(theta_t));
            sig_perk_hash_final(&state, partial_theta_tree[to], H3);
        }
    }
}

void sig_perk_get_theta_partial_tree_seeds(theta_t partial_tree_seeds[THETA_TREE_LEVELS],
                                           const perk_theta_seeds_tree_t theta_tree, const uint16_t alpha) {
    for (unsigned i = 0; i < THETA_TREE_LEVELS; i++) {
        unsigned level = (1U << (i + 1U)) - 1;
        unsigned node = (alpha >> (THETA_TREE_LEVELS - 1U - i)) ^ 1U;
        memcpy(partial_tree_seeds[i], theta_tree[level + node], sizeof(theta_t));
    }
}
