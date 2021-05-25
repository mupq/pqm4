// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#include "btfy_ffft.h"

//#include "cantor_to_gftower.h"

#include "btfy_consts_gft.h"

#include "gfv_tower.h"

#include "gft_mul_vi.h"




static
void (* gft_mul_vi [12]) (uint32_t * x, const uint32_t * y);




static
void btfy_layer( uint32_t* data, int datalen , int si )
{
  int blk_size = 1<<(si+1);
  int len = 1<<si;
  int count = 0;
  uint32_t temp[32];
  uint32_t temp2[32];

  int k=0;
  {
    // count = 0;
    //si_a = 0;
    uint32_t *data_k = data+k;
    for(int i=0;i<len;i+=32) {
      //gf232v_mulscalar_gf16(temp,&data_k[len+i],si_a);
      // temp = 0;
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) {
        data_k[i+j] ^= temp2[j];
        data_k[len+i+j] ^= data_k[i+j];
      }
    }
    k += blk_size;
    count++;
  }
  if(k<datalen) {
    // count = 1;
    //si_a = 2;
    uint32_t *data_k = data+k;
    for(int i=0;i<len;i+=32) {
      gf232v_mul_0x2(temp,&data_k[len+i]);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) {
        data_k[i+j] ^= temp[j]^temp2[j];
        data_k[len+i+j] ^= data_k[i+j];
      }
    }
    k += blk_size;
    count++;
  }
  if(k<datalen) {
    // count = 2;
    //si_a = 5;
    uint32_t *data_k = data+k;
    for(int i=0;i<len;i+=32) {
      gf232v_mul_0x5(temp,&data_k[len+i]);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) {
        data_k[i+j] ^= temp[j]^temp2[j];
        data_k[len+i+j] ^= data_k[i+j];
      }
    }
    k += blk_size;
    count++;
  }
  for(;k<datalen;k+=blk_size) {
    uint32_t si_a = s0_gft[count++];
    uint32_t *data_k = data+k;
    if( 16 > si_a )
    for(int i=0;i<len;i+=32) {
      gf232v_mulscalar_gf16(temp,&data_k[len+i],si_a);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) {
        data_k[i+j] ^= temp[j]^temp2[j];
        data_k[len+i+j] ^= data_k[i+j];
      }
    }
    else // if (256 > si_a )
    for(int i=0;i<len;i+=32) {
      gf232v_mulscalar_gf256(temp,&data_k[len+i],si_a);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) {
        data_k[i+j] ^= temp[j]^temp2[j];
        data_k[len+i+j] ^= data_k[i+j];
      }
    }
  }
}



///////////////////////////////



static
void btfy_layer_s4( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s4_gf16_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S4)|((data[i+32+j])<<16);
      uint32_t data_h = ((data[i+j])>>16)|(data[i+32+j]&MASK_S4);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf16( tmp , data+i+32 , ptr+(pi<<2) );
    (*gft_mul_vi[4])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    if( (++pi) >= S4_GF16_NUMX32 ) break;
  }

  ptr = s4_gf256_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S4)|((data[i+32+j])<<16);
      uint32_t data_h = ((data[i+j])>>16)|(data[i+32+j]&MASK_S4);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[4])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    ++pi;
  }
}



static
void btfy_layer_s3( uint32_t*data, int datalen )
{
  const uint32_t *ptr = s3_gf256_vec;
  uint32_t tmp[32];
  uint32_t tmp2[32];
  for(int i=0;i<datalen;i+=64) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S3)|((data[i+32+j]&~MASK_S3)<<8);
      uint32_t data_h = ((data[i+j]&MASK_S3)>>8)|(data[i+32+j]&MASK_S3);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(i>>3) );  // (i>>1)*S4_WIDTH/32
    (*gft_mul_vi[3])( tmp2 , data+i+32 );

    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
  }
}



static
void btfy_layer_s2( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s2_gf256_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S2)|((data[i+32+j]&~MASK_S2)<<4);
      uint32_t data_h = ((data[i+j]&MASK_S2)>>4)|(data[i+32+j]&MASK_S2);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[2])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    if( (++pi) >= S2_GF256_NUMX32 ) break;
  }

  ptr = s2_gf216_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S2)|((data[i+32+j]&~MASK_S2)<<4);
      uint32_t data_h = ((data[i+j]&MASK_S2)>>4)|(data[i+32+j]&MASK_S2);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf216( tmp , data+i+32 , ptr+(pi<<4) );
    (*gft_mul_vi[2])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    ++pi;
  }
}




