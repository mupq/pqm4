/**
 *
 * Reference ISO-C11 Implementation of CROSS.
 *
 * @version 2.2 (July 2025)
 *
 * Authors listed in alphabetical order:
 * 
 * @author: Alessandro Barenghi <alessandro.barenghi@polimi.it>
 * @author: Marco Gianvecchio <marco.gianvecchio@mail.polimi.it>
 * @author: Patrick Karl <patrick.karl@tum.de>
 * @author: Gerardo Pelosi <gerardo.pelosi@polimi.it>
 * @author: Jonas Schupp <jonas.schupp@tum.de>
 * 
 * 
 * This code is hereby placed in the public domain.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 **/

#pragma once

/* skip include directives when preprocessing assembly */
#ifndef ASM_SKIP_INCLUDE
#include <stdint.h>
#endif

#include "build_defs.h"

/******************************************************************************/
/*************************** Base Fields Parameters ***************************/
/******************************************************************************/
#if defined(RSDP)

/* The same base field and restriction are employed for all categories of RSDP */
#define   P (127)
#define   Z (  7)
/* single-register table representation of E, the value of g^7=1 is also
 * represented to avoid exponent renormalization*/
#define RESTR_G_TABLE ((uint64_t) (0x0140201008040201))
#define RESTR_G_GEN 2
#define FP_ELEM uint8_t
#define FZ_ELEM uint8_t
#define FP_DOUBLEPREC uint16_t
#define FP_TRIPLEPREC uint32_t
#elif defined(RSDPG)

/* The same base field and restriction are employed for all categories of RSDP */
#define   P (509)
#define   Z (127)
/* Restricted subgroup generator */
#define RESTR_G_GEN 16
#define FZ_ELEM uint8_t
#define FZ_DOUBLEPREC uint16_t
#define FP_ELEM uint16_t
#define FP_DOUBLEPREC uint32_t
#define FP_TRIPLEPREC uint32_t

#else
#error define either RSDP or RSDPG
#endif

/******************************************************************************/
/****************************** RSDP Parameters *******************************/
/******************************************************************************/
#if defined(RSDP)
/********************************* Category 1 *********************************/
#if defined(CATEGORY_1)
#define SEC_MARGIN_LAMBDA (128)
#define   N (127)
#define   K ( 76)

#if defined(SPEED)
#define   T (157)
#define   W ( 82)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(BALANCED)
#define   T (256)
#define   W (215)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(SIG_SIZE)
#define   T (520)
#define   W (488)
#define POSITION_IN_FW_STRING_T uint16_t

#else
#error define optimization corner in Cmakelist
#endif

/********************************* Category 3 *********************************/
#elif defined(CATEGORY_3)
#define SEC_MARGIN_LAMBDA (192)
#define   N (187)
#define   K (111)

#if defined(SPEED)
#define   T (239)
#define   W (125)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(BALANCED)
#define   T (384)
#define   W (321)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(SIG_SIZE)
#define   T (580)
#define   W (527)
#define POSITION_IN_FW_STRING_T uint16_t

#else
#error define optimization corner in Cmakelist
#endif

/********************************* Category 5 *********************************/
#elif defined(CATEGORY_5)
#define SEC_MARGIN_LAMBDA (256)
#define   N (251)
#define   K (150)

#if defined(SPEED)
#define   T (321)
#define   W (167)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(BALANCED)
#define   T (512)
#define   W (427)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(SIG_SIZE)
#define   T (832)
#define   W (762)
#define POSITION_IN_FW_STRING_T uint16_t

#else
#error define optimization corner in Cmakelist
#endif

#else
#error define category for parameters
#endif

/******************************************************************************/
/****************************** RSDP(G) Parameters ****************************/
/******************************************************************************/
#elif defined(RSDPG)
/********************************* Category 1 *********************************/
#if defined(CATEGORY_1)
#define SEC_MARGIN_LAMBDA (128)
#define   N ( 55)
#define   K ( 36)
#define   M ( 25)

#if defined(SPEED)
#define   T (147)
#define   W (76)
#define POSITION_IN_FW_STRING_T uint8_t
#elif defined(BALANCED)
#define   T (256)
#define   W (220)
#define POSITION_IN_FW_STRING_T uint8_t
#elif defined(SIG_SIZE)
#define   T (512)
#define   W (484)
#define POSITION_IN_FW_STRING_T uint16_t

