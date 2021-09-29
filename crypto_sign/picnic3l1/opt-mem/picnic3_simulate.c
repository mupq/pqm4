/*! @file picnic3_impl.c
 *  @brief This is the main file of the signature scheme for the Picnic3
 *  parameter sets.
 *
 *  This file is part of the reference implementation of the Picnic signature
 * scheme. See the accompanying documentation for complete details.
 *
 *  The code is provided under the MIT license, see LICENSE for
 *  more details.
 *  SPDX-License-Identifier: MIT
 */

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if !defined(_MSC_VER)
#include <stdalign.h>
#endif

#include "bitstream.h"
#include "compat.h"
#include "io.h"
#include "picnic3_simulate.h"
#include "picnic3_types.h"

#define picnic3_mpc_sbox_bitsliced(LOWMC_N, XOR, AND, SHL, SHR, bitmask_a, bitmask_b, bitmask_c)   \
  do {                                                                                             \
    mzd_local_t a[1], b[1], c[1];                                                                  \
    /* a */                                                                                        \
    AND(a, bitmask_a, statein);                                                                    \
    /* b */                                                                                        \
    AND(b, bitmask_b, statein);                                                                    \
    /* c */                                                                                        \
    AND(c, bitmask_c, statein);                                                                    \
                                                                                                   \
    SHL(a, a, 2);                                                                                  \
    SHL(b, b, 1);                                                                                  \
                                                                                                   \
    mzd_local_t t0[1], t1[1], t2[1];                                                               \
                                                                                                   \
    mzd_local_t s_ab[1], s_bc[1], s_ca[1];                                                         \
    /* b & c */                                                                                    \
    AND(s_bc, b, c);                                                                               \
    /* c & a */                                                                                    \
    AND(s_ca, c, a);                                                                               \
    /* a & b */                                                                                    \
    AND(s_ab, a, b);                                                                               \
    for (int i = 0; i < 16; i++) {                                                                 \
      mzd_local_t tmp[1];                                                                          \
      bitstream_t party_msgs = {{msgs->msgs[i]}, msgs->pos};                                       \
      if (i == msgs->unopened) {                                                                   \
        /* we are in verify, just grab the broadcast s from the msgs array */                      \
        mzd_from_bitstream(&party_msgs, tmp, (LOWMC_N + 63) / (sizeof(uint64_t) * 8), LOWMC_N);    \
        /* a */                                                                                    \
        AND(t0, bitmask_a, tmp);                                                                   \
        /* b */                                                                                    \
        AND(t1, bitmask_b, tmp);                                                                   \
        /* c */                                                                                    \
        AND(t2, bitmask_c, tmp);                                                                   \
        SHL(t0, t0, 2);                                                                            \
        SHL(t1, t1, 1);                                                                            \
        XOR(s_ab, t2, s_ab);                                                                       \
        XOR(s_bc, t1, s_bc);                                                                       \
        XOR(s_ca, t0, s_ca);                                                                       \
                                                                                                   \
        continue;                                                                                  \
      }                                                                                            \
      bitstream_t party_tape = {{tapes->tape[i]}, tapes->pos};                                     \
      /* make a mzd_local from tape[i] for input_masks */                                          \
      mzd_local_t mask_a[1], mask_b[1], mask_c[1];                                                 \
      mzd_from_bitstream(&party_tape, tmp, (LOWMC_N + 63) / (sizeof(uint64_t) * 8), LOWMC_N);      \
      /* a */                                                                                      \
      AND(mask_a, bitmask_a, tmp);                                                                 \
      /* b */                                                                                      \
      AND(mask_b, bitmask_b, tmp);                                                                 \
      /* c */                                                                                      \
      AND(mask_c, bitmask_c, tmp);                                                                 \
      SHL(mask_a, mask_a, 2);                                                                      \
      SHL(mask_b, mask_b, 1);                                                                      \
                                                                                                   \
      /* make a mzd_local from tape[i] for and_helper */                                           \
      mzd_local_t and_helper_ab[1], and_helper_bc[1], and_helper_ca[1];                            \
      mzd_from_bitstream(&party_tape, tmp, (LOWMC_N + 63) / (sizeof(uint64_t) * 8), LOWMC_N);      \
      /* a */                                                                                      \
      AND(and_helper_ab, bitmask_c, tmp);                                                          \
      /* b */                                                                                      \
      AND(and_helper_bc, bitmask_b, tmp);                                                          \
      /* c */                                                                                      \
      AND(and_helper_ca, bitmask_a, tmp);                                                          \
      SHL(and_helper_ca, and_helper_ca, 2);                                                        \
      SHL(and_helper_bc, and_helper_bc, 1);                                                        \
                                                                                                   \
      /* s_ab */                                                                                   \
      AND(t0, a, mask_b);                                                                          \
      AND(t1, b, mask_a);                                                                          \
      XOR(t0, t0, t1);                                                                             \
      XOR(tmp, t0, and_helper_ab);                                                                 \
      XOR(s_ab, tmp, s_ab);                                                                        \
      /* s_bc */                                                                                   \
      AND(t0, b, mask_c);                                                                          \
      AND(t1, c, mask_b);                                                                          \
      XOR(t0, t0, t1);                                                                             \
      XOR(t0, t0, and_helper_bc);                                                                  \
      XOR(s_bc, t0, s_bc);                                                                         \
                                                                                                   \
      SHR(t0, t0, 1);                                                                              \
      XOR(tmp, tmp, t0);                                                                           \
      /* s_ca */                                                                                   \
      AND(t0, c, mask_a);                                                                          \
      AND(t1, a, mask_c);                                                                          \
      XOR(t0, t0, t1);                                                                             \
      XOR(t0, t0, and_helper_ca);                                                                  \
      XOR(s_ca, t0, s_ca);                                                                         \
                                                                                                   \
      SHR(t0, t0, 2);                                                                              \
      XOR(tmp, tmp, t0);                                                                           \
      mzd_to_bitstream(&party_msgs, tmp, (LOWMC_N + 63) / (sizeof(uint64_t) * 8), LOWMC_N);        \
    }                                                                                              \
    tapes->pos += LOWMC_N;                                                                         \
    tapes->pos += LOWMC_N;                                                                         \
    msgs->pos += LOWMC_N;                                                                          \
                                                                                                   \
    /* (b & c) ^ a */                                                                              \
    XOR(t0, s_bc, a);                                                                              \
                                                                                                   \
    /* (c & a) ^ a ^ b */                                                                          \
    XOR(a, a, b);                                                                                  \
    XOR(t1, s_ca, a);                                                                              \
                                                                                                   \
    /* (a & b) ^ a ^ b ^c */                                                                       \
    XOR(t2, s_ab, a);                                                                              \
    XOR(t2, t2, c);                                                                                \
                                                                                                   \
    SHR(t0, t0, 2);                                                                                \
    SHR(t1, t1, 1);                                                                                \
                                                                                                   \
    XOR(t2, t2, t1);                                                                               \
    XOR(statein, t2, t0);                                                                          \
  } while (0)

#include "lowmc_129_129_4.h"

#if !defined(NO_UINT64_FALLBACK)
static void picnic3_mpc_sbox_uint64_lowmc_129_129_4(mzd_local_t* statein, randomTape_t* tapes,
                                                    msgs_t* msgs) {

  picnic3_mpc_sbox_bitsliced(LOWMC_129_129_4_N, mzd_xor_uint64_192, mzd_and_uint64_192,
                             mzd_shift_left_uint64_192, mzd_shift_right_uint64_192,
                             mask_129_129_43_a, mask_129_129_43_b, mask_129_129_43_c);
}

#define IMPL uint64
/* PICNIC3_L1_FS */
#include "lowmc_129_129_4_fns_uint64.h"
#undef SIM_ONLINE
#define SIM_ONLINE lowmc_simulate_online_uint64_129_43
#include "picnic3_simulate.c.i"

#undef IMPL
#endif