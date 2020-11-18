
#ifndef NTT_H
#define NTT_H

#define RmodM 78830
#define R2inv256 -14494
#define Rinv256 73712
#define inv256 -4078
#define MOD 1043969
#define Mprime 1993076223


void mul_509(unsigned short *res_coeffs, const unsigned short *small_coeffs, const unsigned short *big_coeffs);

#endif
