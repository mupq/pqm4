/* See https://ntruprime.cr.yp.to/software.html for detailed documentation. */

#include "int32_sort.h"

static void minmax(int32_t *x,int32_t *y)
{
  uint32_t xi = *x;
  uint32_t yi = *y;
  uint32_t xy = xi ^ yi;
  uint32_t c = yi - xi;
  c ^= xy & (c ^ yi);
  c >>= 31;
  c = -c;
  c &= xy;
  *x = xi ^ c;
  *y = yi ^ c;
}

void int32_sort(int32_t *x,int n)
{
  int top,p,q,i;

  if (n < 2) return;
  top = 1;
  while (top < n - top) top += top;

  for (p = top;p > 0;p >>= 1) {
    for (i = 0;i < n - p;++i)
      if (!(i & p))
        minmax(x + i,x + i + p);
    for (q = top;q > p;q >>= 1)
      for (i = 0;i < n - q;++i)
        if (!(i & p))
          minmax(x + i + p,x + i + q);
  }
}
