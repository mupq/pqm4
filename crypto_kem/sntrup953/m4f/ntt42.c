#include "ntt42.h"

void ntt1176_512(int* fpad, int* f){
    good_mask_7_6_28_512(fpad, f);
    ntt7_rader_1176(fpad, fpad);
    ntt6_1176(fpad);
}

void intt1176_1024(int* h, int* fpad){
    intt6_1176(fpad);
    intt7_rader_1176(fpad, fpad);
    inv_good_mask_7_6_28_1024(h, fpad);
}

void ntt1176_512x(int* fpad, int* f){
    good_mask_7_6_28_512x(fpad, f);
    ntt7_rader_1176(fpad, fpad);
    ntt6_1176(fpad);
}

void intt1176_1024x(int* h, int* fpad){
    intt6_1176(fpad);
    intt7_rader_1176(fpad, fpad);
    inv_good_mask_7_6_28_1024x(h, fpad);
}

void ntt2016_953(int* fpad, int* f){
    good_mask_7_6_48_953(fpad, f);
    ntt7_rader(fpad, fpad);
    ntt6(fpad);
}

void intt2016_1906(int* h, int* fpad){
    intt6(fpad);
    intt7_rader(fpad, fpad);
    inv_good_mask_7_6_48_1906(h, fpad);
}

void ntt2016_953x(int* fpad, int* f){
    good_mask_7_6_48_953x(fpad, f);
    ntt7_rader(fpad, fpad);
    ntt6(fpad);
}