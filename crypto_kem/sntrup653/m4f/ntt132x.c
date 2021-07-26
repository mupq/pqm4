#include "ntt132x.h"

void ntt264_128(int* fpad, int* f){
    int tmp[132];
    mask128_264(tmp, f);
    ntt11_rader_264(fpad, tmp);
    ntt12_for264(fpad);
}

void ntt264_128x(int* fpad, int* f){
    int tmp[133];
    tmp[0]=0;
    mask128x_264(tmp, f);
    ntt11_rader_264(fpad, tmp);
    ntt12_for264(fpad);
}

void basemul_264(int* hpad, int* fpad, int* gpad){
    polymul_2x2_132(hpad, fpad, gpad);
}

void intt264_256(int* f, int* fpad){
    int tmp[132];
    intt12_for264(fpad);
    intt11_rader_264(tmp, fpad);
    imask256_264(f, tmp);
}

void intt264_256x(int* f, int* fpad){
    int tmp[132];
    intt12_for264(fpad);
    intt11_rader_264(tmp, fpad);
    imask256x_264(f, tmp);
}

void ntt528_256(int* fpad, int* f){
    int tmp[264];
    mask256_528(tmp, f);
    ntt11_rader_528(fpad, tmp);
    ntt12_for528(fpad);
}

void ntt528_256x(int* fpad, int* f){
    int tmp[265];
    tmp[0]=0;
    mask256x_528(tmp, f);
    ntt11_rader_528(fpad, tmp);
    ntt12_for528(fpad);
}

void basemul_528(int* hpad, int* fpad, int* gpad){
    polymul_4x4_132(hpad, fpad, gpad);
}

void intt528_512(int* f, int* fpad){
    int tmp[264];
    intt12_for528(fpad);
    intt11_rader_528(tmp, fpad);
    imask512_528(f, tmp);
}

void intt528_512x(int* f, int* fpad){
    int tmp[264];
    intt12_for528(fpad);
    intt11_rader_528(tmp, fpad);
    imask512x_528(f, tmp);
}

void ntt792_256(int* fpad, int* f){
    int tmp[396];
    mask256_792(tmp, f);
    ntt11_rader_792(fpad, tmp);
    ntt12_for792(fpad);
}

void ntt792_256x(int* fpad, int* f){
    int tmp[397];
    tmp[0]=0;
    mask256x_792(tmp, f);
    ntt11_rader_792(fpad, tmp);
    ntt12_for792(fpad);
}

void ntt792_512(int* fpad, int* f){
    int tmp[396];
    mask512_792(tmp, f);
    ntt11_rader_792(fpad, tmp);
    ntt12_for792(fpad);
}

void ntt792_512x(int* fpad, int* f){
    int tmp[397];
    tmp[0]=0;
    mask512x_792(tmp, f);
    ntt11_rader_792(fpad, tmp);
    ntt12_for792(fpad);
}

void basemul_792(int* hpad, int* fpad, int* gpad){
    polymul_6x6_132(hpad, fpad, gpad);
}

void intt792_768(int* f, int* fpad){
    int tmp[396];
    intt12_for792(fpad);
    intt11_rader_792(tmp, fpad);
    imask768_792(f, tmp);
}

void intt792_768x(int* f, int* fpad){
    int tmp[396];
    intt12_for792(fpad);
    intt11_rader_792(tmp, fpad);
    imask768x_792(f, tmp);
}