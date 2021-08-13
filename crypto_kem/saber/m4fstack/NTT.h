#ifndef NTT_H
#define NTT_H

#include "SABER_params.h"
#include "NTT_params.h"
#include <stdint.h>

static const int32_t CRT_constants[4] = {
    Q1Q2, Q1Q1invRmod, Q2Q2prime
};

// profile.compressed_layers = 2;
// for(int i = 0; i < profile.compressed_layers; i++){
//     profile.merged_layers[i]= 3;
// }

// gen_streamlined_CT_negacyclic_table(streamlined_CT_negacyclic_table_Q1Q2, RmodQ1Q2, omegaQ1Q2, Q1Q2, &profile, 0);
// print_table(streamlined_CT_negacyclic_table_Q1Q2, NTT_N);
static const int32_t streamlined_CT_negacyclic_table_Q1Q2[NTT_N] = {
-10790239, -9536204, -6257664, 10276457, 2216394, -11013493, -6308437, -2952568, -12652760, -6526839, 170812, -10085157, 11283370, 10064939, 4935045, -12696742, -2522583, -11057244, 831656, 9511410, 2088463, 2927433, 8224194, 8679711, -8183720, -7836837, 5141500, -12428729, 4530982, -4045107, -2683865, -12289212, -12672803, -11196795, 6573093, -2917062, -10270322, 371460, -9922532, 2470383, 10695464, -3892856, -1556720, -6592493, 8378129, 4619612, 6074925, 12120915, 7751589, -9214817, 5757708, 851137, -1196321, 8484143, 11670672, -3041171, -1279366, 7869959, 11739496, 6717881, -6139656, -6988319, -1579586, 0
};

// gen_streamlined_CT_negacyclic_table(streamlined_CT_negacyclic_table_Q1, RmodQ1, omegaQ1, Q1, &profile, 1);
// print_table(streamlined_CT_negacyclic_table_Q1, (NTT_N - 1) + (1 << 0) + (1 << 3));
static const int16_t streamlined_CT_negacyclic_table_Q1[((NTT_N - 1) / 7) << 3] = {
0, 3777, -3182, 3625, -3696, -1100, 2456, 2194, 0, -121, -2088, -2816, 3266, -3600, -1738, 3689, 0, 2250, 1986, 2237, -638, -7, 1887, -810, 0, -834, 1993, 1599, 1305, 1760, 679, -438, 0, 2495, -2006, -3706, 3555, 1881, 3174, 396, 0, 2319, 2557, -1525, -2555, 2440, -3772, 2535, 0, -2876, -1483, 1296, 2310, -3153, -1535, 549, 0, 1701, -3364, -2830, 2956, 514, -1399, 1321, 0, -1414, -1921, 617, 1431, -2043, -103, 2804
};

// gen_streamlined_CT_negacyclic_table(streamlined_CT_negacyclic_table_Q2, RmodQ2, omegaQ2, Q2, &profile, 1);
// print_table(streamlined_CT_negacyclic_table_Q2, (NTT_N - 1) + (1 << 0) + (1 << 3));
static const int16_t streamlined_CT_negacyclic_table_Q2[((NTT_N - 1) / 7) << 3] = {
0, -758, 359, 1517, -1422, 1493, 202, -287, 0, -182, 130, -1602, 1469, -126, -1618, -1162, 0, 1577, 829, -1458, -8, -516, 666, -320, 0, 171, 1325, 573, 1015, 552, 1223, 652, 0, -622, 383, -264, -282, -1544, -1491, -1293, 0, 1474, -411, -1542, -725, 1508, -398, 961, 0, -1468, -1571, 205, 677, -1275, 1065, 448, 0, -1202, -732, -608, -1421, -107, 951, -247, 0, -962, 1017, 681, -271, 830, 90, -853
};

