#include <stdint.h>

extern void mask256_918(int16_t* fpad, int16_t* f);
extern void mask256x_918(int16_t* fpad, int16_t* f);
extern void mask512_918(int16_t* f, int16_t* fpad);
extern void mask512x_918(int16_t* fpad, int16_t* f);
extern void imask768_918(int16_t* f, int16_t* fpad);
extern void imask768x_918(int16_t* fpad, int16_t* f);
extern void Good17x9_Rader17_918(int16_t* fpad, int16_t* f);
extern void ntt9_rader_918(int16_t* fpad);
extern void polymul_6x6_153_mr(int16_t* hpad, int16_t* fpad, int16_t* gpad);
extern void intt9_rader_918(int16_t* fpad);
extern void iRader17_iGood17x9_918(int16_t* h, int16_t* fpad);

void ntt918_256(int16_t* fpad, int16_t* f);
void ntt918_256x(int16_t* fpad, int16_t* f);
void ntt918_512(int16_t* fpad, int16_t* f);
void ntt918_512x(int16_t* fpad, int16_t* f);
void intt918_768(int16_t* f, int16_t* fpad);
void intt918_768x(int16_t* fpad, int16_t* f);
void basemul_918(int16_t* hpad, int16_t* fpad, int16_t* gpad);


void ntt918_256(int16_t* fpad, int16_t* f){
    int16_t tmp918[919];
    mask256_918(tmp918, f);
    Good17x9_Rader17_918(fpad, tmp918);
    ntt9_rader_918(fpad);
}

void ntt918_256x(int16_t* fpad, int16_t* f){
    int16_t tmp918[919];
    tmp918[0]=0;
    mask256x_918(tmp918, f);
    Good17x9_Rader17_918(fpad, tmp918);
    ntt9_rader_918(fpad);
}

void ntt918_512(int16_t* fpad, int16_t* f){
    int16_t tmp918[919];
    mask512_918(tmp918, f);
    Good17x9_Rader17_918(fpad, tmp918);
    ntt9_rader_918(fpad);
}

void ntt918_512x(int16_t* fpad, int16_t* f){
    int16_t tmp918[919];
    tmp918[0]=0;
    mask512x_918(tmp918, f);
    Good17x9_Rader17_918(fpad, tmp918);
    ntt9_rader_918(fpad);
}

void basemul_918(int16_t* hpad, int16_t* fpad, int16_t* gpad){
    polymul_6x6_153_mr(hpad, fpad, gpad);
}

void intt918_768(int16_t* h, int16_t* fpad){
    int16_t tmp918[919];
    intt9_rader_918(fpad);
    iRader17_iGood17x9_918(tmp918, fpad);
    imask768_918(h, tmp918);
}

void intt918_768x(int16_t* h, int16_t* fpad){
    int16_t tmp918[919];
    intt9_rader_918(fpad);
    iRader17_iGood17x9_918(tmp918, fpad);
    imask768x_918(h, tmp918);
}