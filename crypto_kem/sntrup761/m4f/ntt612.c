#include <stdint.h>

extern void mask256(int16_t* fpad, int16_t* f);
extern void mask256x(int16_t* fpad, int16_t* f);
extern void imask512(int16_t* f, int16_t* fpad);
extern void imask512x(int16_t* fpad, int16_t* f);
extern void Good17x9_Rader17_612(int16_t* fpad, int16_t* f);
extern void ntt9_rader_612(int16_t* fpad);
extern void polymul_4x4_153_mr(int16_t* hpad, int16_t* fpad, int16_t* gpad);
extern void intt9_rader_612(int16_t* fpad);
extern void iRader17_iGood17x9_612(int16_t* h, int16_t* fpad);

void ntt612(int16_t* fpad, int16_t* f);
void ntt612x(int16_t* fpad, int16_t* f);
void intt612(int16_t* f, int16_t* fpad);
void intt612x(int16_t* fpad, int16_t* f);
void basemul_612(int16_t* hpad, int16_t* fpad, int16_t* gpad);

void ntt612(int16_t* fpad, int16_t* f){
    int16_t tmp[613];
    mask256(tmp, f);
    Good17x9_Rader17_612(fpad, tmp);
    ntt9_rader_612(fpad);
}

void ntt612x(int16_t* fpad, int16_t* f){
    int16_t tmp[613];
    tmp[0]=0;
    mask256x(tmp, f);
    Good17x9_Rader17_612(fpad, tmp);
    ntt9_rader_612(fpad);
}

void basemul_612(int16_t* hpad, int16_t* fpad, int16_t* gpad){
    polymul_4x4_153_mr(hpad, fpad, gpad);
}

void intt612(int16_t* h, int16_t* fpad){
    int16_t tmp[613];
    intt9_rader_612(fpad);
    iRader17_iGood17x9_612(tmp, fpad);
    imask512(h, tmp);
}

void intt612x(int16_t* h, int16_t* fpad){
    int16_t tmp[613];
    intt9_rader_612(fpad);
    iRader17_iGood17x9_612(tmp, fpad);
    imask512x(h, tmp);
}