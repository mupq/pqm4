
/**
 * @file verbose.h
 * @brief Header file verbose.c
 */

#ifndef SIG_PERK_VERBOSE_H
#define SIG_PERK_VERBOSE_H

#include <stdint.h>
#include "arithmetic.h"
#include "data_structures.h"
#include "signature.h"

/**
 * @brief Print a string
 *
 * @param [in] var a string containing the characters to print
 */
void sig_perk_verbose_print_string(const char *var);

/**
 * @brief Print in hexadecimal format a given number of bytes
 *
 * @param [in] var a string containing the name of the variable to be printed
 * @param [in] input a string containing the data to be printed
 * @param [in] size an integer that is the number of bytes to be printed
 */
void sig_perk_verbose_print_uint8_t_array(const char *var, const uint8_t *input, uint16_t size);

/**
 * @brief Print in decimal format a given number of bytes
 *
 * @param [in] var a string containing the name of the variable to be printed
 * @param [in] input a string containing the data to be printed
 * @param [in] size an integer that is the number of bytes to be printed
 */
void sig_perk_verbose_print_uint16_t_array(const char *var, const uint16_t *input, uint16_t size);

/**
 * @brief Print the public key x_i
 *
 * @param [in] x an array of vectors vect2_t x_i with i in 0 .. PARAM_T - 1
 */
void sig_perk_verbose_print_x(const vect1_t x[PARAM_T]);

/**
 * @brief Print the public key y_i
 *
 * @param [in] y an array of vectors vect2_t y_i with i in 0 .. PARAM_T - 1
 */
void sig_perk_verbose_print_y(const vect2_t y[PARAM_T]);

/**
 * @brief Print the values of the matrix H
 *
 * @param [in] m_input a matrix
 */
void sig_perk_verbose_print_matrix(const mat_t m_input);

/**
 * @brief Print the root randomness theta, commitment cmt_1 and vector v
 *
 * @param [in] theta a variable containing the seed theta
 * @param [in] input a commitment
 * @param [in] v a vector
 * @param [in] round_number an integer containing the round number
 */
void sig_perk_verbose_print_theta_cmt_1_and_v(theta_t theta, cmt_t input, vect1_t v, uint16_t round_number);

/**
 * @brief Print the challenges
 *
 * @param [in] challenges a pointer to the challenges
 */
void sig_perk_verbose_print_challenges(challenge_t *challenges);

/**
 * @brief Print the signature
 *
 * @param [in] signature a pointer to the signature
 */
void sig_perk_verbose_print_signature(const perk_signature_t *signature);

/**
 * @brief Print the seeds thetas in all rounds
 *
 * @param [in] instances a pointer to the instances of the signature
 */
void sig_perk_verbose_print_thetas(perk_instance_t *instances);

/**
 * @brief Print a message and a signature
 *
 * @param [in] m a string containing a message
 * @param [in] mlen an integer that is the size of a message
 * @param [in] signature a string containing a signature
 */
void sig_perk_verbose_print_signature_raw(const uint8_t *m, uint64_t mlen, const uint8_t *signature);

#ifdef VERBOSE
#define SIG_PERK_VERBOSE_PRINT_string(var)                      sig_perk_verbose_print_string(var)
#define SIG_PERK_VERBOSE_PRINT_uint8_t_array(var, input, size)  sig_perk_verbose_print_uint8_t_array(var, input, size)
#define SIG_PERK_VERBOSE_PRINT_uint16_t_array(var, input, size) sig_perk_verbose_print_uint16_t_array(var, input, size)
#define SIG_PERK_VERBOSE_PRINT_x(x)                             sig_perk_verbose_print_x(x)
#define SIG_PERK_VERBOSE_PRINT_y(y)                             sig_perk_verbose_print_y(y)
#define SIG_PERK_VERBOSE_PRINT_matrix(m_input)                  sig_perk_verbose_print_matrix(m_input)
#define SIG_PERK_VERBOSE_PRINT_theta_cmt_1_and_v(theta, input, v, round_number) \
    sig_perk_verbose_print_theta_cmt_1_and_v(theta, input, v, round_number)
#define SIG_PERK_VERBOSE_PRINT_challenges(challenges) sig_perk_verbose_print_challenges(challenges)
#define SIG_PERK_VERBOSE_PRINT_signature(signature)   sig_perk_verbose_print_signature(signature)
#define SIG_PERK_VERBOSE_PRINT_thetas(instances)      sig_perk_verbose_print_thetas(instances)
#define SIG_PERK_VERBOSE_PRINT_signature_raw(m, mlen, signature) \
    sig_perk_verbose_print_signature_raw(m, mlen, signature)
#else
#define SIG_PERK_VERBOSE_PRINT_string(var)
#define SIG_PERK_VERBOSE_PRINT_uint8_t_array(var, input, size)
#define SIG_PERK_VERBOSE_PRINT_uint16_t_array(var, input, size)
#define SIG_PERK_VERBOSE_PRINT_x(x)
#define SIG_PERK_VERBOSE_PRINT_y(y)
#define SIG_PERK_VERBOSE_PRINT_matrix(m_input)
#define SIG_PERK_VERBOSE_PRINT_theta_cmt_1_and_v(theta, input, v, round_number)
#define SIG_PERK_VERBOSE_PRINT_challenges(challenges)
#define SIG_PERK_VERBOSE_PRINT_signature(signature)
#define SIG_PERK_VERBOSE_PRINT_thetas(instances)
#define SIG_PERK_VERBOSE_PRINT_signature_raw(m, mlen, signature)
#endif

#endif