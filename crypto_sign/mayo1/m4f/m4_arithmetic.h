// SPDX-License-Identifier: Apache-2.0

#ifndef M4_ARITHMETIC_H
#define M4_ARITHMETIC_H

#include <string.h>
#include <arithmetic.h>
#include <simple_arithmetic.h>
#include <arithmetic_fixed.h>

// M4R
void multiply_P1_right_m4f_O_asm2(uint32_t *table, const unsigned char *O, int col);
void multiply_P1t_right_m4f_V_V_O_asm(uint32_t *acc, const uint32_t *table, const uint64_t *P1, int rows);
void multiply_P1t_right_m4f_first_V_V_O_asm(uint32_t *acc, const uint32_t *table, const uint64_t *P1);
void multiply_P1_right_m4f_V_V_O_asm(uint32_t *acc, const uint32_t *table, const uint64_t *P1, int rows);

void multiply_P1_right_m4f_K_asm2_transposed(uint32_t *table, const unsigned char *O, int col);
void multiply_P1_right_m4f_V_V_K_asm(uint32_t *acc, const uint32_t *table, const uint64_t *P1, int rows);

// matmul
void mul_add_mat_x_m_mat_m4f_K_V_O_triangular_asm(uint64_t *acc, const unsigned char *mat, const uint64_t *bs_mat);
void mul_add_mat_x_m_mat_m4f_K_V_K_triangular_asm(uint64_t *acc, const unsigned char *mat, const uint64_t *bs_mat);
void mul_add_mat_trans_x_m_mat_m4f_V_O_O_asm(uint64_t *acc, const unsigned char *mat, const uint64_t *bs_mat);


// verification
void calculate_PS_m4f_stack_asm(uint64_t *acc, const uint64_t *P, const unsigned char *S, const int cols);
void multiply_bins_stack_asm(uint64_t *out, uint64_t *bins, const int cols);

void multiply_bins_asm(uint64_t *out, uint64_t *bins, const int cols);
void calculate_SPS_m4f_asm(uint64_t *acc, const uint64_t *PS, const unsigned char * S);

// multiplies the transpose of a single matrix with m matrices and adds result to acc
static inline
void mul_add_mat_trans_x_m_mat(const int m_vec_limbs, const unsigned char *mat, const uint64_t *bs_mat, uint64_t *acc,
                               const int mat_rows, const int mat_cols, const int bs_mat_cols){
    (void) m_vec_limbs;
    (void) mat_rows;
    (void) mat_cols;
    (void) bs_mat_cols;

    mul_add_mat_trans_x_m_mat_m4f_V_O_O_asm(acc, mat, bs_mat);
}

// multiplies a single matrix with m matrices and adds result to acc
static inline
void mul_add_mat_x_m_mat(const int m_vec_limbs, const unsigned char *mat, const uint64_t *bs_mat, uint64_t *acc,
                         const int mat_rows, const int mat_cols, const int bs_mat_cols) {
    (void) m_vec_limbs;
    if(mat_rows == K_MAX && mat_cols == V_MAX && bs_mat_cols == O_MAX){
        mul_add_mat_x_m_mat_m4f_K_V_O_triangular_asm(acc, mat, bs_mat);
    } else if(mat_rows == K_MAX && mat_cols == V_MAX && bs_mat_cols == K_MAX){
        mul_add_mat_x_m_mat_m4f_K_V_K_triangular_asm(acc, mat, bs_mat);
    }
}