#else
#error define optimization corner in Cmakelist
#endif

/********************************* Category 3 *********************************/
#elif defined(CATEGORY_3)
#define SEC_MARGIN_LAMBDA (192)
#define   N ( 79)
#define   K ( 48)
#define   M ( 40)

#if defined(SPEED)
#define   T (224)
#define   W (119)
#define POSITION_IN_FW_STRING_T uint8_t
#elif defined(BALANCED)
#define   T (268)
#define   W (196)
#define POSITION_IN_FW_STRING_T uint8_t
#elif defined(SIG_SIZE)
#define   T (512)
#define   W (463)
#define POSITION_IN_FW_STRING_T uint16_t

#else
#error define optimization corner in Cmakelist
#endif

/********************************* Category 5 *********************************/
#elif defined(CATEGORY_5)
#define SEC_MARGIN_LAMBDA (256)
#define   N (106)
#define   K ( 69)
#define   M ( 48)

#if defined(SPEED)
#define   T (300)
#define   W (153)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(BALANCED)
#define   T (356)
#define   W (258)
#define POSITION_IN_FW_STRING_T uint16_t
#elif defined(SIG_SIZE)
#define   T (642)
#define   W (575)
#define POSITION_IN_FW_STRING_T uint16_t

#else
#error define optimization corner in Cmakelist
#endif

#else
#error define category for parameters
#endif

#else
#error define either RSDP or RSDPG
#endif


#define CSPRNG_DOMAIN_SEP_CONST ((uint16_t)0)
#define HASH_DOMAIN_SEP_CONST ((uint16_t)32768)

/************* Helper macros for derived parameter computation ***************/

#define ROUND_UP(amount, round_amt) ( ((amount+round_amt-1)/round_amt)*round_amt )

#define IS_REPRESENTABLE_IN_D_BITS(D, N)                \
  (( N>=(1L << (D-1)) && N<(1L << D)) ? D : -1)

