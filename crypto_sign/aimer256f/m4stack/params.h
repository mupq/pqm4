// SPDX-License-Identifier: MIT

#ifndef PARAMS_H
#define PARAMS_H

#define AIMER_NAMESPACE(s)          samsungsds_aimer256f_m4stack_##s

#define SECURITY_BITS               256                  // security parameter
#define SECURITY_BYTES              (SECURITY_BITS / 8)  // byte size of security parameter

#define AIM2_NUM_BITS_FIELD         SECURITY_BITS        // number of bits in field element
#define AIM2_NUM_BYTES_FIELD        SECURITY_BYTES       // number of bytes in field element
#define AIM2_NUM_WORDS_FIELD        (SECURITY_BITS / 64) // number of 64-bit words in element
#define AIM2_NUM_BITS_WORD          64                   // number of bits in word
#define AIM2_IV_SIZE                SECURITY_BYTES       // byte size of AIM2 initial vector

#define AIM2_NUM_INPUT_SBOX         3                    // number of AIM2 input S-boxes

#define AIMER_SALT_SIZE             SECURITY_BYTES       // byte size of salt
#define AIMER_SEED_SIZE             SECURITY_BYTES       // byte size of seed
#define AIMER_COMMIT_SIZE           (SECURITY_BYTES * 2) // byte size of commitment

#define AIMER_L                     AIM2_NUM_INPUT_SBOX
#define AIMER_T                     65                   // number of parallel repetitions (Tau)
#define AIMER_N                     16                   // number of MPC parties (N)
#define AIMER_LOGN                  4                    // log_2(N)

#endif // PARAMS_H
