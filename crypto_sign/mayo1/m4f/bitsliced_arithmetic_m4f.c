// SPDX-License-Identifier: Apache-2.0

#include "bitsliced_arithmetic.h"
#include <stdalign.h>
#include <string.h>
#include <simple_arithmetic.h>
#include "m4f_asm.h"

// This implements arithmetic for bitsliced vectors of m field elements in Z_2[x]/(x^4+x+1)
// A bitsliced vector is consists of m/32 * 4 consecutive uint32_t's
// the first m/32 uint32_t's are the degree-0 terms, the following m/3 uint32_t's are the degree-1 terms and so on.

void bitsliced_m_vec_mul_add(int m_legs, const uint32_t *in, unsigned char a, uint32_t *acc) {
    const uint32_t *in0 = in;
    const uint32_t *in1 = in + m_legs;
    const uint32_t *in2 = in + 2 * m_legs;
    const uint32_t *in3 = in + 3 * m_legs;

    uint32_t *acc0 = acc;
    uint32_t *acc1 = acc + m_legs;
    uint32_t *acc2 = acc + 2 * m_legs;
    uint32_t *acc3 = acc + 3 * m_legs;

    // terms of a
    uint32_t aa = a;
    uint32_t a0 = -(aa & 1);
    uint32_t a1 = -((aa >> 1) & 1);
    uint32_t a2 = -((aa >> 2) & 1);
    uint32_t a3 = -((aa >> 3) & 1);

    uint32_t x, y, z;
    for (int i = 0; i < m_legs; i++) {
        // deg 0 term of a;
        acc0[i] ^= a0 & in0[i];
        acc1[i] ^= a0 & in1[i];
        acc2[i] ^= a0 & in2[i];
        acc3[i] ^= a0 & in3[i];

        // deg 1 term of a;
        x = in0[i] ^ in3[i];
        acc0[i] ^= a1 & in3[i];
        acc1[i] ^= a1 & x;
        acc2[i] ^= a1 & in1[i];
        acc3[i] ^= a1 & in2[i];

        // deg 2 term of a
        y = in3[i] ^ in2[i];
        acc0[i] ^= a2 & in2[i];
        acc1[i] ^= a2 & y;
        acc2[i] ^= a2 & x;
        acc3[i] ^= a2 & in1[i];

        // deg 3 term of a
        z = in2[i] ^ in1[i];
        acc0[i] ^= a3 & in1[i];
        acc1[i] ^= a3 & z;
        acc2[i] ^= a3 & y;
        acc3[i] ^= a3 & x;
    }
}


void bitsliced_m_upper(int m_legs, const uint32_t *in, uint32_t *out, int size) {
    int m_vecs_stored = 0;
    for (int r = 0; r < size; r++) {
        for (int c = r; c < size; c++) {
            bitsliced_m_vec_copy(m_legs, in + m_legs * 4 * (r * size + c), out + m_legs * 4 * m_vecs_stored );
            if (r != c) {
                bitsliced_m_vec_add(m_legs, in + m_legs * 4 * (c * size + r), out + m_legs * 4 * m_vecs_stored );
            }
            m_vecs_stored ++;
        }
    }
}

void bitslice_m_vec(int m_legs, const unsigned char *in, uint32_t *out) {
    uint32_t *out0 = out;
    uint32_t *out1 = out + m_legs;
    uint32_t *out2 = out + 2 * m_legs;
    uint32_t *out3 = out + 3 * m_legs;

    for (int leg = 0; leg < m_legs; leg++) {
        uint32_t d0 = 0, d1 = 0, d2 = 0, d3 = 0;
        for (int i = 31; i >= 0; i--) {
            d0 = (d0 << 1) ^  (in[32 * leg + i] & 1);
            d1 = (d1 << 1) ^ ((in[32 * leg + i] & 2) >> 1);
            d2 = (d2 << 1) ^ ((in[32 * leg + i] & 4) >> 2);
            d3 = (d3 << 1) ^ ((in[32 * leg + i] & 8) >> 3);
        }
        out0[leg] = d0;
        out1[leg] = d1;
        out2[leg] = d2;
        out3[leg] = d3;
    }
}

