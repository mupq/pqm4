/*
 *  This file is part of the optimized implementation of the Picnic signature scheme.
 *  See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#ifndef LOWMC_H
#define LOWMC_H

#include "lowmc_pars.h"

// forward decleration to picnic3_types.h since we get some cyclic dependencies otherwise
typedef struct randomTape_t randomTape_t;

typedef void (*lowmc_implementation_f)(lowmc_key_t const*, mzd_local_t const*, mzd_local_t*);
typedef void (*lowmc_compute_aux_implementation_f)(lowmc_key_t*, randomTape_t* tapes);

void lowmc_uint64_lowmc_129_129_4(lowmc_key_t const*, mzd_local_t const*, mzd_local_t*);
void lowmc_compute_aux_uint64_lowmc_129_129_4(lowmc_key_t*, randomTape_t* tapes);

#endif