static
void btfy_layer_s1( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s1_gf256_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S1)|((data[i+32+j]&~MASK_S1)<<2);
      uint32_t data_h = ((data[i+j]&MASK_S1)>>2)|(data[i+32+j]&MASK_S1);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[1])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    if( (++pi) >= S1_GF256_NUMX32 ) break;
  }

  ptr = s1_gf216_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S1)|((data[i+32+j]&~MASK_S1)<<2);
      uint32_t data_h = ((data[i+j]&MASK_S1)>>2)|(data[i+32+j]&MASK_S1);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf216( tmp , data+i+32 , ptr+(pi<<4) );
    (*gft_mul_vi[1])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    ++pi;
  }
}




static
void btfy_layer_s0( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s0_gf256_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S0)|((data[i+32+j]&~MASK_S0)<<1);
      uint32_t data_h = ((data[i+j]&MASK_S0)>>1)|(data[i+32+j]&MASK_S0);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[0])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    if( (++pi) >= S0_GF256_NUMX32 ) break;
  }

  ptr = s0_gf216_vec;
  pi = 0;
  while(i<datalen) {
    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S0)|((data[i+32+j]&~MASK_S0)<<1);
      uint32_t data_h = ((data[i+j]&MASK_S0)>>1)|(data[i+32+j]&MASK_S0);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
    gf232v_mul_gf216( tmp , data+i+32 , ptr+(pi<<4) );
    (*gft_mul_vi[0])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) {
      data[i+j] ^= tmp[j]^tmp2[j];
      data[i+32+j] ^= data[i+j];
    }
    i+=64;
    ++pi;
  }
}




//////////////////////////////////////////////////


//void (* gft_mul_vi [12]) (uint32_t * x, const uint32_t * y);


void btfy_32768( uint32_t * poly )
{
  int datalen = 1024;

  gft_mul_vi[0] = gft_mul_v26;
  gft_mul_vi[1] = gft_mul_v25;
  gft_mul_vi[2] = gft_mul_v24;
  gft_mul_vi[3] = gft_mul_v23;
  gft_mul_vi[4] = gft_mul_v22;
  gft_mul_vi[5] = gft_mul_v21;
  gft_mul_vi[6] = gft_mul_v20;
  gft_mul_vi[7] = gft_mul_v19;
  gft_mul_vi[8] = gft_mul_v18;
  gft_mul_vi[9] = gft_mul_v17;

  btfy_layer( poly , datalen , 9 );
  btfy_layer( poly , datalen , 8 );
  btfy_layer( poly , datalen , 7 );
  btfy_layer( poly , datalen , 6 );
  btfy_layer( poly , datalen , 5 );

  btfy_layer_s4( poly , datalen );
  btfy_layer_s3( poly , datalen );
  btfy_layer_s2( poly , datalen );
  btfy_layer_s1( poly , datalen );
  btfy_layer_s0( poly , datalen );
}


void btfy_65536( uint32_t * poly )
{
  int datalen = 2048;

  gft_mul_vi[0] = gft_mul_v27;
  gft_mul_vi[1] = gft_mul_v26;
  gft_mul_vi[2] = gft_mul_v25;
  gft_mul_vi[3] = gft_mul_v24;
  gft_mul_vi[4] = gft_mul_v23;
  gft_mul_vi[5] = gft_mul_v22;
  gft_mul_vi[6] = gft_mul_v21;
  gft_mul_vi[7] = gft_mul_v20;
  gft_mul_vi[8] = gft_mul_v19;
  gft_mul_vi[9] = gft_mul_v18;
  gft_mul_vi[10] = gft_mul_v17;

  btfy_layer( poly , datalen , 10 );
  btfy_layer( poly , datalen , 9 );
  btfy_layer( poly , datalen , 8 );
  btfy_layer( poly , datalen , 7 );
  btfy_layer( poly , datalen , 6 );
  btfy_layer( poly , datalen , 5 );

  btfy_layer_s4( poly , datalen );
  btfy_layer_s3( poly , datalen );
  btfy_layer_s2( poly , datalen );
  btfy_layer_s1( poly , datalen );
  btfy_layer_s0( poly , datalen );
}



//////////////////////////////////////////////////



