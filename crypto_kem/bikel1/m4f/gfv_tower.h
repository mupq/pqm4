// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef _GFV_TOWER_H_
#define _GFV_TOWER_H_

#include <stdint.h>


typedef uint32_t sto_t;

#include "run_config.h"

#if defined(_M4_ASM_)

#include "gfv_tower_asm.h"

static inline void gf4v_mul_2( sto_t *c, const sto_t *a ) { gf4v_mul_2_asm(c,a); }
static inline void gf4v_mul( sto_t *c, const sto_t *a , const sto_t *b) { gf4v_mul_asm(c,a,b); }
static inline void gf4v_mulscalar( sto_t *c, const sto_t *a , uint8_t b) { gf4v_mulscalar_asm(c,a,b); }

static inline void gf16v_mul_0x4( sto_t *c, const sto_t *a ) { gf16v_mul_0x4_asm(c,a); }
static inline void gf16v_mul_0x5( sto_t *c, const sto_t *a ) { gf16v_mul_0x5_asm(c,a); }
static inline void gf16v_mul_8( sto_t *c, const sto_t *a ) { gf16v_mul_8_asm(c,a); }
static inline void gf16v_mul( sto_t *c, const sto_t *a , const sto_t *b) { gf16v_mul_asm(c,a,b); }
static inline void gf16v_mulscalar( sto_t *c, const sto_t *a , uint8_t b) { gf16v_mulscalar_asm(c,a,b); }

static inline void gf256v_mul( sto_t *c, const sto_t *a , const sto_t *b) { gf256v_mul_asm(c,a,b); }
static inline void gf256v_mulscalar( sto_t *c, const sto_t *a , uint8_t b) { gf256v_mulscalar_asm(c,a,b); }
static inline void gf256v_mul_0x80( sto_t *c, const sto_t *a) { gf256v_mul_0x80_asm( c, a); }

static inline void gf216v_mul( sto_t *c, const sto_t *a , const sto_t *b ) { gf216v_mul_asm( c, a , b ); }
static inline void gf216v_mul_0x8000( sto_t *c, const sto_t *a ) { gf216v_mul_0x8000_asm( c, a ); }

static inline void gf232v_mul( sto_t *c, const sto_t *a , const sto_t *b ) { gf232v_mul_asm( c, a , b ); }
static inline void gf232v_mul_0x2( sto_t *c, const sto_t *a ) { gf232v_mul_0x2_asm( c, a ); }
static inline void gf232v_mul_0x5( sto_t *c, const sto_t *a ) { gf232v_mul_0x5_asm( c, a ); }

static inline void gf232v_mul_gf16( sto_t *c, const sto_t *a , const sto_t *b_gf16 )   { gf232v_mul_gf16_asm(c,a,b_gf16); }
static inline void gf232v_mul_gf256( sto_t *c, const sto_t *a , const sto_t *b_gf256 ) { gf232v_mul_gf256_asm(c,a,b_gf256); }
static inline void gf232v_mul_gf216( sto_t *c, const sto_t *a , const sto_t *b_gf216 ) { gf232v_mul_gf216_asm(c,a,b_gf216); }
static inline void gf232v_mulscalar_gf16( sto_t *c, const sto_t *a , uint8_t b )       { gf232v_mulscalar_gf16_asm(c,a,b); }
static inline void gf232v_mulscalar_gf256( sto_t *c, const sto_t *a , uint8_t b )      { gf232v_mulscalar_gf256_asm(c,a,b); }
static inline void gf232v_mulscalar( sto_t *c, const sto_t *a , uint32_t _b )          { gf232v_mulscalar_asm(c,a,_b); }


#else

// gf4 := gf2[x]/x^2+x+1
static inline void gf4v_mul_2( sto_t *c, const sto_t *a ) {
  sto_t tmp = a[0];
  c[0] = a[1];
  c[1] = a[1]^tmp;
}

static inline void gf4v_mul( sto_t *c, const sto_t *a , const sto_t *b) {
  c[0] = (a[0]&b[0])^(a[1]&b[1]);
  c[1] = (a[0]&b[1])^(a[1]&(b[0]^b[1]));
}

static inline void gf4v_mulscalar( sto_t *c, const sto_t *a , uint8_t b) {
  sto_t b0 = b&1;   // may not apply to all type of storages
  sto_t b1 = (b>>1)&1;
  c[0] = (a[0]*b0)^(a[1]*b1);
  c[1] = (a[0]*b1)^(a[1]*(b0^b1));
}


///////////////////////////////////////////////////////////////////////////////////


