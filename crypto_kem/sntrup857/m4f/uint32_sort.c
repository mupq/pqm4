/*********************************
*
* Implementation of djbsort for unsigned 32-bit integer arrays
* 
***********************************/

//#include "crypto_sort_int32.h"
#include "crypto_sort.h"
#include "uint32.h"
typedef uint32 crypto_uint32;

/* can save time by vectorizing xor loops */
/* can save time by integrating xor loops with int32_sort */

void uint32_sort(void *array,long long n)
{
  crypto_uint32 *x = array;
  long long j;
  for (j = 0;j < n;++j) x[j] ^= 0x80000000;
  crypto_sort(array,n);
  for (j = 0;j < n;++j) x[j] ^= 0x80000000;
}
// static void minmax(uint32 *x,uint32 *y)
// {
//   uint32 xi = *x;
//   uint32 yi = *y;
//   uint32 xy = xi ^ yi;
//   uint32 c = yi - xi;
//   c ^= xy & (c ^ yi ^ 0x80000000);
//   c >>= 31;
//   c = -c;
//   c &= xy;
//   *x = xi ^ c;
//   *y = yi ^ c;
// }

// void uint32_sort(uint32 *x,int n)
// {
//   int top,p,q,i;

//   if (n < 2) return;
//   top = 1;
//   while (top < n - top) top += top;

//   for (p = top;p > 0;p >>= 1) {
//     for (i = 0;i < n - p;++i)
//       if (!(i & p))
//         minmax(x + i,x + i + p);
//     for (q = top;q > p;q >>= 1)
//       for (i = 0;i < n - q;++i)
//         if (!(i & p))
//           minmax(x + i + p,x + i + q);
//   }
// }