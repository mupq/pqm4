/*! @file tree.c
 *  @brief This file has the tree implementation used to generate random seeds
 *  and commit to multiple values with a Merkle tree.
 *
 *  This file is part of the reference implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#include <assert.h>
#include <limits.h>
#include <stdlib.h>

#include "endian_compat.h"
#include "kdf_shake.h"
#include "picnic.h"
#include "picnic3_tree.h"
#include "picnic3_types.h"

static int contains(const size_t* list, size_t len, size_t value) {
  for (size_t i = 0; i < len; i++) {
    if (list[i] == value) {
      return 1;
    }
  }
  return 0;
}

static int exists(tree_t* tree, size_t i) {
  if (i >= tree->numNodes) {
    return 0;
  }
  if (tree->exists[i]) {
    return 1;
  }
  return 0;
}

void createPartySeedTree(tree_t* tree, parties_seed_tree_storage_t* storage) {

  tree->depth    = ceil_log2(PICNIC_NUM_PARTIES) + 1;
  tree->numNodes = ((1 << (tree->depth)) - 1) -
                   ((1 << (tree->depth - 1)) -
                    PICNIC_NUM_PARTIES); /* Num nodes in complete - number of missing leaves */
  assert(tree->numNodes == PICNIC_PARTY_TREE_NUM_NODES);
  tree->numLeaves = PICNIC_NUM_PARTIES;
  tree->dataSize  = PICNIC_SEED_SIZE;
  tree->nodes     = storage->nodes_ptr;

  memset(storage->nodes, 0, sizeof(storage->nodes));
  for (size_t i = 0; i < tree->numNodes; i++) {
    tree->nodes[i] = storage->nodes[i];
  }

  memset(storage->haveNode, 0, sizeof(storage->haveNode));
  tree->haveNode = storage->haveNode;

  /* Depending on the number of leaves, the tree may not be complete */
  memset(storage->exists, 0, sizeof(storage->exists));
  tree->exists = storage->exists;
  memset(tree->exists + tree->numNodes - tree->numLeaves, 1, tree->numLeaves); /* Set leaves */
  for (int i = tree->numNodes - tree->numLeaves; i > 0; i--) {
    if (exists(tree, 2 * i + 1) || exists(tree, 2 * i + 2)) {
      tree->exists[i] = 1;
    }
  }
  tree->exists[0] = 1;
}
void createRoundSeedTree(tree_t* tree, round_seed_tree_storage_t* storage) {

  tree->depth    = ceil_log2(PICNIC_NUM_ROUNDS) + 1;
  tree->numNodes = ((1 << (tree->depth)) - 1) -
                   ((1 << (tree->depth - 1)) -
                    PICNIC_NUM_ROUNDS); /* Num nodes in complete - number of missing leaves */
  assert(tree->numNodes == PICNIC_ROUND_TREE_NUM_NODES);
  tree->numLeaves = PICNIC_NUM_ROUNDS;
  tree->dataSize  = PICNIC_SEED_SIZE;
  tree->nodes     = storage->nodes_ptr;

  memset(storage->nodes, 0, sizeof(storage->nodes));
  for (size_t i = 0; i < tree->numNodes; i++) {
    tree->nodes[i] = storage->nodes[i];
  }

  memset(storage->haveNode, 0, sizeof(storage->haveNode));
  tree->haveNode = storage->haveNode;

  /* Depending on the number of leaves, the tree may not be complete */
  memset(storage->exists, 0, sizeof(storage->exists));
  tree->exists = storage->exists;
  memset(tree->exists + tree->numNodes - tree->numLeaves, 1, tree->numLeaves); /* Set leaves */
  for (int i = tree->numNodes - tree->numLeaves; i > 0; i--) {
    if (exists(tree, 2 * i + 1) || exists(tree, 2 * i + 2)) {
      tree->exists[i] = 1;
    }
  }
  tree->exists[0] = 1;
}

