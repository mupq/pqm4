#ifndef PARAMS_H
#define PARAMS_H

#define PARAMS_N 640    // 格的主维度（Lattice dimension）
#define PARAMS_NBAR 8   // 秘密矩阵 S 和误差矩阵 E 的列数
#define PARAMS_LOGQ 15  // 模数 q 的位长
#define PARAMS_Q (1 << PARAMS_LOGQ) // 模数 q 的具体值
// #define PARAMS_EXTRACTED_BITS 2
#define PARAMS_EXTRACTED_BITS 1
#define PARAMS_STRIPE_STEP 8
#define PARAMS_PARALLEL 4
// #define BYTES_SEED_A 16
#define BYTES_SEED_A 32
#define BYTES_MU (PARAMS_EXTRACTED_BITS*PARAMS_NBAR*PARAMS_NBAR)/8
#define BYTES_PKHASH CRYPTO_BYTES
// new parameters for venom
#define BYTES_SALT 32
#define BYTES_SEED_SE (2*CRYPTO_BYTES)
#define PARAMS_PK_LOGP 10
#define PARAMS_U_LOGP  9
#define PARAMS_V_LOGP  4

// Selecting SHAKE XOF function for the KEM and noise sampling
#define shake     shake128

// CDF table
#define CDF_TABLE_DATA {4643, 13363, 20579, 25843, 29227, 31145, 32103, 32525, 32689, 32745, 32762, 32766, 32767}
#define CDF_TABLE_LEN 13

#endif