static
void ibtfy_layer( uint32_t* data, int datalen , int si )
{
  int blk_size = 1<<(si+1);
  int len = 1<<si;
  int count = 0;
  uint32_t temp[32];
  uint32_t temp2[32];

  int k=0;
  {
    // count = 0;
    //si_a = 0;
    uint32_t *data_k = data+k;
    for(int i=0;i<len;i+=32) {
      for(int j=0;j<32;j++) { data_k[len+i+j] ^= data_k[i+j]; }
      //gf232v_mulscalar_gf16(temp,&data_k[len+i],si_a);
      // temp = 0;
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) { data_k[i+j] ^= temp2[j]; }
    }
    k += blk_size;
    count++;
  }
  if(k<datalen) {
    // count = 1;
    //si_a = 2;
    uint32_t *data_k = data+k;
    for(int i=0;i<len;i+=32) {
      for(int j=0;j<32;j++) { data_k[len+i+j] ^= data_k[i+j]; }
      gf232v_mul_0x2(temp,&data_k[len+i]);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) { data_k[i+j] ^= temp[j]^temp2[j]; }
    }
    k += blk_size;
    count++;
  }
  if(k<datalen) {
    // count = 2;
    //si_a = 5;
    uint32_t *data_k = data+k;
    for(int i=0;i<len;i+=32) {
      for(int j=0;j<32;j++) { data_k[len+i+j] ^= data_k[i+j]; }
      gf232v_mul_0x5(temp,&data_k[len+i]);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) { data_k[i+j] ^= temp[j]^temp2[j]; }
    }
    k += blk_size;
    count++;
  }

  for(;k<datalen;k+=blk_size) {
    uint32_t si_a = s0_gft[count++];

    uint32_t *data_k = data+k;
    if( 16 > si_a )
    for(int i=0;i<len;i+=32) {
      for(int j=0;j<32;j++) { data_k[len+i+j] ^= data_k[i+j]; }
      gf232v_mulscalar_gf16(temp,&data_k[len+i],si_a);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) { data_k[i+j] ^= temp[j]^temp2[j]; }
    }
    else // if (256 > si_a )
    for(int i=0;i<len;i+=32) {
      for(int j=0;j<32;j++) { data_k[len+i+j] ^= data_k[i+j]; }
      gf232v_mulscalar_gf256(temp,&data_k[len+i],si_a);
      (*gft_mul_vi[si])( temp2 , &data_k[len+i] );
      for(int j=0;j<32;j++) { data_k[i+j] ^= temp[j]^temp2[j]; }
    }
  }
}



///////////////////////////////////////////////////////



static
void ibtfy_layer_s4( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s4_gf16_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf16( tmp , data+i+32 , ptr+(pi<<2) );
    (*gft_mul_vi[4])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S4)|((data[i+32+j])<<16);
      uint32_t data_h = ((data[i+j])>>16)|(data[i+32+j]&MASK_S4);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    if( (++pi) >= S4_GF16_NUMX32 ) break;
  }

  ptr = s4_gf256_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[4])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S4)|((data[i+32+j])<<16);
      uint32_t data_h = ((data[i+j])>>16)|(data[i+32+j]&MASK_S4);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    ++pi;
  }
}



static
void ibtfy_layer_s3( uint32_t*data, int datalen )
{
  const uint32_t *ptr = s3_gf256_vec;
  uint32_t tmp[32];
  uint32_t tmp2[32];
  for(int i=0;i<datalen;i+=64) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(i>>3) );  // (i>>1)*S4_WIDTH/32
    (*gft_mul_vi[3])( tmp2 , data+i+32 );

    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S3)|((data[i+32+j]&~MASK_S3)<<8);
      uint32_t data_h = ((data[i+j]&MASK_S3)>>8)|(data[i+32+j]&MASK_S3);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }
  }
}




static
void ibtfy_layer_s2( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s2_gf256_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[2])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S2)|((data[i+32+j]&~MASK_S2)<<4);
      uint32_t data_h = ((data[i+j]&MASK_S2)>>4)|(data[i+32+j]&MASK_S2);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    if( (++pi) >= S2_GF256_NUMX32 ) break;
  }

  ptr = s2_gf216_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf216( tmp , data+i+32 , ptr+(pi<<4) );
    (*gft_mul_vi[2])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S2)|((data[i+32+j]&~MASK_S2)<<4);
      uint32_t data_h = ((data[i+j]&MASK_S2)>>4)|(data[i+32+j]&MASK_S2);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    ++pi;
  }
}




