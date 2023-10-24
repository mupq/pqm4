#include "ov_keypair.h"
#include "ov.h"
#include "ov_blas.h"
#include "utils_prng.h"
#include "params.h"

#ifdef _USE_GF16
#include "gf16_asm.h"
#else
#include "gf256_asm.h"
#endif


#if !(defined(_OV_PKC) || defined(_OV_PKC_SKC)) || !defined(_SAVE_MEMORY_)
void ov_publicmap( unsigned char * y, const unsigned char * trimat, const unsigned char * x )
{
    #ifdef _OV256_112_44
    gf256trimat_eval_m4f_112_44_publicinputs(y, trimat, x);
    #elif defined(_OV16_160_64)
    gf16trimat_eval_m4f_160_32_publicinputs(y, trimat, x, gf16mul_lut);
    #else
    #error ov_publicmap not implemented
    #endif
}
#endif

#if (defined(_OV_PKC) || defined(_OV_PKC_SKC)) && defined(_SAVE_MEMORY_)
void ov_publicmap_pkc(unsigned char * y, const cpk_t * cpk, const unsigned char *signature){

    prng_publicinputs_t prng0;
    prng_set_publicinputs(&prng0 , cpk->pk_seed);
    #ifdef _OV256_112_44
    gf256trimat_eval_m4f_112_44_incremental_publicinputs(y, &prng0, cpk->P3, signature);
    #elif defined(_OV16_160_64)
    gf16trimat_eval_m4f_160_32_incremental_publicinputs(y,cpk->P3, signature, gf16mul_lut, &prng0);
    #else
    #error ov_publicmap_pkc not implemented
    #endif
}
#endif
