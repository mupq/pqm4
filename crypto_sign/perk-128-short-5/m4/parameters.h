
/**
 * @file parameters.h
 * @brief Parameters of the PERK scheme
 */

#ifndef SIG_PERK_PARAMETER_H
#define SIG_PERK_PARAMETER_H

#define SECURITY_BYTES 16 /**< Number of bytes for the expected security level */
#define PARAM_N1       83 /**< Parameter n of the scheme */
#define PARAM_M        36 /**< Parameter m of the scheme */
#define PARAM_T        5  /**< Parameter t of the scheme */
#define PARAM_TAU      18 /**< Parameter tau of the scheme */

#define PARAM_N           256 /**< Parameter N of the scheme */
#define THETA_TREE_LEVELS 8   /**< The number of levels of the theta tree i.e log2(PARAM_N) */

#define PARAM_Q      1021 /**< Parameter q of the scheme */
#define PARAM_Q_BITS 10   /**< Number of bits needed to represent PARAM_Q */

#define PARAM_N_MASK ((1U << THETA_TREE_LEVELS) - 1) /**< Mask for bits representing PARAM_N */
#define PARAM_Q_MASK ((1U << PARAM_Q_BITS) - 1)      /**< Mask for bits representing PARAM_Q */

#define PARAM_RANK_UNRANK_K         7   /**< Parameter for rank/unrank compression - log2(PARAM_N1) */
#define PARAM_PERM_COMPRESSION_BITS 414 /**< Bits needed for Lehemr compression - log2(PARAM_N1!)  */
#define PARAM_PERM_COMPRESSION_BYTES \
    (((PARAM_PERM_COMPRESSION_BITS - 1) / 8) + 1) /**< Bytes needed for Lehemr compression */

#define SEED_BYTES       SECURITY_BYTES       /**< Seed size used in the scheme */
#define SALT_BYTES       (2 * SECURITY_BYTES) /**< Salt size used in the scheme */
#define HASH_BYTES       (2 * SECURITY_BYTES) /**< Hash size used in the scheme */
#define COMMITMENT_BYTES HASH_BYTES           /**< Commitment size used in the scheme */

#define PUBLIC_KEY_BYTES  (SEED_BYTES + ((PARAM_M * PARAM_Q_BITS * PARAM_T + 7) / 8)) /**< Public key size */
#define PRIVATE_KEY_BYTES (SEED_BYTES + PUBLIC_KEY_BYTES)                             /**< Private key size */

#define SIGNATURE_BYTES                                                                                      \
    (SALT_BYTES + (2 * COMMITMENT_BYTES) + (COMMITMENT_BYTES + SEED_BYTES * THETA_TREE_LEVELS) * PARAM_TAU + \
     ((PARAM_TAU * PARAM_N1 * PARAM_Q_BITS + 7) / 8) +                                                       \
     (PARAM_PERM_COMPRESSION_BYTES * PARAM_TAU)) /**< Signature size */

#define EXIT_FAILURE 1 /**< Exit code in case of failure */
#define EXIT_SUCCESS 0 /**< Exit code in case of success */

#endif  // SIG_PERK_PARAMETER_H
