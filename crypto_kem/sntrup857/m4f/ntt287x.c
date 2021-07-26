#include "ntt287x.h"

void ntt1722_857(int* fpad, int* f){
    good_mask_41_7_6_857(fpad, f);
    ntt41_rader(fpad, fpad);
    ntt7_rader(fpad);
}

void basemul_1722(int* fpad, int* gpad){
    polymul_6x6_287(fpad, gpad);
}

void intt1722(int* h, int* fpad){
    intt7_rader(fpad);
	intt41_rader(fpad, fpad);
	inv_good_mask_41_7_6_1722(h, fpad);
}

void ntt574_256(int* fpad, int* f){
    good_mask_41_7_2_256(fpad, f);
    ntt41_rader_574(fpad, fpad);
    ntt7_rader_574(fpad);
}

void ntt574_256x(int* fpad, int* f){
    good_mask_41_7_2_256x(fpad, f);
    ntt41_rader_574(fpad, fpad);
    ntt7_rader_574(fpad);
}

void basemul_574(int* h, int* f, int* g){
    polymul_2x2_287(h, f, g);
}

void intt574_512(int* h, int* fpad){
    int tmp[287];
    intt7_rader_574(fpad);
	intt41_rader_574(fpad, fpad);
	inv_good_mask_41_7_2_574(tmp, fpad);
    imask512_574(h, tmp);
}

void intt574_512x(int* h, int* fpad){
    int tmp[287];
    intt7_rader_574(fpad);
	intt41_rader_574(fpad, fpad);
	inv_good_mask_41_7_2_574(tmp, fpad);
    imask512x_574(h, tmp);
}

void ntt1148_512(int* fpad, int* f){
    good_mask_41_7_4_512(fpad, f);
    ntt41_rader_1148(fpad, fpad);
    ntt7_rader_1148(fpad);
}

void ntt1148_512x(int* fpad, int* f){
    good_mask_41_7_4_512x(fpad, f);
    ntt41_rader_1148(fpad, fpad);
    ntt7_rader_1148(fpad);
}

void basemul_1148(int* h, int* f, int* g){
    polymul_4x4_287(h, f, g);
}

void intt1148_1024(int* h, int* fpad){
    int tmp[574];
    intt7_rader_1148(fpad);
	intt41_rader_1148(fpad, fpad);
	inv_good_mask_41_7_4_1148(tmp, fpad);
    imask1024_1148(h, tmp);
}

void intt1148_1024x(int* h, int* fpad){
    int tmp[574];
    intt7_rader_1148(fpad);
	intt41_rader_1148(fpad, fpad);
	inv_good_mask_41_7_4_1148(tmp, fpad);
    imask1024x_1148(h, tmp);
}