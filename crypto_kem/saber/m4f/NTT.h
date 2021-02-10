#ifndef NTT_H
#define NTT_H

#include "SABER_params.h"
#include <stdint.h>

#define RmodM -8432555
#define RinvN -8389379
#define R2invN 7689784
#define MOD 25166081
#define Mprime 41877759

static const int32_t mul_table[32] = {
9600669, -10575964, -8064557, 819256, 588496, 8693794, 7460755, -2723061, -4092287, 3261033, 5563113, 11307548, 9567042, -11980428, -6931502, -2510833, 10319196, 6726360, -10171507, -8693725, 42688, -10505644, 9502337, -10910265, -5318976, 1134236, 614272, 6236460, -5184115, 1069349, 9233574, -12174351
};

static const int32_t root_table[64] = {
2921358, -10203707, -1203107, 6577444, 1776511, -4194664, 5735629, 7301157, -4359117, 5669200, -9600669, 10575964, 8064557, -819256, -9084979, -7944926, 1686897, -588496, -8693794, -7460755, 2723061, -11637995, -4810496, 7146164, 4092287, -3261033, -5563113, -11307548, -7261676, -4293923, -6267356, -9567042, 11980428, 6931502, 2510833, 4034819, -1988985, -8060830, -10319196, -6726360, 10171507, 8693725, 647681, -9344183, 2733537, -42688, 10505644, -9502337, 10910265, 2695651, 11450840, -12030083, 5318976, -1134236, -614272, -6236460, -2559945, -908786, -2665284, 5184115, -1069349, -9233574, 12174351
};

static const int32_t inv_root_table[64] = {
-11182464, 1203107, 10203707, -5735629, 4194664, -1776511, -6577444, 2559945, 2665284, 908786, -12174351, 9233574, 1069349, -5184115, -2695651, 12030083, -11450840, 6236460, 614272, 1134236, -5318976, -647681, -2733537, 9344183, -10910265, 9502337, -10505644, 42688, -4034819, 8060830, 1988985, -8693725, -10171507, 6726360, 10319196, 7261676, 6267356, 4293923, -2510833, -6931502, -11980428, 9567042, 11637995, -7146164, 4810496, 11307548, 5563113, 3261033, -4092287, 9084979, -1686897, 7944926, -2723061, 7460755, 8693794, 588496, -7301157, -5669200, 4359117, 819256, -8064557, -10575964, 9600669
};

// void _NTT_forward(uint16_t *a, const int32_t *root_table, uint32_t mod, uint32_t modprime, uint32_t *tmp);
void _NTT_forward(uint32_t *tmp, const int32_t *root_table, uint32_t modprime, uint32_t mod, uint16_t *a);
// void _NTT_inv(uint32_t *in, const int32_t *inv_root_table, uint32_t mod, uint32_t modprime,  uint16_t *out);
void _NTT_inv(uint16_t *out, const int32_t *inv_root_table, uint32_t modprime, uint32_t mod, uint32_t *in);

#define NTT_forward(out, in) _NTT_forward(&out[0], root_table, Mprime, MOD, &in[0])
#define NTT_inv(out, in) _NTT_inv(&out[0], inv_root_table, Mprime, MOD, &in[0])

void mul(uint32_t *res, const int32_t *mul_table, uint32_t modprime, uint32_t mod, uint32_t *poly1, uint32_t *poly2);
// out = in1 * in2
#define NTT_mul(out, in1, in2) mul(out, mul_table, Mprime, MOD, in1, in2);

void mul_acc(uint32_t *res, const int32_t *mul_table, uint32_t modprime, uint32_t mod, uint32_t *poly1, uint32_t *poly2);
// out = out + in1 * in2
#define NTT_mul_acc(out, in1, in2) mul_acc(out, mul_table, Mprime, MOD, in1, in2);



#endif