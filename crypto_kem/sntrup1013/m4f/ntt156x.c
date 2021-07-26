#include "ntt156x.h"
void ntt312_128(int* fpad, int* f){
  int tmp[156];
  mask128_312(tmp, f);
  ntt13_rader_for312(fpad, tmp);
  ntt12_for312(fpad);
}
void ntt312_128x(int* fpad, int* f){
  int tmp[157];
  tmp[0]=0;
  mask128x_312(tmp, f);
  ntt13_rader_for312(fpad, tmp);
  ntt12_for312(fpad);
}
void basemul_312(int* h, int* f, int* g){
  basemul_2x2_156(h, f, g);
}
void intt312_256(int* h, int* fpad){
  int tmp[156];
  intt12_for312(fpad);
  intt13_rader_for312(tmp, fpad);
  imask256_312(h, tmp);
}
void intt312_256x(int* h, int* fpad){
  int tmp[156];
  intt12_for312(fpad);
  intt13_rader_for312(tmp, fpad);
  imask256x_312(h, tmp);
}

void ntt624_256(int* fpad, int* f){
  int tmp[312];
  mask256_624(tmp, f);
  ntt13_rader_for624(fpad, tmp);
  ntt12_for624(fpad);
}
void ntt624_256x(int* fpad, int* f){
  int tmp[313];
  tmp[0]=0;
  mask256x_624(tmp, f);
  ntt13_rader_for624(fpad, tmp);
  ntt12_for624(fpad);
}
void basemul_624(int* h, int* f, int* g){
  basemul_4x4_156(h, f, g);
}
void intt624_512(int* h, int* fpad){
  int tmp[312];
  intt12_for624(fpad);
  intt13_rader_for624(tmp, fpad);
  imask512_624(h, tmp);
}
void intt624_512x(int* h, int* fpad){
  int tmp[312];
  intt12_for624(fpad);
  intt13_rader_for624(tmp, fpad);
  imask512x_624(h, tmp);
}

void ntt1248_512(int* fpad, int* f){
  int tmp[624];
  mask512_1248(tmp, f);
  ntt13_rader_for1248(fpad, tmp);
  ntt12_for1248(fpad);
}
void ntt1248_512x(int* fpad, int* f){
  int tmp[625];
  tmp[0]=0;
  mask512x_1248(tmp, f);
  ntt13_rader_for1248(fpad, tmp);
  ntt12_for1248(fpad);
}
void basemul_1248(int* h, int* f, int* g){
  basemul_8x8_156(h, f, g);
}
void intt1248_1024(int* h, int* fpad){
  int tmp[624];
  intt12_for1248(fpad);
  intt13_rader_for1248(tmp, fpad);
  imask1024_1248(h, tmp);
}
void intt1248_1024x(int* h, int* fpad){
  int tmp[624];
  intt12_for1248(fpad);
  intt13_rader_for1248(tmp, fpad);
  imask1024x_1248(h, tmp);
}

void ntt2184_1013(int* fpad, int* f){
  int tmp[1092];
  mask1013(tmp, f);
  ntt13_rader(fpad, f);
  ntt24(fpad);
}

void basemul_2184(int* h, int* f, int* g){
  basemul_7x7_312(h, f, g);
}

void intt2184_2026(int* h, int* fpad){
  int tmp[1092];
  intt24(fpad);
  intt13_rader(tmp, fpad);
  imask2026(h, tmp);
}