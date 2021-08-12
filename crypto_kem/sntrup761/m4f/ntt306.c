#include <stdint.h>

extern void mask128(int16_t* fpad, int16_t* f);
extern void mask128x(int16_t* fpad, int16_t* f);
extern void imask256(int16_t* f, int16_t* fpad);
extern void imask256x(int16_t* fpad, int16_t* f);
extern void Good17x9_Rader17_306(int16_t* fpad, int16_t* f);
extern void ntt9_rader_306(int16_t* fpad);
extern void polymul_2x2_153_mr(int16_t* hpad, int16_t* fpad, int16_t* gpad);
extern void intt9_rader_306(int16_t* fpad);
extern void iRader17_iGood17x9_306(int16_t* h, int16_t* fpad);

void ntt306(int16_t* fpad, int16_t* f);
void ntt306x(int16_t* fpad, int16_t* f);
void intt306(int16_t* f, int16_t* fpad);
void intt306x(int16_t* fpad, int16_t* f);
void basemul_306(int16_t* hpad, int16_t* fpad, int16_t* gpad);

void ntt306(int16_t* fpad, int16_t* f){
    int16_t tmp306[307];
    mask128(tmp306, f);
    Good17x9_Rader17_306(fpad, tmp306);
    ntt9_rader_306(fpad);
}

void ntt306x(int16_t* fpad, int16_t* f){
    int16_t tmp306[307];
    tmp306[0]=0;
    mask128x(tmp306, f);
    Good17x9_Rader17_306(fpad, tmp306);
    ntt9_rader_306(fpad);
}

void basemul_306(int16_t* hpad, int16_t* fpad, int16_t* gpad){
    polymul_2x2_153_mr(hpad, fpad, gpad);
}

void intt306(int16_t* h, int16_t* fpad){
    int16_t tmp306[307];
    intt9_rader_306(fpad);
    iRader17_iGood17x9_306(tmp306, fpad);
    imask256(h, tmp306);
}

void intt306x(int16_t* h, int16_t* fpad){
    int16_t tmp306[307];
    intt9_rader_306(fpad);
    iRader17_iGood17x9_306(tmp306, fpad);
    imask256x(h, tmp306);
}