void createRoundCommitmentTree(tree_t* tree, round_commitment_tree_storage_t* storage) {

  tree->depth    = ceil_log2(PICNIC_NUM_ROUNDS) + 1;
  tree->numNodes = ((1 << (tree->depth)) - 1) -
                   ((1 << (tree->depth - 1)) -
                    PICNIC_NUM_ROUNDS); /* Num nodes in complete - number of missing leaves */
  assert(tree->numNodes == PICNIC_ROUND_TREE_NUM_NODES);
  tree->numLeaves = PICNIC_NUM_ROUNDS;
  tree->dataSize  = PICNIC_DIGEST_SIZE;
  tree->nodes     = storage->nodes_ptr;

  memset(storage->nodes, 0, sizeof(storage->nodes));
  for (size_t i = 0; i < tree->numNodes; i++) {
    tree->nodes[i] = storage->nodes[i];
  }

  memset(storage->haveNode, 0, sizeof(storage->haveNode));
  tree->haveNode = storage->haveNode;

  /* Depending on the number of leaves, the tree may not be complete */
  memset(storage->exists, 0, sizeof(storage->exists));
  tree->exists = storage->exists;
  memset(tree->exists + tree->numNodes - tree->numLeaves, 1, tree->numLeaves); /* Set leaves */
  for (int i = tree->numNodes - tree->numLeaves; i > 0; i--) {
    if (exists(tree, 2 * i + 1) || exists(tree, 2 * i + 2)) {
      tree->exists[i] = 1;
    }
  }
  tree->exists[0] = 1;
}

static int isLeftChild(size_t node) {
  assert(node != 0);
  return (node % 2 == 1);
}

static int hasRightChild(tree_t* tree, size_t node) {
  return (2 * node + 2 < tree->numNodes && exists(tree, node));
}

static size_t getParent(size_t node) {
  assert(node != 0);
  return ((node + 1) >> 1) - 1;
}

uint8_t** getLeaves(tree_t* tree) {
  return &tree->nodes[tree->numNodes - tree->numLeaves];
}

uint8_t* getLeaf(tree_t* tree, size_t leafIndex) {
  assert(leafIndex < tree->numLeaves);
  size_t firstLeaf = tree->numNodes - tree->numLeaves;
  return tree->nodes[firstLeaf + leafIndex];
}

static void hashSeed(uint8_t* digest, const uint8_t* inputSeed, uint8_t* salt, uint8_t hashPrefix,
                     size_t repIndex, size_t nodeIndex) {
  hash_context ctx;

  hash_init_prefix(&ctx, PICNIC_DIGEST_SIZE, hashPrefix);
  hash_update(&ctx, inputSeed, PICNIC_SEED_SIZE);
  hash_update(&ctx, salt, PICNIC_SALT_SIZE);
  hash_update_uint16_le(&ctx, repIndex);
  hash_update_uint16_le(&ctx, nodeIndex);
  hash_final(&ctx);
  hash_squeeze(&ctx, digest, 2 * PICNIC_SEED_SIZE);
}

static void expandSeeds(tree_t* tree, uint8_t* salt, size_t repIndex) {
  uint8_t tmp[2 * MAX_SEED_SIZE_BYTES];

  /* Walk the tree, expanding seeds where possible. Compute children of
   * non-leaf nodes. */
  size_t lastNonLeaf = getParent(tree->numNodes - 1);
  for (size_t i = 0; i <= lastNonLeaf; i++) {
    if (!tree->haveNode[i]) {
      continue;
    }

    hashSeed(tmp, tree->nodes[i], salt, HASH_PREFIX_1, repIndex, i);

    if (!tree->haveNode[2 * i + 1]) {
      /* left child = H_left(seed_i || salt || t || i) */
      memcpy(tree->nodes[2 * i + 1], tmp, PICNIC_SEED_SIZE);
      tree->haveNode[2 * i + 1] = 1;
    }

    /* The last non-leaf node will only have a left child when there are an odd number of leaves */
    if (exists(tree, 2 * i + 2) && !tree->haveNode[2 * i + 2]) {
      /* right child = H_right(seed_i || salt || t || i)  */
      memcpy(tree->nodes[2 * i + 2], tmp + PICNIC_SEED_SIZE, PICNIC_SEED_SIZE);
      tree->haveNode[2 * i + 2] = 1;
    }
  }
}

