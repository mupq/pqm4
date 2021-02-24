#include "int32.h"
#include "uint32.h"

void int32_divmod_uint14(int32 *q,uint16 *r,int32 x,uint16 m)
{
  uint32 uq,uq2;
  uint16 ur,ur2;
  uint32 mask;

  uint32_divmod_uint14(&uq,&ur,0x80000000+(uint32)x,m);
  uint32_divmod_uint14(&uq2,&ur2,0x80000000,m);
  ur -= ur2; uq -= uq2;
  mask = -(uint32)(ur>>15);
  ur += mask&m; uq += mask;
  *r = ur; *q = uq;
}

int32 int32_div_uint14(int32 x,uint16 m)
{
  int32 q;
  uint16 r;
  int32_divmod_uint14(&q,&r,x,m);
  return q;
}

uint16 int32_mod_uint14(int32 x,uint16 m)
{
  int32 q;
  uint16 r;
  int32_divmod_uint14(&q,&r,x,m);
  return r;
}