static inline
void repack_add(uint32_t *out, const uint32_t *P2, const int dim0, const int dim1){
  const int v = dim0;
  const int o = dim1;
  const int m = M_MAX;
  const int mp = 16*((M_MAX+15)/16);
  const int o_size = (o+7)/8;


  for (int row = 0; row < v; row++)
  {
    for(int col = 0; col< o; col+=2){
      for(int k=0; k < m ; k += 8){
        unsigned char byte0 = P2[(row * mp + k)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte1 = P2[(row * mp + k + 1)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte2 = P2[(row * mp + k + 2)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte3 = P2[(row * mp + k + 3)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte4 = P2[(row * mp + k + 4)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte5 = P2[(row * mp + k + 5)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte6 = P2[(row * mp + k + 6)*o_size + (col/8)] >> (4*(col % 8));
        unsigned char byte7 = P2[(row * mp + k + 7)*o_size + (col/8)] >> (4*(col % 8));

        uint32_t out0 = (byte0 & 0xF) |
                        ((byte1 & 0xF) << (1*4) ) |
                        ((byte2 & 0xF) << (2*4) ) |
                        ((byte3 & 0xF) << (3*4) ) |
                        ((byte4 & 0xF) << (4*4) ) |
                        ((byte5 & 0xF) << (5*4) ) |
                        ((byte6 & 0xF) << (6*4) ) |
                        ((byte7 & 0xF) << (7*4) );

        uint32_t out1 = (byte0 >> 4) |
                        (byte1 & 0xF0) |
                        (byte2 & 0xF0) << (1*4) |
                        (byte3 & 0xF0) << (2*4) |
                        (byte4 & 0xF0) << (3*4) |
                        (byte5 & 0xF0) << (4*4) |
                        (byte6 & 0xF0) << (5*4) |
                        (byte7 & 0xF0) << (6*4);

        out[0]   ^= out0;
        if(col+1 < o)
          out[2*((m+15)/16)] ^= out1;
        out += 1;
      }
      if(col+1 < o)
        out += 2*((m+15)/16);
    }
  }
}

#if V_MAX % 2 != 0
#error This implementation requires even V
#endif

static __attribute__ ((noinline,unused))
void multiply_P1_right_m4f(uint32_t *P2, const uint64_t *P1, const unsigned char *O){
    const int o_size = (O_MAX+7)/8;
    const int m_vec_limbs = (M_MAX + 15)/ 16;

    uint32_t table[o_size*256];

    for (int col = 0; col < V_MAX; col += 2 ){

        for (int i = 0; i < o_size; i++)
        {
            table[i] = 0;
        }
        // build table.
        multiply_P1_right_m4f_O_asm2(table, O + col*O_MAX, col);

        // do pairs of field elements (P1)
        multiply_P1_right_m4f_V_V_O_asm(P2, table, P1 + m_vec_limbs * col, col+1);

    }
}

static __attribute__ ((noinline,unused))
void P1_times_O(const mayo_params_t* p, const uint64_t* P1, const unsigned char* O, uint64_t* acc){
    (void)p;
    // TODO: try to eliminate requiring M_MAX+7
    uint32_t P1_O[(O_MAX + 7)/8 * (8*((M_MAX+7)/8)) * V_MAX] = {0};
    multiply_P1_right_m4f(P1_O, P1, O);
    repack_add((uint32_t *)acc, P1_O, V_MAX, O_MAX);
}

static __attribute__ ((noinline,unused))
void multiply_P1_right_transposed_m4f(uint32_t *P1_O, const uint64_t *P1, const unsigned char *O){
    const int k_size = (K_MAX+7)/8;
    const int m_vec_limbs = (M_MAX + 15)/ 16;

    uint32_t table[k_size*256];
    for (int col = 0; col < V_MAX; col += 2 ){

        for (int i = 0; i < k_size; i++)
        {
            table[i] = 0;
        }

        // build table.
        multiply_P1_right_m4f_K_asm2_transposed(table, O + col, col);
        // do pairs of field elements (P1)
        multiply_P1_right_m4f_V_V_K_asm(P1_O, table, P1 + m_vec_limbs * col, col+1);
    }
}

static __attribute__ ((noinline,unused))
void P1_times_Vt(const mayo_params_t* p, const uint64_t* P1, const unsigned char* V, uint64_t* acc){
    (void)p;
    // TODO: try to eliminate requiring M_MAX+7
    uint32_t P1_Vt[(K_MAX + 7)/8 * (8*((M_MAX+7)/8)) * V_MAX] = {0};

    multiply_P1_right_transposed_m4f((uint32_t *)P1_Vt, P1, V);

    repack_add((uint32_t *)acc, P1_Vt, V_MAX, K_MAX);
}


static void multiply_P1P1t_right_m4f(uint32_t *P1_O, const uint64_t *P1, const unsigned char *O){
    const int o_size = (O_MAX+7)/8;
    // input and outputs are padded to 64-bit limbs
    // intermediate representation is 32-bit limbs
    const int m_vec_limbs_64 = (M_MAX + 15)/ 16;
    const int m_vec_limbs_32 = (M_MAX + 7) / 8;

    uint32_t table[o_size*256];

    const uint64_t *P1t_ptr = P1;
    for (int col = 0; col < V_MAX; col += 2 ){

        for (int i = 0; i < o_size; i++)
        {
            table[i] = 0;
        }

        // build table.
        multiply_P1_right_m4f_O_asm2(table, O + col*O_MAX, col);



        // do pairs of field elements (P1t)
        if(col >= 0){
            multiply_P1t_right_m4f_V_V_O_asm(&P1_O[((col)*m_vec_limbs_32*8) * o_size], table, P1t_ptr + m_vec_limbs_64 * (col), V_MAX-col-1);
        } else {
            multiply_P1t_right_m4f_first_V_V_O_asm(P1_O, table, P1);
        }


        if(col >= 0)
            P1t_ptr += m_vec_limbs_64*(V_MAX-col-1);
        P1t_ptr += m_vec_limbs_64*(V_MAX-(col+1)-1);
        // do pairs of field elements (P1)
        multiply_P1_right_m4f_V_V_O_asm(P1_O, table, P1 + m_vec_limbs_64 * col, col+1);
    }
}

static __attribute__ ((noinline,unused))
void P1P1t_times_O(const mayo_params_t* p, const uint64_t* P1, const unsigned char* O, uint64_t* acc) {
    (void)p;
    uint32_t P1_O[(O_MAX + 7)/8 *  (8*((M_MAX+7)/8)) * V_MAX] = {0};
    multiply_P1P1t_right_m4f(P1_O, P1, O);
    repack_add((uint32_t *)acc, P1_O, V_MAX, O_MAX);
}



// compute P * S^t = [ P1  P2 ] * [S1] = [P1*S1 + P2*S2]
//                   [  0  P3 ]   [S2]   [        P3*S2]
static __attribute__ ((noinline,unused))
void m_calculate_PS(const uint64_t *P1, const uint64_t *P2, const uint64_t *P3, const unsigned char *S,
                    const int _m, const int _v, const int _o, const int _k, uint64_t *PS)
{
    (void)_m;
    (void)_v;
    (void)_o;
    (void)_k;

    const int m = M_MAX;
    const int v = V_MAX;
    const int o = O_MAX;
    const int k = K_MAX;

    const int m_vec_limbs = (m + 15) / 16;
    const int n = o + v;

    uint64_t accumulator[16 * ((M_MAX + 15) / 16) * N_MAX] = {0};
    int P1_used;
    int P3_used;
    for (int col = 0; col < k; col++)
    {
        memset(accumulator, 0, sizeof accumulator);
        P1_used = 0;
        for (int row = 0; row < v; row++)
        {
            calculate_PS_m4f_stack_asm(accumulator + (row * 16) * m_vec_limbs, P1 + P1_used * m_vec_limbs, S + col * n + row, v - row);
            P1_used += v - row;
            calculate_PS_m4f_stack_asm(accumulator + (row * 16) * m_vec_limbs, P2 + (row * o) * m_vec_limbs, S + (col * n) + v, o);
        }

        P3_used = 0;
        for (int row = v; row < n; row++)
        {
            calculate_PS_m4f_stack_asm(accumulator + (row * 16) * m_vec_limbs, P3 + P3_used * m_vec_limbs, S + col * n + row, n - row);
            P3_used += (n - row);
        }

        multiply_bins_stack_asm(PS + col * m_vec_limbs, accumulator, n);
    }
}

static __attribute__ ((noinline,unused))
void m_calculate_SPS(const uint64_t *PS, const unsigned char *S, int _m, int _k, int  _n, uint64_t *SPS){
    (void) _n;
    (void) _m;
    (void) _k;

    const int m = M_MAX;
    const int k = K_MAX;

    uint64_t accumulator[16*((M_MAX+15)/16)*K_MAX*K_MAX] = {0};
    const int m_vec_limbs = (m + 15)/ 16;

    for (int col = 0; col < k; col += 1) {
        calculate_SPS_m4f_asm(accumulator + ( (col) * 16 )*m_vec_limbs, PS + (col) * m_vec_limbs, S);
    }

    // multiply stuff according to the bins of the accumulator and add to PS.
    multiply_bins_asm(SPS, accumulator, k*k);
}



static __attribute__ ((noinline,unused))
void compute_M_and_VPV(const mayo_params_t* p, const unsigned char* Vdec, const uint64_t *L, const uint64_t *P1, uint64_t *VL, uint64_t *VP1V){

    const int param_k = PARAM_k(p);
    const int param_v = PARAM_v(p);
    const int param_o = PARAM_o(p);

    //VL
    mul_add_mat_x_m_mat(PARAM_m_vec_limbs(p), Vdec, L, VL, param_k, param_v, param_o);

    //VP1V
    uint64_t Pv[V_MAX * K_MAX * M_VEC_LIMBS_MAX] = {0};
    P1_times_Vt(p, P1, Vdec, Pv);
    mul_add_mat_x_m_mat(PARAM_m_vec_limbs(p), Vdec, Pv, VP1V, param_k, param_v, param_k);
}

static inline
void compute_P3(const mayo_params_t* p, const uint64_t* P1, uint64_t *P2, const unsigned char *O, uint64_t *P3){

    const int m_vec_limbs = PARAM_m_vec_limbs(p);
    const int param_v = PARAM_v(p);
    const int param_o = PARAM_o(p);

    // compute P1*O + P2
    P1_times_O(p, P1, O, P2);

    // compute P3 = O^t * (P1*O + P2)
    mul_add_mat_trans_x_m_mat(m_vec_limbs, O, P2, P3, param_v, param_o, param_o);
}

// compute P * S^t = [ P1  P2 ] * [S1] = [P1*S1 + P2*S2]
//                   [  0  P3 ]   [S2]   [        P3*S2]
// compute S * PS  = [ S1 S2 ] * [ P1*S1 + P2*S2 = P1 ] = [ S1*P1 + S2*P2 ]
//                               [         P3*S2 = P2 ]
static __attribute__ ((noinline,unused)) void m_calculate_PS_SPS(const mayo_params_t *p, const uint64_t *P1, const uint64_t *P2, const uint64_t *P3, const unsigned char *s,
                                      uint64_t *SPS) {
    // compute P * S^t = {(P1, P2), (0, P3)} * S^t = {(P1*S1 + P2*S2), (P3 * S2)}
    #ifndef ENABLE_PARAMS_DYNAMIC
    (void) p;
    #endif
    uint64_t PS[N_MAX * K_MAX * M_VEC_LIMBS_MAX] = { 0 };
    m_calculate_PS(P1, P2, P3, s, PARAM_m(p), PARAM_v(p), PARAM_o(p), PARAM_k(p), PS);

    // compute S * P * S = S* (P*S)
    m_calculate_SPS(PS, s, PARAM_m(p), PARAM_k(p), PARAM_n(p), SPS);
}

#endif