// gf16 := gf4[y]/y^2+y+x
static inline void gf16v_mul( sto_t *c, const sto_t *a , const sto_t *b ) {
  sto_t c2[2];
  sto_t c1[2];
  c1[0] = a[0]^a[2];
  c1[1] = a[1]^a[3];
  c2[0] = b[0]^b[2];
  c2[1] = b[1]^b[3];
  gf4v_mul( c , a , b );
  gf4v_mul( c+2 , c1 , c2 );
  gf4v_mul( c2 , a+2 , b+2 );
  c[2] ^= c[0];
  c[3] ^= c[1];

  gf4v_mul_2( c1 , c2 );
  c[0] ^= c1[0];
  c[1] ^= c1[1];
}

static inline void gf16v_mulscalar( sto_t *c, const sto_t *a , uint8_t b ) {
  sto_t c1[2];
  sto_t c2[2];
  c1[0] = a[0]^a[2];
  c1[1] = a[1]^a[3];
  uint8_t b2 = b^(b>>2);
  gf4v_mulscalar( c , a , b );
  gf4v_mulscalar( c+2 , c1 , b2 );
  gf4v_mulscalar( c2 , a+2 , b>>2 );
  c[2] ^= c[0];
  c[3] ^= c[1];

  gf4v_mul_2( c1 , c2 );
  c[0] ^= c1[0];
  c[1] ^= c1[1];
}

static inline void gf16v_mul_0x4( sto_t *c, const sto_t *a ) {
  gf4v_mul_2( c , a+2 );
  c[2] = a[0]^a[2];
  c[3] = a[1]^a[3];
}

static inline void gf16v_mul_0x5( sto_t *c, const sto_t *a ) {
  gf4v_mul_2( c , a+2 );
  c[0] ^= a[0];
  c[1] ^= a[1];
  c[2] = a[0];
  c[3] = a[1];
}

static inline void gf16v_mul_8( sto_t *c, const sto_t *a ) {
  sto_t c2[2];
  gf4v_mul_2( c+2 , a );
  gf4v_mul_2( c2 , a+2 );
  c[2] ^= c2[0];
  c[3] ^= c2[1];
  gf4v_mul_2( c , c2 );
}

////////////

// gf256 := gf16[X]/X^2+X+xy
static inline void gf256v_mul( sto_t *c, const sto_t *a , const sto_t *b ) {
  sto_t c1[4];
  sto_t c2[4];
  c1[0] = a[0]^a[4];
  c1[1] = a[1]^a[5];
  c1[2] = a[2]^a[6];
  c1[3] = a[3]^a[7];
  c2[0] = b[0]^b[4];
  c2[1] = b[1]^b[5];
  c2[2] = b[2]^b[6];
  c2[3] = b[3]^b[7];

  gf16v_mul( c , a , b );
  gf16v_mul( c+4 , c1 , c2 );
  gf16v_mul( c2 , a+4 , b+4 );
  c[4] ^= c[0];
  c[5] ^= c[1];
  c[6] ^= c[2];
  c[7] ^= c[3];

  gf16v_mul_8( c1 , c2 );
  c[0] ^= c1[0];
  c[1] ^= c1[1];
  c[2] ^= c1[2];
  c[3] ^= c1[3];
}

static inline void gf256v_mulscalar( sto_t *c, const sto_t *a , uint8_t b ) {
  sto_t c1[4];
  sto_t c2[4];
  c1[0] = a[0]^a[4];
  c1[1] = a[1]^a[5];
  c1[2] = a[2]^a[6];
  c1[3] = a[3]^a[7];
  uint8_t b2 = b^(b>>4);

  gf16v_mulscalar( c , a , b );
  gf16v_mulscalar( c+4 , c1 , b2 );
  gf16v_mulscalar( c2 , a+4 , b>>4 );
  c[4] ^= c[0];
  c[5] ^= c[1];
  c[6] ^= c[2];
  c[7] ^= c[3];

  gf16v_mul_8( c1 , c2 );
  c[0] ^= c1[0];
  c[1] ^= c1[1];
  c[2] ^= c1[2];
  c[3] ^= c1[3];
}



static inline void gf256v_mul_0x80( sto_t *c, const sto_t *a ) {
  sto_t c2[4];
  gf16v_mul_8( c+4 , a );
  gf16v_mul_8( c2 , a+4 );
  c[4] ^= c2[0];
  c[5] ^= c2[1];
  c[6] ^= c2[2];
  c[7] ^= c2[3];
  gf16v_mul_8( c , c2 );
}


////////


// gf216 := gf256[Y]/Y^2+Y+Xxy
static inline void gf216v_mul( sto_t *c, const sto_t *a , const sto_t *b ) {
  sto_t c1[8]; for(int i=0;i<8;i++) c1[i] = a[i]^a[8+i];
  sto_t c2[8]; for(int i=0;i<8;i++) c2[i] = b[i]^b[8+i];

  gf256v_mul( c , a , b );
  gf256v_mul( c+8 , c1 , c2 );
  gf256v_mul( c2 , a+8 , b+8 );
  for( int i=0;i<8;i++) c[8+i] ^= c[i];

  gf256v_mul_0x80( c1 , c2 );
  for( int i=0;i<8;i++) c[i] ^= c1[i];
}

