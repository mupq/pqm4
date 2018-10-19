/*
 * packing.c
 *
 *  Created on: Aug 29, 2017
 *      Author: zhenfei
 */


#include <stdint.h>
#include <string.h>
#include "param.h"
#include "packing.h"




/* ntru_elements_2_octets
 *
 * Packs an array of n-bit elements into an array of
 * ((in_len * n_bits) + 7) / 8 octets.
 * NOTE: Assumes 8 < n_bits < 16.
 */

static void
ntru_elements_2_octets(
    uint16_t        in_len,         /*  in - no. of elements to be packed */
    uint16_t const *in,             /*  in - ptr to elements to be packed */
    uint8_t         n_bits,         /*  in - no. of bits in input element */
    uint8_t        *out)            /* out - addr for output octets */
{
    uint16_t  temp;
    uint16_t  shift;
    uint16_t  i;

    /* pack */

    temp = 0;
    shift = n_bits - 8;
    i = 0;

    while (i < in_len)
    {

        /* add bits to temp to fill an octet and output the octet */
        temp |= in[i] >> shift;
        *out++ = (uint8_t)(temp & 0xff);

        if (shift > 8)
        {
            /* next full octet is in current input word */

            shift = shift - 8;
            temp = 0;
        }
        else
        {
            shift = 8 - shift;
            /* put remaining bits of input word in temp as partial octet,
             * and increment index to next input word
             */
            temp = in[i] << shift;
            shift = n_bits - shift;

            ++i;
        }
    }

    /* output any bits remaining in last input word */

    if (shift != n_bits - 8)
    {
        *out++ = (uint8_t)(temp & 0xff);
    }


    return;
}


/* ntru_octets_2_elements
 *
 * Unpacks an octet string into an array of ((in_len * 8) / n_bits)
 * n-bit elements.  Any extra bits are discarded.
 * NOTE: Assumes 8 < n_bits < 16.
 */

static void
ntru_octets_2_elements(
    uint16_t        in_len,         /*  in - no. of octets to be unpacked */
    uint8_t const  *in,             /*  in - ptr to octets to be unpacked */
    uint8_t         n_bits,         /*  in - no. of bits in output element */
    uint16_t       *out)            /* out - addr for output elements */
{
    uint16_t  temp;
    uint16_t  mask;
    uint16_t  shift;
    uint16_t  i;

    /* unpack */

    temp = 0;
    mask = (1 << n_bits) - 1;
    shift = n_bits;
    i = 0;
    int counter = 0;
    while (i < in_len)
    {
        if (shift > 8)
        {
            /* the current octet will not fill the current element */

            shift = shift - 8;
            temp |= ((uint16_t)in[i]) << shift;
        }
        else
        {
            /* add bits from the current octet to fill the current element and
             * output the element
             */

            shift = 8 - shift;

            temp |= ((uint16_t)in[i]) >> shift;
            *out++ = temp & mask;
            counter = counter+1;
            /* add the remaining bits of the current octet to start an element */
            shift = n_bits - shift;
            temp = ((uint16_t)in[i]) << shift;
        }
        ++i;
    }
    return;
}


/*
 * trinary polynomial to char string
 * pack 5 coefficients into 8 bits
 */
static void
tri_to_string(
    const uint16_t  in_len,     /*  in - degree of trinary poly */
    const uint16_t  *in,        /*  in - ptr to poly */
    unsigned char   *out)       /* out - addr for output string */
{
    unsigned char tmp1, tmp2;
    int i,j;
    int padNover5;

    padNover5 = in_len/5;
    if(in_len%5==0)
        padNover5--;
    for (i=0;i<padNover5;i++)
    {
        tmp1 = 0;
        for (j=0;j<5;j++)
        {
            tmp2 = (in[i*5+j]&0b11);
            if (tmp2==0b11)
                tmp2 = 2;
            tmp1 += tmp2;
            if (j!=4)
                tmp1 *= 3;
        }
        out[i] = tmp1;
    }
    tmp1 = 0;
    for (i=0;i<5;i++)
    {
        if (padNover5*5+i > in_len && i!=4)
            tmp1 *= 3;
        else
        {
            tmp2 = (in[padNover5*5+i]&0b11);
            if (tmp2==0b11)
                tmp2 = 2;
            tmp1 += tmp2;
            if (i!=4)
                tmp1 *= 3;
        }
    }
    out[padNover5] = tmp1;

    return;
}


/*
 * trinary polynomial to char string
 * unpack 5 coefficients from 8 bits
 */
static void
string_to_tri(
    const uint16_t  in_len,     /*  in - degree of trinary poly */
    const unsigned char  *in,   /*  in - ptr to string */
    uint16_t        *out)       /* out - addr for trinary poly */
{
    unsigned char tmp;
    int i,j;
    int padNover5;

    padNover5 = in_len/5;
    if(in_len%5==0)
        padNover5--;

    for(i=0;i<padNover5;i++)
    {
        tmp = in[i];
        for (j=4;j>=0;j--)
        {
            out[i*5+j] = tmp%3;
            if (out[i*5+j]== 2)
                out[i*5+j] = -1;
            tmp /= 3;
        }
    }
    tmp = in [padNover5];

    for (i=4;i>=0;i--)
    {
        if (padNover5*5+i<in_len)
        {
            out[padNover5*5+i] = tmp%3;
            if (out[padNover5*5+i]== 2)
                out[padNover5*5+i] = -1;
        }
        tmp /= 3;
    }


    return;
}


int pack_public_key(
    unsigned char   *blob,
    const PARAM_SET *param,
    const uint16_t  *h)

{
    blob[0] = (char) param->id;
    ntru_elements_2_octets(param->N, h, param->q_bits, blob+1);

    return 0;
}

int unpack_public_key(
    const unsigned char   *blob,
    PARAM_SET *param,
    uint16_t  *h)
{
    param = get_param_set_by_id(blob[0]);
    ntru_octets_2_elements (param->packpk, blob+1, param->q_bits, h);
    return 0;
}


int pack_secret_key_CCA(
    unsigned char   *blob,
    const PARAM_SET *param,
    const uint16_t  *F,
    uint16_t        *h)
{

    blob[0] = (char) param->id;
    tri_to_string(param->N, F, blob+1);
    pack_public_key (blob+1+param->packsk, param, h);
    return 0;
}

int pack_secret_key_KEM(
    unsigned char   *blob,
    const PARAM_SET *param,
    const uint16_t  *F)
{

    blob[0] = (char) param->id;
    tri_to_string(param->N, F, blob+1);

    return 0;
}

int unpack_secret_key_CCA(
    const unsigned char   *blob,
    PARAM_SET       *param,
    uint16_t        *F,
    uint16_t        *h)
{
    param = get_param_set_by_id(blob[0]);
    if(param == NULL)
    {
        return -1;
    }
    string_to_tri (param->N, blob+1, F);
    unpack_public_key (blob+1+param->packsk, param, h);

    return 0;
}

int unpack_secret_key_KEM(
    const unsigned char   *blob,
    PARAM_SET       *param,
    uint16_t        *F)
{
    param = get_param_set_by_id(blob[0]);
    string_to_tri (param->N, blob+1, F);

    return 0;
}
