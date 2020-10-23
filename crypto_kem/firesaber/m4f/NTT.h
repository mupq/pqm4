#ifndef NTT_H
#define NTT_H

#include <stdint.h>

#define N 256
#define RmodM -8432555
#define RinvN -8389379
#define R2invN 7689784
#define MOD 25166081
#define Mprime 41877759

void NTT_forward(uint16_t* a, const int *root_table, int mod, int modprime, int *tmp);
void my_mul(int *a, const int *mul_table, int mod, int modprime, int *matrix0, int *matrix1, int *matrix2, int *matrix3, int *res);
void NTT_inv(int *in, const int *inv_root_table, int mod, int modprime,  uint16_t *out, uint16_t mod_mask);
void NTT_forward_pk(uint16_t *a,  const int * root_table, int mod, int modprime, int *tmp);
void NTT_inv_inner(int *in, const int *inv_root_table, int mod, int modprime, uint16_t *out, uint16_t mod_mask);

#endif