void generatePartySeeds(tree_t* tree, parties_seed_tree_storage_t* storage, uint8_t* rootSeed,
                        uint8_t* salt, size_t repIndex) {
  createPartySeedTree(tree, storage);

  memcpy(tree->nodes[0], rootSeed, PICNIC_SEED_SIZE);
  tree->haveNode[0] = 1;
  expandSeeds(tree, salt, repIndex);
}

void generateRoundSeeds(tree_t* tree, round_seed_tree_storage_t* storage, uint8_t* rootSeed,
                        uint8_t* salt, size_t repIndex) {
  createRoundSeedTree(tree, storage);

  memcpy(tree->nodes[0], rootSeed, PICNIC_SEED_SIZE);
  tree->haveNode[0] = 1;
  expandSeeds(tree, salt, repIndex);
}

static int isLeafNode(tree_t* tree, size_t node) {
  return (2 * node + 1 >= tree->numNodes);
}

static int hasSibling(tree_t* tree, size_t node) {
  if (!exists(tree, node)) {
    return 0;
  }

  if (isLeftChild(node) && !exists(tree, node + 1)) {
    return 0;
  }

  return 1;
}

static size_t getSibling(tree_t* tree, size_t node) {
  assert(node < tree->numNodes);
  assert(node != 0);
  assert(hasSibling(tree, node));

  if (isLeftChild(node)) {
    if (node + 1 < tree->numNodes) {
      return node + 1;
    } else {
      assert(!"getSibling: request for node with not sibling");
      return 0;
    }
  } else {
    return node - 1;
  }
}

/* Returns the number of bytes written to output */
static void getRevealedNodesRoundTree(tree_t* tree, uint16_t* hideList, size_t hideListSize,
                                      size_t* revealed, size_t* outputSize) {
  /* Compute paths up from hideList to root, store as sets of nodes */
  size_t pathLen = tree->depth - 1;

  /* pathSets[i][0...hideListSize] stores the nodes in the path at depth i
   * for each of the leaf nodes in hideListSize */
  size_t pathSets[PICNIC_NUM_ROUNDS_LOG2][PICNIC_NUM_OPENED_ROUNDS];
  assert(hideListSize <= PICNIC_NUM_OPENED_ROUNDS);

  /* Compute the paths back to the root */
  for (size_t i = 0; i < hideListSize; i++) {
    size_t pos = 0;
    size_t node =
        hideList[i] +
        (tree->numNodes - tree->numLeaves); /* input lists leaf indexes, translate to nodes */
    pathSets[pos][i] = node;
    pos++;
    while ((node = getParent(node)) != 0) {
      pathSets[pos][i] = node;
      pos++;
    }
  }

  /* Determine seeds to reveal */
  size_t revealedPos = 0;
  for (size_t d = 0; d < pathLen; d++) {
    for (size_t i = 0; i < hideListSize; i++) {
      if (!hasSibling(tree, pathSets[d][i])) {
        continue;
      }
      size_t sibling = getSibling(tree, pathSets[d][i]);
      if (!contains(pathSets[d], hideListSize, sibling)) {
        // Determine the seed to reveal
        while (!hasRightChild(tree, sibling) && !isLeafNode(tree, sibling)) {
          sibling = 2 * sibling + 1; // sibling = leftChild(sibling)
        }
        // Only reveal if we haven't already
        if (!contains(revealed, revealedPos, sibling)) {
          revealed[revealedPos] = sibling;
          revealedPos++;
        }
      }
    }
  }

  *outputSize = revealedPos;
}
static void getRevealedNodesPartyTree(tree_t* tree, uint16_t hideParty, size_t* revealed,
                                      size_t* outputSize) {
  /* Compute paths up from hideList to root, store as sets of nodes */
  size_t pathLen = tree->depth - 1;

  /* pathSets[i][0...hideListSize] stores the nodes in the path at depth i
   * for each of the leaf nodes in hideListSize */
  size_t pathSet[PICNIC_NUM_PARTIES_LOG2];

  /* Compute the paths back to the root */
  {
    size_t pos   = 0;
    size_t node  = hideParty + (tree->numNodes -
                               tree->numLeaves); /* input lists leaf indexes, translate to nodes */
    pathSet[pos] = node;
    pos++;
    while ((node = getParent(node)) != 0) {
      pathSet[pos] = node;
      pos++;
    }
  }

  /* Determine seeds to reveal */
  size_t revealedPos = 0;
  for (size_t d = 0; d < pathLen; d++) {
    if (!hasSibling(tree, pathSet[d])) {
      continue;
    }
    size_t sibling = getSibling(tree, pathSet[d]);
    // Determine the seed to reveal
    while (!hasRightChild(tree, sibling) && !isLeafNode(tree, sibling)) {
      sibling = 2 * sibling + 1; // sibling = leftChild(sibling)
    }
    // Only reveal if we haven't already
    if (!contains(revealed, revealedPos, sibling)) {
      revealed[revealedPos] = sibling;
      revealedPos++;
    }
  }

  *outputSize = revealedPos;
}

