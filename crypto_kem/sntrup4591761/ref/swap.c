/* See https://ntruprime.cr.yp.to/software.html for detailed documentation. */

#include "swap.h"

void swap(void *x,void *y,int bytes,int mask)
{
  int i;
  char xi, yi, c, t;

  c = mask;
  
  for (i = 0;i < bytes;++i) {
    xi = i[(char *) x];
    yi = i[(char *) y];
    t = c & (xi ^ yi);
    xi ^= t;
    yi ^= t;
    i[(char *) x] = xi;
    i[(char *) y] = yi;
  }
}
