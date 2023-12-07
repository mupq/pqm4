
/**
 * @file data_structures.h
 * @brief common data structures for the scheme
 */

#ifndef SIG_PERK_DATA_STRUCTURES_H
#define SIG_PERK_DATA_STRUCTURES_H

#include <stdint.h>
#include "arithmetic.h"
#include "parameters.h"
#include "permutation.h"
#include "symmetric.h"
#include "theta_tree.h"

/**
 * @brief Commitment cmt_t
 *
 * This structure contains a commitment
 */
typedef uint8_t cmt_t[COMMITMENT_BYTES];

/** @struct perk_public_key_t
 *  @brief This structure contains the public key
 *  @var perk_public_key_t::seed
 *  Member 'seed' is an array of bytes used to generate the public key
 *  @var perk_public_key_t::H
 *  Member 'H' is a matrix
 *  @var perk_public_key_t::x
 *  Member 'x' is a vector of vectors
 *  @var perk_public_key_t::y
 *  Member 'y' is a vector of vectors
 */
typedef struct {
    uint8_t seed[SEED_BYTES];
    mat_t H;
    vect1_t x[PARAM_T];
    vect2_t y[PARAM_T];
} perk_public_key_t;

/** @struct perk_private_key_t
 *  @brief This structure contains the private key
 *  @var perk_private_key_t::seed
 *  Member 'seed' is an array of bytes used to generate the private key
 *  @var perk_private_key_t::pi
 *  Member 'pi' is a permutation
 *  @var perk_private_key_t::pk_bytes
 *  Member 'pk_bytes' is an array of bytes that contain the public key
 */
typedef struct {
    uint8_t seed[SEED_BYTES];
    perm_t pi;
    uint8_t pk_bytes[PUBLIC_KEY_BYTES];
} perk_private_key_t;

/** @struct perk_instance_t
 *  @brief This structure contains an instance of one round of the scheme
 *  @var perk_instance_t::theta_tree
 *  Member 'theta_tree' is a seed tree containing theta and the theta_i
 *  @var perk_instance_t::pi_i
 *  Member 'pi_i' is a permutation
 *  @var perk_instance_t::v_i
 *  Member 'v_i' is a pointer to the second element of the s_i array. v_i shares the memory with s_i
 *  @var perk_instance_t::s_i
 *  Member 's_i' is an array of vectors
 *  @var perk_instance_t::cmt_1_i
 *  Member 'cmt_1_i' is an array of commitments. Commitments are stored in reverse order: from element (PARAM_N-1) down
 *  to element 0.
 *  @var perk_instance_t::cmt_1
 *  Member 'cmt_1' is a commitment
 */
typedef struct {
    perk_theta_seeds_tree_t theta_tree;
    perm_t pi_i[PARAM_N];
    // v_i shares the same memory with s_i. The pointer must be initialized to s_i + 1;
    vect1_t *v_i;
    vect1_t s_i[PARAM_N + 1];
    cmt_t cmt_1_i[PARAM_N];
    cmt_t cmt_1;
} perk_instance_t;

/**
 * @brief initialize an array of "perk_instance_t" elements
 *
 * @param [out,in] instances array of perk_instance_t elements
 * @param [in]     elements number of elements to be initialized
 */
static inline void perk_instance_t_array_init(perk_instance_t *instances, const int elements) {
    for (int i = 0; i < elements; i++) {
        instances[i].v_i = &(instances[i].s_i[1]);
    }
}

/** @struct perk_response_t
 *  @brief This structure contains the response
 *  @var perk_response_t::z1
 *  Member 'z1' is a vector
 *  @var perk_response_t::z2_pi
 *  Member 'z2_pi' is a permutation
 *  @var perk_response_t::z2_theta
 *  Member 'z2_theta' is an array of theta_t
 *  @var perk_response_t::cmt_1_alpha
 *  Member 'cmt_1_alpha' is commitment
 */
typedef struct {
    vect1_t z1;
    perm_t z2_pi;
    theta_t z2_theta[THETA_TREE_LEVELS];
    cmt_t cmt_1_alpha;
} perk_response_t;

/** @struct perk_signature_t
 *  @brief This structure contains the signature
 *  @var perk_signature_t::salt
 *  Member 'salt' is a salt
 *  @var perk_signature_t::h1
 *  Member 'h1' is a digest
 *  @var perk_signature_t::h2
 *  Member 'h2' is a digest
 *  @var perk_signature_t::responses
 *  Member 'responses' is an array of perk_response_t
 */
typedef struct {
    salt_t salt;
    digest_t h1;
    digest_t h2;
    perk_response_t responses[PARAM_TAU];
} perk_signature_t;

#endif