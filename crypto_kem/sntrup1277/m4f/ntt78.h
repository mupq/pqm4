#ifndef NTT78X
#define NTT78X
extern void good_mask_13_6_36_1277(int*, int*);
extern void ntt13_rader(int*, int*);
extern void ntt6(int*);
extern void basemul_2808(int*, int*, int*);
extern void intt6(int*);
extern void intt13_rader(int*, int*);
extern void inv_good_mask_13_6_36_2554(int*, int*);

extern void good_mask_13_6_16_512(int*, int*);
extern void good_mask_13_6_16_512x(int*, int*);
extern void ntt13_rader_1248(int*, int*);
extern void ntt6_1248(int*);
extern void basemul_1248(int*, int*, int*);
extern void intt6_1248(int*);
extern void intt13_rader_1248(int*, int*);
extern void inv_good_mask_13_6_16_1024(int*, int*);
extern void inv_good_mask_13_6_16_1024x(int*, int*);

void ntt2808_1277(int* fpad, int* f);
void intt2808_2554(int* h, int* fpad);

void ntt1248_512(int* fpad, int* f);
void ntt1248_512x(int* fpad, int* f);
void intt1248_1024(int* h, int* fpad);
void intt1248_1024x(int* h, int* fpad);
#endif