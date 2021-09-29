
#ifndef PICNIC_PARAMS_H
#define PICNIC_PARAMS_H

#define PICNIC_SALT_SIZE 32
#define PICNIC_DIGEST_SIZE 32
#define PICNIC_SEED_SIZE 16
#define PICNIC_NUM_ROUNDS 250
#define PICNIC_NUM_ROUNDS_LOG2 8
#define PICNIC_NUM_OPENED_ROUNDS 36
#define PICNIC_NUM_PARTIES 16
#define PICNIC_NUM_PARTIES_LOG2 4
#define PICNIC_INPUT_SIZE 17
#define PICNIC_OUTPUT_SIZE 17
#define PICNIC_VIEW_SIZE 65
#define PICNIC_TAPE_SIZE (2 * PICNIC_VIEW_SIZE)
#define PICNIC_AUX_SIZE PICNIC_VIEW_SIZE
#define PICNIC_ROUND_TREE_NUM_NODES 505
#define PICNIC_ROUND_TREE_MAX_REVEALED_NODES (PICNIC_NUM_OPENED_ROUNDS * 3) // tau * log(M/tau)
#define PICNIC_PARTY_TREE_NUM_NODES 31
// at most log(depth) seeds needed to reveal all but one party
#define PICNIC_PARTY_TREE_MAX_REVEALED_NODES (PICNIC_NUM_PARTIES_LOG2)
#define LOWMC_N 129
#define LOWMC_M 43
#define LOWMC_K LOWMC_N
#define LOWMC_R 4

/* Prefix values for domain separation */
static const uint8_t HASH_PREFIX_0 = 0;
static const uint8_t HASH_PREFIX_1 = 1;
static const uint8_t HASH_PREFIX_2 = 2;
static const uint8_t HASH_PREFIX_3 = 3;
static const uint8_t HASH_PREFIX_4 = 4;
static const uint8_t HASH_PREFIX_5 = 5;
#endif