void unbitslice_m_vec(int m_legs, const uint32_t *in, unsigned char *out) {
    const uint32_t *in0 = in;
    const uint32_t *in1 = in + m_legs;
    const uint32_t *in2 = in + 2 * m_legs;
    const uint32_t *in3 = in + 3 * m_legs;

    for (int leg = 0; leg < m_legs; leg ++) {
        for (int i = 0; i < 32; i++) {
            out[leg * 32 + i] = ((in0[leg] >> i) & 1) ^
                                (((in1[leg] >> i) & 1) << 1) ^
                                (((in2[leg] >> i) & 1) << 2) ^
                                (((in3[leg] >> i) & 1) << 3) ;
        }
    }
}

void P1_times_O(const mayo_params_t* p, const uint32_t* P1, const unsigned char* O, uint32_t* acc){
    (void) p;
    mul_add_bitsliced_m_upper_triangular_mat_x_mat_m4f_V_V_O_triangular_asm(acc, P1, O);
}

void P1P1t_times_O(const mayo_params_t* p, const uint32_t* P1, const unsigned char* O, uint32_t* acc){
    (void) p;
    const int param_m = M_MAX;
    const int m_legs = param_m / 32;
    const int param_o = O_MAX;
    const int param_v = V_MAX;
    int bs_mat_entries_used;

    for (int i = 0; i < m_legs; i++)
    {
        bs_mat_entries_used = 0;
        for (int r = 0; r < param_v - 1; r++)
        {
            bs_mat_entries_used++;
            int c = r + 1;
            mayo_expand_sk_computeL_inner1_m4f(acc + m_legs * 4 * (r * param_o) + i, P1 + m_legs * 4 * bs_mat_entries_used + i, O + c * param_o, O + param_v * param_o);
            bs_mat_entries_used += param_v - (r + 1);
        }
    }

    for (int i = 0; i < m_legs; i++)
    {
        bs_mat_entries_used = 0;
        for (int c = 1; c < param_v; c++)
        {
            mayo_expand_sk_computeL_inner2_m4f(acc + m_legs * 4 * (c * param_o) + i, P1 + m_legs * 4 * (bs_mat_entries_used + 1) + i , O, c);
            bs_mat_entries_used += 1;
        }
    }
}

void P1_times_Vt(const mayo_params_t* p, const uint32_t* P1, const unsigned char* V, uint32_t* acc){
    (void) p;
    mul_add_bitsliced_m_upper_triangular_mat_x_mat_trans_m4f_V_V_K_triangular_asm(acc, P1, V);
}


// multiplies the transpose of a single matrix with m bitsliced matrices and adds result to acc
void mul_add_mat_trans_x_bitsliced_m_mat(int m_legs, const unsigned char *mat, const uint32_t *bs_mat, uint32_t *acc, int mat_rows, int mat_cols, int bs_mat_cols) {

    for (int r = 0; r < mat_cols; r++) {
        for (int c = 0; c < mat_rows; c++) {
            for (int k = 0; k < bs_mat_cols; k += 1) {
#if defined(MAYO_VARIANT) && (M_MAX == 64)
                (void) m_legs;
                bitsliced_64_vec_mul_add((uint64_t *)bs_mat + 4 * (c * bs_mat_cols + k), mat[c * mat_cols + r], (uint64_t *) acc + 4 * (r * bs_mat_cols + k));
#elif defined(MAYO_VARIANT) && (M_MAX == 96)
                (void) m_legs;
                bitsliced_96_vec_mul_add(bs_mat + 12 * (c * bs_mat_cols + k), mat[c * mat_cols + r], acc + 12 * (r * bs_mat_cols + k));
#elif defined(MAYO_VARIANT) && (M_MAX == 128)
                (void) m_legs;
                bitsliced_128_vec_mul_add((uint64_t *)bs_mat + 8 * (c * bs_mat_cols + k), mat[c * mat_cols + r], (uint64_t *) acc + 8 * (r * bs_mat_cols + k));
#else
                bitsliced_m_vec_mul_add(m_legs, bs_mat + m_legs * 4 * (c * bs_mat_cols + k), mat[c * mat_cols + r], acc + m_legs * 4 * (r * bs_mat_cols + k));
#endif
            }
        }
    }
}