size_t revealRoundSeedsSize(uint16_t* hideList, size_t hideListSize) {
  tree_t tree;
  round_seed_tree_storage_t storage;
  createRoundSeedTree(&tree, &storage);
  size_t numNodesRevealed = 0;
  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  getRevealedNodesRoundTree(&tree, hideList, hideListSize, revealed, &numNodesRevealed);

  return numNodesRevealed * PICNIC_SEED_SIZE;
}

size_t revealPartySeeds(tree_t* tree, uint16_t hideParty, uint8_t* output, size_t outputSize) {
  uint8_t* outputBase = output;
  size_t revealedSize = 0;

  if (outputSize > INT_MAX) {
    return -1;
  }
  int outLen = (int)outputSize;

  size_t revealed[PICNIC_PARTY_TREE_MAX_REVEALED_NODES];
  getRevealedNodesPartyTree(tree, hideParty, revealed, &revealedSize);
  for (size_t i = 0; i < revealedSize; i++) {
    outLen -= PICNIC_SEED_SIZE;
    if (outLen < 0) {
      assert(!"Insufficient sized buffer provided to revealSeeds");
      return 0;
    }
    memcpy(output, tree->nodes[revealed[i]], PICNIC_SEED_SIZE);
    output += PICNIC_SEED_SIZE;
  }

  return output - outputBase;
}
size_t revealRoundSeeds(tree_t* tree, uint16_t* hideList, size_t hideListSize, uint8_t* output,
                        size_t outputSize) {
  uint8_t* outputBase = output;
  size_t revealedSize = 0;

  if (outputSize > INT_MAX) {
    return -1;
  }
  int outLen = (int)outputSize;

  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  getRevealedNodesRoundTree(tree, hideList, hideListSize, revealed, &revealedSize);
  for (size_t i = 0; i < revealedSize; i++) {
    outLen -= PICNIC_SEED_SIZE;
    if (outLen < 0) {
      assert(!"Insufficient sized buffer provided to revealSeeds");
      return 0;
    }
    memcpy(output, tree->nodes[revealed[i]], PICNIC_SEED_SIZE);
    output += PICNIC_SEED_SIZE;
  }

  return output - outputBase;
}

