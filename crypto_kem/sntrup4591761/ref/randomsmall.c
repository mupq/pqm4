/* See https://ntruprime.cr.yp.to/software.html for detailed documentation. */

#include "params.h"
#include "randombytes.h"
#include <stdint.h>
#include "small.h"

void small_random(small *g)
{
  int i;

  for (i = 0;i < p;++i) {
    uint32_t r = small_random32();
    g[i] = (small) (((1073741823 & r) * 3) >> 30) - 1;
  }
}
