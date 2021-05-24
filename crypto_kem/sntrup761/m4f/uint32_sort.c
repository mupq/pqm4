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