int reconstructRoundSeeds(tree_t* tree, uint16_t* hideList, size_t hideListSize, uint8_t* input,
                          size_t inputLen, uint8_t* salt, size_t repIndex) {
  int ret = 0;

  if (inputLen > INT_MAX) {
    return -1;
  }
  int inLen = (int)inputLen;

  size_t revealedSize = 0;
  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  getRevealedNodesRoundTree(tree, hideList, hideListSize, revealed, &revealedSize);
  for (size_t i = 0; i < revealedSize; i++) {
    inLen -= PICNIC_SEED_SIZE;
    if (inLen < 0) {
      ret = -1;
      goto Exit;
    }
    memcpy(tree->nodes[revealed[i]], input, PICNIC_SEED_SIZE);
    tree->haveNode[revealed[i]] = 1;
    input += PICNIC_SEED_SIZE;
  }

  expandSeeds(tree, salt, repIndex);

Exit:
  return ret;
}
int reconstructPartySeeds(tree_t* tree, uint16_t hideParty, uint8_t* input, size_t inputLen,
                          uint8_t* salt, size_t repIndex) {
  int ret = 0;

  if (inputLen > INT_MAX) {
    return -1;
  }
  int inLen = (int)inputLen;

  size_t revealedSize = 0;
  size_t revealed[PICNIC_PARTY_TREE_MAX_REVEALED_NODES];
  getRevealedNodesPartyTree(tree, hideParty, revealed, &revealedSize);
  for (size_t i = 0; i < revealedSize; i++) {
    inLen -= PICNIC_SEED_SIZE;
    if (inLen < 0) {
      ret = -1;
      goto Exit;
    }
    memcpy(tree->nodes[revealed[i]], input, PICNIC_SEED_SIZE);
    tree->haveNode[revealed[i]] = 1;
    input += PICNIC_SEED_SIZE;
  }

  expandSeeds(tree, salt, repIndex);

Exit:
  return ret;
}

static void computeParentHash(tree_t* tree, size_t child, uint8_t* salt) {
  if (!exists(tree, child)) {
    return;
  }

  size_t parent = getParent(child);

  if (tree->haveNode[parent]) {
    return;
  }

  /* Compute the hash for parent, if we have everything */
  if (!tree->haveNode[2 * parent + 1]) {
    return;
  }

  if (exists(tree, 2 * parent + 2) && !tree->haveNode[2 * parent + 2]) {
    return;
  }

  /* Compute parent data = H(left child data || [right child data] || salt || parent idx) */
  hash_context ctx;
  hash_init_prefix(&ctx, PICNIC_DIGEST_SIZE, HASH_PREFIX_3);
  hash_update(&ctx, tree->nodes[2 * parent + 1], PICNIC_DIGEST_SIZE);
  if (hasRightChild(tree, parent)) {
    /* One node may not have a right child when there's an odd number of leaves */
    hash_update(&ctx, tree->nodes[2 * parent + 2], PICNIC_DIGEST_SIZE);
  }

  hash_update(&ctx, salt, PICNIC_SALT_SIZE);
  hash_update_uint16_le(&ctx, parent);
  hash_final(&ctx);
  hash_squeeze(&ctx, tree->nodes[parent], PICNIC_DIGEST_SIZE);
  tree->haveNode[parent] = 1;
}

/* Create a Merkle tree by hashing up all nodes.
 * leafData must have length tree->numNodes, but some may be NULL. */
void buildMerkleTree(tree_t* tree, uint8_t leafData[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE], uint8_t* salt) {

  size_t firstLeaf = tree->numNodes - tree->numLeaves;

  /* Copy data to the leaves. The actual data being committed to has already been
   * hashed, according to the spec. */
  for (size_t i = 0; i < tree->numLeaves; i++) {
    if (leafData[i] != NULL) {
      memcpy(tree->nodes[firstLeaf + i], leafData[i], tree->dataSize);
      tree->haveNode[firstLeaf + i] = 1;
    }
  }
  /* Starting at the leaves, work up the tree, computing the hashes for intermediate nodes */
  for (int i = (int)tree->numNodes; i > 0; i--) {
    computeParentHash(tree, i, salt);
  }
}

