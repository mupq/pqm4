#ifndef NTT287X
#define NTT287X

extern void good_mask_41_7_6_857(int*, int*);
extern void inv_good_mask_41_7_6_1722(int*, int*);
extern void ntt41_rader(int*, int*);
extern void intt41_rader(int*, int*);
extern void ntt7_rader(int*);
extern void intt7_rader(int*);
extern void polymul_6x6_287(int*, int*);

extern void good_mask_41_7_2_256(int*, int*);
extern void good_mask_41_7_2_256x(int*, int*);
extern void inv_good_mask_41_7_2_574(int*, int*);
extern void ntt41_rader_574(int*, int*);
extern void intt41_rader_574(int*, int*);
extern void ntt7_rader_574(int*);
extern void intt7_rader_574(int*);
extern void polymul_2x2_287(int*, int*, int*);

extern void good_mask_41_7_4_512(int*, int*);
extern void good_mask_41_7_4_512x(int*, int*);
extern void inv_good_mask_41_7_4_1148(int*, int*);
extern void ntt41_rader_1148(int*, int*);
extern void intt41_rader_1148(int*, int*);
extern void ntt7_rader_1148(int*);
extern void intt7_rader_1148(int*);
extern void polymul_4x4_287(int*, int*, int*);

extern void imask512_574(int*, int*);
extern void imask512x_574(int*, int*);
extern void imask1024_1148(int*, int*);
extern void imask1024x_1148(int*, int*);

void ntt1722_857(int*, int*);
void basemul_1722(int*, int*);
void intt1722(int*, int*);

void ntt574_256(int*, int*);
void ntt574_256x(int*, int*);
void basemul_574(int*, int*, int*);
void intt574_512(int*, int*);
void intt574_512x(int*, int*);

void ntt1148_512(int*, int*);
void ntt1148_512x(int*, int*);
void basemul_1148(int*, int*, int*);
void intt1148_1024(int*, int*);
void intt1148_1024x(int*, int*);

#endif