.syntax unified
.cpu cortex-m4
.thumb

#include "gf256trimat_eval.i"


//void gf256trimat_eval_m4f_68_44(uint32_t *c, uint32_t *a, uint8_t *b);
.global gf256trimat_eval_m4f_68_44
.type gf256trimat_eval_m4f_68_44, %function
.align 2
gf256trimat_eval_m4f_68_44:
    gf256_trimat_eval 68, 44