// multiplies a single matrix with m bitsliced matrices and adds result to acc
void mul_add_mat_x_bitsliced_m_mat(int m_legs, const unsigned char *mat, const uint32_t *bs_mat, uint32_t *acc, int mat_rows, int mat_cols, int bs_mat_cols) {
    (void) m_legs;
    if(mat_rows == K_MAX && mat_cols == V_MAX && bs_mat_cols == O_MAX){
        mul_add_mat_x_bitsliced_m_mat_m4f_K_V_O_triangular_asm(acc, mat, bs_mat);
    } else if(mat_rows == K_MAX && mat_cols == V_MAX && bs_mat_cols == K_MAX){
        mul_add_mat_x_bitsliced_m_mat_m4f_K_V_K_triangular_asm(acc, mat, bs_mat);
    } 
}

// compute P * S^t = [ P1  P2 ] * [S1] = [P1*S1 + P2*S2] in bitsliced form
//                   [  0  P3 ]   [S2]   [        P3*S2]
void bitsliced_m_calculate_PS_m4f(const uint32_t *P1, const uint32_t *P2, const uint32_t *P3, const unsigned char *S, uint32_t *PS) {
    const int m = M_MAX;
    const int v = V_MAX;
    const int o = O_MAX;
    const int k = K_MAX;
    const int n = o + v;
    const int m_legs = m / 32;

    #if N_MAX > 78
    uint32_t accumulator[16 * M_MAX * N_MAX / 8] = {0};
    int P1_used;
    int P3_used;
    for (int col = 0; col < k; col++) {
        memset(accumulator, 0, sizeof accumulator);
        P1_used = 0;
        for (int row = 0; row < v; row++) {
                bitsliced_m_calculate_PS_m4f_stack_asm(accumulator + ( row * 16 )*m_legs * 4 ,  P1 + P1_used * m_legs * 4, S + col*n + row, v-row);
                P1_used += v-row;
                bitsliced_m_calculate_PS_m4f_stack_asm(accumulator + ( row * 16  )*m_legs * 4 , P2 + (row * o)*m_legs * 4, S + (col * n) + v, o);
        }

        P3_used = 0;
        for (int row = v; row < n; row++) {
            bitsliced_m_calculate_PS_m4f_stack_asm(accumulator + ( row * 16 )*m_legs * 4 , P3 + P3_used * m_legs * 4, S + col * n + row, n-row);
            P3_used += (n-row);

        }
        bitsliced_multiply_bins_stack_asm(accumulator, PS + col * m_legs * 4, n);
    }
    #else
    uint32_t accumulator[16 * M_MAX * K_MAX * N_MAX / 8] = {0};
    int P1_used = 0;

    //bitsliced_m_calculate_PS_m4f_P1_asm(accumulator, P1, S);
    for (int row = 0; row < v; row++) {

        bitsliced_m_calculate_PS_m4f_asm(accumulator + ( (row * k) * 16)*m_legs * 4,  P1 + P1_used * m_legs * 4, S+row, v-row);
        P1_used += (v-row);
        bitsliced_m_calculate_PS_m4f_asm(accumulator + ( (row * k) * 16)*m_legs * 4, P2 + (row * o)*m_legs * 4, S+v, o);
    }

    int P3_used = 0;
    for (int row = v; row < n; row++) {
        bitsliced_m_calculate_PS_m4f_asm(accumulator + ( (row * k) * 16)*m_legs * 4,  P3 + P3_used * m_legs * 4, S+row, n-row);
        P3_used += (n-row);
    }

    // multiply stuff according to the bins of the accumulator and add to PS.
    bitsliced_multiply_bins_asm(accumulator, PS, n*k);
    #endif
}


