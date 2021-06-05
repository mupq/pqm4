// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#include <stdint.h>
#define r 24659

#include "run_config.h"

static inline uint32_t bit_mask(uint32_t s,int i) { return -((s>>i)&1); }

#if defined(_M4_ASM_)
void cshift(uint32_t *array, int s) { cshift_asm(array,s); }
#else



void cshift(uint32_t *array, int s)
{
  int i, j;
  uint32_t mask;
  uint32_t Rx0;
  uint32_t Rx1;
  uint32_t Rx2;
  uint32_t Rx3;
  uint32_t Ry0;
  uint32_t Ry1;
  uint32_t Ry2;
  uint32_t Ry3;

  // conditional shifting 512 blocks

  for (i = 0; i < 512; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 1024; j += 1024)
    {
        Ry0 = array[i+j+512];
        Ry1 = array[i+j+513];
        Ry2 = array[i+j+514];
        Ry3 = array[i+j+515];
        //if ((s >> 14) & 1) {
        {  mask = bit_mask(s,14);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+1024];
        Rx1 = array[i+j+1025];
        Rx2 = array[i+j+1026];
        Rx3 = array[i+j+1027];
        //if ((s >> 14) & 1) {
        {  mask = bit_mask(s,14);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+512] = Ry0;
        array[i+j+513] = Ry1;
        array[i+j+514] = Ry2;
        array[i+j+515] = Ry3;
    }
  }

  for (i = 0; i < 6; i++) {
    Rx0 = array[i + 1024];
    Ry0 = array[i + 1536];
    //if ((s >> 14) & 1)
    mask = bit_mask(s,14);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 1024] = Rx0;
  }

  // conditional shifting 256 blocks

  for (i = 0; i < 256; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 1024; j += 512)
    {
        Ry0 = array[i+j+256];
        Ry1 = array[i+j+257];
        Ry2 = array[i+j+258];
        Ry3 = array[i+j+259];
        //if ((s >> 13) & 1) {
        {  mask = bit_mask(s,13);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+512];
        Rx1 = array[i+j+513];
        Rx2 = array[i+j+514];
        Rx3 = array[i+j+515];
        //if ((s >> 13) & 1) {
        {  mask = bit_mask(s,13);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+256] = Ry0;
        array[i+j+257] = Ry1;
        array[i+j+258] = Ry2;
        array[i+j+259] = Ry3;
    }
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 1024];
    Ry0 = array[i + 1280];
    //if ((s >> 13) & 1)
    mask = bit_mask(s,13);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 1024] = Rx0;
  }

  // conditional shifting 128 blocks

  for (i = 0; i < 128; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 768; j += 256)
    {
        Ry0 = array[i+j+128];
        Ry1 = array[i+j+129];
        Ry2 = array[i+j+130];
        Ry3 = array[i+j+131];
        //if ((s >> 12) & 1) {
        {  mask = bit_mask(s,12);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+256];
        Rx1 = array[i+j+257];
        Rx2 = array[i+j+258];
        Rx3 = array[i+j+259];
        //if ((s >> 12) & 1) {
        {  mask = bit_mask(s,12);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+128] = Ry0;
        array[i+j+129] = Ry1;
        array[i+j+130] = Ry2;
        array[i+j+131] = Ry3;
    }
    Ry0 = array[i+j+128];
    Ry1 = array[i+j+129];
    Ry2 = array[i+j+130];
    Ry3 = array[i+j+131];
    //if ((s >> 12) & 1) {
    {  mask = bit_mask(s,12);
      //Rx0 = Ry0;
      Rx0 ^= (Ry0^Rx0)&mask;
      //Rx1 = Ry1;
      Rx1 ^= (Ry1^Rx1)&mask;
      //Rx2 = Ry2;
      Rx2 ^= (Ry2^Rx2)&mask;
      //Rx3 = Ry3;
      Rx3 ^= (Ry3^Rx3)&mask;
    }
    array[i+j+0] = Rx0;
    array[i+j+1] = Rx1;
    array[i+j+2] = Rx2;
    array[i+j+3] = Rx3;
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 896];
    Ry0 = array[i + 1024];
    //if ((s >> 12) & 1)
    mask = bit_mask(s,12);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 896] = Rx0;
  }

  // conditional shifting 64 blocks

  for (i = 0; i < 64; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 768; j += 128)
    {
        Ry0 = array[i+j+64];
        Ry1 = array[i+j+65];
        Ry2 = array[i+j+66];
        Ry3 = array[i+j+67];
        //if ((s >> 11) & 1) {
        {  mask = bit_mask(s,11);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+128];
        Rx1 = array[i+j+129];
        Rx2 = array[i+j+130];
        Rx3 = array[i+j+131];
        //if ((s >> 11) & 1) {
        {  mask = bit_mask(s,11);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+64] = Ry0;
        array[i+j+65] = Ry1;
        array[i+j+66] = Ry2;
        array[i+j+67] = Ry3;
    }
    Ry0 = array[i+j+64];
    Ry1 = array[i+j+65];
    Ry2 = array[i+j+66];
    Ry3 = array[i+j+67];
    //if ((s >> 11) & 1) {
    {  mask = bit_mask(s,11);
      //Rx0 = Ry0;
      Rx0 ^= (Ry0^Rx0)&mask;
      //Rx1 = Ry1;
      Rx1 ^= (Ry1^Rx1)&mask;
      //Rx2 = Ry2;
      Rx2 ^= (Ry2^Rx2)&mask;
      //Rx3 = Ry3;
      Rx3 ^= (Ry3^Rx3)&mask;
    }
    array[i+j+0] = Rx0;
    array[i+j+1] = Rx1;
    array[i+j+2] = Rx2;
    array[i+j+3] = Rx3;
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 832];
    Ry0 = array[i + 896];
    //if ((s >> 11) & 1)
    mask = bit_mask(s,11);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 832] = Rx0;
  }

  // conditional shifting 32 blocks

  for (i = 0; i < 32; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 768; j += 64)
    {
        Ry0 = array[i+j+32];
        Ry1 = array[i+j+33];
        Ry2 = array[i+j+34];
        Ry3 = array[i+j+35];
        //if ((s >> 10) & 1) {
        {  mask = bit_mask(s,10);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+64];
        Rx1 = array[i+j+65];
        Rx2 = array[i+j+66];
        Rx3 = array[i+j+67];
        //if ((s >> 10) & 1) {
        {  mask = bit_mask(s,10);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+32] = Ry0;
        array[i+j+33] = Ry1;
        array[i+j+34] = Ry2;
        array[i+j+35] = Ry3;
    }
    Ry0 = array[i+j+32];
    Ry1 = array[i+j+33];
    Ry2 = array[i+j+34];
    Ry3 = array[i+j+35];
    //if ((s >> 10) & 1) {
    {  mask = bit_mask(s,10);
      //Rx0 = Ry0;
      Rx0 ^= (Ry0^Rx0)&mask;
      //Rx1 = Ry1;
      Rx1 ^= (Ry1^Rx1)&mask;
      //Rx2 = Ry2;
      Rx2 ^= (Ry2^Rx2)&mask;
      //Rx3 = Ry3;
      Rx3 ^= (Ry3^Rx3)&mask;
    }
    array[i+j+0] = Rx0;
    array[i+j+1] = Rx1;
    array[i+j+2] = Rx2;
    array[i+j+3] = Rx3;
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 800];
    Ry0 = array[i + 832];
    //if ((s >> 10) & 1)
    mask = bit_mask(s,10);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 800] = Rx0;
  }

  // conditional shifting 16 blocks

  for (i = 0; i < 16; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 768; j += 32)
    {
        Ry0 = array[i+j+16];
        Ry1 = array[i+j+17];
        Ry2 = array[i+j+18];
        Ry3 = array[i+j+19];
        //if ((s >> 9) & 1) {
        {  mask = bit_mask(s,9);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+32];
        Rx1 = array[i+j+33];
        Rx2 = array[i+j+34];
        Rx3 = array[i+j+35];
        //if ((s >> 9) & 1) {
        {  mask = bit_mask(s,9);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+16] = Ry0;
        array[i+j+17] = Ry1;
        array[i+j+18] = Ry2;
        array[i+j+19] = Ry3;
    }
    Ry0 = array[i+j+16];
    Ry1 = array[i+j+17];
    Ry2 = array[i+j+18];
    Ry3 = array[i+j+19];
    //if ((s >> 9) & 1) {
    {  mask = bit_mask(s,9);
      //Rx0 = Ry0;
      Rx0 ^= (Ry0^Rx0)&mask;
      //Rx1 = Ry1;
      Rx1 ^= (Ry1^Rx1)&mask;
      //Rx2 = Ry2;
      Rx2 ^= (Ry2^Rx2)&mask;
      //Rx3 = Ry3;
      Rx3 ^= (Ry3^Rx3)&mask;
    }
    array[i+j+0] = Rx0;
    array[i+j+1] = Rx1;
    array[i+j+2] = Rx2;
    array[i+j+3] = Rx3;
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 784];
    Ry0 = array[i + 800];
    //if ((s >> 9) & 1)
    mask = bit_mask(s,9);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 784] = Rx0;
  }

  // conditional shifting 8 blocks

  for (i = 0; i < 8; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 768; j += 16)
    {
        Ry0 = array[i+j+8];
        Ry1 = array[i+j+9];
        Ry2 = array[i+j+10];
        Ry3 = array[i+j+11];
        //if ((s >> 8) & 1) {
        {  mask = bit_mask(s,8);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+16];
        Rx1 = array[i+j+17];
        Rx2 = array[i+j+18];
        Rx3 = array[i+j+19];
        //if ((s >> 8) & 1) {
        {  mask = bit_mask(s,8);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+8] = Ry0;
        array[i+j+9] = Ry1;
        array[i+j+10] = Ry2;
        array[i+j+11] = Ry3;
    }
    Ry0 = array[i+j+8];
    Ry1 = array[i+j+9];
    Ry2 = array[i+j+10];
    Ry3 = array[i+j+11];
    //if ((s >> 8) & 1) {
    {  mask = bit_mask(s,8);
      //Rx0 = Ry0;
      Rx0 ^= (Ry0^Rx0)&mask;
      //Rx1 = Ry1;
      Rx1 ^= (Ry1^Rx1)&mask;
      //Rx2 = Ry2;
      Rx2 ^= (Ry2^Rx2)&mask;
      //Rx3 = Ry3;
      Rx3 ^= (Ry3^Rx3)&mask;
    }
    array[i+j+0] = Rx0;
    array[i+j+1] = Rx1;
    array[i+j+2] = Rx2;
    array[i+j+3] = Rx3;
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 776];
    Ry0 = array[i + 784];
    //if ((s >> 8) & 1)
    mask = bit_mask(s,8);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 776] = Rx0;
  }

  // conditional shifting 4 blocks

  for (i = 0; i < 4; i += 4) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    Rx2 = array[i+2];
    Rx3 = array[i+3];
    for (j = 0; j < 768; j += 8)
    {
        Ry0 = array[i+j+4];
        Ry1 = array[i+j+5];
        Ry2 = array[i+j+6];
        Ry3 = array[i+j+7];
        //if ((s >> 7) & 1) {
        {  mask = bit_mask(s,7);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
          //Rx2 = Ry2;
          Rx2 ^= (Ry2^Rx2)&mask;
          //Rx3 = Ry3;
          Rx3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        array[i+j+2] = Rx2;
        array[i+j+3] = Rx3;
        Rx0 = array[i+j+8];
        Rx1 = array[i+j+9];
        Rx2 = array[i+j+10];
        Rx3 = array[i+j+11];
        //if ((s >> 7) & 1) {
        {  mask = bit_mask(s,7);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
          //Ry2 = Rx2;
          Ry2 ^= (Ry2^Rx2)&mask;
          //Ry3 = Rx3;
          Ry3 ^= (Ry3^Rx3)&mask;
        }
        array[i+j+4] = Ry0;
        array[i+j+5] = Ry1;
        array[i+j+6] = Ry2;
        array[i+j+7] = Ry3;
    }
    Ry0 = array[i+j+4];
    Ry1 = array[i+j+5];
    Ry2 = array[i+j+6];
    Ry3 = array[i+j+7];
    //if ((s >> 7) & 1) {
    {  mask = bit_mask(s,7);
      //Rx0 = Ry0;
      Rx0 ^= (Ry0^Rx0)&mask;
      //Rx1 = Ry1;
      Rx1 ^= (Ry1^Rx1)&mask;
      //Rx2 = Ry2;
      Rx2 ^= (Ry2^Rx2)&mask;
      //Rx3 = Ry3;
      Rx3 ^= (Ry3^Rx3)&mask;
    }
    array[i+j+0] = Rx0;
    array[i+j+1] = Rx1;
    array[i+j+2] = Rx2;
    array[i+j+3] = Rx3;
  }

  for (i = 0; i < 3; i++) {
    Rx0 = array[i + 772];
    Ry0 = array[i + 776];
    //if ((s >> 7) & 1)
    mask = bit_mask(s,7);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 772] = Rx0;
  }

  // conditional shifting 2 blocks

  for (i = 0; i < 2; i += 2) {
    Rx0 = array[i+0];
    Rx1 = array[i+1];
    for (j = 0; j < 772; j += 4)
    {
        Ry0 = array[i+j+2];
        Ry1 = array[i+j+3];
        //if ((s >> 6) & 1) {
        {  mask = bit_mask(s,6);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
          //Rx1 = Ry1;
          Rx1 ^= (Ry1^Rx1)&mask;
        }
        array[i+j+0] = Rx0;
        array[i+j+1] = Rx1;
        Rx0 = array[i+j+4];
        Rx1 = array[i+j+5];
        //if ((s >> 6) & 1) {
        {  mask = bit_mask(s,6);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
          //Ry1 = Rx1;
          Ry1 ^= (Ry1^Rx1)&mask;
        }
        array[i+j+2] = Ry0;
        array[i+j+3] = Ry1;
    }
  }

  for (i = 0; i < 1; i++) {
    Rx0 = array[i + 772];
    Ry0 = array[i + 774];
    //if ((s >> 6) & 1)
    mask = bit_mask(s,6);
      //Rx0 = Ry0;
      Rx0 ^= (Rx0^Ry0)&mask;
    array[i + 772] = Rx0;
  }

  // conditional shifting 1 blocks

  for (i = 0; i < 1; i += 1) {
    Rx0 = array[i+0];
    for (j = 0; j < 772; j += 2)
    {
        Ry0 = array[i+j+1];
        //if ((s >> 5) & 1) {
        {  mask = bit_mask(s,5);
          //Rx0 = Ry0;
          Rx0 ^= (Ry0^Rx0)&mask;
        }
        array[i+j+0] = Rx0;
        Rx0 = array[i+j+2];
        //if ((s >> 5) & 1) {
        {  mask = bit_mask(s,5);
          //Ry0 = Rx0;
          Ry0 ^= (Ry0^Rx0)&mask;
        }
        array[i+j+1] = Ry0;
    }
  }

}

