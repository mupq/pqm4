#include "int16.h"
#include "int32.h"
#include "uint16.h"
#include "uint32.h"
#include "uint64.h"
#include "Decode.h"

static int16 mullo(int16 x,int16 y) { return x*y; }
static int16 mulhi(int16 x,int16 y) { return (x*(int32)y)>>16; }

extern void Decode_Rq(int16 *R,const unsigned char *s)
{
  // int16 *R = v;
  long long i;
  int16 a0,a1,ri,lo,hi,s0,s1;
  
  s += 1158; // crypto_decode_STRBYTES;
  a1 = 0;
  a1 += *--s; /* 0...255 */
  lo = mullo(a1,-10434);
  a1 = mulhi(a1,-656)-mulhi(lo,1608);
  a1 += *--s; /* -804...1056 */
  a1 += (a1>>15)&1608; /* 0...1607 */
  R[0] = a1;
  
  /* reconstruct mod 1*[9470]+[11127] */
  
  ri = R[0];
  s1 = *--s;
  s0 = *--s;
  lo = mullo(ri,-1772);
  a0 = mulhi(ri,-3624)-mulhi(lo,9470); /* -5641...4735 */
  a0 += s1; /* -5641...4990 */
  lo = mullo(a0,-1772);
  a0 = mulhi(a0,-3624)-mulhi(lo,9470); /* -5011...5046 */
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
    a0 = mulhi(ri,541)-mulhi(lo,1557); /* -779...913 */
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
  
  ri = R[2];
  s0 = *--s;
  lo = mullo(ri,-1661);
  a0 = mulhi(ri,-545)-mulhi(lo,10101); /* -5187...5050 */
  a0 += s0; /* -5187...5305 */
  a0 += (a0>>15)&10101; /* 0...10100 */
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
    lo = mullo(ri,-1661);
    a0 = mulhi(ri,-545)-mulhi(lo,10101); /* -5187...5050 */
    a0 += s1; /* -5187...5305 */
    lo = mullo(a0,-1661);
    a0 = mulhi(a0,-545)-mulhi(lo,10101); /* -5095...5093 */
    a0 += s0; /* -5095...5348 */
    a0 += (a0>>15)&10101; /* 0...10100 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,12509);

    /* invalid inputs might need reduction mod 10101 */
    a1 -= 10101;
    a1 += (a1>>15)&10101;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 11*[1608]+[11468] */
  
  ri = R[5];
  s1 = *--s;
  s0 = *--s;
  lo = mullo(ri,-10434);
  a0 = mulhi(ri,-656)-mulhi(lo,1608); /* -968...804 */
  a0 += s1; /* -968...1059 */
  lo = mullo(a0,-10434);
  a0 = mulhi(a0,-656)-mulhi(lo,1608); /* -815...813 */
  a0 += s0; /* -815...1068 */
  a0 += (a0>>15)&1608; /* 0...1607 */
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
    lo = mullo(ri,-10434);
    a0 = mulhi(ri,-656)-mulhi(lo,1608); /* -968...804 */
    a0 += s0; /* -968...1059 */
    a0 += (a0>>15)&1608; /* 0...1607 */
    a1 = (ri<<5)+((s0-a0)>>3);
    a1 = mullo(a1,6521);

    /* invalid inputs might need reduction mod 1608 */
    a1 -= 1608;
    a1 += (a1>>15)&1608;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 23*[10265]+[286] */
  
  ri = R[11];
  s0 = *--s;
  lo = mullo(ri,-1634);
  a0 = mulhi(ri,4206)-mulhi(lo,10265); /* -5133...6184 */
  a0 += s0; /* -5133...6439 */
  a0 += (a0>>15)&10265; /* 0...10264 */
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
    lo = mullo(ri,-1634);
    a0 = mulhi(ri,4206)-mulhi(lo,10265); /* -5133...6184 */
    a0 += s1; /* -5133...6439 */
    lo = mullo(a0,-1634);
    a0 = mulhi(a0,4206)-mulhi(lo,10265); /* -5462...5545 */
    a0 += s0; /* -5462...5800 */
    a0 += (a0>>15)&10265; /* 0...10264 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,-19415);

    /* invalid inputs might need reduction mod 10265 */
    a1 -= 10265;
    a1 += (a1>>15)&10265;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 47*[1621]+[11550] */
  
  ri = R[23];
  s1 = *--s;
  s0 = *--s;
  lo = mullo(ri,-10350);
  a0 = mulhi(ri,-134)-mulhi(lo,1621); /* -844...810 */
  a0 += s1; /* -844...1065 */
  lo = mullo(a0,-10350);
  a0 = mulhi(a0,-134)-mulhi(lo,1621); /* -813...812 */
  a0 += s0; /* -813...1067 */
  a0 += (a0>>15)&1621; /* 0...1620 */
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
    lo = mullo(ri,-10350);
    a0 = mulhi(ri,-134)-mulhi(lo,1621); /* -844...810 */
    a0 += s0; /* -844...1065 */
    a0 += (a0>>15)&1621; /* 0...1620 */
    a1 = (ri<<8)+s0-a0;
    a1 = mullo(a1,-14595);

    /* invalid inputs might need reduction mod 1621 */
    a1 -= 1621;
    a1 += (a1>>15)&1621;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 95*[644]+[4591] */
  
  ri = R[47];
  s0 = *--s;
  lo = mullo(ri,-26052);
  a0 = mulhi(ri,-272)-mulhi(lo,644); /* -390...322 */
  a0 += s0; /* -390...577 */
  a0 += (a0>>15)&644; /* 0...643 */
  a1 = (ri<<6)+((s0-a0)>>2);
  a1 = mullo(a1,-7327);

  /* invalid inputs might need reduction mod 4591 */
  a1 -= 4591;
  a1 += (a1>>15)&4591;

  R[94] = a0;
  R[95] = a1;
  for (i = 46;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-26052);
    a0 = mulhi(ri,-272)-mulhi(lo,644); /* -390...322 */
    a0 += s0; /* -390...577 */
    a0 += (a0>>15)&644; /* 0...643 */
    a1 = (ri<<6)+((s0-a0)>>2);
    a1 = mullo(a1,-7327);

    /* invalid inputs might need reduction mod 644 */
    a1 -= 644;
    a1 += (a1>>15)&644;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 190*[406]+[4591] */
  
  R[190] = R[95];
  for (i = 94;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,24213);
    a0 = mulhi(ri,78)-mulhi(lo,406); /* -203...222 */
    a0 += s0; /* -203...477 */
    a0 -= 406; /* -609..>71 */
    a0 += (a0>>15)&406; /* -203...405 */
    a0 += (a0>>15)&406; /* 0...405 */
    a1 = (ri<<7)+((s0-a0)>>1);
    a1 = mullo(a1,25827);

    /* invalid inputs might need reduction mod 406 */
    a1 -= 406;
    a1 += (a1>>15)&406;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 380*[322]+[4591] */
  
  R[380] = R[190];
  for (i = 189;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,13433);
    a0 = mulhi(ri,50)-mulhi(lo,322); /* -161...173 */
    a0 += s0; /* -161...428 */
    a0 -= 322; /* -483..>106 */
    a0 += (a0>>15)&322; /* -161...321 */
    a0 += (a0>>15)&322; /* 0...321 */
    a1 = (ri<<7)+((s0-a0)>>1);
    a1 = mullo(a1,-7327);

    /* invalid inputs might need reduction mod 322 */
    a1 -= 322;
    a1 += (a1>>15)&322;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 761*[4591] */
  
  R[760] = R[380]-2295;
  for (i = 379;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = mullo(ri,-3654);
    a0 = mulhi(ri,1702)-mulhi(lo,4591); /* -2296...2721 */
    a0 += s1; /* -2296...2976 */
    lo = mullo(a0,-3654);
    a0 = mulhi(a0,1702)-mulhi(lo,4591); /* -2356...2372 */
    a0 += s0; /* -2356...2627 */
    a0 += (a0>>15)&4591; /* 0...4590 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,15631);

    /* invalid inputs might need reduction mod 4591 */
    a1 -= 4591;
    a1 += (a1>>15)&4591;

    R[2*i] = a0-2295;
    R[2*i+1] = a1-2295;
  }
}

