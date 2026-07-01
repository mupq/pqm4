/**
 *
 * Reference ISO-C11 Implementation of CROSS.
 *
 * @version 2.2 (July 2025)
 *
 * Authors listed in alphabetical order:
 * 
 * @author: Alessandro Barenghi <alessandro.barenghi@polimi.it>
 * @author: Marco Gianvecchio <marco.gianvecchio@mail.polimi.it>
 * @author: Patrick Karl <patrick.karl@tum.de>
 * @author: Gerardo Pelosi <gerardo.pelosi@polimi.it>
 * @author: Jonas Schupp <jonas.schupp@tum.de>
 * 
 * 
 * This code is hereby placed in the public domain.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 **/

#pragma once

#include <stdlib.h>
#include <string.h>

#include "m4_defs.h"
#include "csprng_hash.h"
#include "parameters.h"
#include "restr_arith.h"

#if defined(M4_FALLBACK)
#include "m4_fallback.h"
#else
#include <arm_acle.h>
#endif

#if defined(RSDP)
#define FPRED_SINGLE(x) (((x) & 0x7F) + ((x) >> 7))
#define FPRED_DOUBLE(x) FPRED_SINGLE(FPRED_SINGLE(x))
#define FPRED_OPPOSITE(x) ((x) ^ 0x7F)
#define FP_DOUBLE_ZERO_NORM(x) (((x) + (((x) + 1) >> 7)) & 0x7F)
/* Ad-hoc reduction for matrix multiplication, for ints in [0,P+K*P^2] */
#define U32_REDUCE_FP(x) (((x) - (((uint64_t)(x) * 4227331) >> 29) * P))


#elif defined(RSDPG)
/* Reduction modulo P=509 as shown in:
 * Hacker's Delight, Second Edition, Chapter 10, Figure 10-4
 * Works for integers in the range [0,4294967295] i.e. all uint32_t */
#define FPRED_SINGLE(x) (((x) - (((uint64_t)(x) * 2160140723) >> 40) * P))
#define FPRED_DOUBLE(x) (FPRED_SINGLE(x))
#define FPRED_OPPOSITE(x) (FPRED_SINGLE(P - (x)))
/* no redundant zero notation in F_509 */
#define FP_DOUBLE_ZERO_NORM(x) (x)
/* Ad-hoc reduction for matrix multiplication, for ints in [0,(P-1)+K*(P-1)^2] */
#define U32_REDUCE_FP(x) (((x) - (((uint64_t)(x) * 4219025) >> 31) * P))


#endif

#if defined(RSDP)

static inline
FP_ELEM RESTR_TO_VAL(FP_ELEM x){
	uint32_t t;
	t = (1 << x);
	t += t >> 7;
	t &= 0x7f;
	return (FP_ELEM)t;
}

#elif defined(RSDPG)

#define RESTR_G_GEN_1  ((FP_ELEM)RESTR_G_GEN)
#define RESTR_G_GEN_2  ((FP_ELEM) 256)
#define RESTR_G_GEN_4  ((FP_ELEM) 384)
#define RESTR_G_GEN_8  ((FP_ELEM) 355)
#define RESTR_G_GEN_16 ((FP_ELEM) 302)
#define RESTR_G_GEN_32 ((FP_ELEM) 93)
#define RESTR_G_GEN_64 ((FP_ELEM) 505)
#define FP_ELEM_CMOV(BIT,TRUE_V,FALSE_V)  ( (((FP_ELEM)0 - (BIT)) & (TRUE_V)) | (~((FP_ELEM)0 - (BIT)) & (FALSE_V)) )
/* log reduction, constant time unrolled S&M w/precomputed squares.
 * To be further optimized with muxed register-fitting tables */
static inline
FP_ELEM RESTR_TO_VAL(FP_ELEM x){
    uint32_t res1, res2, res3, res4;
    res1 = ( FP_ELEM_CMOV(((x >> 0) &1),RESTR_G_GEN_1 ,1)) *
           ( FP_ELEM_CMOV(((x >> 1) &1),RESTR_G_GEN_2 ,1)) ;
    res2 = ( FP_ELEM_CMOV(((x >> 2) &1),RESTR_G_GEN_4 ,1)) *
           ( FP_ELEM_CMOV(((x >> 3) &1),RESTR_G_GEN_8 ,1)) ;
    res3 = ( FP_ELEM_CMOV(((x >> 4) &1),RESTR_G_GEN_16,1)) *
           ( FP_ELEM_CMOV(((x >> 5) &1),RESTR_G_GEN_32,1)) ;
    res4 =   FP_ELEM_CMOV(((x >> 6) &1),RESTR_G_GEN_64,1);
    /* Two intermediate reductions necessary:
     *     RESTR_G_GEN_1*RESTR_G_GEN_2*RESTR_G_GEN_4*RESTR_G_GEN_8    < 2^32
     *     RESTR_G_GEN_16*RESTR_G_GEN_32*RESTR_G_GEN_64               < 2^32 */
    return FPRED_SINGLE( FPRED_SINGLE(res1 * res2) * FPRED_SINGLE(res3 * res4) );
}

#endif

/* in-place normalization of redundant zero representation for syndromes*/
static inline
void fp_dz_norm_synd(FP_ELEM v[N-K]){
    for (int i = 0; i < N-K; i++){
       v[i] = FP_DOUBLE_ZERO_NORM(v[i]);
    }
}

static inline
void fp_dz_norm(FP_ELEM v[N]){
    for (int i = 0; i < N; i++){
       v[i] = FP_DOUBLE_ZERO_NORM(v[i]);
    }
}
/* Computes the product e*H of an n-element restricted vector by a (n-k)*n
 * FP H is in systematic form. Only the non systematic portion of H =[V I],
 * V, is provided, transposed, hence linearized by columns so that syndrome
 * computation is vectorizable. */