/* Note that we never output the root node */
static void getRevealedMerkleNodes(tree_t* tree, const uint16_t* missingLeaves, size_t missingLeavesSize,
                                   size_t* revealed, size_t* outputSize) {
  size_t firstLeaf                                  = tree->numNodes - tree->numLeaves;
  uint8_t missingNodes[PICNIC_ROUND_TREE_NUM_NODES] = {
      0,
  };

  /* Mark leaves that are missing */
  for (size_t i = 0; i < missingLeavesSize; i++) {
    missingNodes[firstLeaf + missingLeaves[i]] = 1;
  }

  /* For the nonleaf nodes, if both leaves are missing, mark it as missing too */
  int lastNonLeaf = getParent(tree->numNodes - 1);
  for (int i = lastNonLeaf; i > 0; i--) {
    if (!exists(tree, i)) {
      continue;
    }
    if (exists(tree, 2 * i + 2)) {
      if (missingNodes[2 * i + 1] && missingNodes[2 * i + 2]) {
        missingNodes[i] = 1;
      }
    } else {
      if (missingNodes[2 * i + 1]) {
        missingNodes[i] = 1;
      }
    }
  }

  /* For each missing leaf node, add the highest missing node on the path
   * back to the root to the set to be revealed */
  size_t pos = 0;
  for (size_t i = 0; i < missingLeavesSize; i++) {
    size_t node = missingLeaves[i] + firstLeaf; /* input is leaf indexes, translate to nodes */
    do {
      if (!missingNodes[getParent(node)]) {
        if (!contains(revealed, pos, node)) {
          revealed[pos] = node;
          pos++;
        }
        break;
      }
    } while ((node = getParent(node)) != 0);
  }

  *outputSize = pos;
}

size_t openMerkleTreeSize(uint16_t* missingLeaves, size_t missingLeavesSize) {

  tree_t tree;
  round_commitment_tree_storage_t storage;
  createRoundCommitmentTree(&tree, &storage);
  size_t revealedSize = 0;
  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  getRevealedMerkleNodes(&tree, missingLeaves, missingLeavesSize, revealed, &revealedSize);

  return revealedSize * PICNIC_DIGEST_SIZE;
}

/* Serialze the missing nodes that the verifier will require to check commitments for non-missing
 * leaves */
void openMerkleTree(tree_t* tree, uint16_t* missingLeaves, size_t missingLeavesSize,
                    uint8_t* output, size_t* outputSizeBytes) {
  size_t revealedSize = 0;
  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  getRevealedMerkleNodes(tree, missingLeaves, missingLeavesSize, revealed, &revealedSize);

  /* Serialize output */
  *outputSizeBytes = revealedSize * tree->dataSize;

  for (size_t i = 0; i < revealedSize; i++) {
    memcpy(output, tree->nodes[revealed[i]], tree->dataSize);
    output += tree->dataSize;
  }
}

/* addMerkleNodes: deserialize and add the data for nodes provided by the committer */
int addMerkleNodes(tree_t* tree, uint16_t* missingLeaves, size_t missingLeavesSize, uint8_t* input,
                   size_t inputSize) {
  int ret = 0;

  assert(missingLeavesSize < tree->numLeaves);

  if (inputSize > INT_MAX) {
    return -1;
  }
  int intLen = (int)inputSize;

  size_t revealedSize = 0;
  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  getRevealedMerkleNodes(tree, missingLeaves, missingLeavesSize, revealed, &revealedSize);
  assert(!contains(revealed, revealedSize, 0));

  /* Deserialize input */
  for (size_t i = 0; i < revealedSize; i++) {
    intLen -= tree->dataSize;
    if (intLen < 0) {
      ret = -1;
      goto Exit;
    }
    memcpy(tree->nodes[revealed[i]], input, tree->dataSize);
    input += tree->dataSize;
    tree->haveNode[revealed[i]] = 1;
  }

  if (intLen != 0) {
    ret = -1;
    goto Exit;
  }

Exit:
  return ret;
}

