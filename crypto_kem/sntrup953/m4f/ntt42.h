#ifndef NTT42X
#define NTT42X

extern void good_mask_7_6_28_512(int*, int*);
extern void good_mask_7_6_28_512x(int*, int*);
extern void ntt7_rader_1176(int*, int*);
extern void ntt6_1176(int*);
extern void basemul_1176(int*, int*, int*);
extern void intt6_1176(int*);
extern void intt7_rader_1176(int*, int*);
extern void inv_good_mask_7_6_28_1024(int*, int*);
extern void inv_good_mask_7_6_28_1024x(int*, int*);

extern void good_mask_7_6_48_953(int*, int*);
extern void good_mask_7_6_48_953x(int*, int*);
extern void ntt7_rader(int*, int*);
extern void ntt6(int*);
extern void basemul_2016(int*, int*, int*);
extern void intt6(int*);
extern void intt7_rader(int*, int*);
extern void inv_good_mask_7_6_48_1906(int*, int*);

void ntt1176_512(int*, int*);
void ntt1176_512x(int*, int*);
void intt1176_1024(int*, int*);
void intt1176_1024x(int*, int*);

void ntt2016_953(int*, int*);
void ntt2016_953x(int*, int*);
void intt2016_1906(int*, int*);


#endif