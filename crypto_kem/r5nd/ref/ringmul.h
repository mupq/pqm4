// ringmul.h
// 2018-06-26  Markku-Juhani O. Saarinen <mjos@iki.fi>

#ifndef _RINGMUL_H_
#define _RINGMUL_H_

#include "api.h"

// create a sparse ternary vector from a seed
void create_spter_idx(uint16_t idx[PARAMS_H / 2][2],
    const uint8_t *seed, const size_t seed_size);

// multiplication mod q, result length n
void ringmul_q(modq_t d[PARAMS_ND + PARAMS_MUL_PAD],
    const modq_t a[PARAMS_ND], const uint16_t idx[PARAMS_H / 2][2]);

// multiplication mod p, result length mu
void ringmul_p(modp_t d[PARAMS_MU + PARAMS_MUL_PAD],
    const modp_t a[PARAMS_ND], const uint16_t idx[PARAMS_H / 2][2]);

#endif /* _RINGMUL_H_ */