/* verifyMerkleTree: verify for each leaf that is set */
int verifyMerkleTree(tree_t* tree, /* uint16_t* missingLeaves, size_t missingLeavesSize, */
                     uint8_t** leafData, uint8_t* salt) {
  size_t firstLeaf = tree->numNodes - tree->numLeaves;

  /* Copy the leaf data, where we have it. The actual data being committed to has already been
   * hashed, according to the spec. */
  for (size_t i = 0; i < tree->numLeaves; i++) {
    if (leafData[i] != NULL) {
      if (tree->haveNode[firstLeaf + i] == 1) {
        return -1; /* A leaf was assigned from the prover for a node we've recomputed */
      }

      if (leafData[i] != NULL) {
        memcpy(tree->nodes[firstLeaf + i], leafData[i], tree->dataSize);
        tree->haveNode[firstLeaf + i] = 1;
      }
    }
  }

  /* At this point the tree has some of the leaves, and some intermediate nodes
   * Work up the tree, computing all nodes we don't have that are missing. */
  for (int i = (int)tree->numNodes; i > 0; i--) {
    computeParentHash(tree, i, salt);
  }

  /* Fail if the root was not computed. */
  if (!tree->haveNode[0]) {
    return -1;
  }

  return 0;
}

static void hashMerkleNode(uint8_t* out, const uint8_t* in1, const uint8_t* in2, const uint8_t* salt, uint16_t idx)
{
  /* Compute out = H(in1 || in2 || salt || idx) */
  hash_context ctx;
  hash_init_prefix(&ctx, PICNIC_DIGEST_SIZE, HASH_PREFIX_3);
  hash_update(&ctx, in1, PICNIC_DIGEST_SIZE);
  hash_update(&ctx, in2, PICNIC_DIGEST_SIZE);
  hash_update(&ctx, salt, PICNIC_SALT_SIZE);
  hash_update_uint16_le(&ctx, idx);
  hash_final(&ctx);
  hash_squeeze(&ctx, out, PICNIC_DIGEST_SIZE);
}

void computeMerkleRoot(uint8_t* root, uint8_t leafData[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE], const uint8_t* salt)
{
  assert(PICNIC_NUM_ROUNDS % 2 == 0);
  uint8_t tmp[PICNIC_NUM_ROUNDS/2][PICNIC_DIGEST_SIZE];
  uint8_t zeroBuf[PICNIC_DIGEST_SIZE] = {0};

  size_t layerSizePrevious = PICNIC_NUM_ROUNDS;
  size_t layerSizeFull = 128;                 /* Size of the first layer in the (complete) tree we need to compute; just above the leaves */
  size_t layerSize = PICNIC_NUM_ROUNDS/2;     /* Actual number of nodes in the layer, since the tree is not complete */
  int layerStartIdx = layerSizeFull - 1;      /* Index of the first node in the layer, using the array representation of Picnic */

  while(layerSizeFull > 0) {
    size_t hasOdd = (layerSizePrevious % 2) ? 1 : 0;
    for(size_t i = 0; i < layerSize; i++) {
      size_t nodeIdx = layerStartIdx + i;
      if((i == layerSize - 1) && hasOdd) {   /* Handle the last node that has one child */
        hashMerkleNode(tmp[i], leafData[2*i], zeroBuf, salt, nodeIdx);      
      }
      else {
        hashMerkleNode(tmp[i], leafData[2*i], leafData[2*i+1], salt, nodeIdx);
      }
    }

    layerSizePrevious = layerSize;
    layerSizeFull = layerSizeFull/2;
    layerSize = (layerSize+1)/2;    // == ceil(layersize/2)
    layerStartIdx = layerSizeFull - 1;
    leafData = tmp;  // After the first layer (leafData -> tmp), we're computing in-place (tmp->tmp)
  }

  memcpy(root, tmp[0], PICNIC_DIGEST_SIZE);
}

/* Creates the tree with no nodes storage */
void createRoundCommitmentTreeLight(tree_t* tree, round_commitment_tree_storage_light_t* storage) {

  tree->depth    = ceil_log2(PICNIC_NUM_ROUNDS) + 1;
  tree->numNodes = ((1 << (tree->depth)) - 1) -
                   ((1 << (tree->depth - 1)) -
                    PICNIC_NUM_ROUNDS); /* Num nodes in complete - number of missing leaves */
  assert(tree->numNodes == PICNIC_ROUND_TREE_NUM_NODES);
  tree->numLeaves = PICNIC_NUM_ROUNDS;
  tree->dataSize  = PICNIC_DIGEST_SIZE;
  tree->nodes = NULL;
  tree->haveNode = NULL;

  /* Depending on the number of leaves, the tree may not be complete */
  memset(storage->exists, 0, sizeof(storage->exists));
  tree->exists = storage->exists;
  memset(tree->exists + tree->numNodes - tree->numLeaves, 1, tree->numLeaves); /* Set leaves */
  for (int i = tree->numNodes - tree->numLeaves; i > 0; i--) {
    if (exists(tree, 2 * i + 1) || exists(tree, 2 * i + 2)) {
      tree->exists[i] = 1;
    }
  }
  tree->exists[0] = 1;
}