void bitsliced_m_calculate_SPS_m4f(const uint32_t *PS, const unsigned char *S, uint32_t *SPS){
    const int k = K_MAX;
    const int m = M_MAX;
    uint32_t accumulator[16*M_MAX*K_MAX*K_MAX/8] = {0};
    const int m_legs = m/32;

    for (int col = 0; col < k; col += 1) {
        bitsliced_m_calculate_SPS_m4f_asm(accumulator + ( (col) * 16 )*m_legs * 4, PS + (col) * m_legs * 4, S);
    }

    bitsliced_multiply_bins_asm(accumulator, SPS, k*k);
}

void bitsliced_m_calculate_PS_SPS(const uint32_t *bitsliced_P1, const uint32_t *bitsliced_P2, const uint32_t *bitsliced_P3, const unsigned char *S,
                              const int m, const int v, const int o, const int k, uint32_t *bitsliced_SPS){
    (void) m;
    (void) v;
    (void) o;
    (void) k;
    // compute P * S^t = {(P1, P2), (0, P3)} * S^t = {(P1*S1 + P2*S2), (P3 * S2)}
    alignas (32) uint32_t bitsliced_PS[N_MAX * K_MAX * M_MAX / 8];

    bitsliced_m_calculate_PS_m4f(bitsliced_P1, bitsliced_P2, bitsliced_P3, S, bitsliced_PS);
    bitsliced_m_calculate_SPS_m4f(bitsliced_PS, S, bitsliced_SPS);
}



#define PARAM_m(p) PARAM_NAME(m)
#define PARAM_o(p) PARAM_NAME(o)
#define PARAM_A_cols(p) PARAM_NAME(A_cols)
#define PARAM_k(p) PARAM_NAME(k)
#define MAYO_MIN(x, y) (((x) < (y)) ? (x) : (y))
#define MAYO_MAX(x, y) (((x) > (y)) ? (x) : (y))

// assembly
void ef_bitslice_asm(uint32_t *a_bs, unsigned char *a);
void ef_unbitslice_asm(unsigned char *a, uint32_t *a_bs);
uint8_t ef_inner1_asm(uint32_t *pivot_row, uint32_t *a_bs_row, int pivot_col, int pivot_row_lower_bound, int pivot_row_ctr, uint8_t *pivot_is_zero, int row_upper_bound);
void    ef_inner2_asm(uint32_t *pivot_row2, uint32_t *pivot_row, uint8_t pivot);
void    ef_inner3_asm(uint32_t *a_bs_row, uint32_t *pivot_row, int pivot_row_ctr, int pivot_row_lower_bound, int pivot_row_upper_bound, int pivot_is_zero);
int     ef_inner4_asm(uint32_t *a_bs, uint32_t *pivot_row, int pivot_row_lower_bound, int pivot_row_ctr, int pivot_col, int pivot_is_nonzero);
void    backsub_inner_asm(uint8_t *a1, uint8_t *a2, uint8_t *a3, int correct_column, int r);


// put matrix in row echelon form with ones on first nonzero entries *in
// constant time*
static void EF(unsigned char *A, int nrows, int ncols) {

    uint32_t _pivot_row[(K_MAX * O_MAX + 1 + 31) / 32 * 4];
    uint32_t _pivot_row2[(K_MAX * O_MAX + 1 + 31) / 32 * 4];
    uint32_t bitsliced_A[((K_MAX * O_MAX + 1 + 31) / 32) * 4 * M_MAX];

    int legs = (ncols + 31) / 32;


    ef_bitslice_asm(bitsliced_A, A);

    // pivot row is secret, pivot col is not

    //unsigned char inverse;
    int pivot_row = 0;
    for (int pivot_col = 0; pivot_col < ncols; pivot_col++) {

        int pivot_row_lower_bound = MAYO_MAX(0, pivot_col + nrows - ncols);
        int pivot_row_upper_bound = MAYO_MIN(nrows - 1, pivot_col);
        // the pivot row is guaranteed to be between these lower and upper bounds if
        // A has full rank

        // zero out pivot row
        for (int i = 0; i < legs * 4; i++) {
            _pivot_row[i] = 0;
        }

        // try to get a pivot row in constant time
        unsigned char pivot = 0;
        unsigned char pivot_is_zero = 1;


        // make sure pivot is non-zero
        pivot = ef_inner1_asm(_pivot_row, bitsliced_A + pivot_row_lower_bound*legs*4, pivot_col, pivot_row_lower_bound, pivot_row, &pivot_is_zero, MAYO_MIN(nrows - 1, pivot_row_upper_bound + 16));

        ef_inner2_asm(_pivot_row2, _pivot_row, pivot);

        // conditionally write pivot row to the correct row, if there is a nonzero
        // pivot
        ef_inner3_asm(bitsliced_A + pivot_row_lower_bound * legs * 4, _pivot_row2, pivot_row, pivot_row_lower_bound, pivot_row_upper_bound, pivot_is_zero ? 1 : 0);

        // eliminate entries below pivot
        pivot_row = ef_inner4_asm(bitsliced_A, _pivot_row2, pivot_row_lower_bound, pivot_row, pivot_col, pivot_is_zero ? 0 : 1);
    }

    // unbitslice the matrix A
    for (int i = 0; i < nrows; i++) {
        ef_unbitslice_asm(A + i*ncols, bitsliced_A + i * legs * 4);
    }
}


