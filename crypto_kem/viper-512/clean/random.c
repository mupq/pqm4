#include "random.h"
#include <stdint.h>
#include <stddef.h>
// pqm4 提供的随机字节接口（在 pqm4 工程中一般由 common/randombytes.c 提供）
#include "randombytes.h"
void random_init(void) {
    // pqm4 的 randombytes() 一般不需要初始化；如果你的板级实现需要，可在此加入
}

void random_bytes(uint8_t *out, size_t len) {
    randombytes(out, len);
}

void random_poly_uniform(poly *p) {
    // 简单实现：逐系数取 16bit 再 mod q（偏慢但能跑通；用于 demo/benchmark OK）
    // 若要与 Kyber 类似的拒绝采样/均匀性更好，可后续再优化。
    for (int i = 0; i < MLWQ_N; ++i) {
        uint16_t val = 0;
        random_bytes((uint8_t *)&val, sizeof(val));
        p->coeffs[i] = (int16_t)(val % MLWQ_Q);
    }
}

void random_poly_eta(poly *p) {
    for(int i=0; i<MLWQ_N; ++i) {
        // 模拟 CBD2: [-2, 2]
        // 概率: 0(37.5%), 1(25%), 2(6.25%)
        uint8_t byte = 0;
        random_bytes(&byte, sizeof(byte));
        int b0 = byte & 1;
        int b1 = (byte >> 1) & 1;
        int b2 = (byte >> 2) & 1;
        int b3 = (byte >> 3) & 1;
        p->coeffs[i] = (b0 + b1) - (b2 + b3);
    }
}

void random_poly_vec_eta(poly_vec *pv) {
    for (int i = 0; i < MLWQ_K; ++i) {
        random_poly_eta(&pv->vec[i]);
    }
}