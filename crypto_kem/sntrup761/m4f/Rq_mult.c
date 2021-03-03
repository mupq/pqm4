#include "Rq_mult.h"


/*************************************************
* Name:        Rq_mult_small
*
* Description: Computes polynomial multiplication in Z_q/(X^p-X-1)
*              with selected implementation.
*
* Arguments:
* Fq *h          : pointer to the output polynomial in R_q
* const Fq *f    : pointer to the input polynomial in R_q
* const small *g : pointer to the input polynomial in R_q
**************************************************/
void Rq_mult_small(Fq *h,const Fq *f,const small *g)
{
  int16_t g_modq[1530], fg[1530];

  byteToShort(h, g);

  ntt17_rader(h, g_modq);
  ntt17_rader(f, fg);
  fft9(g_modq);
  fft9(fg);

  polymul_10x10_153_mr(fg, g_modq);

  ifft9(fg);
  intt17_rader_mr(fg, g_modq);
  mod_reduce(h, g_modq);

}

/*************************************************
* Name:        Rq_mult_twice
*
* Description: Computes two polynomial multiplications in Z_q/(X^p-X-1)
*              with selected implementation.
*
* Arguments:
* Fq *bG          : pointer to the output polynomial in R_q
* Fq *bA          : pointer to the output polynomial in R_q
* const Fq *G    : pointer to the input polynomial in R_q
* const Fq *A    : pointer to the input polynomial in R_q
* const small *b : pointer to the input polynomial in R_q
**************************************************/
void Rq_mult_twice(Fq *bG, Fq *bA, const Fq *G, const Fq *A, const small *b){

  int16_t b_modq[1530], G_modq[1530], A_modq[1530];

  byteToShort(bG, b);

  ntt17_rader((const int16_t*)bG, b_modq);
  ntt17_rader(G, G_modq);
  ntt17_rader(A, A_modq);
  fft9(b_modq);
  fft9(G_modq);
  fft9(A_modq);

  polymul_10x10_153_mr(G_modq, b_modq);
  polymul_10x10_153_mr(A_modq, b_modq);

  ifft9(G_modq);
  ifft9(A_modq);
  intt17_rader_mr(G_modq, b_modq);
  intt17_rader_mr(A_modq, G_modq);
  mod_reduce(bG, b_modq);
  mod_reduce(bA, G_modq);

}
