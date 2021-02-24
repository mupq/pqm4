#include "uint32.h"
#include "uint64.h"

/*
CPU division instruction typically takes time depending on x.
This software is designed to take time independent of x.
Time still varies depending on m; user must ensure that m is constant.
Time also varies on CPUs where multiplication is variable-time.
There could be more CPU issues.
There could also be compiler issues. 
*/

void uint32_divmod_uint14(uint32 *q,uint16 *r,uint32 x,uint16 m)
{
  uint32 v = 0x80000000;
  uint32 qpart;
  uint32 mask;

  v /= m;

  /* caller guarantees m > 0 */
  /* caller guarantees m < 16384 */
  /* vm <= 2^31 <= vm+m-1 */
  /* xvm <= 2^31 x <= xvm+x(m-1) */

  *q = 0;

  qpart = (x*(uint64)v)>>31;
  /* 2^31 qpart <= xv <= 2^31 qpart + 2^31-1 */
  /* 2^31 qpart m <= xvm <= 2^31 qpart m + (2^31-1)m */
  /* 2^31 qpart m <= 2^31 x <= 2^31 qpart m + (2^31-1)m + x(m-1) */
  /* 0 <= 2^31 newx <= (2^31-1)m + x(m-1) */
  /* 0 <= newx <= (1-1/2^31)m + x(m-1)/2^31 */
  /* 0 <= newx <= (1-1/2^31)(2^14-1) + (2^32-1)((2^14-1)-1)/2^31 */

  x -= qpart*m; *q += qpart;
  /* x <= 49146 */

  qpart = (x*(uint64)v)>>31;
  /* 0 <= newx <= (1-1/2^31)m + x(m-1)/2^31 */
  /* 0 <= newx <= m + 49146(2^14-1)/2^31 */
  /* 0 <= newx <= m + 0.4 */
  /* 0 <= newx <= m */

  x -= qpart*m; *q += qpart;
  /* x <= m */

  x -= m; *q += 1;
  mask = -(x>>31);
  x += mask&(uint32)m; *q += mask;
  /* x < m */

  *r = x;
}

uint32 uint32_div_uint14(uint32 x,uint16 m)
{
  uint32 q;
  uint16 r;
  uint32_divmod_uint14(&q,&r,x,m);
  return q;
}

uint16 uint32_mod_uint14(uint32 x,uint16 m)
{
  uint32 q;
  uint16 r;
  uint32_divmod_uint14(&q,&r,x,m);
  return r;
}
