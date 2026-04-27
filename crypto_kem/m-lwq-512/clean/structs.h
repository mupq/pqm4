#ifndef STRUCTS_H
#define STRUCTS_H

#include <stdint.h>
#include "params.h"


typedef struct {
    int16_t coeffs[MLWQ_N];
} __attribute__((aligned(32))) poly;

typedef struct {
    poly vec[MLWQ_K];
} __attribute__((aligned(32))) poly_vec;

typedef struct {
    poly_vec row[MLWQ_K];
} __attribute__((aligned(32))) poly_matrix;

// 公钥
typedef struct {
    uint8_t seed_A[SEEDBYTES];
    uint8_t seed_d[SEEDBYTES];
    poly_vec b_q; // 这里包含 poly_vec，会自动对齐
} mlwq_pk;

// 私钥
typedef struct {
    poly_vec s;
} mlwq_sk;

// KEM 私钥
typedef struct {
    mlwq_sk pke_sk;
    mlwq_pk pk;
    uint8_t h_pk[HASHBYTES];
    uint8_t z[SEEDBYTES];
} mlwq_kem_sk;

// 密文
typedef struct {
    poly_vec u;
    poly v;
} mlwq_ciphertext;

#endif