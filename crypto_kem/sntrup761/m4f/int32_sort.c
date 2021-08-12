/*********************************
*
* Implementation of djbsort for signed 32-bit integer arrays
* 
***********************************/

#include "crypto_sort.h"
#include "int32.h"
//#define int32 crypto_int32

// #include "int32_minmax_thumb.inc"
#define int32_MINMAX(a,b) \
do { \
  int32 temp1; \
  asm( \
    "cmp %0,%1\n\t" \
    "mov %2,%0\n\t" \
    "itt gt\n\t" \
    "movgt %0,%1\n\t" \
    "movgt %1,%2\n\t" \
    : "+r"(a), "+r"(b), "=r"(temp1) \
    : \
    : "cc" \
  ); \
} while(0)

/* assume 2 <= n <= 0x40000000 */
static void crypto_sort_smallindices(int32 *x,int32 n)
{
  int32 top,p,q,r,i,j;

  top = 1;
  while (top < n - top) top += top;

  for (p = top;p >= 4;p >>= 1) {
    i = 0;
    while (i + 2 * p <= n) {
      for (j = i;j < i + p;++j)
        int32_MINMAX(x[j],x[j+p]);
      i += 2 * p;
    }
    for (j = i;j < n - p;++j)
      int32_MINMAX(x[j],x[j+p]);

    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done;
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        for (j = i;j < i + p; j += 4) {
          int32 a = x[j + p];
	  int32 b = x[j + p + 1];
          int32 aa = x[j + p + 2];
	  int32 bb = x[j + p + 3];
          for (r = q;r > p;r >>= 1) {
            int32_MINMAX(a,x[j+r]);
            int32_MINMAX(b,x[j+r+1]);
            int32_MINMAX(aa,x[j+r+2]);
            int32_MINMAX(bb,x[j+r+3]);
	  }
          x[j + p] = a;
	  x[j + p + 1] = b;
          x[j + p + 2] = aa;
	  x[j + p + 3] = bb;
        }
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done: ;
    }
  }
  /* this should be just p = 2 */
  for (;p == 2;p = 1) {
    i = 0;
    while (i + 2 * p <= n) {
      for (j = i;j < i + p;++j)
        int32_MINMAX(x[j],x[j+p]);
      i += 2 * p;
    }
    for (j = i;j < n - p;++j)
      int32_MINMAX(x[j],x[j+p]);

    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done0;
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        for (j = i;j < i + p; j += 2) {
          int32 a = x[j + p];
	  int32 b = x[j + p + 1];
          for (r = q;r > p;r >>= 1) {
            int32_MINMAX(a,x[j+r]);
            int32_MINMAX(b,x[j+r+1]);
	  }
          x[j + p] = a;
	  x[j + p + 1] = b;
        }
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done0: ;
    }
  }
  /* this should be just p = 1 */
  for (;p == 1;p = 0) {
    i = 0;
    while (i + 2 * p <= n) {
      for (j = i;j < i + p;++j)
        int32_MINMAX(x[j],x[j+p]);
      i += 2 * p;
    }
    for (j = i;j < n - p;++j)
      int32_MINMAX(x[j],x[j+p]);

    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done1;
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        for (j = i;j < i + p;++j) {
          int32 a = x[j + p];
          for (r = q;r > p;r >>= 1)
            int32_MINMAX(a,x[j+r]);
          x[j + p] = a;
        }
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done1: ;
    }
  }
}

void crypto_sort(void *array,long long n)
{
  long long top,p,q,r,i,j;
  int32 *x = array;

  if (n < 2) return;
  if (n < 0x40000000) {
    crypto_sort_smallindices(x,n);
    return;
  }
  top = 1;
  while (top < n - top) top += top;

  for (p = top;p >= 1;p >>= 1) {
    i = 0;
    while (i + 2 * p <= n) {
      for (j = i;j < i + p;++j)
        int32_MINMAX(x[j],x[j+p]);
      i += 2 * p;
    }
    for (j = i;j < n - p;++j)
      int32_MINMAX(x[j],x[j+p]);

    i = 0;
    j = 0;
    for (q = top;q > p;q >>= 1) {
      if (j != i) for (;;) {
        if (j == n - q) goto done;
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j + r]);
        x[j + p] = a;
        ++j;
        if (j == i + p) {
          i += 2 * p;
          break;
        }
      }
      while (i + p <= n - q) {
        for (j = i;j < i + p;++j) {
          int32 a = x[j + p];
          for (r = q;r > p;r >>= 1)
            int32_MINMAX(a,x[j+r]);
          x[j + p] = a;
        }
        i += 2 * p;
      }
      /* now i + p > n - q */
      j = i;
      while (j < n - q) {
        int32 a = x[j + p];
        for (r = q;r > p;r >>= 1)
          int32_MINMAX(a,x[j+r]);
        x[j + p] = a;
        ++j;
      }

      done: ;
    }
  }
}