void Decode_Rounded(int16 *R,const unsigned char *s)
{
  long long i;
  int16 a0,a1,ri,lo,hi,s0,s1;
  
  s += 1007; // crypto_decode_STRBYTES;
  a1 = 0;
  a1 += *--s; /* 0...255 */
  lo = mullo(a1,-4828);
  a1 = mulhi(a1,-84)-mulhi(lo,3475);
  a1 += *--s; /* -1738...1992 */
  a1 += (a1>>15)&3475; /* 0...3474 */
  R[0] = a1;
  
  /* reconstruct mod 1*[593]+[1500] */
  
  ri = R[0];
  s0 = *--s;
  lo = mullo(ri,-28292);
  a0 = mulhi(ri,60)-mulhi(lo,593); /* -297...311 */
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
    a0 = mulhi(ri,672)-mulhi(lo,6232); /* -3116...3284 */
    a0 += s1; /* -3116...3539 */
    lo = mullo(a0,-2692);
    a0 = mulhi(a0,672)-mulhi(lo,6232); /* -3148...3152 */
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
  a0 = mulhi(ri,-476)-mulhi(lo,1263); /* -751...631 */
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
    a0 = mulhi(ri,-476)-mulhi(lo,1263); /* -751...631 */
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
  
  /* reconstruct mod 11*[9097]+[2188] */
  
  ri = R[5];
  s1 = *--s;
  s0 = *--s;
  lo = mullo(ri,-1844);
  a0 = mulhi(ri,2348)-mulhi(lo,9097); /* -4549...5135 */
  a0 += s1; /* -4549...5390 */
  lo = mullo(a0,-1844);
  a0 = mulhi(a0,2348)-mulhi(lo,9097); /* -4712...4741 */
  a0 += s0; /* -4712...4996 */
  a0 += (a0>>15)&9097; /* 0...9096 */
  a1 = (s1<<8)+s0-a0;
  a1 = mullo(a1,17081);

  /* invalid inputs might need reduction mod 2188 */
  a1 -= 2188;
  a1 += (a1>>15)&2188;

  R[10] = a0;
  R[11] = a1;
  for (i = 4;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = mullo(ri,-1844);
    a0 = mulhi(ri,2348)-mulhi(lo,9097); /* -4549...5135 */
    a0 += s1; /* -4549...5390 */
    lo = mullo(a0,-1844);
    a0 = mulhi(a0,2348)-mulhi(lo,9097); /* -4712...4741 */
    a0 += s0; /* -4712...4996 */
    a0 += (a0>>15)&9097; /* 0...9096 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,17081);

    /* invalid inputs might need reduction mod 9097 */
    a1 -= 9097;
    a1 += (a1>>15)&9097;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 23*[1526]+[367] */
  
  ri = R[11];
  s0 = *--s;
  lo = mullo(ri,-10994);
  a0 = mulhi(ri,372)-mulhi(lo,1526); /* -763...856 */
  a0 += s0; /* -763...1111 */
  a0 += (a0>>15)&1526; /* 0...1525 */
  a1 = (ri<<7)+((s0-a0)>>1);
  a1 = mullo(a1,-18381);

  /* invalid inputs might need reduction mod 367 */
  a1 -= 367;
  a1 += (a1>>15)&367;

  R[22] = a0;
  R[23] = a1;
  for (i = 10;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-10994);
    a0 = mulhi(ri,372)-mulhi(lo,1526); /* -763...856 */
    a0 += s0; /* -763...1111 */
    a0 += (a0>>15)&1526; /* 0...1525 */
    a1 = (ri<<7)+((s0-a0)>>1);
    a1 = mullo(a1,-18381);

    /* invalid inputs might need reduction mod 1526 */
    a1 -= 1526;
    a1 += (a1>>15)&1526;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 47*[625]+[150] */
  
  ri = R[23];
  s0 = *--s;
  lo = mullo(ri,-26844);
  a0 = mulhi(ri,-284)-mulhi(lo,625); /* -384...312 */
  a0 += s0; /* -384...567 */
  a0 += (a0>>15)&625; /* 0...624 */
  a1 = (ri<<8)+s0-a0;
  a1 = mullo(a1,32401);

  /* invalid inputs might need reduction mod 150 */
  a1 -= 150;
  a1 += (a1>>15)&150;

  R[46] = a0;
  R[47] = a1;
  for (i = 22;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-26844);
    a0 = mulhi(ri,-284)-mulhi(lo,625); /* -384...312 */
    a0 += s0; /* -384...567 */
    a0 += (a0>>15)&625; /* 0...624 */
    a1 = (ri<<8)+s0-a0;
    a1 = mullo(a1,32401);

    /* invalid inputs might need reduction mod 625 */
    a1 -= 625;
    a1 += (a1>>15)&625;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 95*[6400]+[1531] */
  
  ri = R[47];
  s1 = *--s;
  s0 = *--s;
  lo = mullo(ri,-2621);
  a0 = mulhi(ri,2816)-mulhi(lo,6400); /* -3200...3904 */
  a0 += s1; /* -3200...4159 */
  lo = mullo(a0,-2621);
  a0 = mulhi(a0,2816)-mulhi(lo,6400); /* -3338...3378 */
  a0 += s0; /* -3338...3633 */
  a0 += (a0>>15)&6400; /* 0...6399 */
  a1 = (ri<<8)+s1+((s0-a0)>>8);
  a1 = mullo(a1,23593);

  /* invalid inputs might need reduction mod 1531 */
  a1 -= 1531;
  a1 += (a1>>15)&1531;

  R[94] = a0;
  R[95] = a1;
  for (i = 46;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = mullo(ri,-2621);
    a0 = mulhi(ri,2816)-mulhi(lo,6400); /* -3200...3904 */
    a0 += s1; /* -3200...4159 */
    lo = mullo(a0,-2621);
    a0 = mulhi(a0,2816)-mulhi(lo,6400); /* -3338...3378 */
    a0 += s0; /* -3338...3633 */
    a0 += (a0>>15)&6400; /* 0...6399 */
    a1 = (ri<<8)+s1+((s0-a0)>>8);
    a1 = mullo(a1,23593);

    /* invalid inputs might need reduction mod 6400 */
    a1 -= 6400;
    a1 += (a1>>15)&6400;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 190*[1280]+[1531] */
  
  R[190] = R[95];
  for (i = 94;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-13107);
    a0 = mulhi(ri,256)-mulhi(lo,1280); /* -640...704 */
    a0 += s0; /* -640...959 */
    a0 += (a0>>15)&1280; /* 0...1279 */
    a1 = ri+((s0-a0)>>8);
    a1 = mullo(a1,-13107);

    /* invalid inputs might need reduction mod 1280 */
    a1 -= 1280;
    a1 += (a1>>15)&1280;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 380*[9157]+[1531] */
  
  R[380] = R[190];
  for (i = 189;i >= 0;--i) {
    ri = R[i];
    s1 = *--s;
    s0 = *--s;
    lo = mullo(ri,-1832);
    a0 = mulhi(ri,1592)-mulhi(lo,9157); /* -4579...4976 */
    a0 += s1; /* -4579...5231 */
    lo = mullo(a0,-1832);
    a0 = mulhi(a0,1592)-mulhi(lo,9157); /* -4690...4705 */
    a0 += s0; /* -4690...4960 */
    a0 += (a0>>15)&9157; /* 0...9156 */
    a1 = (s1<<8)+s0-a0;
    a1 = mullo(a1,25357);

    /* invalid inputs might need reduction mod 9157 */
    a1 -= 9157;
    a1 += (a1>>15)&9157;

    R[2*i] = a0;
    R[2*i+1] = a1;
  }
  
  /* reconstruct mod 761*[1531] */
  
  R[760] = 3*R[380]-2295;
  for (i = 379;i >= 0;--i) {
    ri = R[i];
    s0 = *--s;
    lo = mullo(ri,-10958);
    a0 = mulhi(ri,518)-mulhi(lo,1531); /* -766...895 */
    a0 += s0; /* -766...1150 */
    a0 += (a0>>15)&1531; /* 0...1530 */
    a1 = (ri<<8)+s0-a0;
    a1 = mullo(a1,15667);

    /* invalid inputs might need reduction mod 1531 */
    a1 -= 1531;
    a1 += (a1>>15)&1531;

    R[2*i] = 3*a0-2295;
    R[2*i+1] = 3*a1-2295;
  }
}
