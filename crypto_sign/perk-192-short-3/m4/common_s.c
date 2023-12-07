
/**
 * @file common_s.c
 * @brief Streamlined common functions
 */

#include "common.h"
#include "djbsort.h"
#include "permutation.h"
#include "symmetric.h"

int sig_perk_perm_gen_given_random_input_and_compose(perm_t pi_comp, perm_t p, const uint16_t rnd_buff[PARAM_N1]) {
    uint32_t buffer[PARAM_N1];
    // Use 16 bits for randomness
    for (int i = 0; i < PARAM_N1; i++) {
        buffer[i] = (((uint32_t)rnd_buff[i]) << 16) | pi_comp[i] << 8U | i;
    }
    // sort
    uint32_sort(buffer, PARAM_N1);
    // check that no double random values were produced
    for (int i = 1; i < PARAM_N1; i++) {
        if ((buffer[i - 1] >> 16) == (buffer[i] >> 16)) {
            return EXIT_FAILURE;
        }
    }
    // extract permutation from buffer
    for (int i = 0; i < PARAM_N1; i++) {
        p[i] = (uint8_t)(0xFF & buffer[i]);
        pi_comp[i] = (uint8_t)((0xFF00 & buffer[i]) >> 8U);
    }
    return EXIT_SUCCESS;
}

void sig_perk_gen_one_pi_i_and_compose(perm_t pi_comp, perm_t pi_i, const salt_t salt,
                                       uint16_t rnd_buffer_pi_i[PARAM_N1], sig_perk_prg_state_t *state,
                                       const theta_t theta) {
    sig_perk_prg_init(state, PRG1, salt, theta);
    sig_perk_prg(state, (uint8_t *)rnd_buffer_pi_i, PARAM_N1 * sizeof(uint16_t));
    while (sig_perk_perm_gen_given_random_input_and_compose(pi_comp, pi_i, rnd_buffer_pi_i) != EXIT_SUCCESS) {
        sig_perk_prg(state, (uint8_t *)rnd_buffer_pi_i, PARAM_N1 * sizeof(uint16_t));
    }
}
