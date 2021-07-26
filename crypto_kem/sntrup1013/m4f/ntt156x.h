#ifndef NTT156X
#define NTT156X
extern void mask1013(int*, int*);
extern void ntt13_rader(int*, int*);
extern void ntt24(int*);
extern void basemul_7x7_312(int*, int*, int*);
extern void intt24(int*);
extern void intt13_rader(int*, int*);
extern void imask2026(int*, int*);

extern void mask128_312(int*, int*);
extern void mask128x_312(int*, int*);
extern void mask256_624(int*, int*);
extern void mask256x_624(int*, int*);
extern void mask512_1248(int*, int*);
extern void mask512x_1248(int*, int*);

extern void imask256_312(int*, int*);
extern void imask256x_312(int*, int*);
extern void imask512_624(int*, int*);
extern void imask512x_624(int*, int*);
extern void imask1024_1248(int*, int*);
extern void imask1024x_1248(int*, int*);

extern void basemul_2x2_156(int*, int*, int*);
extern void basemul_4x4_156(int*, int*, int*);
extern void basemul_8x8_156(int*, int*, int*);

extern void ntt13_rader_for312(int*, int*);
extern void ntt13_rader_for624(int*, int*);
extern void ntt13_rader_for1248(int*, int*);

extern void intt13_rader_for312(int*, int*);
extern void intt13_rader_for624(int*, int*);
extern void intt13_rader_for1248(int*, int*);

extern void ntt12_for312(int*);
extern void ntt12_for624(int*);
extern void ntt12_for1248(int*);

extern void intt12_for312(int*);
extern void intt12_for624(int*);
extern void intt12_for1248(int*);

void ntt2184_1013(int*, int*);
void basemul_2184(int*, int*, int*);
void intt2184_2026(int*, int*);

void ntt312_128(int*, int*);
void ntt312_128x(int*, int*);
void basemul_312(int*, int*, int*);
void intt312_256(int*, int*);
void intt312_256x(int*, int*);

void ntt624_256(int*, int*);
void ntt624_256x(int*, int*);
void basemul_624(int*, int*, int*);
void intt624_512(int*, int*);
void intt624_512x(int*, int*);

void ntt1248_512(int*, int*);
void ntt1248_512x(int*, int*);
void basemul_1248(int*, int*, int*);
void intt1248_1024(int*, int*);
void intt1248_1024x(int*, int*);
#endif