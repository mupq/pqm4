#include "int16.h"
#include "uint16.h"
#include "uint32.h"
#include "Encode.h"

void Encode_Rq(unsigned char *out,int16 *R)
{
  // const int16 *R0 = R;
  /* XXX: caller could overlap R with input */
  // uint16 R[381];
  long i;
  uint16 r0,r1;
  uint32 r2;
  
  for (i = 0;i < 380;++i) {
    r0 = R[2*i]+2295;
    r1 = R[2*i+1]+2295;
    r2 = r0+r1*(uint32)4591;
    *out++ = r2; r2 >>= 8;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  R[380] = R[760]+2295;
  
  for (i = 0;i < 190;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)322;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  R[190] = R[380];
  
  for (i = 0;i < 95;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)406;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  R[95] = R[190];
  
  for (i = 0;i < 48;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)644;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  
  for (i = 0;i < 23;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)1621;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  r0 = R[46];
  r1 = R[47];
  r2 = r0+r1*(uint32)1621;
  *out++ = r2; r2 >>= 8;
  *out++ = r2; r2 >>= 8;
  R[23] = r2;
  
  for (i = 0;i < 11;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)10265;
    *out++ = r2; r2 >>= 8;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  r0 = R[22];
  r1 = R[23];
  r2 = r0+r1*(uint32)10265;
  *out++ = r2; r2 >>= 8;
  R[11] = r2;
  
  for (i = 0;i < 5;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)1608;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  r0 = R[10];
  r1 = R[11];
  r2 = r0+r1*(uint32)1608;
  *out++ = r2; r2 >>= 8;
  *out++ = r2; r2 >>= 8;
  R[5] = r2;
  
  for (i = 0;i < 2;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)10101;
    *out++ = r2; r2 >>= 8;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  r0 = R[4];
  r1 = R[5];
  r2 = r0+r1*(uint32)10101;
  *out++ = r2; r2 >>= 8;
  R[2] = r2;
  
  r0 = R[0];
  r1 = R[1];
  r2 = r0+r1*(uint32)1557;
  *out++ = r2; r2 >>= 8;
  R[0] = r2;
  R[1] = R[2];
  
  r0 = R[0];
  r1 = R[1];
  r2 = r0+r1*(uint32)9470;
  *out++ = r2; r2 >>= 8;
  *out++ = r2; r2 >>= 8;
  R[0] = r2;
  
  r0 = R[0];
  *out++ = r0; r0 >>= 8;
  *out++ = r0; r0 >>= 8;
}

void Encode_Rounded(unsigned char *out,int16 *R)
{
  // const int16 *R0 = v;
  /* XXX: caller could overlap R with input */
  // uint16 R[381];
  long i;
  uint16 r0,r1;
  uint32 r2;
  
  for (i = 0;i < 380;++i) {
    r0 = ((R[2*i]+2295)*10923)>>15;
    r1 = ((R[2*i+1]+2295)*10923)>>15;
    r2 = r0+r1*(uint32)1531;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  R[380] = ((R[760]+2295)*10923)>>15;
  
  for (i = 0;i < 190;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)9157;
    *out++ = r2; r2 >>= 8;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  R[190] = R[380];
  
  for (i = 0;i < 95;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)1280;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  R[95] = R[190];
  
  for (i = 0;i < 48;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)6400;
    *out++ = r2; r2 >>= 8;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  
  for (i = 0;i < 24;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)625;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  
  for (i = 0;i < 12;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)1526;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  
  for (i = 0;i < 6;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)9097;
    *out++ = r2; r2 >>= 8;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  
  for (i = 0;i < 3;++i) {
    r0 = R[2*i];
    r1 = R[2*i+1];
    r2 = r0+r1*(uint32)1263;
    *out++ = r2; r2 >>= 8;
    R[i] = r2;
  }
  
  r0 = R[0];
  r1 = R[1];
  r2 = r0+r1*(uint32)6232;
  *out++ = r2; r2 >>= 8;
  *out++ = r2; r2 >>= 8;
  R[0] = r2;
  R[1] = R[2];
  
  r0 = R[0];
  r1 = R[1];
  r2 = r0+r1*(uint32)593;
  *out++ = r2; r2 >>= 8;
  R[0] = r2;
  
  r0 = R[0];
  *out++ = r0; r0 >>= 8;
  *out++ = r0; r0 >>= 8;
}
