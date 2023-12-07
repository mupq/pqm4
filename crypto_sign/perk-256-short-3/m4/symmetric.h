
/**
 * @file symmetric.h
 * @brief Header file for symmetric.c
 */

#ifndef SIG_PERK_SYMMETRIC_H
#define SIG_PERK_SYMMETRIC_H

#include <stdint.h>
#include "fips202.h"
#include "parameters.h"

// domains for hash and prg
#define H0   0x00
#define H1   0x01
#define H2   0x02
#define H3   0x03
#define PRG1 0x04
#define PRG2 0x05

/**
 * @brief Salt salt_t
 *
 * This structure contains the salt
 */
typedef uint8_t salt_t[SALT_BYTES];

/**
 * @brief Digest digest_t
 *
 * This structure contains the digest
 */
typedef uint8_t digest_t[HASH_BYTES];

/**
 * @brief Seed seed_t
 *
 * This structure defines a string containing SEED_BYTES bytes
 */
typedef uint8_t seed_t[SEED_BYTES];

#if (SECURITY_BYTES == 16)
#define PRNG_BLOCK_SIZE 168  // SHAKE128 Block Size
#elif (SECURITY_BYTES == 24)
#define PRNG_BLOCK_SIZE 136  // SHAKE256 Block Size
#elif (SECURITY_BYTES == 32)
#define PRNG_BLOCK_SIZE 136  // SHAKE256 Block Size
#endif

#if (SECURITY_BYTES == 16)
#define Keccak_HashInitialize_SHAKE(state)              shake128_inc_init(state)
#define Keccak_HashUpdate_SHAKE(state, input, inlen)    shake128_inc_absorb(state, input, inlen)
#define Keccak_HashFinal_SHAKE(state)                   shake128_inc_finalize(state)
#define Keccak_HashSqueeze_SHAKE(state, output, outlen) shake128_inc_squeeze(output, outlen, state)
#define Keccak_HashInitialize_SHA3(state)               sha3_256_inc_init(state)
#define Keccak_HashUpdate_SHA3(state, input, inlen)     sha3_256_inc_absorb(state, input, inlen)
#define Keccak_HashFinal_SHA3(state, digest)            sha3_256_inc_finalize(digest, state)

typedef shake128incctx sig_perk_prg_state_t;
typedef sha3_256incctx sig_perk_hash_state_t;
#elif (SECURITY_BYTES == 24)
#define Keccak_HashInitialize_SHAKE(state)              shake256_inc_init(state)
#define Keccak_HashUpdate_SHAKE(state, input, inlen)    shake256_inc_absorb(state, input, inlen)
#define Keccak_HashFinal_SHAKE(state)                   shake256_inc_finalize(state)
#define Keccak_HashSqueeze_SHAKE(state, output, outlen) shake256_inc_squeeze(output, outlen, state)
#define Keccak_HashInitialize_SHA3(state)               sha3_384_inc_init(state)
#define Keccak_HashUpdate_SHA3(state, input, inlen)     sha3_384_inc_absorb(state, input, inlen)
#define Keccak_HashFinal_SHA3(state, digest)            sha3_384_inc_finalize(digest, state)

typedef shake256incctx sig_perk_prg_state_t;
typedef sha3_384incctx sig_perk_hash_state_t;
#elif (SECURITY_BYTES == 32)
#define Keccak_HashInitialize_SHAKE(state)              shake256_inc_init(state)
#define Keccak_HashUpdate_SHAKE(state, input, inlen)    shake256_inc_absorb(state, input, inlen)
#define Keccak_HashFinal_SHAKE(state)                   shake256_inc_finalize(state)
#define Keccak_HashSqueeze_SHAKE(state, output, outlen) shake256_inc_squeeze(output, outlen, state)
#define Keccak_HashInitialize_SHA3(state)               sha3_512_inc_init(state)
#define Keccak_HashUpdate_SHA3(state, input, inlen)     sha3_512_inc_absorb(state, input, inlen)
#define Keccak_HashFinal_SHA3(state, digest)            sha3_512_inc_finalize(digest, state)

typedef shake256incctx sig_perk_prg_state_t;
typedef sha3_512incctx sig_perk_hash_state_t;
#endif

/**
 * @brief Initialize a PRNG
 *        absorb the salt if not NULL and seed
 *
 * @param [out,in] state a pointer to the state of the PRNG
 * @param [in] domain a byte that is the domain separator.
 * @param [in] salt a string containing the salt. If Null no salt is absorbed.
 * @param [in] seed a string containing the seed. If Null no seed is absorbed.
 */
void sig_perk_prg_init(sig_perk_prg_state_t *state, const uint8_t domain, const salt_t salt, const seed_t seed);

/**
 * @brief PRNG
 *
 * @param [out,in] state a pointer to the state of the PRNG
 * @param [out] output pinter to the buffer to be filled
 * @param [in] outlen size of the output
 */
void sig_perk_prg(sig_perk_prg_state_t *state, uint8_t *output, size_t outlen);

/**
 * @brief initialize the HASH function
 *        absorb the salt and ctr if != 0
 *
 * @param [out,in] state a pointer to the state of the HASH.
 * @param [in] salt a string containing the salt.
 * @param [in] tau pointer to uint8_t absorbed after the salt. If NULL tau is not absorbed.
 * @param [in] n pointer to uint8_t absorbed after the salt. If NULL n is not absorbed.
 */
void sig_perk_hash_init(sig_perk_hash_state_t *state, const salt_t salt, const uint8_t *tau, const uint8_t *n);

/**
 * @brief HASH update
 *
 * @param [out,in] state a pointer to the state of the HASH.
 * @param [in] message message to be absorbed.
 * @param [in] message_size size of the message.
 */
void sig_perk_hash_update(sig_perk_hash_state_t *state, const uint8_t *message, const size_t message_size);

/**
 * @brief output the digest for the chosen hash function (domain)
 *
 * @param [out,in] state a pointer to the state of the HASH.
 * @param [out] digest output digest.
 * @param [in] domain domain: H0, H1 or H2.
 */
void sig_perk_hash_final(sig_perk_hash_state_t *state, digest_t digest, const uint8_t domain);

#endif