#include "arithmetic.h"
#include "simple_arithmetic.h"
#include <stdalign.h>
#include <string.h>
#include "mayo.h"
#include "mem.h"

#define MAYO_MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MAYO_MIN(x, y) (((x) < (y)) ? (x) : (y))

volatile unsigned char unsigned_char_blocker = 0;
// EF
void ef_bitslice_asm(uint32_t *a_bs, unsigned char *a);
void ef_unbitslice_asm(unsigned char *a, uint32_t *a_bs);
uint8_t ef_inner1_asm(uint32_t *pivot_row, uint32_t *a_bs_row, int pivot_col, int pivot_row_lower_bound, int pivot_row_ctr, uint8_t *pivot_is_zero, int row_upper_bound);
void    ef_inner2_asm(uint32_t *pivot_row2, uint32_t *pivot_row, uint8_t pivot);
void    ef_inner3_asm(uint32_t *a_bs_row, uint32_t *pivot_row, int pivot_row_ctr, int pivot_row_lower_bound, int pivot_row_upper_bound, int pivot_is_zero);
int     ef_inner4_asm(uint32_t *a_bs, uint32_t *pivot_row, int pivot_row_lower_bound, int pivot_row_ctr, int pivot_col, int pivot_is_nonzero);
void    backsub_inner_asm(uint8_t *a1, uint8_t *a2, uint8_t *a3, int correct_column, int r);


// -----------------------------------------------------------------------------------------
// NON-OPTIMIZED ARITHMETIC
// -----------------------------------------------------------------------------------------

void m_upper(const mayo_params_t *p, const uint64_t *in, uint64_t *out, int size)
{
#ifndef ENABLE_PARAMS_DYNAMIC
    (void)p;
#endif
    // TODO: check if this is worthwhile to optimize or fine
    const int m_vec_limbs = PARAM_m_vec_limbs(p);
    int m_vecs_stored = 0;
    for (int r = 0; r < size; r++)
    {
        for (int c = r; c < size; c++)
        {
            m_vec_copy(m_vec_limbs, in + m_vec_limbs * (r * size + c), out + m_vec_limbs * m_vecs_stored);
            if (r != c)
            {
                m_vec_add(m_vec_limbs, in + m_vec_limbs * (c * size + r), out + m_vec_limbs * m_vecs_stored);
            }
            m_vecs_stored++;
        }
    }
}


// -----------------------------------------------------------------------------------------
// OPTIMIZED ARITHMETIC
// -----------------------------------------------------------------------------------------

// put matrix in row echelon form with ones on first nonzero entries *in
// constant time*
static void EF_m4f(unsigned char *A, int nrows, int ncols) {

    uint32_t _pivot_row[(K_MAX * O_MAX + 1 + 31) / 32 * 4];
    uint32_t _pivot_row2[(K_MAX * O_MAX + 1 + 31) / 32 * 4];
    uint32_t bitsliced_A[((K_MAX * O_MAX + 1 + 31) / 32) * 4 * M_MAX];

    int legs = (ncols + 31) / 32;


    ef_bitslice_asm(bitsliced_A, A);

    // pivot row is secret, pivot col is not
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
                           unsigned char *x, int _k, int _o, int _m, int _A_cols ) {
    (void) p;
    (void) _k;
    (void) _o;
    (void) _m;
    (void) _A_cols;

    const int k = K_MAX;
    const int o = O_MAX;
    const int m = M_MAX;
    const int A_cols = (K_MAX * O_MAX + 1);

    unsigned char finished;
    int col_upper_bound;
    unsigned char correct_column;

    // x <- r
    for (int i = 0; i < k * o; i++)
    {
        x[i] = r[i];
    }

    // compute Ar;
    unsigned char Ar[M_MAX];
    for (int i = 0; i < m; i++)
    {
        A[k * o + i * (k * o + 1)] = 0; // clear last col of A
    }
    mat_mul(A, r, Ar, k * o + 1, m, 1);

    // move y - Ar to last column of matrix A
    for (int i = 0; i < m; i++)
    {
        A[k * o + i * (k * o + 1)] = sub_f(y[i], Ar[i]);
    }


    EF_m4f(A, m, k * o + 1);

    // check if last row of A (excluding the last entry of y) is zero
    unsigned char full_rank = 0;
    for (int i = 0; i < A_cols - 1; i++)
    {
        full_rank |= A[(m - 1) * A_cols + i];
    }


    if (full_rank == 0)
    {
        return 0;
    }

    // back substitution in constant time
    // the index of the first nonzero entry in each row is secret, which makes
    // things less efficient

    for (int row = m - 1; row >= 0; row--)
    {
        finished = 0;
        col_upper_bound = MAYO_MIN(row + (32 / (m - row)), k * o);
        // the first nonzero entry in row r is between r and col_upper_bound with probability at least ~1-q^{-32}

        for (int col = row; col <= col_upper_bound; col++)
        {

            // Compare two chars in constant time.
            // Returns 0x00 if the byte arrays are equal, 0xff otherwise.
            correct_column = ct_compare_8((A[row * A_cols + col]), 0) & ~finished;

            unsigned char u = correct_column & A[row * A_cols + A_cols - 1];
            x[col] ^= u;

            if(row>0) {
                backsub_inner_asm(A + row * A_cols + A_cols - 1, A + col, A + A_cols - 1, correct_column, row);
            }
            finished = finished | correct_column;
        }
    }
    return 1;
}