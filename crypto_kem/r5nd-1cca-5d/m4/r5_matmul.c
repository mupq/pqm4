//  r5_matmul.c
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

#include "r5_parameter_sets.h"

#if (PARAMS_N == 1)

#include <string.h>

#include "r5_matmul.h"
#include "r5_xof.h"
#include "r5_addsub.h"
#include "little_endian.h"

// U = A_T * R

void r5_matmul_ra_q(modq_t d[PARAMS_M_BAR][PARAMS_D],
    modq_t a[PARAM_TAU2_A_RANDOM + PARAMS_D],
    uint16_t a_perm[PARAMS_D],
    uint16_t r_t[PARAMS_M_BAR][PARAMS_H / 2][2])
{
    size_t i, l;

    // Initialize result
    memset(d, 0, PARAMS_M_BAR * PARAMS_D * sizeof (modq_t));

    for (l = 0; l < PARAMS_M_BAR; l++) {
        for (i = 0; i < (PARAMS_H / 2) - 2; i += 3) {
            r5_modq_addsub3_d(d[l],
                &a[a_perm[r_t[l][i][0]]], &a[a_perm[r_t[l][i][1]]],
                &a[a_perm[r_t[l][i + 1][0]]], &a[a_perm[r_t[l][i + 1][1]]],
                &a[a_perm[r_t[l][i + 2][0]]], &a[a_perm[r_t[l][i + 2][1]]]);
        }
        while (i < PARAMS_H / 2) {
            r5_modq_addsub_d(d[l],
                &a[a_perm[r_t[l][i][0]]], &a[a_perm[r_t[l][i][1]]]);
            i++;
        }
    }
}

// B = A * S

void r5_matmul_as_q(modq_t d[PARAMS_D][PARAMS_N_BAR],
    modq_t a[PARAM_TAU2_A_RANDOM + PARAMS_D],
    uint16_t a_perm[PARAMS_D],
    uint16_t s_t[PARAMS_N_BAR][PARAMS_H / 2][2])
{
    size_t i, l;

    memset(d, 0, PARAMS_N_BAR * PARAMS_D * sizeof (modq_t));

    for (l = 0; l < PARAMS_N_BAR; l++) {
        for (i = 0; i < PARAMS_H / 2 - 2; i += 3) {
            r5_modq_addsub3_perm_nbar_d(&d[0][l], a_perm,
                &a[s_t[l][i][0]], &a[s_t[l][i][1]],
                &a[s_t[l][i + 1][0]], &a[s_t[l][i + 1][1]],
                &a[s_t[l][i + 2][0]], &a[s_t[l][i + 2][1]]);
        }
        while (i < PARAMS_H / 2) {
            r5_modq_addsub_perm_nbar_d(&d[0][l], a_perm,
                &a[s_t[l][i][0]], &a[s_t[l][i][1]]);
            i++;
        }
    }
}

// X' = S_T * U

void r5_matmul_us_p(modp_t d[PARAMS_MU],
    modp_t u_t[PARAMS_M_BAR][PARAMS_D],
    uint16_t s_t[PARAMS_N_BAR][PARAMS_H / 2][2])
{
    size_t i, j, k, idx;
    modp_t t;

    idx = 0;
    for (i = 0; i < PARAMS_N_BAR && idx < PARAMS_MU; i++) {
        for (j = 0; j < PARAMS_M_BAR && idx < PARAMS_MU; j++) {
            t = 0;
            for (k = 0; k < PARAMS_H / 2; k++) {
                t += u_t[j][s_t[i][k][0]] - u_t[j][s_t[i][k][1]];
            }
            d[idx++] = t;
        }
    }
}

// X = B_T * R

void r5_matmul_rb_p(modp_t d[PARAMS_MU],
    modp_t b[PARAMS_D][PARAMS_N_BAR],
    uint16_t r_t[PARAMS_M_BAR][PARAMS_H / 2][2])
{
    size_t i, j, l, idx;
    modp_t t;

    idx = 0;
    for (l = 0; l < PARAMS_N_BAR && idx < PARAMS_MU; l++) {
        for (j = 0; j < PARAMS_M_BAR && idx < PARAMS_MU; j++) {
            t = 0;
            for (i = 0; i < PARAMS_H / 2; i++) {
                t += b[r_t[j][i][0]][l] - b[r_t[j][i][1]][l];
            }
            d[idx++] = t;
        }
    }
}

#endif