#define BITS_TO_REPRESENT(N)                            \
  (N == 0 ? 1 : (15                                     \
                 + IS_REPRESENTABLE_IN_D_BITS( 1, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 2, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 3, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 4, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 5, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 6, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 7, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 8, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS( 9, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(10, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(11, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(12, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(13, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(14, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(15, N)    \
                 + IS_REPRESENTABLE_IN_D_BITS(16, N)    \
                 )                                      \
   )

#define LOG2(L) ( (BITS_TO_REPRESENT(L) > BITS_TO_REPRESENT(L-1)) ? (BITS_TO_REPRESENT(L-1)) : (BITS_TO_REPRESENT(L)) )

#define NUM_BITS_P (BITS_TO_REPRESENT(P))

/***************** Derived parameters *****************************************/
#define SEED_LENGTH_BYTES (SEC_MARGIN_LAMBDA/8)
#define KEYPAIR_SEED_LENGTH_BYTES (2*(SEC_MARGIN_LAMBDA/8))
#define HASH_DIGEST_LENGTH (2*(SEC_MARGIN_LAMBDA/8))
#define SALT_LENGTH_BYTES (2*(SEC_MARGIN_LAMBDA/8))

#define NUM_LEAVES_MERKLE_TREE (T)
#define NUM_NODES_MERKLE_TREE (2*NUM_LEAVES_MERKLE_TREE-1)

#define NUM_LEAVES_SEED_TREE (T)
#define NUM_NODES_SEED_TREE (2*NUM_LEAVES_SEED_TREE-1)

/* Sizes of bitpacked field element vectors
 * Bitpacking an n-elements vector of num_bits_for_q-1 bits long values
 * will pack 8 values in num_bits_for_q-1 bytes exactly, leaving the remaining
 * N % 8 as a tail */
#define DENSELY_PACKED_FP_VEC_SIZE ((N/8)*BITS_TO_REPRESENT(P-1) + \
                                   ROUND_UP( ((N%8)*BITS_TO_REPRESENT(P-1)),8)/8)
#define DENSELY_PACKED_FP_SYN_SIZE (((N-K)/8)*BITS_TO_REPRESENT(P-1) +              ROUND_UP( (((N-K)%8)*BITS_TO_REPRESENT(P-1)),8)/8)
#define DENSELY_PACKED_FZ_VEC_SIZE ((N/8)*BITS_TO_REPRESENT(Z-1) + \
                                   ROUND_UP( ((N%8)*BITS_TO_REPRESENT(Z-1)),8)/8)
#ifdef RSDPG
#define DENSELY_PACKED_FZ_RSDP_G_VEC_SIZE ((M/8)*BITS_TO_REPRESENT(Z-1) + \
                                          ROUND_UP( ((M%8)*BITS_TO_REPRESENT(Z-1)),8)/8)
#endif


/* Derived parameters computed via compute_derived_parameters.py */
#if ( defined(CATEGORY_1) && defined(RSDP)  && defined(SPEED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 2, 2, 58, 58}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 30, 60, 64, 128}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 1, 0, 28, 0, 128}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {185, 93, 30}
#define TREE_CONSECUTIVE_LEAVES {128, 28, 1}
#define TREE_NODES_TO_STORE 82
#define BITS_N_FP_CT_RNG 1127
#define BITS_CHALL_1_FPSTAR_CT_RNG 1421
#define BITS_V_CT_RNG 28028
#define BITS_N_FZ_CT_RNG 717
#define BITS_CWSTR_RNG 3656

#elif ( defined(CATEGORY_1) && defined(RSDP)  && defined(BALANCED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 256}
#define TREE_SUBROOTS 1
#define TREE_LEAVES_START_INDICES {255}
#define TREE_CONSECUTIVE_LEAVES {256}
#define TREE_NODES_TO_STORE 108
#define BITS_N_FP_CT_RNG 1127
#define BITS_CHALL_1_FPSTAR_CT_RNG 2170
#define BITS_V_CT_RNG 28028
#define BITS_N_FZ_CT_RNG 717
#define BITS_CWSTR_RNG 4776

#elif ( defined(CATEGORY_1) && defined(RSDP)  && defined(SIG_SIZE) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 16, 16, 16, 16, 16, 16}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 16, 32, 64, 128, 256, 512}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 512}
#define TREE_SUBROOTS 2
#define TREE_LEAVES_START_INDICES {527, 23}
#define TREE_CONSECUTIVE_LEAVES {512, 8}
#define TREE_NODES_TO_STORE 129
#define BITS_N_FP_CT_RNG 1127
#define BITS_CHALL_1_FPSTAR_CT_RNG 4130
#define BITS_V_CT_RNG 28028
#define BITS_N_FZ_CT_RNG 717
#define BITS_CWSTR_RNG 10390

#elif ( defined(CATEGORY_3) && defined(RSDP)  && defined(SPEED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 2, 30}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 126, 224}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 1, 14, 224}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {253, 239, 126}
#define TREE_CONSECUTIVE_LEAVES {224, 14, 1}
#define TREE_NODES_TO_STORE 125
#define BITS_N_FP_CT_RNG 1673
#define BITS_CHALL_1_FPSTAR_CT_RNG 2163
#define BITS_V_CT_RNG 60711
#define BITS_N_FZ_CT_RNG 1065
#define BITS_CWSTR_RNG 5264

#elif ( defined(CATEGORY_3) && defined(RSDP)  && defined(BALANCED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0, 256}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 128, 256}
#define TREE_SUBROOTS 2
#define TREE_LEAVES_START_INDICES {511, 383}
#define TREE_CONSECUTIVE_LEAVES {256, 128}
#define TREE_NODES_TO_STORE 165
#define BITS_N_FP_CT_RNG 1673
#define BITS_CHALL_1_FPSTAR_CT_RNG 3255
#define BITS_V_CT_RNG 60711
#define BITS_N_FZ_CT_RNG 1065
#define BITS_CWSTR_RNG 8586

#elif ( defined(CATEGORY_3) && defined(RSDP)  && defined(SIG_SIZE) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 8, 8, 8, 8, 136, 136}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 24, 48, 96, 192, 256, 512}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 4, 0, 0, 0, 64, 0, 512}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {647, 327, 27}
#define TREE_CONSECUTIVE_LEAVES {512, 64, 4}
#define TREE_NODES_TO_STORE 184
#define BITS_N_FP_CT_RNG 1673
#define BITS_CHALL_1_FPSTAR_CT_RNG 4718
#define BITS_V_CT_RNG 60711
#define BITS_N_FZ_CT_RNG 1065
#define BITS_CWSTR_RNG 12880

#elif ( defined(CATEGORY_5) && defined(RSDP)  && defined(SPEED) )
#define TREE_OFFSETS {0, 0, 0, 2, 2, 2, 2, 2, 2, 130}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 6, 12, 24, 48, 96, 192, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 1, 0, 0, 0, 0, 0, 64, 256}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {385, 321, 6}
#define TREE_CONSECUTIVE_LEAVES {256, 64, 1}
#define TREE_NODES_TO_STORE 167
#define BITS_N_FP_CT_RNG 2247
#define BITS_CHALL_1_FPSTAR_CT_RNG 2905
#define BITS_V_CT_RNG 108689
#define BITS_N_FZ_CT_RNG 1431
#define BITS_CWSTR_RNG 8343

#elif ( defined(CATEGORY_5) && defined(RSDP)  && defined(BALANCED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256, 512}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 0, 512}
#define TREE_SUBROOTS 1
#define TREE_LEAVES_START_INDICES {511}
#define TREE_CONSECUTIVE_LEAVES {512}
#define TREE_NODES_TO_STORE 220
#define BITS_N_FP_CT_RNG 2247
#define BITS_CHALL_1_FPSTAR_CT_RNG 4347
#define BITS_V_CT_RNG 108689
#define BITS_N_FZ_CT_RNG 1431
#define BITS_CWSTR_RNG 10746

#elif ( defined(CATEGORY_5) && defined(RSDP)  && defined(SIG_SIZE) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 128}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256, 384, 768}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 64, 0, 768}
#define TREE_SUBROOTS 2
#define TREE_LEAVES_START_INDICES {895, 447}
#define TREE_CONSECUTIVE_LEAVES {768, 64}
#define TREE_NODES_TO_STORE 251
#define BITS_N_FP_CT_RNG 2247
#define BITS_CHALL_1_FPSTAR_CT_RNG 6734
#define BITS_V_CT_RNG 108689
#define BITS_N_FZ_CT_RNG 1431
#define BITS_CWSTR_RNG 18150

#elif ( defined(CATEGORY_1) &&  defined(RSDPG)  && defined(SPEED) )
#define TREE_OFFSETS {0, 0, 0, 0, 2, 6, 6, 38, 38}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 14, 24, 48, 64, 128}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 1, 2, 0, 16, 0, 128}
#define TREE_SUBROOTS 4
#define TREE_LEAVES_START_INDICES {165, 85, 27, 14}
#define TREE_CONSECUTIVE_LEAVES {128, 16, 2, 1}
#define TREE_NODES_TO_STORE 76
#define BITS_N_FP_CT_RNG 729
#define BITS_CHALL_1_FPSTAR_CT_RNG 1647
#define BITS_V_CT_RNG 6624
#define BITS_W_CT_RNG 5677
#define BITS_M_FZ_CT_RNG 343
#define BITS_CWSTR_RNG 3472

#elif ( defined(CATEGORY_1) &&  defined(RSDPG)  && defined(BALANCED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 256}
#define TREE_SUBROOTS 1
#define TREE_LEAVES_START_INDICES {255}
#define TREE_CONSECUTIVE_LEAVES {256}
#define TREE_NODES_TO_STORE 101
#define BITS_N_FP_CT_RNG 729
#define BITS_CHALL_1_FPSTAR_CT_RNG 2682
#define BITS_V_CT_RNG 6624
#define BITS_W_CT_RNG 5677
#define BITS_M_FZ_CT_RNG 343
#define BITS_CWSTR_RNG 4776

#elif ( defined(CATEGORY_1) &&  defined(RSDPG)  && defined(SIG_SIZE) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256, 512}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 0, 512}
#define TREE_SUBROOTS 1
#define TREE_LEAVES_START_INDICES {511}
#define TREE_CONSECUTIVE_LEAVES {512}
#define TREE_NODES_TO_STORE 117
#define BITS_N_FP_CT_RNG 729
#define BITS_CHALL_1_FPSTAR_CT_RNG 5085
#define BITS_V_CT_RNG 6624
#define BITS_W_CT_RNG 5677
#define BITS_M_FZ_CT_RNG 343
#define BITS_CWSTR_RNG 9153

#elif ( defined(CATEGORY_3) &&  defined(RSDPG)  && defined(SPEED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 64}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 192}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 32, 192}
#define TREE_SUBROOTS 2
#define TREE_LEAVES_START_INDICES {255, 223}
#define TREE_CONSECUTIVE_LEAVES {192, 32}
#define TREE_NODES_TO_STORE 119
#define BITS_N_FP_CT_RNG 1071
#define BITS_CHALL_1_FPSTAR_CT_RNG 2502
#define BITS_V_CT_RNG 14211
#define BITS_W_CT_RNG 11655
#define BITS_M_FZ_CT_RNG 539
#define BITS_CWSTR_RNG 5128

#elif ( defined(CATEGORY_3) &&  defined(RSDPG)  && defined(BALANCED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 8, 24, 24, 24, 24}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 24, 32, 64, 128, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 4, 8, 0, 0, 0, 256}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {279, 47, 27}
#define TREE_CONSECUTIVE_LEAVES {256, 8, 4}
#define TREE_NODES_TO_STORE 138
#define BITS_N_FP_CT_RNG 1071
#define BITS_CHALL_1_FPSTAR_CT_RNG 2925
#define BITS_V_CT_RNG 14211
#define BITS_W_CT_RNG 11655
#define BITS_M_FZ_CT_RNG 539
#define BITS_CWSTR_RNG 6444

#elif ( defined(CATEGORY_3) &&  defined(RSDPG)  && defined(SIG_SIZE) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 64, 128, 256, 512}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 0, 0, 0, 0, 512}
#define TREE_SUBROOTS 1
#define TREE_LEAVES_START_INDICES {511}
#define TREE_CONSECUTIVE_LEAVES {512}
#define TREE_NODES_TO_STORE 165
#define BITS_N_FP_CT_RNG 1071
#define BITS_CHALL_1_FPSTAR_CT_RNG 5238
#define BITS_V_CT_RNG 14211
#define BITS_W_CT_RNG 11655
#define BITS_M_FZ_CT_RNG 539
#define BITS_CWSTR_RNG 9981

#elif ( defined(CATEGORY_5) &&  defined(RSDPG)  && defined(SPEED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 8, 24, 88, 88}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 56, 96, 128, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 4, 8, 32, 0, 256}
#define TREE_SUBROOTS 4
#define TREE_LEAVES_START_INDICES {343, 183, 111, 59}
#define TREE_CONSECUTIVE_LEAVES {256, 32, 8, 4}
#define TREE_NODES_TO_STORE 153
#define BITS_N_FP_CT_RNG 1431
#define BITS_CHALL_1_FPSTAR_CT_RNG 3357
#define BITS_V_CT_RNG 24192
#define BITS_W_CT_RNG 20594
#define BITS_M_FZ_CT_RNG 679
#define BITS_CWSTR_RNG 7929

#elif ( defined(CATEGORY_5) &&  defined(RSDPG)  && defined(BALANCED) )
#define TREE_OFFSETS {0, 0, 0, 0, 0, 0, 8, 8, 8, 200}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 16, 32, 56, 112, 224, 256}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 0, 0, 4, 0, 0, 96, 256}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {455, 359, 59}
#define TREE_CONSECUTIVE_LEAVES {256, 96, 4}
#define TREE_NODES_TO_STORE 185
#define BITS_N_FP_CT_RNG 1431
#define BITS_CHALL_1_FPSTAR_CT_RNG 3897
#define BITS_V_CT_RNG 24192
#define BITS_W_CT_RNG 20594
#define BITS_M_FZ_CT_RNG 679
#define BITS_CWSTR_RNG 8937

#elif ( defined(CATEGORY_5) &&  defined(RSDPG)  && defined(SIG_SIZE) )
#define TREE_OFFSETS {0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 260}
#define TREE_NODES_PER_LEVEL {1, 2, 4, 8, 12, 24, 48, 96, 192, 384, 512}
#define TREE_LEAVES_PER_LEVEL {0, 0, 0, 2, 0, 0, 0, 0, 0, 128, 512}
#define TREE_SUBROOTS 3
#define TREE_LEAVES_START_INDICES {771, 643, 13}
#define TREE_CONSECUTIVE_LEAVES {512, 128, 2}
#define TREE_NODES_TO_STORE 220
#define BITS_N_FP_CT_RNG 1431
#define BITS_CHALL_1_FPSTAR_CT_RNG 6597
#define BITS_V_CT_RNG 24192
#define BITS_W_CT_RNG 20594
#define BITS_M_FZ_CT_RNG 679
#define BITS_CWSTR_RNG 15140

#endif