static int indexOf(const size_t* list, size_t len, size_t value) {
  for (size_t i = 0; i < len; i++) {
    if (list[i] == value) {
      return i;
    }
  }
  return -1;
}

static void copyIfRevealed(size_t* revealed, size_t revealedSize, const uint8_t* data, size_t nodeIdx, uint8_t* output) {
  int outIdx = indexOf(revealed, revealedSize, nodeIdx);
  if(outIdx >= 0) {
    memcpy(output + outIdx*PICNIC_DIGEST_SIZE, data, PICNIC_DIGEST_SIZE);
  }
}

/* In this implementation we compute all the nodes, and copy the ones we need into the output buffer. 
 * The code is nearly identical to computeMerkleRoot */
void computeMerkleTreeOpening(tree_t* tree, const uint8_t leafData[PICNIC_NUM_ROUNDS][PICNIC_DIGEST_SIZE], const uint16_t* missingLeaves, size_t missingLeavesSize, uint8_t* output, size_t* outputSizeBytes, const uint8_t* salt)
{
  assert(PICNIC_NUM_ROUNDS == 250); // because we hardcode 128 and 255 below
  uint8_t tmp[PICNIC_NUM_ROUNDS/2][PICNIC_DIGEST_SIZE];
  size_t revealedSize = 0;
  size_t revealed[PICNIC_ROUND_TREE_MAX_REVEALED_NODES];
  uint8_t zeroBuf[PICNIC_DIGEST_SIZE] = {0};

  /* Based on the missing leaves, figure out which nodes to reveal */
  getRevealedMerkleNodes(tree, missingLeaves, missingLeavesSize, revealed, &revealedSize);
  *outputSizeBytes = revealedSize * PICNIC_DIGEST_SIZE;

  /* First copy any leaves that should be output */
  size_t leafStartIdx = 255;
  for(size_t i = 0; i < PICNIC_NUM_ROUNDS; i++){
    copyIfRevealed(revealed, revealedSize, leafData[i], leafStartIdx + i, output);
  }

  size_t layerSizePrevious = PICNIC_NUM_ROUNDS;
  size_t layerSizeFull = 128;                 /* Size of the first layer in the (complete) tree we need to compute; just above the leaves */
  size_t layerSize = PICNIC_NUM_ROUNDS/2;     /* Actual number of nodes in the layer, since the tree is not complete */
  int layerStartIdx = layerSizeFull - 1;      /* Index of the first node in the layer, using the array representation of Picnic */

  while(layerSizeFull > 0) {
    size_t hasOdd = (layerSizePrevious % 2) ? 1 : 0;
    for(size_t i = 0; i < layerSize; i++) {
      size_t nodeIdx = layerStartIdx + i;
      if((i == layerSize - 1) && hasOdd) {   /* Handle the last node that has one child */
        hashMerkleNode(tmp[i], leafData[2*i], zeroBuf, salt, nodeIdx);      
      }
      else {
        hashMerkleNode(tmp[i], leafData[2*i], leafData[2*i+1], salt, nodeIdx);
      }
      copyIfRevealed(revealed, revealedSize, tmp[i], nodeIdx, output);
    }

    layerSizePrevious = layerSize;
    layerSizeFull = layerSizeFull/2;
    layerSize = (layerSize+1)/2;    // == ceil(layersize/2)
    layerStartIdx = layerSizeFull - 1;
    leafData = tmp;  // After the first layer (leafData -> tmp), we're computing in-place (tmp->tmp)
  }

}
