/*
 * param.h
 *
 *  Created on: Aug 16, 2017
 *      Author: zhenfei
 */

#ifndef PARAM_H_
#define PARAM_H_

#include <stdint.h>

typedef enum _NTRU_PARAM_SET_ID         PARAM_SET_ID;
typedef const struct _NTRU_PARAM_SET    PARAM_SET;
#define LENGTH_OF_HASH 64
enum _NTRU_PARAM_SET_ID {
    /* scheme_method - dimension */
    NTRU_KEM_443,
    NTRU_KEM_743,
    NTRU_CCA_443,
    NTRU_CCA_743,
};


struct _NTRU_PARAM_SET {
  PARAM_SET_ID     id;          /* parameter set id */
  const char       *name;       /* human readable name */
  const uint8_t    OID[3];      /* OID */
  uint8_t          N_bits;      /* ceil(log2(N)) */
  uint8_t          q_bits;      /* ceil(log2(q)) */
  const uint64_t   N;           /* ring degree */
  uint16_t         packpk;       /* length of packed pk */
  uint16_t         packsk;       /* length of packed sk */
  int8_t           p;           /* message space prime */
  int64_t          q;           /* ring modulus */
  const uint64_t   d;           /* df, dg, dr */
  const uint64_t   padN;        /* degree for karatsuba */
  const uint8_t    max_msg_len; /* maximum length of a message (in bytes) */

};

PARAM_SET *
get_param_set_by_id(PARAM_SET_ID id);


#endif /* PARAM_H_ */