// gen_mul_table(mul_Rmod_table_Q1Q2, center_mul(omegaQ1Q2, RmodQ1Q2, Q1Q2), expmod(omegaQ1Q2, 2, Q1Q2), Q1Q2);
// print_table(mul_Rmod_table_Q1Q2, NTT_N >> 1);
static const int32_t mul_Rmod_table_Q1Q2[NTT_N >> 1] = {
170812, -10085157, 11283370, 10064939, -11057244, 831656, 9511410, 2088463, -8183720, -7836837, 5141500, -12428729, -12289212, -12672803, -11196795, 6573093, -9922532, 2470383, 10695464, -3892856, 4619612, 6074925, 12120915, 7751589, -1196321, 8484143, 11670672, -3041171, 6717881, -6139656, -6988319, -1579586
};

// gen_mul_table(mul_Rmod_table_Q1, center_mul(omegaQ1, RmodQ1, Q1), expmod(omegaQ1, 2, Q1), Q1);
// print_table(mul_Rmod_table_Q1, NTT_N >> 1);
static const int16_t mul_Rmod_table_Q1[NTT_N >> 1] = {
3266, -3600, -1738, 3689, -638, -7, 1887, -810, 1305, 1760, 679, -438, 3555, 1881, 3174, 396, -2555, 2440, -3772, 2535, 2310, -3153, -1535, 549, 2956, 514, -1399, 1321, 1431, -2043, -103, 2804
};

// gen_mul_table(mul_Rmod_table_Q2, center_mul(omegaQ2, RmodQ2, Q2), expmod(omegaQ2, 2, Q2), Q2);
// print_table(mul_Rmod_table_Q2, NTT_N >> 1);
static const int16_t mul_Rmod_table_Q2[NTT_N >> 1] = {
1469, -126, -1618, -1162, -8, -516, 666, -320, 1015, 552, 1223, 652, -282, -1544, -1491, -1293, -725, 1508, -398, 961, 677, -1275, 1065, 448, -1421, -107, 951, -247, -271, 830, 90, -853
};

// gen_streamlined_inv_CT_negacyclic_table(streamlined_inv_CT_negacyclic_table_Q1Q2, RmodQ1Q2, expmod(invomegaQ1Q2, 2, Q1Q2), center_mul(expmod(RmodQ1Q2, 2, Q1Q2), invNQ1Q2, Q1Q2), invomegaQ1Q2, Q1Q2, &profile, 0);
// print_table(streamlined_inv_CT_negacyclic_table_Q1Q2, NTT_N << 1);
static const int32_t streamlined_inv_CT_negacyclic_table_Q1Q2[NTT_N << 1] = {
-800936, -800936, 10790239, -800936, 6257664, 10790239, 9536204, -800936, -800936, 10790239, -800936, 6257664, 10790239, 9536204, -45519, -9785872, 8741751, -12555915, 9222792, -3974469, 6186724, -1752018, 6308437, 1279366, 9214817, -11739496, -851137, -7869959, -5757708, 4113944, 11492079, 2504776, -564125, 2964683, -2036310, 7029166, 2951251, 6257664, 6308437, 11013493, 1279366, 1556720, 9214817, 2917062, -10111425, -4039544, -1461286, 7718709, 9738183, -10403380, 11943422, -7769673, -2216394, -4530982, -2927433, 2683865, -8679711, 4045107, -8224194, -2249904, -7863363, 12440447, -10742070, -3018363, -3083871, -3820015, -8140660, 10790239, 6257664, 9536204, 6308437, -2216394, 11013493, -10276457, -10327566, -4435558, 2610308, 5372942, -8646977, 3434759, 1700428, -1560502, 11013493, 1556720, 2917062, -8378129, -371460, 6592493, 10270322, -7732673, -6689674, 2456345, -7861158, 10371470, -9485354, 11616061, 4175938, 9536204, -2216394, -10276457, -4530982, -4935045, -2927433, 2952568, 1891592, -6151042, -7828647, -617246, 2503574, -9072878, -3135900, 10766842, -10276457, -4935045, 2952568, 2522583, 6526839, 12696742, 12652760, -5847575, 4072115, 853026, 5000199, -3241236, 2941196, -4942030, 2549034, 0
};

