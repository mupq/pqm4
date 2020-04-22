#include "int16.h"
#include "int32.h"
#include "uint16.h"
#include "uint32.h"
#include "uint64.h"
#include "Decode.h"
#include "cmsis.h"
extern void Decode_Rq_asm(int16 *R,const unsigned char *s);
extern void Decode_Rounded_asm(int16 *R,const unsigned char *s);

static int16 mullo(int16 x,int16 y) { return x*y; }
static int16 mulhi(int16 x,int16 y) { return (x*(int32)y) >> 16; }

extern void Decode_Rq(int16 *R,const unsigned char *s)
{
  // int16 *R = v;
  long long i;
  int16 a0,a1,ri,lo,hi,s0,s1;
  int16 z,y,m0;

  s += 1158; // crypto_decode_STRBYTES;
  a1 = 0;
  a1 += *--s; /* 0...255 */
  lo = mullo(a1,-10434);
  a1 = (a1 * (-656) - lo * 1608) >> 16;
  a1 += *--s; /* -804...1056 */
  a1 += (a1>>15)&1608; /* 0...1607 */
  R[0] = a1;

  /* reconstruct mod 1*[9470]+[11127] */

  ri = R[0];
  s1 = *--s;
  s0 = *--s;
  lo = mullo(ri,-1772);
  a0 = (ri * (-3624) - lo * 9470) >> 16;
  a0 += s1; /* -5641...4990 */
  lo = mullo(a0,-1772);
  a0 = (a0 * (-3624) - lo * 9470) >> 16;
  a0 += s0; /* -5011...5301 */
  a0 += (a0>>15)&9470; /* 0...9469 */
  a1 = (ri<<15)+(s1<<7)+((s0-a0)>>1);
  a1 = mullo(a1,-21121);

  /* invalid inputs might need reduction mod 11127 */
  a1 -= 11127;
  a1 += (a1>>15)&11127;

  R[0] = a0;
  R[1] = a1;

  /* reconstruct mod 2*[1557]+[11127] */

  R[2] = R[1];
  for (i = 0;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-10775);
    a0 = (ri * 541 - lo * 1557) >> 16;
    a0 += s0; /* -779...1168 */
    a0 += (a0>>15)&1557; /* 0...1556 */
    a1 = (ri<<8)+s0-a0;
    a1 = mullo(a1,-26307);

    /* invalid inputs might need reduction mod 1557 */
    a1 -= 1557;
    a1 += (a1>>15)&1557;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  /* reconstruct mod 5*[10101]+[282] */

  z = -1661;
  y = -545;
  m0 = 10101;
  ri = R[2];
  s0 = *--s;
  lo = __SMULBB(ri, z);
  a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
  a0 += s0; /* -5187...5305 */
  a0 += (a0>>15)&m0; /* 0...10100 */
  a1 = (ri<<8)+s0-a0;
  a1 = mullo(a1,12509);

  /* invalid inputs might need reduction mod 282 */
  a1 -= 282;
  a1 += (a1>>15)&282;

  R[4] = a0;
  R[5] = a1;
  for (i = 1;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = __SMULBB(ri, z);
    a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
    a0 += s1; /* -5187...5305 */
    lo = __SMULBB(a0, z);
    a0 = __SSUB16(__SMULBB(a0, y), __SMULBB(lo, m0)) >> 16;
    a0 += s0; /* -5095...5348 */
    a0 += (a0>>15)&m0; /* 0...10100 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,12509);

    /* invalid inputs might need reduction mod 10101 */
    a1 -= m0;
    a1 += (a1>>15)&m0;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  /* reconstruct mod 11*[1608]+[11468] */

  z = -10434;
  y = -656;
  m0 = 1608;
  ri = R[5];
  s1 = *--s;
  s0 = *--s;
  lo = __SMULBB(ri, z);
  a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
  a0 += s1; /* -968...1059 */
  lo = __SMULBB(a0, z);
  a0 = __SSUB16(__SMULBB(a0, y), __SMULBB(lo, m0)) >> 16;
  a0 += s0; /* -815...1068 */
  a0 += (a0>>15)&m0; /* 0...1607 */
  a1 = (ri<<13)+(s1<<5)+((s0-a0)>>3);
  a1 = mullo(a1,6521);

  /* invalid inputs might need reduction mod 11468 */
  a1 -= 11468;
  a1 += (a1>>15)&11468;

  R[10] = a0;
  R[11] = a1;
  for (i = 4;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = __SMULBB(ri, z);
    a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
    a0 += s0; /* -968...1059 */
    a0 += (a0>>15)&m0; /* 0...1607 */
    a1 = (ri<<5)+((s0-a0)>>3);
    a1 = mullo(a1,6521);

    /* invalid inputs might need reduction mod 1608 */
    a1 -= m0;
    a1 += (a1>>15)&m0;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  /* reconstruct mod 23*[10265]+[286] */

  z = -1634;
  y = 4206;
  m0 = 10265;
  ri = R[11];
  s0 = *--s;
  lo = __SMULBB(ri, z);
  a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
  a0 += s0; /* -5133...6439 */
  a0 += (a0>>15)&m0; /* 0...10264 */
  a1 = (ri<<8)+s0-a0;
  a1 = mullo(a1,-19415);

  /* invalid inputs might need reduction mod 286 */
  a1 -= 286;
  a1 += (a1>>15)&286;

  R[22] = a0;
  R[23] = a1;
  for (i = 10;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = __SMULBB(ri, z);
    a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
    a0 += s1; /* -5133...6439 */
    lo = __SMULBB(a0, z);
    a0 = __SSUB16(__SMULBB(a0, y), __SMULBB(lo, m0)) >> 16;
    a0 += s0; /* -5462...5800 */
    a0 += (a0>>15)&m0; /* 0...10264 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,-19415);

    /* invalid inputs might need reduction mod 10265 */
    a1 -= m0;
    a1 += (a1>>15)&m0;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  /* reconstruct mod 47*[1621]+[11550] */
  z = -10350;
  y = -134;
  m0 = 1621;
  ri = R[23];
  s1 = *--s;
  s0 = *--s;
  lo = __SMULBB(ri, z);
  a0 = __SSUB16(__SMULBB(ri, y), __SMULBB(lo, m0)) >> 16;
  a0 += s1; /* -844...1065 */
  lo = __SMULBB(a0, z);
  a0 = __SSUB16(__SMULBB(a0, y), __SMULBB(lo, m0)) >> 16;
  a0 += s0; /* -813...1067 */
  a0 += (a0>>15)&m0; /* 0...1620 */
  a1 = (s1<<8)+s0-a0;
  a1 = mullo(a1,-14595);

  /* invalid inputs might need reduction mod 11550 */
  a1 -= 11550;
  a1 += (a1>>15)&11550;

  R[46] = a0;
  R[47] = a1;
  for (i = 22;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = __SMULBB(ri, z);
    a0 = (ri * y - lo * m0) >> 16;
    a0 += s0; /* -844...1065 */
    a0 += (a0>>15)&m0; /* 0...1620 */
    a1 = (ri<<8)+s0-a0;
    a1 = mullo(a1,-14595);

    /* invalid inputs might need reduction mod 1621 */
    a1 -= m0;
    a1 += (a1>>15)&m0;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  Decode_Rq_asm(R + 46, s - 2);
  /* reconstruct mod 95*[644]+[4591] */
  /* reconstruct mod 190*[406]+[4591] */
  /* reconstruct mod 380*[322]+[4591] */
  /* reconstruct mod 761*[4591] */
}

void Decode_Rounded(int16 *R,const unsigned char *s)
{
  long long i;
  int16 a0,a1,ri,lo,hi,s0,s1;
  int16 z, y, m0;

  s += 1007; // crypto_decode_STRBYTES;
  a1 = 0;
  a1 += *--s; /* 0...255 */
  lo = mullo(a1,-4828);
  a1 = (a1 * (-84) - lo * 3475) >> 16;
  a1 += *--s; /* -1738...1992 */
  a1 += (a1>>15)&3475; /* 0...3474 */
  R[0] = a1;

  /* reconstruct mod 1*[593]+[1500] */

  ri = R[0];
  s0 = *--s;
  lo = mullo(ri,-28292);
  a0 = (ri * 60 - lo * 593) >> 16;
  a0 += s0; /* -297...566 */
  a0 += (a0>>15)&593; /* 0...592 */
  a1 = (ri<<8)+s0-a0;
  a1 = mullo(a1,-31055);

  /* invalid inputs might need reduction mod 1500 */
  a1 -= 1500;
  a1 += (a1>>15)&1500;

  R[0] = a0;
  R[1] = a1;

  /* reconstruct mod 2*[6232]+[1500] */

  R[2] = R[1];
  for (i = 0;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = mullo(ri,-2692);
    a0 = (ri * 672 - lo * 6232) >> 16;
    a0 += s1; /* -3116...3539 */
    lo = mullo(a0,-2692);
    a0 = (a0 * 672 - lo * 6232) >> 16;
    a0 += s0; /* -3148...3407 */
    a0 += (a0>>15)&6232; /* 0...6231 */
    a1 = (ri<<13)+(s1<<5)+((s0-a0)>>3);
    a1 = mullo(a1,12451);

    /* invalid inputs might need reduction mod 6232 */
    a1 -= 6232;
    a1 += (a1>>15)&6232;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  /* reconstruct mod 5*[1263]+[304] */

  ri = R[2];
  s0 = *--s;
  lo = mullo(ri,-13284);
  a0 = (ri * (-476) - lo * 1263) >> 16;
  a0 += s0; /* -751...886 */
  a0 += (a0>>15)&1263; /* 0...1262 */
  a1 = (ri<<8)+s0-a0;
  a1 = mullo(a1,-22001);

  /* invalid inputs might need reduction mod 304 */
  a1 -= 304;
  a1 += (a1>>15)&304;

  R[4] = a0;
  R[5] = a1;
  for (i = 1;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-13284);
    a0 = (ri * (-476) - lo * 1263) >> 16;
    a0 += s0; /* -751...886 */
    a0 += (a0>>15)&1263; /* 0...1262 */
    a1 = (ri<<8)+s0-a0;
    a1 = mullo(a1,-22001);

    /* invalid inputs might need reduction mod 1263 */
    a1 -= 1263;
    a1 += (a1>>15)&1263;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }

  Decode_Rounded_asm(R + 4, s - 4);
  /* reconstruct mod 11*[9097]+[2188] */
  /* reconstruct mod 23*[1526]+[367] */
  /* reconstruct mod 47*[625]+[150] */
  /* reconstruct mod 95*[6400]+[1531] */
  /* reconstruct mod 190*[1280]+[1531] */
  /* reconstruct mod 380*[9157]+[1531] */
  /* reconstruct mod 761*[1531] */
}
