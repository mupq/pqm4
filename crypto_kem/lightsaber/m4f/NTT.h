#ifndef NTT_H
#define NTT_H

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <stdbool.h>

#define N 256
#define RmodM -4378189
#define RinvN 4191613
#define R2invN 8870406
#define MOD 20972417
#define Mprime 1544799103

void NTT_forward(uint16_t* a, const int *root_table, int mod, int modprime, int *tmp);
void my_mul(int *a, const int *mul_table, int mod, int modprime, int *matrix0, int *matrix1, int *res);
void NTT_inv(int *in, const int *inv_root_table, int mod, int modprime,  uint16_t *out, uint16_t mod_mask);
void NTT_forward_pk(uint16_t *a,  const int * root_table, int mod, int modprime, int *tmp);
void NTT_inv_inner(int *in, const int *inv_root_table, int mod, int modprime, uint16_t *out, uint16_t mod_mask);
#endif
