/*
 * packing.h
 *
 *  Created on: Aug 29, 2017
 *      Author: zhenfei
 */

#ifndef PACKING_H_
#define PACKING_H_

int unpack_secret_key_KEM(
    const unsigned char   *blob,
    PARAM_SET       *param,
    uint16_t        *F);

int unpack_secret_key_CCA(
    const unsigned char   *blob,
    PARAM_SET       *param,
    uint16_t        *F,
    uint16_t        *h);



int pack_secret_key_CCA(
    unsigned char   *blob,
    const PARAM_SET *param,
    const uint16_t  *F,
    uint16_t        *h);

int pack_secret_key_KEM(
    unsigned char   *blob,
    const PARAM_SET *param,
    const uint16_t  *F);


int pack_public_key(
    unsigned char   *blob,
    const PARAM_SET *param,
    const uint16_t  *h);

int unpack_public_key(
    const unsigned char
                    *blob,
    PARAM_SET       *param,
    uint16_t        *h);

#endif /* PACKING_H_ */
