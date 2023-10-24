.syntax unified
.cpu cortex-m4
.thumb

#include "gf256mat_prod.i"


//void gf256mat_prod_m4f_1936_68_normal_normal(uint32_t *c, uint32_t *a, uint8_t *b);
.global gf256mat_prod_m4f_1936_68_normal_normal
.type gf256mat_prod_m4f_1936_68_normal_normal, %function
.align 2
gf256mat_prod_m4f_1936_68_normal_normal:
    gf256_mat_prod 1936, 68

//void gf256mat_prod_m4f_68_44_normal_normal(uint32_t *c, uint32_t *a, uint8_t *b);
.global gf256mat_prod_m4f_68_44_normal_normal
.type gf256mat_prod_m4f_68_44_normal_normal, %function
.align 2
gf256mat_prod_m4f_68_44_normal_normal:
    gf256_mat_prod 68, 44

//void gf256mat_prod_m4f_44_X_normal_normal(uint32_t *c, uint32_t *a, uint8_t *b);
.global gf256mat_prod_m4f_44_X_normal_normal
.type gf256mat_prod_m4f_44_X_normal_normal, %function
.align 2
gf256mat_prod_m4f_44_X_normal_normal:
    gf256_mat_prod_x 44
