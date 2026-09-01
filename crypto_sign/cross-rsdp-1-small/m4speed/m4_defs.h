#pragma once

#include "build_defs.h"
#include "parameters.h"

/******************************************************************************/
/**************************** Cortex-M4 Parameters ****************************/
/******************************************************************************/

#define M4_REG_BYTES (32/8)

/* inputs to LDMIA are 32-bit aligned */
#define U16_PER_M4_REG (32/16)

    /* transpose the parity-check matrix */
    #define V_ROWS (N-K)
    #define V_COLS (ROUND_UP(K, U16_PER_M4_REG))
    #define W_ROWS (N-M)
    #define W_COLS (ROUND_UP(M, U16_PER_M4_REG))

/* extend the elements of the parity-check matrices (from u8 to u16) */
    #define FP_ELEM_M4_SAMP FP_ELEM_M4

#if defined(RSDP)
    #define FP_ELEM_M4 uint16_t
    #define FZ_ELEM_M4 FZ_ELEM
#else
    #define FP_ELEM_M4 FP_ELEM
    #define FZ_ELEM_M4 uint16_t
#endif

/* number of 16-bit vector elements loaded before calling SMLAD */
#define SMLAD_STEP_SIZE  (10)
/* repetitions of the LDMIA-SMLAD sequence, for matrices V and W */
#define SMLAD_STEP_REP_V   (K/SMLAD_STEP_SIZE)
#define SMLAD_STEP_REP_W   (M/SMLAD_STEP_SIZE)
/* number of vector elements processed by the LDMIA-SMLAD steps */
#define SMLAD_BATCH_SIZE_V (SMLAD_STEP_REP_V*SMLAD_STEP_SIZE)
#define SMLAD_BATCH_SIZE_W (SMLAD_STEP_REP_W*SMLAD_STEP_SIZE)

#if defined(RSDP)
#define FP_ELEM_MULT 1
#else
#define FP_ELEM_MULT 2
#endif