#endif //defined(_M4_ASM_)

static inline
uint64_t umlal( uint64_t c, uint32_t a, uint32_t b ) { return c + (uint64_t)((uint64_t)a)*((uint64_t)b); }


static inline
void shiftright_small_umlal_C(uint32_t *array, int s, int len ) {

  uint32_t s_mul = (((1ULL)<<(32-s))-1)&0xffffffff;
  union {
    uint64_t u64;
    uint32_t u32[2];
  } c;

  c.u64 = umlal( array[len] , s_mul , array[len] );
  for(int i=len-1;i>=0;i--) {
    c.u32[1] = c.u32[0];
    c.u32[0] = array[i];
    c.u64 = umlal( c.u64 , s_mul , array[i] );
    array[i] = c.u32[1];
  }

}

static inline void cshift_small(uint32_t *array1, int s) {
  s &= 31;
#if defined(_M4_ASM_)
  shiftright_small_umlal(array1, s, (r+31)/32);
#else
  int sh = 32-s;
  for(int i = 0; i < (r+31)/32; i++)
    array1[i] = (array1[i]>>s)|((((uint64_t)array1[i+1])<<sh)&0xffffffff);
    //array1[i] = (array1[i]>>s)|(array1[i+1]<<sh);
#endif
}

static inline void rotr_cshift_fixtail(uint32_t *array) {
  array[771 - 1] &= 0x7ffff;
  array[771 ] = 0;
}

