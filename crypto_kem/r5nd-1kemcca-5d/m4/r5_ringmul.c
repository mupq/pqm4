//  r5_ringmul.c
//  Copyright (c) 2019, PQShield Ltd. and Koninklijke Philips N.V.

//  Fast ring arithmetic (without cache attack countermeasures)

#include "r5_parameter_sets.h"

#if (PARAMS_N == PARAMS_D)

#include <string.h>

#include "r5_ringmul.h"
#include "r5_xof.h"
#include "r5_addsub.h"
#include "little_endian.h"

// multiplication mod q, result length n

void r5_ringmul_q(modq_t d[PARAMS_D],
    modq_t a[2 * (PARAMS_D + 1)],
    uint16_t idx[PARAMS_H / 2][2])
{
    size_t i;

    //  note: order of coefficients a[1..n] is *NOT* reversed!
    //  "lift" -- multiply by (x - 1)
    a[PARAMS_D] = a[PARAMS_D - 1];
    for (i = PARAMS_D - 1; i >= 1; i--) {
        a[i] = a[i - 1] - a[i];
    }
    a[0] = -a[0];

    //  duplicate at the end
    memcpy(&a[PARAMS_D + 1], a, (PARAMS_D + 1) * sizeof(modq_t));

    //  initialize result
    memset(d, 0, PARAMS_D * sizeof (modq_t));

    for (i = 0; i < (PARAMS_H / 2) - 2; i += 3) {
        r5_modq_addsub3_d(d, &a[(PARAMS_D + 1) - idx[i][0]],
                          &a[(PARAMS_D + 1) - idx[i][1]],
                          &a[(PARAMS_D + 1) - idx[i + 1][0]],
                          &a[(PARAMS_D + 1) - idx[i + 1][1]],
                          &a[(PARAMS_D + 1) - idx[i + 2][0]],
                          &a[(PARAMS_D + 1) - idx[i + 2][1]]);
    }

    while (i < PARAMS_H / 2) {
        r5_modq_addsub_d(d, &a[(PARAMS_D + 1) - idx[i][0]],
                         &a[(PARAMS_D + 1) - idx[i][1]]);
        i++;
    }

    //  "unlift"
    d[0] = -d[0];
    for (i = 1; i < PARAMS_D; i++) {
        d[i] = d[i - 1] - d[i];
    }
}

// multiplication mod p, result length mu

void r5_ringmul_p(modp_t d[PARAMS_MU],
    modp_t a[PARAMS_D + PARAMS_MU + 2],
    uint16_t idx[PARAMS_H / 2][2])
{
    size_t i;

    //  note: order of coefficients p[1..N] is *NOT* reversed!
#if (PARAMS_XE == 0) && (PARAMS_F == 0)
    //  without error correction we "lift" -- i.e. multiply by (x - 1)
    a[PARAMS_D] = a[PARAMS_D - 1];
    for (i = PARAMS_D - 1; i >= 1; i--) {
        a[i] = a[i - 1] - a[i];
    }
    a[0] = -a[0];
#else
    a[PARAMS_D] = 0;
    a[PARAMS_D + 1] = a[0];
    a++;                                //  don't lift, shift!
#endif

    memcpy(&a[PARAMS_D + 1], a, PARAMS_MU * sizeof (modp_t));

    //  initialize result
    memset(d, 0, (PARAMS_MU) * sizeof(modp_t));

    for (i = 0; i < PARAMS_H / 2; i++) {
        r5_modp_addsub_mu(d,
            &a[PARAMS_D + 1 - idx[i][0]], &a[PARAMS_D + 1 - idx[i][1]]);
    }

#if (PARAMS_XE == 0) && (PARAMS_F == 0)
    //  without error correction we "lifted" so we now need to "unlift"
    d[0] = -d[0];
    for (i = 1; i < PARAMS_MU; ++i) {
        d[i] = d[i - 1] - d[i];
    }
#endif
}

#endif

