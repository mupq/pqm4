#include "polymat.h"
#include "params.h"
#include "poly.h"
#include "polyvec.h"
#include <stdint.h>

/*************************************************
 * Name:        expand_a_gen_mod_q_elem
 *              (internal use only)
 *
 * Description: Unpack polynomial of A_gen
 *
 * Arguments:   - poly elem: output poly for the matrix element
 *              - const row: row of the matrix element 0 <= row < K
 *              - const column: column of the matrix element 0 <= column < L
 *              - const uint8_t pk[]: compressed public key
 **************************************************/
static void expand_a_gen_mod_q_elem(poly *elem, const size_t row, const size_t column,
                             const uint8_t pk[CRYPTO_PUBLICKEYBYTES]){
    uint16_t nonce;

    nonce = (row << 8) + (column);
    poly_uniform(elem, pk, nonce);
    poly_shl(elem, 1);
}

/*************************************************
 * Name:        expand_b_mod_q_elem
 *              (internal use only)
 *
 * Description: Unpack polynomial of b
 *
 * Arguments:   - poly elem: output poly for the matrix element
 *              - const row: row of the matrix element 0 <= row < K
 *              - const column: column of the matrix element 0 <= column < L
 *              - const uint8_t pk[]: compressed public key
 **************************************************/
static void expand_b_mod_q_elem(poly *elem, const size_t row, const uint8_t pk[CRYPTO_PUBLICKEYBYTES]){
#if D == 0
    polyq_unpack(elem, pk + SEEDBYTES + row * POLYQ_PACKEDBYTES);
#else
    poly a;
    uint16_t nonce;

    polyq_unpack(elem, pk + SEEDBYTES + row * POLYQ_PACKEDBYTES);

    // first column of A = 2(a-b1*2^d)
    
    nonce = (K << 8) + M + row;
    // dbg_send_msg_and_hexdump("b nonce: ", (uint8_t*) &nonce, sizeof(nonce));
    poly_uniform(&a, pk, nonce);

    poly_shl(elem, D);

    poly_sub(elem, &a, elem);
    poly_shl(elem, 1);
    poly_ntt(elem);
#endif
}

#if 0
/*************************************************
 * Name:        expand_pk_matrix_elem
 *
 * Description: Unpack public key polynomial A[row, column].
 *
 * Arguments:   - poly elem: output poly for the matrix element
 *              - const row: row of the matrix element 0 <= row < K
 *              - const column: column of the matrix element 0 <= column < L
 *              - const uint8_t pk[]: compressed public key
 **************************************************/
void expand_pk_matrix_elem(poly *elem, const size_t row, const size_t column,
                           const uint8_t pk[CRYPTO_PUBLICKEYBYTES]){
    if (0 < column) {
        expand_a_gen_mod_q_elem(elem, row, column - 1, pk);
    } else {
        expand_b_mod_q_elem(elem, row, pk);
    }
}
#endif

/*************************************************
 * Name:        expand_pk_matrix_elem_frozen
 *
 * Description: Unpack public key polynomial A[row, column].
 *
 * Arguments:   - poly elem: output poly for the matrix element
 *              - const row: row of the matrix element 0 <= row < K
 *              - const column: column of the matrix element 0 <= column < L
 *              - const uint8_t pk[]: compressed public key
 **************************************************/
void expand_pk_matrix_elem_frozen(poly_frozen *elem, const size_t row, const size_t column,
                           const uint8_t pk[CRYPTO_PUBLICKEYBYTES]){
    poly p;
    if (0 < column) {
        expand_a_gen_mod_q_elem(&p, row, column - 1, pk);
    } else {
        expand_b_mod_q_elem(&p, row, pk);
    }
    for (size_t j = 0; j < N; j++) {
        elem->coeffs[j] = (uint16_t) (freeze(p.coeffs[j]) & 0xFFFF);
    }
}





/*************************************************
 * Name:        polymat_expand
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|j|i)
 *              or AES256CTR(rho,j|i).
 *
 * Arguments:   - polyvecm mat[K]: output matrix k \times m
 *              - const uint8_t rho[]: byte array containing seed rho
 **************************************************/
void polymatkl_expand(polyvecl mat[K], const uint8_t rho[SEEDBYTES]) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < M; ++j)
            poly_uniform(&mat[i].vec[j + 1], rho, (i << 8) + j);
}

/*************************************************
 * Name:        polymat_expand
 *
 * Description: Implementation of ExpandA. Generates matrix A with uniformly
 *              random coefficients a_{i,j} by performing rejection
 *              sampling on the output stream of SHAKE128(rho|j|i)
 *              or AES256CTR(rho,j|i).
 *
 * Arguments:   - polyvecm mat[K]: output matrix k \times m
 *              - const uint8_t rho[]: byte array containing seed rho
 **************************************************/
void polymatkm_expand(polyvecm mat[K], const uint8_t rho[SEEDBYTES]) {
    unsigned int i, j;

    for (i = 0; i < K; ++i)
        for (j = 0; j < M; ++j)
            poly_uniform(&mat[i].vec[j], rho, (i << 8) + j);
}

// doubles k * m sub-matrix of k * l mat
void polymatkl_double(polyvecl mat[K]) {
    unsigned int i, j, k;
    for (i = 0; i < K; ++i) {
        for (j = 1; j < L; ++j) {
            for (k = 0; k < N; ++k) {
                mat[i].vec[j].coeffs[k] *= 2;
            }
        }
    }
}

void polymatkl_pointwise_montgomery(polyveck *t, const polyvecl mat[K],
                                    const polyvecl *v) {
    unsigned int i;

    for (i = 0; i < K; ++i) {
        polyvecl_pointwise_acc_montgomery(&t->vec[i], &mat[i], v);
    }
}

void polymatkm_pointwise_montgomery(polyveck *t, const polyvecm mat[K],
                                    const polyvecm *v) {
    unsigned int i;

    for (i = 0; i < K; ++i) {
        polyvecm_pointwise_acc_montgomery(&t->vec[i], &mat[i], v);
    }
}