// sample a solution x to Ax = y, with r used as randomness
// require:
// - A is a matrix with m rows and k*o+1 collumns (values in the last collum are
// not important, they will be overwritten by y) in row major order
// - y is a vector with m elements
// - r and x are k*o bytes long
// return: 1 on success, 0 on failure
int sample_solution(const mayo_params_t *p, unsigned char *A,
                           const unsigned char *y, const unsigned char *r,
                           unsigned char *x, int _k, int _o, int _m, int _A_cols) {
    int finished;
    int col_upper_bound;
    int correct_column;
    (void) _k;
    (void) _o;
    (void) _m;
    (void) _A_cols;
    const int k = PARAM_k(p);
    const int o = PARAM_o(p);
    const int m = PARAM_m(p);
    const int A_cols = PARAM_A_cols(p);

    (void) p;

    // x <- r
    for (int i = 0; i < k * o; i++) {
        x[i] = r[i];
    }

    // compute Ar;
    unsigned char Ar[M_MAX];
    for (int i = 0; i < m; i++) {
        A[k * o + i * (k * o + 1)] = 0; // clear last col of A
    }
    mat_mul(A, r, Ar, k * o + 1, m, 1);

    // move y - Ar to last column of matrix A
    for (int i = 0; i < m; i++) {
        A[k * o + i * (k * o + 1)] = sub_f(y[i], Ar[i]);
    }

    EF(A, m, k * o + 1);

    // check if last row of A (excluding the last entry of y) is zero
    unsigned char full_rank = 0;
    for (int i = 0; i < A_cols - 1; i++) {
        full_rank |= A[(m - 1) * A_cols + i];
    }


    if (full_rank == 0) {
        return 0;
    }

    // back substitution in constant time
    // the index of the first nonzero entry in each row is secret, which makes
    // things less efficient
    for (int u = m - 1; u >= 0; u--) {
        finished = 0;
        col_upper_bound = MAYO_MIN(u + (32/(m-u)), k*o);
        // the first nonzero entry in row r is between r and col_upper_bound with probability at least ~1-q^{-32}

        for (int col = u; col <= col_upper_bound; col++) {
            correct_column = (A[u * A_cols + col] != 0) && !finished;

            x[col] ^= correct_column * A[u * A_cols + A_cols - 1];


            #if 1
            if(u>0) {
                backsub_inner_asm(A + u * A_cols + A_cols - 1, A + col, A + A_cols - 1, correct_column, u);
            }
            #else
            for (int i = 0; i < u; i++) {
                A[i * A_cols + A_cols - 1] ^=
                    correct_column *
                    mul_f(A[u * A_cols + A_cols - 1], A[i * A_cols + col]);
            }
            #endif

            // for (int i = 0; i < r; i++) {
                // A[i * A_cols + A_cols - 1] ^=
                //     correct_column *
                //     mul_f(A[r * A_cols + A_cols - 1], A[i * A_cols + col]);

            // }


            finished = finished || correct_column;
        }
    }
    return 1;
}
