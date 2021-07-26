#include "NTT.h"

const int streamlined_Rmod_root_table[NTT_N << 1] = {
1722679, 1722679, 865525, 1722679, -1290222, -1508812, -1650143, 1722679, 1722679, -1290222, 1722679, -1290222, -1508812, -1650143, -1290222, -1508812, -1650143, 1753243, 1975668, -410333, -1565538, -1508812, 1753243, 1975668, -547910, -1280995, -879274, 469574, -1650143, -410333, -1565538, 1482164, -1623492, 1023660, -83082, 1753243, -547910, -1280995, -1691482, -1390688, -101462, 886303, 1975668, -879274, 469574, 1646095, -554949, -1925069, 40913, -410333, 1482164, -1623492, -421547, -133625, 197532, 1161616, -1565538, 1023660, -83082, -1144915, -1694402, 491373, -1436838
};
const int streamlined_Rmod_inv_GS_root_table[NTT_N << 1] = {
1722679, 1722679, 1290222, 1722679, 1290222, 1650143, 1508812, 1722679, 1722679, 1290222, 1722679, 1290222, 1650143, 1508812, 1290222, 1650143, 1508812, 1565538, 410333, -1975668, -1753243, 1650143, 1565538, 410333, 83082, -1023660, 1623492, -1482164, 1508812, -1975668, -1753243, -469574, 879274, 1280995, 547910, 1565538, 83082, -1023660, 1436838, -491373, 1694402, 1144915, 410333, 1623492, -1482164, -1161616, -197532, 133625, 421547, -1975668, -469574, 879274, -40913, 1925069, 554949, -1646095, -1753243, 1280995, 547910, -886303, 101462, 1390688, 1691482
};

// 0, 3, 6, 1, 4, 7, 2, 5, 8
const int _9_NTT_Rmod_root_table[9] = {
1722679, -1785888, 63209,
668135, -290078, -378057,
654672, -1729508, 1074836
};

// 0, 6, 3, 8, 5, 2, 7, 4, 1
const int _9_inv_NTT_Rmod_root_table[9] = {
1722679, 63209, -1785888,
1074836, -1729508, 654672,
-378057, -290078, 668135
};

extern void __asm_Good_64x27(int*, const int*, int, int, int*);
extern void __asm_Good_64x27_small(int*, const int*, int, int, int*);
extern void __asm_ntt_3_4_5(int*, const int*, int, int);
extern void __asm_9_ntt(int*, const int*, int, int);
extern void __asm_base_mul(int*, int*, int, int, const int*);
extern void __asm_9_intt(int*, const int*, int, int);
extern void __asm_intt(int*, const int*, int, int);
extern void __asm_final_map(int*, int, int, int, int*);

void polymul_857x857_mod5167(int* polyout, int* polyin1, int* polyin2);
void polymul_857x857_mod5167(int* polyout, int* polyin1, int* polyin2){
    int mem[1 << 12];
    int *ntt1, *ntt2;
    ntt1 = mem;
    ntt2 = ntt1 + ARRAY_N;
    __asm_Good_64x27(ntt1, streamlined_Rmod_root_table, Mprime, MOD, polyin1);
    __asm_Good_64x27_small(ntt2, streamlined_Rmod_root_table, Mprime, MOD, polyin2);
    __asm_ntt_3_4_5(ntt1, streamlined_Rmod_root_table, Mprime, MOD);
    __asm_ntt_3_4_5(ntt2, streamlined_Rmod_root_table, Mprime, MOD);
    __asm_9_ntt(ntt1, _9_NTT_Rmod_root_table, Mprime, MOD);
    __asm_9_ntt(ntt2, _9_NTT_Rmod_root_table, Mprime, MOD);
    __asm_base_mul(ntt1, ntt2, Mprime, MOD, _9_NTT_Rmod_root_table);
    __asm_9_intt(ntt1, _9_inv_NTT_Rmod_root_table, Mprime, MOD);
    __asm_intt(ntt1, streamlined_Rmod_inv_GS_root_table, Mprime, MOD);
    __asm_final_map(ntt1, Mhalf, Mprime, MOD, polyout);
}