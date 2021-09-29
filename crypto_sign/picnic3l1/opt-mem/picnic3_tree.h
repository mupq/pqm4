/*! @file tree.h
 *  @brief This file has part of the tree implementation used to generate
 *  random seeds and commit to multiple values with a Merkle tree.
 *
 *  This file is part of the reference implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef PICNIC3_TREE_H
#define PICNIC3_TREE_H

#include "picnic_params.h"

/*
 * Represents a (nearly) complete binary tree, stored in memory as an array.
 * The root is at nodes[0], and the left child of node k is 2k + 1, the right
 * child is at 2k + 2
 */
typedef struct tree_t {
  size_t depth;      /* The depth of the tree */
  uint8_t** nodes;   /* The data for each node */
  size_t dataSize;   /* The size data at each node, in bytes */
  uint8_t* haveNode; /* If we have the data (seed or hash) for node i, haveSeed[i] is 1 */
  uint8_t* exists;   /* Since the tree is not always complete, nodes marked 0 don't exist */
  size_t numNodes;   /* The total number of nodes in the tree */
  size_t numLeaves;  /* The total number of leaves in the tree */
} tree_t;

typedef struct round_seed_tree_storage_t {
  uint8_t* nodes_ptr[PICNIC_ROUND_TREE_NUM_NODES];              /* The ptr for each node */
  uint8_t nodes[PICNIC_ROUND_TREE_NUM_NODES][PICNIC_SEED_SIZE]; /* The data for each node */
  uint8_t haveNode[PICNIC_ROUND_TREE_NUM_NODES]; /* If we have the data (seed or hash) for node i,
                                           haveSeed[i] is 1 */
  uint8_t exists[PICNIC_ROUND_TREE_NUM_NODES];   /* Since the tree is not always complete, nodes
                                           marked 0 don't   exist */
} round_seed_tree_storage_t;

typedef struct round_commitment_tree_storage_t {
  uint8_t* nodes_ptr[PICNIC_ROUND_TREE_NUM_NODES];                /* The ptr for each node */
  uint8_t nodes[PICNIC_ROUND_TREE_NUM_NODES][PICNIC_DIGEST_SIZE]; /* The data for each node */
  uint8_t haveNode[PICNIC_ROUND_TREE_NUM_NODES]; /* If we have the data (seed or hash) for node i,
                                           haveSeed[i] is 1 */
  uint8_t exists[PICNIC_ROUND_TREE_NUM_NODES];   /* Since the tree is not always complete, nodes
                                           marked 0 don't   exist */
} round_commitment_tree_storage_t;

/* Represent the commitment tree  without the nodes */
typedef struct round_commitment_tree_storage_light_t {
  uint8_t exists[PICNIC_ROUND_TREE_NUM_NODES];   /* Since the tree is not always complete, nodes
                                           marked 0 don't   exist */
} round_commitment_tree_storage_light_t;

typedef struct parties_seed_tree_storage_t {
  uint8_t* nodes_ptr[PICNIC_PARTY_TREE_NUM_NODES];              /* The ptr for each node */
  uint8_t nodes[PICNIC_PARTY_TREE_NUM_NODES][PICNIC_SEED_SIZE]; /* The data for each node */
  uint8_t haveNode[PICNIC_PARTY_TREE_NUM_NODES]; /* If we have the data (seed or hash) for node i,
                                           haveSeed[i] is 1 */
  uint8_t exists[PICNIC_PARTY_TREE_NUM_NODES];   /* Since the tree is not always complete, nodes
                                           marked 0 don't   exist */
} parties_seed_tree_storage_t;

/* The largest seed size is 256 bits, for the Picnic3-L5-FS parameter set. */
#define MAX_SEED_SIZE_BYTES (32)

void createPartySeedTree(tree_t* tree, parties_seed_tree_storage_t* storage);
void createRoundSeedTree(tree_t* tree, round_seed_tree_storage_t* storage);
void createRoundCommitmentTree(tree_t* tree, round_commitment_tree_storage_t* storage);
uint8_t** getLeaves(tree_t* tree);
/* Get one leaf, leafIndex must be in [0, tree->numLeaves -1] */
uint8_t* getLeaf(tree_t* tree, size_t leafIndex);

/* Functions for trees used to derive seeds.
 *    Signer's usage:   generateSeeds -> revealSeeds -> freeTree
 *    Verifier's usage: createTree -> reconstructSeeds -> freeTree
 */

/* Returns the number of bytes written to output.  A safe number of bytes for
 * callers to allocate is numLeaves*params->seedSizeBytes, or call revealSeedsSize. */
void generatePartySeeds(tree_t* tree, parties_seed_tree_storage_t* storage, uint8_t* rootSeed,
                        uint8_t* salt, size_t repIndex);
void generateRoundSeeds(tree_t* tree, round_seed_tree_storage_t* storage, uint8_t* rootSeed,
                        uint8_t* salt, size_t repIndex);
size_t revealPartySeeds(tree_t* tree, uint16_t hideParty, uint8_t* output, size_t outputLen);
size_t revealRoundSeeds(tree_t* tree, uint16_t* hideList, size_t hideListSize, uint8_t* output,
                        size_t outputLen);
size_t revealRoundSeedsSize(uint16_t* hideList, size_t hideListSize);
int reconstructPartySeeds(tree_t* tree, uint16_t hideParty, uint8_t* input, size_t inputLen,
                          uint8_t* salt, size_t repIndex);
int reconstructRoundSeeds(tree_t* tree, uint16_t* hideList, size_t hideListSize, uint8_t* input,
                          size_t inputLen, uint8_t* salt, size_t repIndex);

/* Functions for Merkle hash trees used for commitments.
 *
 * Signer call sequence:
 *     1. createTree
 *     2. buildMerkleTree  with all commitments as leaf nodes
 *     3. openMerkleTree   with missingLeaves - list of commitments the verifier won't recompute
 *     4. freeTree
 *  Verifier call sequence
 *      1. createTree
 *      2. addMerkleNodes       with the output of the signer
 *      3. verifyMerkleTree     Checks that all leaf nodes present are correct commitments
 *      4. freeTree
 */
void buildMerkleTree(tree_t* tree, uint8_t leafData[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE], uint8_t* salt);
void openMerkleTree(tree_t* tree, uint16_t* missingLeaves, size_t missingLeavesSize,
                    uint8_t* output, size_t* outputSizeBytes);
size_t openMerkleTreeSize(uint16_t* notMissingLeaves, size_t notMissingLeavesSize);
int addMerkleNodes(tree_t* tree, uint16_t* missingLeaves, size_t missingLeavesSize, uint8_t* input,
                   size_t inputSize);
int verifyMerkleTree(tree_t* tree, uint8_t** leafData, uint8_t* salt);

/* Low RAM functions */
void computeMerkleRoot(uint8_t* root, uint8_t leafData[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE], const uint8_t* salt);
void createRoundCommitmentTreeLight(tree_t* tree, round_commitment_tree_storage_light_t* storage);
void computeMerkleTreeOpening(tree_t* tree, const uint8_t leafData[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE], const uint16_t* missingLeaves, size_t missingLeavesSize, uint8_t* output, size_t* outputSizeBytes, const uint8_t* salt);
#endif