extern void __asm_negacyclic_ntt_32(uint32_t *des, const int32_t *root_table, uint32_t Qprime, uint32_t Q, uint16_t *src);
extern void __asm_negacyclic_ntt_16(uint32_t *des, const int16_t *root_table, uint32_t QQprime, uint16_t *src, uint32_t RmodQ);
extern void __asm_negacyclic_ntt_16_light(uint32_t *des, const int16_t *root_table, uint32_t QQprime, uint16_t *src, uint32_t RmodQ);

extern void __asm_mod(uint32_t *des, uint32_t QQprime, uint32_t *src);
extern void __asm_mod_dual(uint32_t *des1, uint32_t *des2, uint32_t _Q1Q1prime, uint32_t _Q2Q2prime, uint32_t *src);

extern void __asm_base_mul_32(uint32_t *des, const int32_t *mul_Rmod_table, uint32_t Qprime, uint32_t Q, uint32_t *src1, uint32_t *src2);
extern void __asm_base_mul_16(uint32_t *des, const int16_t *mul_Rmod_table, uint32_t QQprime, uint32_t *src1, uint32_t *src2);
extern void __asm_base_mul_32x16(uint32_t *des, const int16_t *mul_Rmod_table, uint32_t QQprime, uint32_t *src_32, uint32_t *src_16);

extern void __asm_solv_CRT_32_m4(uint32_t *des, uint32_t *src1, uint32_t *src2, const int32_t *_final_constants);
extern void __asm_negacyclic_intt_32(uint16_t *des, const int32_t *root_table, uint32_t Qprime, uint32_t Q, uint32_t *src);

#define NTT_forward_32(out, in) __asm_negacyclic_ntt_32(out, streamlined_CT_negacyclic_table_Q1Q2, Q1Q2prime, Q1Q2, in)

#define NTT_forward1(out, in) __asm_negacyclic_ntt_16(out, streamlined_CT_negacyclic_table_Q1, Q1Q1prime, in, RmodQ1)
#define NTT_forward2(out, in) __asm_negacyclic_ntt_16_light(out, streamlined_CT_negacyclic_table_Q2, Q2Q2prime, in, RmodQ2)

#define MOD_1(out, in) __asm_mod(out, Q1Q1prime, in)
#define MOD_2(out, in) __asm_mod(out, Q2Q2prime, in)
#define MOD_dual(out1, out2, in) __asm_mod_dual(out1, out2, Q1Q1prime, Q2Q2prime, in)

#define NTT_mul_16_1(out, in1, in2) __asm_base_mul_16(out, mul_Rmod_table_Q1, Q1Q1prime, in1, in2)
#define NTT_mul_16_2(out, in1, in2) __asm_base_mul_16(out, mul_Rmod_table_Q2, Q2Q2prime, in1, in2)

#define NTT_mul_32x16_1(out, in_32, in_16) __asm_base_mul_32x16(out, mul_Rmod_table_Q1, Q1Q1prime, in_32, in_16)
#define NTT_mul_32x16_2(out, in_32, in_16) __asm_base_mul_32x16(out, mul_Rmod_table_Q2, Q2Q2prime, in_32, in_16)

#define NTT_mul_32(out, in1, in2) __asm_base_mul_32(out, mul_Rmod_table_Q1Q2, Q1Q2prime, Q1Q2, in1, in2)

#define NTT_inv_32(out, in) __asm_negacyclic_intt_32(out, streamlined_inv_CT_negacyclic_table_Q1Q2, Q1Q2prime, Q1Q2, in)

#define solv_CRT(out, in1, in2) __asm_solv_CRT_32_m4(out, in1, in2, CRT_constants)


#endif