static
void ibtfy_layer_s1( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s1_gf256_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[1])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S1)|((data[i+32+j]&~MASK_S1)<<2);
      uint32_t data_h = ((data[i+j]&MASK_S1)>>2)|(data[i+32+j]&MASK_S1);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    if( (++pi) >= S1_GF256_NUMX32 ) break;
  }

  ptr = s1_gf216_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf216( tmp , data+i+32 , ptr+(pi<<4) );
    (*gft_mul_vi[1])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S1)|((data[i+32+j]&~MASK_S1)<<2);
      uint32_t data_h = ((data[i+j]&MASK_S1)>>2)|(data[i+32+j]&MASK_S1);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    ++pi;
  }
}




static
void ibtfy_layer_s0( uint32_t*data, int datalen )
{
  uint32_t tmp[32];
  uint32_t tmp2[32];

  const uint32_t *ptr;
  int pi;

  int i = 0;
  ptr = s0_gf256_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf256( tmp , data+i+32 , ptr+(pi<<3) );
    (*gft_mul_vi[0])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S0)|((data[i+32+j]&~MASK_S0)<<1);
      uint32_t data_h = ((data[i+j]&MASK_S0)>>1)|(data[i+32+j]&MASK_S0);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    if( (++pi) >= S0_GF256_NUMX32 ) break;
  }

  ptr = s0_gf216_vec;
  pi = 0;
  while(i<datalen) {
    for(int j=0;j<32;j++) { data[i+32+j] ^= data[i+j]; }
    gf232v_mul_gf216( tmp , data+i+32 , ptr+(pi<<4) );
    (*gft_mul_vi[0])( tmp2 , data+i+32 );
    for(int j=0;j<32;j++) { data[i+j] ^= tmp[j]^tmp2[j]; }

    // reorder data
    for(int j=0;j<32;j++) {
      uint32_t data_l = (data[i+j]&~MASK_S0)|((data[i+32+j]&~MASK_S0)<<1);
      uint32_t data_h = ((data[i+j]&MASK_S0)>>1)|(data[i+32+j]&MASK_S0);
      data[i+j] = data_l;
      data[i+32+j] = data_h;
    }

    i+=64;
    ++pi;
  }
}




///////////////////////////////////////////////////



void ibtfy_32768( uint32_t * poly )
{
  int datalen = 1024;

  gft_mul_vi[0] = gft_mul_v26;
  gft_mul_vi[1] = gft_mul_v25;
  gft_mul_vi[2] = gft_mul_v24;
  gft_mul_vi[3] = gft_mul_v23;
  gft_mul_vi[4] = gft_mul_v22;
  gft_mul_vi[5] = gft_mul_v21;
  gft_mul_vi[6] = gft_mul_v20;
  gft_mul_vi[7] = gft_mul_v19;
  gft_mul_vi[8] = gft_mul_v18;
  gft_mul_vi[9] = gft_mul_v17;

  ibtfy_layer_s0( poly , datalen );
  ibtfy_layer_s1( poly , datalen );
  ibtfy_layer_s2( poly , datalen );
  ibtfy_layer_s3( poly , datalen );
  ibtfy_layer_s4( poly , datalen );

  ibtfy_layer( poly , datalen , 5 );
  ibtfy_layer( poly , datalen , 6 );
  ibtfy_layer( poly , datalen , 7 );
  ibtfy_layer( poly , datalen , 8 );
  ibtfy_layer( poly , datalen , 9 );
}


void ibtfy_65536( uint32_t * poly )
{
  int datalen = 2048;

  gft_mul_vi[0] = gft_mul_v27;
  gft_mul_vi[1] = gft_mul_v26;
  gft_mul_vi[2] = gft_mul_v25;
  gft_mul_vi[3] = gft_mul_v24;
  gft_mul_vi[4] = gft_mul_v23;
  gft_mul_vi[5] = gft_mul_v22;
  gft_mul_vi[6] = gft_mul_v21;
  gft_mul_vi[7] = gft_mul_v20;
  gft_mul_vi[8] = gft_mul_v19;
  gft_mul_vi[9] = gft_mul_v18;
  gft_mul_vi[10] = gft_mul_v17;

  ibtfy_layer_s0( poly , datalen );
  ibtfy_layer_s1( poly , datalen );
  ibtfy_layer_s2( poly , datalen );
  ibtfy_layer_s3( poly , datalen );
  ibtfy_layer_s4( poly , datalen );

  ibtfy_layer( poly , datalen , 5 );
  ibtfy_layer( poly , datalen , 6 );
  ibtfy_layer( poly , datalen , 7 );
  ibtfy_layer( poly , datalen , 8 );
  ibtfy_layer( poly , datalen , 9 );
  ibtfy_layer( poly , datalen , 10 );
}

