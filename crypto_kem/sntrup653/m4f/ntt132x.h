#ifndef NTT132X
#define NTT132X

extern void mask128_264(int* fpad, int* f);
extern void mask128x_264(int* fpad, int* f);
extern void mask256_528(int* fpad, int* f);
extern void mask256x_528(int* fpad, int* f);
extern void mask256_792(int* fpad, int* f);
extern void mask256x_792(int* fpad, int* f);
extern void mask512_792(int* fpad, int* f);
extern void mask512x_792(int* fpad, int* f);
extern void imask256_264(int* f, int* fpad);
extern void imask256x_264(int* f, int* fpad);
extern void imask512_528(int* f, int* fpad);
extern void imask512x_528(int* f, int* fpad);
extern void imask768_792(int* f, int* fpad);
extern void imask768x_792(int* f, int* fpad);

extern void ntt11_rader_264(int* fpad, int* f);
extern void ntt11_rader_528(int* fpad, int* f);
extern void ntt11_rader_792(int* fpad, int* f);
extern void ntt12_for264(int* fpad);
extern void ntt12_for528(int* fpad);
extern void ntt12_for792(int* fpad);
extern void polymul_2x2_132(int* hpad, int* fpad, int* gpad);
extern void polymul_4x4_132(int* hpad, int* fpad, int* gpad);
extern void polymul_6x6_132(int* hpad, int* fpad, int* gpad);
extern void intt12_for264(int* fpad);
extern void intt12_for528(int* fpad);
extern void intt12_for792(int* fpad);
extern void intt11_rader_264(int* h, int* fpad);
extern void intt11_rader_528(int* h, int* fpad);
extern void intt11_rader_792(int* h, int* fpad);

void ntt264_128(int* fpad, int* f);
void ntt264_128x(int* fpad, int* f);
void intt264_256(int* f, int* fpad);
void intt264_256x(int* f, int* fpad);
void basemul_264(int* hpad, int* fpad, int* gpad);

void ntt528_256(int* fpad, int* f);
void ntt528_256x(int* fpad, int* f);
void intt528_512(int* f, int* fpad);
void intt528_512x(int* f, int* fpad);
void basemul_528(int* hpad, int* fpad, int* gpad);

void ntt792_256(int* fpad, int* f);
void ntt792_256x(int* fpad, int* f);
void ntt792_512(int* fpad, int* f);
void ntt792_512x(int* fpad, int* f);
void intt792_768(int* f, int* fpad);
void intt792_768x(int* f, int* fpad);
void basemul_792(int* hpad, int* fpad, int* gpad);

#endif