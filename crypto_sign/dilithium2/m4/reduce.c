#include <stdint.h>
#include "params.h"
#include "reduce.h"

/*************************************************
* Name:        montgomery_reduce
*
* Description: For finite field element a with 0 <= a <= Q*2^32,
*              compute r \equiv a*2^{-32} (mod Q) such that 0 <= r < 2*Q.
*
* Arguments:   - uint64_t: finite field element a
*
* Returns r.
**************************************************/
uint32_t montgomery_reduce(uint64_t a) {
  uint64_t t;

  t = a * QINV;
  t &= ((uint64_t)1 << 32) - 1;
  t *= Q;
  t = a + t;
  t >>= 32;
  return t;
}

/*************************************************
* Name:        reduce32
*
* Description: For finite field element a, compute r \equiv a (mod Q)
*              such that 0 <= r < 2*Q.
*
* Arguments:   - uint32_t: finite field element a
*
* Returns r.
**************************************************/
uint32_t reduce32(uint32_t a) {
  uint32_t t;

  t = a & 0x7FFFFF;
  a >>= 23;
  t += (a << 13) - a;
  return t;
}

/*************************************************
* Name:        csubq
*
* Description: Subtract Q if input coefficient is bigger than Q.
*
* Arguments:   - uint32_t: finite field element a
*
* Returns r.
**************************************************/
uint32_t csubq(uint32_t a) {
  a -= Q;
  a += ((int32_t)a >> 31) & Q;
  return a;
}

/*************************************************
* Name:        freeze
*
* Description: For finite field element a, compute standard
*              representative r = a mod Q.
*
* Arguments:   - uint32_t: finite field element a
*
* Returns r.
**************************************************/
uint32_t freeze(uint32_t a) {
  a = reduce32(a);
  a = csubq(a);
  return a;
}

/*
 *
 * SIGNED REDUCTIONS
 *
 */



/*************************************************
* Name:        montgomery_reduce_signed
*
* Description: For finite field element a with -(1LL<<31)<= a <= Q*2^32,
*              compute r \equiv a*2^{-32} (mod Q) such that 0 <= r < 2*Q.
*
* Arguments:   - uint64_t: finite field element a
*
* Returns r.
**************************************************/
/*int32_t montgomery_reduce_signed(int64_t a)
{
  int64_t t;
  int32_t u;

  u = a * QINV_signed;
  t = (int64_t)u * Q;
  t = a - t;
  t >>= 32;
  return t;
}*/
/*************************************************
* Name:        reduce32_signed
*
* Description: For signed finite field element a, compute r \equiv a (mod Q)
*              such that  <=  -Q/4 < r < 5*Q/4 <2Q
*
* Arguments:   - int32_t: finite field element a
*
* Returns:     - int32_t: r
**************************************************/
int32_t reduce32_signed(int32_t a) {
  int32_t r;

  r = a & 0x7FFFFF;
  a >>= 23;
  r += (a << 13) - a;
  return r;
}

/*************************************************
* Name:        csubaddq
*
* Description: Compute r \equiv a mod Q, 0<= r < Q
*
* Arguments:   - int32_t: finite field element a
*
* Returns:     - uint32_t: r.
**************************************************/
uint32_t csubaddq(int32_t a) {
  a -= Q;
  a += ((int32_t)a >> 31) & Q;
  a += ((int32_t)a >> 31) & Q;
  return a;
}


/*************************************************
* Name:        freeze_signed
*
* Description: For finite field element a, compute standard
*              representative r = a mod Q.
*
* Arguments:   - int32_t: finite field element a
*
* Returns:     - uint32_t: r.
**************************************************/
uint32_t freeze_signed(int32_t a) {
  a = reduce32_signed(a);
  uint32_t r;
  r = csubaddq(a);
  return r;
}