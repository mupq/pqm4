
/**
 * @file theta_tree.h
 * @brief Header file for theta_tree.c
 */

#ifndef SIG_PERK_THETA_TREE_H
#define SIG_PERK_THETA_TREE_H

#include <stdint.h>
#include "parameters.h"
#include "symmetric.h"

#define MASTER_THETA_SEED_OFFSET 0
#define THETA_SEEDS_OFFSET       (PARAM_N - 1)

/**
 * @brief Theta theta_t
 *
 * This structure contains a seed of size SEED_BYTES bytes
 */
typedef uint8_t theta_t[SEED_BYTES];

/**
 * @brief An array of Theta
 *
 * This structure contains an array of 2 * PARAM_N - 1 theta_t
 */
typedef theta_t perk_theta_seeds_tree_t[2 * PARAM_N - 1];

/**
 * @brief expands the tree of thetas (nodes and leaves) from theta master seed and salt
 *
 * @param[in] salt
 * @param[in,out] theta_tree a perk_theta_seeds_tree_t to be expanded with nodes and leaves
 *                           theta_tree[0] is the master seed
 *                           (theta_tree + THETA_SEEDS_OFFSET) is the array of theta_t
 */
void sig_perk_expand_theta_tree(salt_t salt, perk_theta_seeds_tree_t theta_tree);

/**
 * @brief expands the partial tree of thetas (nodes and leaves missing the alpha related ones)
 *        from the array of THETA_TREE_LEVELS node seeds, salt and alpha
 *
 * @param[in] salt
 * @param[out] partial_theta_tree a perk_theta_seeds_tree_t to be expanded with nodes and leaves
 *                                from the array of partial_tree_seeds
 * @param[in]  partial_tree_seeds array of seeds (one for each level)
 * @param[in]  alpha              missing leaf
 */
void sig_perk_expand_theta_partial_tree(salt_t salt, perk_theta_seeds_tree_t partial_theta_tree,
                                        const theta_t partial_tree_seeds[THETA_TREE_LEVELS], const uint16_t alpha);

/**
 * @brief returns the THETA_TREE_LEVELS seeds needed to compute all thetas but the alpha ones
 *        given perk_theta_seeds_tree_t and alpha
 *
 * @param[out] partial_tree_seeds array of seeds needed to rebuild the tree with the missing alpha leaf
 * @param[in]  theta_tree         a complete perk_theta_seeds_tree_t
 * @param[in]  alpha              missing leaf
 */
void sig_perk_get_theta_partial_tree_seeds(theta_t partial_tree_seeds[THETA_TREE_LEVELS],
                                           const perk_theta_seeds_tree_t theta_tree, const uint16_t alpha);

#endif