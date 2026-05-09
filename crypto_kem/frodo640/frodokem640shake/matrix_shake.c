/********************************************************************************************
* FrodoKEM: Learning with Errors Key Encapsulation
*
* Abstract: matrix arithmetic functions used by the KEM
*********************************************************************************************/

#include <stdint.h>
#include <string.h>

#include "fips202.h"

#include "api.h"
#include "common.h"
#include "params.h"

extern uint16_t xs(const uint16_t *s, const int16_t *a_row);
int mul_add_as_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A) {
    // Generate-and-multiply: generate matrix A (N x N) row-wise, multiply by s on the right.
    // Inputs: s, e (N x N_BAR)
    // Output: out = A*s + e (N x N_BAR)
    int k;
    uint16_t i;
    int16_t a_row[4 * PARAMS_N];

    uint8_t seed_A_separated[2 + BYTES_SEED_A];
    uint16_t *seed_A_origin = (uint16_t *)&seed_A_separated;
    memcpy(&seed_A_separated[2], seed_A, BYTES_SEED_A);
    for (i = 0; i < PARAMS_N; i += 4) {
        seed_A_origin[0] = UINT16_TO_LE(i + 0);
        shake128((unsigned char *)(a_row + 0 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(i + 1);
        shake128((unsigned char *)(a_row + 1 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(i + 2);
        shake128((unsigned char *)(a_row + 2 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(i + 3);
        shake128((unsigned char *)(a_row + 3 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
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
int mul_add_sa_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A) {
    // Generate-and-multiply: generate matrix A (N x N) column-wise, multiply by s' on the left.
    // Inputs: s', e' (N_BAR x N)
    // Output: out = s'*A + e' (N_BAR x N)
    int i;
    uint16_t kk;
    uint16_t a_cols[8 * PARAMS_N];

    uint8_t seed_A_separated[2 + BYTES_SEED_A];
    uint16_t *seed_A_origin = (uint16_t *)&seed_A_separated;
    memcpy(&seed_A_separated[2], seed_A, BYTES_SEED_A);
    for (kk = 0; kk < PARAMS_N; kk += 8) {
        seed_A_origin[0] = UINT16_TO_LE(kk + 0);
        shake128((unsigned char *)(a_cols + 0 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(kk + 1);
        shake128((unsigned char *)(a_cols + 1 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(kk + 2);
        shake128((unsigned char *)(a_cols + 2 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(kk + 3);
        shake128((unsigned char *)(a_cols + 3 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        
        seed_A_origin[0] = UINT16_TO_LE(kk + 4);
        shake128((unsigned char *)(a_cols + 4 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(kk + 5);
        shake128((unsigned char *)(a_cols + 5 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(kk + 6);
        shake128((unsigned char *)(a_cols + 6 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);
        seed_A_origin[0] = UINT16_TO_LE(kk + 7);
        shake128((unsigned char *)(a_cols + 7 * PARAMS_N), (unsigned long long)(2 * PARAMS_N), seed_A_separated, 2 + BYTES_SEED_A);

        for (i = 0; i < PARAMS_N; i++) {
          sa(out+i, s+kk, a_cols+i);
        }
    }
    return 1;
}
