#include "ntt78.h"

void ntt2808_1277(int* fpad, int* f){
    int tmp[1404];
    good_mask_13_6_36_1277(tmp, f);
    ntt13_rader(fpad, tmp);
    ntt6(fpad);
}

void intt2808_2554(int* h, int* fpad){
    int tmp[1404];
    intt6(fpad);
    intt13_rader(tmp, fpad);
    inv_good_mask_13_6_36_2554(h, tmp);
}

void ntt1248_512(int* fpad, int* f){
    int tmp[624];
    good_mask_13_6_16_512(tmp, f);
    ntt13_rader_1248(fpad, tmp);
    ntt6_1248(fpad);
}

void ntt1248_512x(int* fpad, int* f){
    int tmp[624];
    good_mask_13_6_16_512x(tmp, f);
    ntt13_rader_1248(fpad, tmp);
    ntt6_1248(fpad);
}

void intt1248_1024(int* h, int* fpad){
    int tmp[624];
    intt6_1248(fpad);
    intt13_rader_1248(tmp, fpad);
    inv_good_mask_13_6_16_1024(h, tmp);
}

void intt1248_1024x(int* h, int* fpad){
    int tmp[624];
    intt6_1248(fpad);
    intt13_rader_1248(tmp, fpad);
    inv_good_mask_13_6_16_1024x(h, tmp);
}