void rotr_cshift(uint32_t *array1, const uint32_t *array0, int s) {
  if(array1 != array0) for(int i=0;i<(2*r-1+31)/32;i++) array1[i]=array0[i];
  cshift(array1, s);
  cshift_small(array1, s);
  rotr_cshift_fixtail(array1);
}


void rotr_cshift_prepare(uint32_t *array) {
  array[771 - 1] = (array[0] << 19) | (array[771 - 1] & 0x7ffff); 
  for(int i = 0; i < 771 ; i++)
     array[771 + i] = (array[i] >> 13 ) | ( array[i + 1] << 19 );
}


#if defined(DEBUGTEST)
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "randombytes.h"
#define SIZE_MEMORY_CSHIFT_24659 1542

int main()
{
  uint32_t array0[ (2*r-1+31)/32 +1];
  uint32_t array1[ SIZE_MEMORY_CSHIFT_24659 ];
  int i, s;

  for (s = 0; s < r; s++)
  {
    printf("shifting %d bits...\n", s);
    randombytes((unsigned char *) array0, sizeof(array0));
    //for (i = 0; i < (2*r-1+31)/32; i++)
    //  printf("%.8lX", array0[i]);
    //printf("\n");
    rotr_cshift_prepare(array0);
    //
    rotr_cshift(array1, array0, s);
    //
    for (i = 0; i < r; i++) {
      //printf("i = %d\n", i);
      assert(((array1[i/32] >> (i%32)) & 1) == ((array0[ (i+s)/32 ] >> ((i+s)%32)) & 1));
    }
  }
  return 0;
}
#endif //defined(DEBUGTEST)