static
void restr_vec_by_fp_matrix(FP_ELEM res[N-K],
                            FZ_ELEM e[N],
                            FP_ELEM_M4 V_tr[V_ROWS][V_COLS]){
    FP_DOUBLEPREC res_dprec[N-K] = {0};
    for(int i=0; i< N-K;i++) {
        res_dprec[i]=RESTR_TO_VAL(e[K+i]);
    }
    for(int i = 0; i < K; i++){
       for(int j = 0; j < N-K; j++){
           res_dprec[j] += FPRED_SINGLE(
                                  (FP_DOUBLEPREC) RESTR_TO_VAL(e[i]) *
                                  (FP_DOUBLEPREC) V_tr[j][i]);
           if(i == P-1) { res_dprec[j] = FPRED_SINGLE(res_dprec[j]); }
       }
    }
    /* Save result trimming to regular precision */
    for(int i=0; i< N-K;i++) {
        res[i] = FPRED_SINGLE(res_dprec[i]);
    }
}

#if !defined(M4_FALLBACK)
extern uint32_t smlad_batch_V(const uint16_t *a, const uint16_t *b);
#endif
static inline 
void fp_vec_by_fp_matrix(FP_ELEM res[N-K],
                         FP_ELEM_M4 e[N],
                         FP_ELEM_M4 V_tr[V_ROWS][V_COLS]){
    /* res: convert to uint32, add last N-K elements of e */
    uint32_t res_x[N - K];
    for (int i = 0; i < N - K; i++){
        res_x[i] = e[i + K];
    }
    for (int icol = 0; icol < N - K; icol++){
        /* - load 10 elements from vector e
         * - load 10 elements from matrix V_tr
         * - multiply them in pairs
         * - accumulate the result
         * repeat until less than 10 elements are left */
        res_x[icol] += smlad_batch_V(&e[0], &V_tr[icol][0]);
        /* multiply and accumplate the last few elements (<10) in pairs */
        for (int irow = SMLAD_BATCH_SIZE_V; irow < K-(K%2); irow += 2){
            res_x[icol] = __smlad(*(uint32_t *)(e+irow), *(uint32_t *)(V_tr[icol]+irow), res_x[icol]);
        }
        /* when K is odd multiply the very last element on its own */
        if(K%2 == 1){
            res_x[icol] += e[K-1] * V_tr[icol][K-1];
        }
        /* reduce the result mod P and store it back */
        res_x[icol] = U32_REDUCE_FP(res_x[icol]);
        res[icol] = res_x[icol];
    }
}

static inline
void fp_vec_by_fp_vec_pointwise(FP_ELEM_M4 res[N],
                                const FP_ELEM in1[N],
                                const FP_ELEM in2[N]){
    for(int i = 0; i < N; i++){
        res[i] = FPRED_SINGLE( (FP_DOUBLEPREC) in1[i] *
                               (FP_DOUBLEPREC) in2[i] );
    }
}

static inline
void restr_by_fp_vec_pointwise(FP_ELEM res[N],
                                const FZ_ELEM in1[N],
                                const FP_ELEM in2[N]){
    for(int i = 0; i < N; i++){
        res[i] = FPRED_SINGLE( (FP_DOUBLEPREC) RESTR_TO_VAL(in1[i]) *
                               (FP_DOUBLEPREC) in2[i]);
    }
}

/* e*chall_1 + u_prime*/
#if defined(RSDP)
static inline
void fp_vec_by_restr_vec_scaled(FP_ELEM res[N],
                                const FZ_ELEM e[N],
                                const FP_ELEM chall_1,
                                const FP_ELEM u_prime[N]){
    for(int i = 0; i < N; i++){
        res[i] = FPRED_DOUBLE( (FP_DOUBLEPREC) u_prime[i] +
                               (FP_DOUBLEPREC) RESTR_TO_VAL(e[i]) * (FP_DOUBLEPREC) chall_1) ;
    }
}
#endif /* defined(RSDP) */

#if defined(RSDPG)
static inline
void fp_vec_by_restr_vec_scaled(FP_ELEM res[N],
                                const FZ_ELEM e[N],
                                const FP_ELEM chall_1,
                                const FP_ELEM u_prime[N]){
    for(int i = 0; i < N; i++){
        res[i] = FPRED_SINGLE( (FP_DOUBLEPREC) u_prime[i] +
                               (FP_DOUBLEPREC) RESTR_TO_VAL(e[i]) * (FP_DOUBLEPREC) chall_1) ;
    }
}
#endif /* defined(RSDPG) */


static inline
void fp_synd_minus_fp_vec_scaled(FP_ELEM res[N-K],
                                 const FP_ELEM synd[N-K],
                                 const FP_ELEM chall_1,
                                 const FP_ELEM s[N-K]){
    for(int j = 0; j < N-K; j++){
        FP_ELEM tmp = FPRED_SINGLE( (FP_DOUBLEPREC) s[j] * (FP_DOUBLEPREC) chall_1);
        tmp = FP_DOUBLE_ZERO_NORM(tmp);
        res[j] = FPRED_SINGLE( (FP_DOUBLEPREC) synd[j] + FPRED_OPPOSITE(tmp) );
    }
}

static inline
void convert_restr_vec_to_fp(FP_ELEM res[N],
                            const FZ_ELEM in[N]){
    for(int j = 0; j < N; j++){
        res[j] = RESTR_TO_VAL(in[j]);
    }
}
