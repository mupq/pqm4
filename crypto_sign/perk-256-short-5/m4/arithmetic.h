
/**
 * @file arithmetic.h
 * @brief Header file for arithmetic.c
 */

#ifndef SIG_PERK_ARITHMETIC_H
#define SIG_PERK_ARITHMETIC_H

#include <stdint.h>
#include "parameters.h"
#include "symmetric.h"

#define SHBIT16 25
#define SHBIT32 41

/**
 * @brief Vector vect1_t
 *
 * This structure contains a vector of size PARAM_N1
 */
typedef uint16_t vect1_t[PARAM_N1];

/**
 * @brief Vector vect2_t
 *
 * This structure contains a vector of size PARAM_M
 */
typedef uint16_t vect2_t[PARAM_M];

/**
 * @brief Matrix mat_t
 *
 * This structure contains a matrix represented as a vector of vectors of type vect1_t
 */
typedef vect1_t mat_t[PARAM_M];

/**
 * @brief perform barrett reduction on a 16 bit input value
 *        output range 0 <= out < PARAM_Q
 *        input range:
 *            - PARAM_Q == 1021: 0 <= a <= 65535 (0xFFFF)
 *
 * @param a 16 bit input
 * @return uint16_t output
 */
static inline uint16_t sig_perk_barrett_reduce16(uint16_t a) {
    uint16_t t;
    const uint32_t v = ((((uint32_t)1U << SHBIT16) / PARAM_Q));

    t = ((v * a + v) >> SHBIT16);  // NOLINT(hicpp-signed-bitwise): tested in unit tests
    t *= PARAM_Q;
    return (uint16_t)(a - t);
}

/**
 * @brief perform barrett reduction on a 32 bit input value
 *        output range 0 <= out < PARAM_Q
 *        input range:
 *            - PARAM_Q == 1021: 0 <= a <= 4294967295 (0xFFFFFFFF)
 *
 * @param a 32 bit input value
 * @return uint16_t output
 */
static inline uint16_t sig_perk_barrett_reduce32(uint32_t a) {
    uint32_t t;
    const uint64_t v = (((uint64_t)1U << SHBIT32) / PARAM_Q);

    t = ((v * a + v) >> SHBIT32);  // NOLINT(hicpp-signed-bitwise): tested in unit tests
    t *= PARAM_Q;
    return (uint16_t)(a - t);
}

/**
 * @brief Add in Fq two vect1_t vectors
 *
 * @details The prototype of this function differs from the others in this file due to
 *          a false positive warning with GCC 13 (-Wstringop-overflow) when compiling with -O3.
 *
 * @param [out] o a vector containing the result
 * @param [in] v1 a vector
 * @param [in] v2 a vector
 */
void sig_perk_vect1_add(uint16_t *o, const uint16_t *v1, const uint16_t *v2);

/**
 * @brief Multiplication in Fq of a vect1_t vector by a scalar
 *
 * @param [out] output vector containing the result
 * @param [in] scalar a scalar in Fq
 * @param [in] input a vector of type vect1_t
 */
void sig_perk_vect1_mult_scalar_vect(vect1_t output, const uint16_t scalar, const vect1_t input);

/**
 * @brief Given a list of PARAM_T vectors vect1_t, compute the rank of the matrix
 * formed by these. Used to test the linear dependence.
 *
 * @param [in] x list of vectors to be seen as a matrix
 * @returns the rank of the matrix
 */
int sig_perk_vect1_compute_rank(vect1_t x[PARAM_T]);

/**
 * @brief Sample uniformly at random a list of PARAM_T vect1_t vectors in Fq
 *
 * @param [out] output an array of vectors vect1_t containing the result
 * @param [out,in] prg PRG state to squeeze
 */
void sig_perk_vect1_set_random_list(vect1_t output[PARAM_T], sig_perk_prg_state_t *prg);

/**
 * @brief Add in Fq two vect2_t vectors
 *
 * @param [out] o a vector containing the result
 * @param [in] v1 a vector
 * @param [in] v2 a vector
 */
void sig_perk_vect2_add(vect2_t o, const vect2_t v1, const vect2_t v2);

/**
 * @brief Subtract in Fq two vect2_t vectors
 *
 * @param [out] o vector containing the result
 * @param [in] v1 vector
 * @param [in] v2 vector
 */
void sig_perk_vect2_sub(vect2_t o, const vect2_t v1, const vect2_t v2);

/**
 * @brief Multiplication in Fq of a vect2_t vector by a scalar
 *
 * @param [out] output vector containing the result
 * @param [in] scalar a scalar in Fq
 * @param [in] input a vector of type vect2_t
 */
void sig_perk_vect2_mult_scalar_vect(vect2_t output, const uint16_t scalar, const vect2_t input);

/**
 * @brief Generate a (PARAM_M x PARAM_N1) random matrix in Fq
 *
 * @param [out] m_output a matrix
 * @param [out,in] prg PRG state to squeeze
 */
void sig_perk_mat_set_random(mat_t m_output, sig_perk_prg_state_t *prg);

/**
 * @brief Compute a matrix vector multiplication in Fq
 *
 * @param [out] output a vector
 * @param [in] m_input a matrix
 * @param [in] v_input a vector
 */
void sig_perk_mat_vect_mul(vect2_t output, const mat_t m_input, const vect1_t v_input);

#endif