#ifndef GF256_ASM__H
#define GF256_ASM__H

#include <stdint.h>
#include "utils_prng.h"

// gf256mat_prod.S
void gf256mat_prod_m4f_1936_68_normal_normal(uint8_t *c, const uint8_t *matA, const uint8_t *b);
void gf256mat_prod_m4f_68_44_normal_normal(uint8_t *c, const uint8_t *matA, const uint8_t *b);
void gf256mat_prod_m4f_44_X_normal_normal(uint8_t *c, const uint8_t *matA, const uint8_t *b, size_t n_A_width);

// gf256mat_inv_22.S
unsigned gf256mat_inv_m4f_22(uint8_t *inv, const uint8_t *mat);

// gf256mat_inv_44.S
unsigned gf256mat_inv_m4f_44(uint8_t *inv, const uint8_t *mat);

// gf256trimat_eval_68_44.S
void gf256trimat_eval_m4f_68_44(uint8_t * y, const uint8_t * trimat, const uint8_t * x);

// gf256trimat_eval_112_44_publicinputs.S
void gf256trimat_eval_m4f_112_44_publicinputs(uint8_t * y, const uint8_t * trimat, const uint8_t * x);

// gf256trimat_eval_112_44_incremental_publicinputs.S
void gf256trimat_eval_m4f_112_44_incremental_publicinputs(uint8_t * y, prng_publicinputs_t *prng, const uint8_t * trimat, const uint8_t * x);

// gf256trimat_2trimat_madd_68_68_44_44.S
void gf256trimat_2trimat_madd_m4f_68_68_44_44(uint8_t *c, const uint8_t *a, const uint8_t *b);

// gf256mat_gauss_elim_44.S
uint8_t gf256mat_gauss_elim_row_echolen_m4f_44(uint8_t *mat);

#endif