static inline void gf216v_mul_0x8000( sto_t *c, const sto_t *a ) {
  sto_t c2[8];
  gf256v_mul_0x80( c+8 , a );
  gf256v_mul_0x80( c2 , a+8 );

  for(int i=0;i<8;i++) c[8+i]^= c2[i];
  gf256v_mul_0x80( c , c2 );
}


////////

// gf232 := gf216[Z]/Z^2+Z+YXxy
static inline void gf232v_mul( sto_t *c, const sto_t *a , const sto_t *b ) {
  sto_t c1[16]; for(int i=0;i<16;i++) c1[i] = a[i]^a[16+i];
  sto_t c2[16]; for(int i=0;i<16;i++) c2[i] = b[i]^b[16+i];

  gf216v_mul( c , a , b );
  gf216v_mul( c+16 , c1 , c2 );
  gf216v_mul( c2 , a+16 , b+16 );
  for( int i=0;i<16;i++) c[16+i] ^= c[i];

  gf216v_mul_0x8000( c1 , c2 );
  for( int i=0;i<16;i++) c[i] ^= c1[i];
}

static inline void gf232v_mul_0x2( sto_t *c, const sto_t *a ) {
  for(int i=0;i<32;i+=4) {
    c[i+0] = a[i+1];
    c[i+1] = a[i+0]^a[i+1];
    c[i+2] = a[i+3];
    c[i+3] = a[i+2]^a[i+3];
  }
}

static inline void gf232v_mul_0x5( sto_t *c, const sto_t *a ) {
  for(int i=0;i<32;i+=4) { gf16v_mul_0x5( c+i , a+i ); }
}



static inline void gf232v_mul_gf16( sto_t *c, const sto_t *a , const sto_t *b_gf16 ) {
  gf16v_mul( c , a , b_gf16 );
  gf16v_mul( c+4 , a+4 , b_gf16 );
  gf16v_mul( c+8 , a+8 , b_gf16 );
  gf16v_mul( c+12 , a+12 , b_gf16 );
  gf16v_mul( c+16 , a+16 , b_gf16 );
  gf16v_mul( c+20 , a+20 , b_gf16 );
  gf16v_mul( c+24 , a+24 , b_gf16 );
  gf16v_mul( c+28 , a+28 , b_gf16 );

}

static inline void gf232v_mul_gf256( sto_t *c, const sto_t *a , const sto_t *b_gf256 ) {
  gf256v_mul( c , a , b_gf256 );
  gf256v_mul( c+8 , a+8 , b_gf256 );
  gf256v_mul( c+16 , a+16 , b_gf256 );
  gf256v_mul( c+24 , a+24 , b_gf256 );
}

// this function seems be slower than gf232v_mul_gf216()
//static inline void gf232v_mul_gf216_12bit( sto_t *c, const sto_t *a , const sto_t *b );

static inline void gf232v_mul_gf216( sto_t *c, const sto_t *a , const sto_t *b_gf216 ) {
  gf216v_mul( c , a , b_gf216 );
  gf216v_mul( c+16 , a+16 , b_gf216 );
}


////

static inline void gf232v_mulscalar_gf16( sto_t *c, const sto_t *a , uint8_t b ) {
  gf16v_mulscalar( c, a , b );
  gf16v_mulscalar( c+4, a+4 , b );
  gf16v_mulscalar( c+8, a+8 , b );
  gf16v_mulscalar( c+12, a+12 , b );
  gf16v_mulscalar( c+16, a+16 , b );
  gf16v_mulscalar( c+20, a+20 , b );
  gf16v_mulscalar( c+24, a+24 , b );
  gf16v_mulscalar( c+28, a+28 , b );
}

static inline void gf232v_mulscalar_gf256( sto_t *c, const sto_t *a , uint8_t b ) {
  gf256v_mulscalar( c, a , b );
  gf256v_mulscalar( c+8, a+8 , b );
  gf256v_mulscalar( c+16, a+16 , b );
  gf256v_mulscalar( c+24, a+24 , b );
}

static inline void gf232v_mulscalar( sto_t *c, const sto_t *a , uint32_t _b ) {
  sto_t b[32];
  for(int i=0;i<32;i++) {
    b[i] = 0 - (_b&1);
    _b>>=1;
  }
  gf232v_mul( c , a , b );
}



#endif  // defined(_M4_ASM_)


#endif // _GFV_TOWER_H_

