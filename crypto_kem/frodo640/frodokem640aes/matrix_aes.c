/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: matrix arithmetic functions used by the KEM
*********************************************************************************************/

#include <stdint.h>
#include <string.h>

#include "aes-publicinputs.h"

#include "api.h"
#include "common.h"
#include "params.h"

extern uint16_t xs(const uint16_t *s, const int16_t *a_row);
int mul_add_as_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A) {
    // Generate-and-multiply: generate matrix A (N x N) row-wise, multiply by s on the right.
    // Inputs: s, e (N x N_BAR)
    // Output: out = A*s + e (N x N_BAR)
    int k;
    uint16_t i, j;
    int16_t a_row[4 * PARAMS_N];
    int16_t a_row_temp[4 * PARAMS_N] = {0};                     // Take four lines of A at once
    aes128ctx_publicinputs ctx128;

    aes128_ecb_keyexp_publicinputs(&ctx128, seed_A);

    for (j = 0; j < PARAMS_N; j += PARAMS_STRIPE_STEP) {
        a_row_temp[j + 1 + 0 * PARAMS_N] = UINT16_TO_LE(j);     // Loading values in the little-endian order
        a_row_temp[j + 1 + 1 * PARAMS_N] = UINT16_TO_LE(j);
        a_row_temp[j + 1 + 2 * PARAMS_N] = UINT16_TO_LE(j);
        a_row_temp[j + 1 + 3 * PARAMS_N] = UINT16_TO_LE(j);
    }

    for (i = 0; i < PARAMS_N; i += 4) {
        for (j = 0; j < PARAMS_N; j += PARAMS_STRIPE_STEP) {    // Go through A, four rows at a time
            a_row_temp[j + 0 * PARAMS_N] = UINT16_TO_LE(i + 0); // Loading values in the little-endian order
            a_row_temp[j + 1 * PARAMS_N] = UINT16_TO_LE(i + 1);
            a_row_temp[j + 2 * PARAMS_N] = UINT16_TO_LE(i + 2);
            a_row_temp[j + 3 * PARAMS_N] = UINT16_TO_LE(i + 3);
        }
        aes128_ecb_publicinputs((uint8_t *)a_row, (uint8_t *)a_row_temp, 4 * PARAMS_N * sizeof(int16_t) / AES_BLOCKBYTES, &ctx128);
        for (k = 0; k < 4 * PARAMS_N; k++) {
            a_row[k] = LE_TO_UINT16(a_row[k]);
        }
        for (k = 0; k < PARAMS_NBAR; k++) {
            out[k + (i + 0)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 0*PARAMS_N);
            out[k + (i + 1)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 1*PARAMS_N);
            out[k + (i + 2)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 2*PARAMS_N);
            out[k + (i + 3)*PARAMS_NBAR] += xs(s + k*PARAMS_N,a_row + 3*PARAMS_N);
        }
    }
    return 1;
}


extern void sa(uint16_t *out,  const uint16_t *s, const uint16_t *a);
int mul_add_sa_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A)
{ // Generate-and-multiply: generate matrix A (N x N) column-wise, multiply by s' on the left.
  // Inputs: s', e' (N_BAR x N)
  // Output: out = s'*A + e' (N_BAR x N)

    int i, j, kk;

    uint16_t a_cols[PARAMS_N*PARAMS_STRIPE_STEP] = {0};
    uint16_t a_cols_temp[PARAMS_N*PARAMS_STRIPE_STEP] = {0};

    aes128ctx_publicinputs roundkeys;
    aes128_ecb_keyexp_publicinputs(&roundkeys, seed_A);

    for (i = 0, j = 0; i < PARAMS_N; i++, j += PARAMS_STRIPE_STEP) {
        a_cols_temp[j] = i; // Loading values in the little-endian order
    }

    for (kk = 0; kk < PARAMS_N; kk += PARAMS_STRIPE_STEP) {
        for (i = 0; i < (PARAMS_N*PARAMS_STRIPE_STEP); i += PARAMS_STRIPE_STEP) {
            a_cols_temp[i + 1] = kk; // Loading values in the little-endian order
        }

        aes128_ecb_publicinputs((unsigned char *)a_cols, (unsigned char *)a_cols_temp, PARAMS_N*PARAMS_STRIPE_STEP*sizeof(int16_t) / AES_BLOCKBYTES, &roundkeys);
        for (i = 0; i < PARAMS_N; i += 8) {
            for (j = 0; j < PARAMS_STRIPE_STEP; j++) {
                sa(out+kk+j, s+i, a_cols+i*PARAMS_STRIPE_STEP+j);
            }
        }
    }
    return 1;
}
