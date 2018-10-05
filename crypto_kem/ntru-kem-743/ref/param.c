/*
 * param.c
 *
 *  Created on: Aug 16, 2017
 *      Author: zhenfei
 */


#include <string.h>
#include "param.h"

static PARAM_SET ParamSets[] = {
    {
        NTRU_KEM_443,         /* parameter set id */
        "NTRU_KEM_443",       /* human readable name */
        {0xff, 0xff, 0xf9},   /* OID */
        9,                   /* bitlength of N */
        11,                   /* bitlength of q */
        443,                 /* ring degree */
        610,                /* length of packed pk */
        89,                /* length of packed sk */
        3,                    /* message space prime */
        2048,                 /* ring modulus, 2^30+2^13+1 */
        115,                  /* standard deviation, ~ 2^10.5 */
        448,                   /* degree for karatsuba */
        33,                 /* maximum length of a message (in bytes) */
    },
    {
        NTRU_KEM_743,         /* parameter set id */
        "NTRU_KEM_743",       /* human readable name */
        {0xff, 0xff, 0xfA},   /* OID */
        10,                   /* bitlength of N */
        11,                   /* bitlength of q */
        743,                 /* ring degree */
        1022,                /* length of packed pk */
        149,                  /* length of packed sk */
        3,                    /* message space prime */
        2048,                 /* ring modulus, 2^30+2^13+1 */
        247,                  /* standard deviation, ~ 2^10.5 */
        768,                   /* degree for karatsuba */
        73,                 /* maximum length of a message (in bytes) */
    },
    {
        NTRU_CCA_443,         /* parameter set id */
        "NTRU_PKE_443",       /* human readable name */
        {0xff, 0xff, 0xf9},   /* OID */
        9,                   /* bitlength of N */
        11,                   /* bitlength of q */
        443,                 /* ring degree */
        610,                /* length of packed pk */
        89,                /* length of packed sk */
        3,                    /* message space prime */
        2048,                 /* ring modulus, 2^30+2^13+1 */
        115,                  /* standard deviation, ~ 2^10.5 */
        448,                   /* degree for karatsuba */
        33,                 /* maximum length of a message (in bytes) */
    },

    {
        NTRU_CCA_743,         /* parameter set id */
        "NTRU_PKE_743",       /* human readable name */
        {0xff, 0xff, 0xf9},   /* OID */
        9,                   /* bitlength of N */
        11,                   /* bitlength of q */
        743,                 /* ring degree */
        1022,                /* length of packed pk */
        149,                /* length of packed sk */
        3,                    /* message space prime */
        2048,                 /* ring modulus, 2^30+2^13+1 */
        115,                  /* standard deviation, ~ 2^10.5 */
        768,                   /* degree for karatsuba */
        73,                 /* maximum length of a message (in bytes) */
    },
};

static int numParamSets = sizeof(ParamSets)/sizeof(PARAM_SET);

PARAM_SET *
get_param_set_by_id(PARAM_SET_ID id)
{
  int i;

  for(i=0; i<numParamSets; i++)
  {
    if(ParamSets[i].id == id)
    {
      return (ParamSets + i);
    }
  }
  return NULL;
}
