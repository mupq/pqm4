#ifndef RANDOM_H
#define RANDOM_H
#include <stdlib.h>
#include "structs.h"

// 系统 RNG 接口
void random_init();
void random_bytes(uint8_t *out, size_t len);
void random_poly_uniform(poly *p);
void random_poly_eta(poly *p);
void random_poly_vec_eta(poly_vec *pv);

#endif
