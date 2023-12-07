
/**
 * @file arithmetic.c
 * @brief Implementation of arithmetic related functions
 */

#include "arithmetic.h"
#include <stdint.h>
#include <string.h>
#include "permutation.h"
#include "symmetric.h"

static inline int16_t caddq(int16_t a) {
    a += (a >> 15U) & PARAM_Q;  // NOLINT(hicpp-signed-bitwise): behavior tested in unit tests
    return a;
}

static uint16_t multiplicativeInverse(uint16_t a) {
    // assume a != 0
    // compute a^(q-2) mod q
    uint16_t result = 1;
    uint16_t exponent = PARAM_Q - 2;

    while (exponent > 0) {
        if ((exponent & 0x1) == 1) {
            result = sig_perk_barrett_reduce32((uint32_t)result * (uint32_t)a);
        }
        a = sig_perk_barrett_reduce32((uint32_t)a * (uint32_t)a);
        exponent >>= 1;
    }

    return result;
}

int sig_perk_vect1_compute_rank(vect1_t in[PARAM_T]) {
    int rank = 0;
    int row, col;

    vect1_t x[PARAM_T];
    memcpy(x, in, sizeof(vect1_t) * PARAM_T);
    for (col = 0; col < PARAM_N1; col++) {
        int pivot_found = 0;

        // Find a non-zero pivot in the current column
        for (int i = rank; i < PARAM_T; i++) {
            if (x[i][col] != 0) {
                row = i;
                pivot_found = 1;
                break;
            }
        }

        if (pivot_found) {
            // Swap the current row with the row containing the pivot
            for (int i = 0; i < PARAM_N1; i++) {
                int temp = x[rank][i];
                x[rank][i] = x[row][i];
                x[row][i] = temp;
            }

            // Perform row operations to eliminate entries below the pivot
            for (row = rank + 1; row < PARAM_T; row++) {
                uint16_t multiplier =
                    sig_perk_barrett_reduce32((uint32_t)x[row][col] * (uint32_t)multiplicativeInverse(x[rank][col]));
                for (int i = col; i < PARAM_N1; i++) {
                    x[row][i] -= sig_perk_barrett_reduce32((uint32_t)multiplier * (uint32_t)x[rank][i]);
                }
            }
            rank++;
        }
        if (rank == PARAM_T)
            break;
    }
    return rank;
}

void sig_perk_vect1_add(uint16_t *o, const uint16_t *v1, const uint16_t *v2) {
    for (uint16_t i = 0; i < PARAM_N1; ++i) {
        // we assume v1 and v2 already reduced
        o[i] = caddq((int16_t)((int16_t)v1[i] + (int16_t)v2[i] - PARAM_Q));
    }
}

void sig_perk_vect1_mult_scalar_vect(vect1_t output, const uint16_t scalar, const vect1_t input) {
    for (uint16_t i = 0; i < PARAM_N1; ++i) {
        output[i] = sig_perk_barrett_reduce32((uint32_t)scalar * (uint32_t)input[i]);
    }
}

void sig_perk_vect1_set_random_list(vect1_t output[PARAM_T], sig_perk_prg_state_t *prg) {
    uint16_t rnd_buff[PRNG_BLOCK_SIZE / 2];
    // generate randomness
    int i = 0, rank;
    do {
        while (i < PARAM_N1 * PARAM_T) {
            int j = 0;
            sig_perk_prg(prg, (uint8_t *)rnd_buff, sizeof(rnd_buff));
            while ((i < PARAM_N1 * PARAM_T) && (j < PRNG_BLOCK_SIZE / 2)) {
                output[i / PARAM_N1][i % PARAM_N1] = PARAM_Q_MASK & rnd_buff[j++];
                if (output[i / PARAM_N1][i % PARAM_N1] < PARAM_Q) {  // accept the sample
                    i++;
                }
            }
        }
        // make sure the vectors x are linearly independent
        rank = sig_perk_vect1_compute_rank(output);
    } while (rank != PARAM_T);
}

void sig_perk_vect2_add(vect2_t o, const vect2_t v1, const vect2_t v2) {
    for (uint16_t i = 0; i < PARAM_M; ++i) {
        // we assume v1 and v2 already reduced
        o[i] = caddq((int16_t)((int16_t)v1[i] + (int16_t)v2[i] - PARAM_Q));
    }
}

void sig_perk_vect2_sub(vect2_t o, const vect2_t v1, const vect2_t v2) {
    for (uint16_t i = 0; i < PARAM_M; ++i) {
        o[i] = caddq((int16_t)((int16_t)v1[i] - (int16_t)v2[i]));
    }
}

void sig_perk_vect2_mult_scalar_vect(vect2_t output, const uint16_t scalar, const vect2_t input) {
    for (uint16_t i = 0; i < PARAM_M; ++i) {
        output[i] = sig_perk_barrett_reduce32((uint32_t)scalar * (uint32_t)input[i]);
    }
}

void sig_perk_mat_set_random(mat_t m_output, sig_perk_prg_state_t *prg) {
    uint16_t rnd_buff[PRNG_BLOCK_SIZE / 2];
    // generate randomness
    int j = 0;
    while (j < PARAM_M * PARAM_N1) {
        int k = 0;
        sig_perk_prg(prg, (uint8_t *)rnd_buff, sizeof(rnd_buff));
        while ((j < PARAM_M * PARAM_N1) && (k < PRNG_BLOCK_SIZE / 2)) {
            m_output[j / PARAM_N1][j % PARAM_N1] = PARAM_Q_MASK & rnd_buff[k++];
            if (m_output[j / PARAM_N1][j % PARAM_N1] < PARAM_Q) {  // accept the sample
                j++;
            }
        }
    }
}

void sig_perk_mat_vect_mul(vect2_t output, const mat_t m_input, const vect1_t v_input) {
    uint32_t tmp = 0;
    for (int i = 0; i < PARAM_M; ++i) {
        for (int j = 0; j < PARAM_N1; ++j) {
            tmp += ((uint32_t)m_input[i][j]) * ((uint32_t)v_input[j]);
        }
        output[i] = sig_perk_barrett_reduce32(tmp);
        tmp = 0;
    }
}