// SPDX-License-Identifier: MIT

#include "api.h"
#include "aim2.h"
#include "field.h"
#include "hash.h"
#include "params.h"
#include "randombytes.h"
#include "sign.h"
#include "tree.h"
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

void commit_and_expand_tape(tape_t *tape, uint8_t *commit,
                            const hash_instance *ctx_precom,
                            const uint8_t seed[AIMER_SEED_SIZE],
                            size_t rep, size_t party)
{
  hash_instance ctx;
  uint8_t buffer[AIMER_SEED_SIZE + 2];

  buffer[0] = (uint8_t)(rep);
  buffer[1] = (uint8_t)(party);
  memcpy(buffer + 2, seed, AIMER_SEED_SIZE);

  hash_ctx_clone(&ctx, ctx_precom);
  hash_update(&ctx, buffer, AIMER_SEED_SIZE + 2);
  hash_final(&ctx);
  hash_squeeze(&ctx, commit, AIMER_COMMIT_SIZE);
  hash_squeeze(&ctx, (uint8_t *)tape, sizeof(tape_t));
  hash_ctx_release(&ctx);
}

void aim2_mpc(mult_chk_t *mult_chk,
              const GF matrix_A[AIMER_L][AIM2_NUM_BITS_FIELD],
              const GF ct_GF)
{
  // pt + c = t ^ {2 ^ e - 1}
  // --> t ^ {2 ^ e} + t * c = t * pt
  // --> z = x * pt
  GF_mul(mult_chk->z_shares[0], mult_chk->x_shares[0], aim2_constants[0]);
  GF_transposed_matmul_add(mult_chk->z_shares[0], mult_chk->x_shares[0],
                           aim2_e1_power_matrix);
  GF_transposed_matmul_add(mult_chk->x_shares[AIMER_L], mult_chk->x_shares[0],
                           matrix_A[0]);

  GF_mul(mult_chk->z_shares[1], mult_chk->x_shares[1], aim2_constants[1]);
  GF_transposed_matmul_add(mult_chk->z_shares[1], mult_chk->x_shares[1],
                           aim2_e2_power_matrix);
  GF_transposed_matmul_add(mult_chk->x_shares[AIMER_L], mult_chk->x_shares[1],
                           matrix_A[1]);

  // x ^ {2 ^ e - 1} = pt + ct
  // --> x ^ {2 ^ e} + x * ct = x * pt
  // --> z = x * pt
  GF_sqr_s(mult_chk->z_shares[AIMER_L], mult_chk->x_shares[AIMER_L]);
  GF_sqr_s(mult_chk->z_shares[AIMER_L], mult_chk->z_shares[AIMER_L]);
  GF_sqr_s(mult_chk->z_shares[AIMER_L], mult_chk->z_shares[AIMER_L]);
  GF_sqr_s(mult_chk->z_shares[AIMER_L], mult_chk->z_shares[AIMER_L]);
  GF_sqr_s(mult_chk->z_shares[AIMER_L], mult_chk->z_shares[AIMER_L]);
  GF_mul_add(mult_chk->z_shares[AIMER_L], mult_chk->x_shares[AIMER_L], ct_GF);
}

// committing to the seeds and the execution views of the parties
void run_phase_1(signature_t *sign,
                 uint8_t commits[AIMER_T][AIMER_N][AIMER_COMMIT_SIZE],
                 uint8_t nodes[AIMER_T][2 * AIMER_N - 1][AIMER_SEED_SIZE],
                 mult_chk_t mult_chk[AIMER_T][AIMER_N],
                 GF alpha_v_shares[AIMER_T][2][AIMER_N],
                 const uint8_t *sk, const uint8_t *m, size_t mlen)
{
  GF pt_GF = {0,}, ct_GF = {0,};
  GF_from_bytes(pt_GF, sk);
  GF_from_bytes(ct_GF, sk + AIM2_NUM_BYTES_FIELD + AIM2_IV_SIZE);

  // message pre-hashing
  hash_instance ctx;
  hash_init_prefix(&ctx, HASH_PREFIX_0);
  hash_update(&ctx, sk + AIM2_NUM_BYTES_FIELD,
              AIM2_IV_SIZE + AIM2_NUM_BYTES_FIELD);
  hash_update(&ctx, m, mlen);
  hash_final(&ctx);

  uint8_t mu[AIMER_COMMIT_SIZE];
  hash_squeeze(&ctx, mu, AIMER_COMMIT_SIZE);
  hash_ctx_release(&ctx);

  // compute first L sboxes' outputs
  GF sbox_outputs[AIMER_L];
  aim2_sbox_outputs(sbox_outputs, pt_GF);

  // derive the binary matrix and the vector from the initial vector
  GF matrix_A[AIMER_L][AIM2_NUM_BITS_FIELD];
  GF vector_b = {0,};
  generate_matrix_LU(matrix_A, vector_b, sk + AIM2_NUM_BYTES_FIELD);

  // generate per-signature randomness
  uint8_t random[SECURITY_BYTES];
  randombytes(random, SECURITY_BYTES);

  // generate salt
  hash_init_prefix(&ctx, HASH_PREFIX_3);
  hash_update(&ctx, sk, AIM2_NUM_BYTES_FIELD);
  hash_update(&ctx, mu, AIMER_COMMIT_SIZE);
  hash_update(&ctx, random, SECURITY_BYTES);
  hash_final(&ctx);
  hash_squeeze(&ctx, sign->salt, AIMER_SALT_SIZE);

  // generate root seeds and expand seed trees
  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    hash_squeeze(&ctx, nodes[rep][0], AIMER_SEED_SIZE);
  }
  expand_trees(nodes, sign->salt);
  hash_ctx_release(&ctx);

  // hash_instance for h_1
  hash_init_prefix(&ctx, HASH_PREFIX_1);
  hash_update(&ctx, mu, AIMER_COMMIT_SIZE);
  hash_update(&ctx, sign->salt, AIMER_SALT_SIZE);

  hash_instance ctx_precom;
  hash_init_prefix(&ctx_precom, HASH_PREFIX_5);
  hash_update(&ctx_precom, sign->salt, AIMER_SALT_SIZE);

  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    // initialize adjustment values
    tape_t delta, tape;
    memset(&delta, 0, sizeof(tape_t));

    for (size_t party = 0; party < AIMER_N; party++)
    {
      // generate execution views and commitments
      commit_and_expand_tape(&tape, commits[rep][party], &ctx_precom,
                             nodes[rep][party + AIMER_N - 1], rep, party);
      hash_update(&ctx, commits[rep][party], AIMER_COMMIT_SIZE);

      // compute offsets
      GF_add(delta.pt_share, delta.pt_share, tape.pt_share);
      GF_add(delta.t_shares[0], delta.t_shares[0], tape.t_shares[0]);
      GF_add(delta.t_shares[1], delta.t_shares[1], tape.t_shares[1]);
      GF_add(delta.a_share, delta.a_share, tape.a_share);
      GF_add(delta.c_share, delta.c_share, tape.c_share);
      GF_set0(mult_chk[rep][party].x_shares[AIMER_L]);

      // adjust the last share and prepare the proof and h_1
      if (party == AIMER_N - 1)
      {
        GF_add(delta.pt_share, delta.pt_share, pt_GF);
        GF_add(delta.t_shares[0], delta.t_shares[0], sbox_outputs[0]);
        GF_add(delta.t_shares[1], delta.t_shares[1], sbox_outputs[1]);
        GF_mul_add_s(delta.c_share, pt_GF, delta.a_share);

        GF_to_bytes(sign->proofs[rep].delta_pt_bytes, delta.pt_share);
        GF_to_bytes(sign->proofs[rep].delta_ts_bytes[0], delta.t_shares[0]);
        GF_to_bytes(sign->proofs[rep].delta_ts_bytes[1], delta.t_shares[1]);
        GF_to_bytes(sign->proofs[rep].delta_c_bytes, delta.c_share);

        GF_add(tape.pt_share, delta.pt_share, tape.pt_share);
        GF_add(tape.t_shares[0], delta.t_shares[0], tape.t_shares[0]);
        GF_add(tape.t_shares[1], delta.t_shares[1], tape.t_shares[1]);
        GF_add(tape.c_share, delta.c_share, tape.c_share);

        GF_copy(mult_chk[rep][party].x_shares[AIMER_L], vector_b);
      }

      // run the MPC simulation and prepare the mult check inputs
      GF_copy(mult_chk[rep][party].pt_share, tape.pt_share);
      GF_copy(mult_chk[rep][party].x_shares[0], tape.t_shares[0]);
      GF_copy(mult_chk[rep][party].x_shares[1], tape.t_shares[1]);
      GF_copy(alpha_v_shares[rep][0][party], tape.a_share);
      GF_copy(alpha_v_shares[rep][1][party], tape.c_share);

      aim2_mpc(&mult_chk[rep][party],
               (const GF (*)[AIM2_NUM_BITS_FIELD])matrix_A, ct_GF);
    }

    // NOTE: depend on the order of values in proof_t
    hash_update(&ctx, sign->proofs[rep].delta_pt_bytes,
                AIM2_NUM_BYTES_FIELD * (AIMER_L + 2));
  }
  hash_ctx_release(&ctx_precom);

  // commit to salt, (all commitments of parties' seeds,
  // delta_pt, delta_t, delta_c) for all repetitions
  hash_final(&ctx);
  hash_squeeze(&ctx, sign->h_1, AIMER_COMMIT_SIZE);
  hash_ctx_release(&ctx);
}

void run_phase_2_and_3(signature_t *sign,
                       GF alpha_v_shares[AIMER_T][2][AIMER_N],
                       const mult_chk_t mult_chk[AIMER_T][AIMER_N])
{
  GF epsilons[AIMER_L + 1];

  hash_instance ctx_e;
  hash_init(&ctx_e);
  hash_update(&ctx_e, sign->h_1, AIMER_COMMIT_SIZE);
  hash_final(&ctx_e);

  hash_instance ctx;
  hash_init_prefix(&ctx, HASH_PREFIX_2);
  hash_update(&ctx, sign->h_1, AIMER_COMMIT_SIZE);
  hash_update(&ctx, sign->salt, AIMER_SALT_SIZE);

  GF alpha = {0,};
  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    GF_set0(alpha);
    hash_squeeze(&ctx_e, (uint8_t *)epsilons, sizeof(epsilons));

    for (size_t party = 0; party < AIMER_N; party++)
    {
      // alpha_share = a_share + sum x_share[i] * eps[i]
      // v_share = c_share - pt_share * alpha + sum z_share[i] * eps[i]
      GF_mul_add(alpha_v_shares[rep][0][party],
                 mult_chk[rep][party].x_shares[0], epsilons[0]);
      GF_mul_add(alpha_v_shares[rep][1][party],
                 mult_chk[rep][party].z_shares[0], epsilons[0]);
      GF_mul_add(alpha_v_shares[rep][0][party],
                 mult_chk[rep][party].x_shares[1], epsilons[1]);
      GF_mul_add(alpha_v_shares[rep][1][party],
                 mult_chk[rep][party].z_shares[1], epsilons[1]);
      GF_mul_add(alpha_v_shares[rep][0][party],
                 mult_chk[rep][party].x_shares[2], epsilons[2]);
      GF_mul_add(alpha_v_shares[rep][1][party],
                 mult_chk[rep][party].z_shares[2], epsilons[2]);

      GF_add(alpha, alpha, alpha_v_shares[rep][0][party]);
    }

    // alpha is opened, so we can finish calculating v_share
    for (size_t party = 0; party < AIMER_N; party++)
    {
      GF_mul_add(alpha_v_shares[rep][1][party],
                 mult_chk[rep][party].pt_share, alpha);
    }
    hash_update(&ctx, (const uint8_t *)alpha_v_shares[rep],
                AIM2_NUM_BYTES_FIELD * 2 * AIMER_N);
  }
  hash_final(&ctx);
  hash_squeeze(&ctx, sign->h_2, AIMER_COMMIT_SIZE);
  hash_ctx_release(&ctx);
  hash_ctx_release(&ctx_e);
}

////////////////////////////////////////////////////////////////////////////////
int crypto_sign_keypair(uint8_t *pk, uint8_t *sk)
{
  if (!pk || !sk)
  {
    return -1;
  }

  randombytes(sk, AIM2_NUM_BYTES_FIELD);
  randombytes(pk, AIM2_IV_SIZE);

  aim2(pk + AIM2_IV_SIZE, sk, pk);
  memcpy(sk + AIM2_NUM_BYTES_FIELD, pk, AIM2_IV_SIZE + AIM2_NUM_BYTES_FIELD);

  return 0;
}

int crypto_sign_signature(uint8_t *sig, size_t *siglen,
        const uint8_t *m, size_t mlen,
        const uint8_t *sk)
{
  hash_instance ctx;
  signature_t *sign = (signature_t *)sig;

  //////////////////////////////////////////////////////////////////////////
  // Phase 1: Committing to the seeds and the execution views of parties. //
  //////////////////////////////////////////////////////////////////////////

  // nodes for seed trees
  uint8_t nodes[AIMER_T][2 * AIMER_N - 1][AIMER_SEED_SIZE];

  // commitments for seeds
  uint8_t commits[AIMER_T][AIMER_N][AIMER_COMMIT_SIZE];

  // multiplication check inputs
  mult_chk_t mult_chk[AIMER_T][AIMER_N];

  // multiplication check outputs
  GF alpha_v_shares[AIMER_T][2][AIMER_N];

  // commitments for phase 1
  run_phase_1(sign, commits, nodes, mult_chk, alpha_v_shares, sk, m, mlen);

  /////////////////////////////////////////////////////////////////
  // Phase 2, 3: Challenging and committing to the simulation of //
  //             the multiplication checking protocol.           //
  /////////////////////////////////////////////////////////////////

  // compute the commitment of phase 3
  run_phase_2_and_3(sign, alpha_v_shares,
                    (const mult_chk_t (*)[AIMER_N])mult_chk);

  //////////////////////////////////////////////////////
  // Phase 4: Challenging views of the MPC protocols. //
  //////////////////////////////////////////////////////

  hash_init(&ctx);
  hash_update(&ctx, sign->h_2, AIMER_COMMIT_SIZE);
  hash_final(&ctx);

  uint8_t indices[AIMER_T]; // AIMER_N <= 256
  hash_squeeze(&ctx, indices, AIMER_T);
  hash_ctx_release(&ctx);
  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    indices[rep] &= (1 << AIMER_LOGN) - 1;
  }

  //////////////////////////////////////////////////////
  // Phase 5: Opening the views of the MPC protocols. //
  //////////////////////////////////////////////////////

  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    size_t i_bar = indices[rep];
    reveal_all_but(sign->proofs[rep].reveal_path,
                   (const uint8_t (*)[AIMER_SEED_SIZE])nodes[rep], i_bar);
    memcpy(sign->proofs[rep].missing_commitment, commits[rep][i_bar],
           AIMER_COMMIT_SIZE);
    GF_to_bytes(sign->proofs[rep].missing_alpha_share_bytes,
                alpha_v_shares[rep][0][i_bar]);
  }
  *siglen = CRYPTO_BYTES;

  return 0;
}

int crypto_sign(uint8_t *sm, size_t *smlen,
        const uint8_t *m, size_t mlen,
        const uint8_t *sk)
{
  crypto_sign_signature(sm + mlen, smlen, m, mlen, sk);

  memcpy(sm, m, mlen);
  *smlen += mlen;

  return 0;
}

int crypto_sign_verify(const uint8_t *sig, size_t siglen,
        const uint8_t *m, size_t mlen,
        const uint8_t *pk)
{
  if (siglen != CRYPTO_BYTES)
  {
    return -1;
  }

  const signature_t *sign = (const signature_t *)sig;

  GF ct_GF = {0,};
  GF_from_bytes(ct_GF, pk + AIM2_IV_SIZE);

  // derive the binary matrix and the vector from the initial vector
  GF matrix_A[AIMER_L][AIM2_NUM_BITS_FIELD];
  GF vector_b = {0,};
  generate_matrix_LU(matrix_A, vector_b, pk);

  hash_instance ctx_e, ctx_h1, ctx_h2;

  // indices = Expand(h_2)
  hash_init(&ctx_e);
  hash_update(&ctx_e, sign->h_2, AIMER_COMMIT_SIZE);
  hash_final(&ctx_e);

  uint8_t indices[AIMER_T]; // AIMER_N <= 256
  hash_squeeze(&ctx_e, indices, AIMER_T);
  hash_ctx_release(&ctx_e);
  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    indices[rep] &= (1 << AIMER_LOGN) - 1;
  }

  // epsilons = Expand(h_1)
  hash_init(&ctx_e);
  hash_update(&ctx_e, sign->h_1, AIMER_COMMIT_SIZE);
  hash_final(&ctx_e);

  // message pre-hashing
  uint8_t mu[AIMER_COMMIT_SIZE];
  hash_init_prefix(&ctx_h1, HASH_PREFIX_0);
  hash_update(&ctx_h1, pk, AIM2_IV_SIZE + AIM2_NUM_BYTES_FIELD);
  hash_update(&ctx_h1, m, mlen);
  hash_final(&ctx_h1);
  hash_squeeze(&ctx_h1, mu, AIMER_COMMIT_SIZE);
  hash_ctx_release(&ctx_h1);

  // ready for computing h_1' and h_2'
  hash_init_prefix(&ctx_h1, HASH_PREFIX_1);
  hash_update(&ctx_h1, mu, AIMER_COMMIT_SIZE);
  hash_update(&ctx_h1, sign->salt, AIMER_SALT_SIZE);

  hash_init_prefix(&ctx_h2, HASH_PREFIX_2);
  hash_update(&ctx_h2, sign->h_1, AIMER_COMMIT_SIZE);
  hash_update(&ctx_h2, sign->salt, AIMER_SALT_SIZE);

  hash_instance ctx_precom;
  hash_init_prefix(&ctx_precom, HASH_PREFIX_5);
  hash_update(&ctx_precom, sign->salt, AIMER_SALT_SIZE);

  for (size_t rep = 0; rep < AIMER_T; rep++)
  {
    size_t i_bar = indices[rep];
    uint8_t nodes[2 * AIMER_N - 2][AIMER_SEED_SIZE];

    reconstruct_tree(nodes, sign->salt, sign->proofs[rep].reveal_path,
                     rep, i_bar);

    GF pt_shares[AIMER_N];
    GF alpha_v_shares[2][AIMER_N];
    GF_set0(alpha_v_shares[1][i_bar]);

    GF epsilons[AIMER_L + 1];
    hash_squeeze(&ctx_e, (uint8_t *)epsilons, sizeof(epsilons));

    GF alpha = {0,};
    for (size_t party = 0; party < AIMER_N; party++)
    {
      if (party == i_bar)
      {
        hash_update(&ctx_h1, sign->proofs[rep].missing_commitment,
                    AIMER_COMMIT_SIZE);
        GF_from_bytes(alpha_v_shares[0][i_bar],
                      sign->proofs[rep].missing_alpha_share_bytes);
        GF_add(alpha, alpha, alpha_v_shares[0][i_bar]);
        continue;
      }

      tape_t tape;
      uint8_t commit[AIMER_COMMIT_SIZE];
      commit_and_expand_tape(&tape, commit, &ctx_precom,
                             nodes[AIMER_N + party - 2], rep, party);
      hash_update(&ctx_h1, commit, AIMER_COMMIT_SIZE);

      // adjust last shares
      mult_chk_t mult_chk;
      memset(&mult_chk, 0, sizeof(mult_chk_t));
      if (party == AIMER_N - 1)
      {
        GF temp = {0,};

        GF_from_bytes(temp, sign->proofs[rep].delta_pt_bytes);
        GF_add(tape.pt_share, tape.pt_share, temp);

        GF_from_bytes(temp, sign->proofs[rep].delta_ts_bytes[0]);
        GF_add(tape.t_shares[0], tape.t_shares[0], temp);
        GF_from_bytes(temp, sign->proofs[rep].delta_ts_bytes[1]);
        GF_add(tape.t_shares[1], tape.t_shares[1], temp);

        GF_from_bytes(temp, sign->proofs[rep].delta_c_bytes);
        GF_add(tape.c_share, tape.c_share, temp);

        GF_copy(mult_chk.x_shares[AIMER_L], vector_b);
      }

      // run the MPC simulation and prepare the mult check inputs
      GF_copy(mult_chk.x_shares[0], tape.t_shares[0]);
      GF_copy(mult_chk.x_shares[1], tape.t_shares[1]);
      GF_copy(pt_shares[party], tape.pt_share);
      GF_copy(alpha_v_shares[0][party], tape.a_share);
      GF_copy(alpha_v_shares[1][party], tape.c_share);
      aim2_mpc(&mult_chk, (const GF (*)[AIM2_NUM_BITS_FIELD])matrix_A, ct_GF);

      GF_mul_add(alpha_v_shares[0][party], mult_chk.x_shares[0], epsilons[0]);
      GF_mul_add(alpha_v_shares[1][party], mult_chk.z_shares[0], epsilons[0]);
      GF_mul_add(alpha_v_shares[0][party], mult_chk.x_shares[1], epsilons[1]);
      GF_mul_add(alpha_v_shares[1][party], mult_chk.z_shares[1], epsilons[1]);
      GF_mul_add(alpha_v_shares[0][party], mult_chk.x_shares[2], epsilons[2]);
      GF_mul_add(alpha_v_shares[1][party], mult_chk.z_shares[2], epsilons[2]);

      GF_add(alpha, alpha, alpha_v_shares[0][party]);
    }

    // alpha is opened, so we can finish calculating v_share
    for (size_t party = 0; party < AIMER_N; party++)
    {
      if (party == i_bar)
      {
        continue;
      }

      GF_mul_add(alpha_v_shares[1][party], pt_shares[party], alpha);
      GF_add(alpha_v_shares[1][i_bar], alpha_v_shares[1][i_bar],
             alpha_v_shares[1][party]);
    }

    // v is opened
    hash_update(&ctx_h2, (const uint8_t *)alpha_v_shares,
                sizeof(alpha_v_shares));

    // NOTE: depend on the order of values in proof_t
    hash_update(&ctx_h1, sign->proofs[rep].delta_pt_bytes,
                AIM2_NUM_BYTES_FIELD * (AIMER_L + 2));
  }
  hash_ctx_release(&ctx_e);
  hash_ctx_release(&ctx_precom);

  uint8_t h_1_prime[AIMER_COMMIT_SIZE];
  hash_final(&ctx_h1);
  hash_squeeze(&ctx_h1, h_1_prime, AIMER_COMMIT_SIZE);
  hash_ctx_release(&ctx_h1);

  uint8_t h_2_prime[AIMER_COMMIT_SIZE];
  hash_final(&ctx_h2);
  hash_squeeze(&ctx_h2, h_2_prime, AIMER_COMMIT_SIZE);
  hash_ctx_release(&ctx_h2);

  if (memcmp(h_1_prime, sign->h_1, AIMER_COMMIT_SIZE) != 0 ||
      memcmp(h_2_prime, sign->h_2, AIMER_COMMIT_SIZE) != 0)
  {
    return -1;
  }

  return 0;
}

int crypto_sign_open(uint8_t *m, size_t *mlen,
        const uint8_t *sm, size_t smlen,
        const uint8_t *pk)
{
  if (smlen < CRYPTO_BYTES)
  {
    return -1;
  }

  const size_t message_len = smlen - CRYPTO_BYTES;
  const uint8_t *message = sm;
  const uint8_t *signature = sm + message_len;

  if (crypto_sign_verify(signature, CRYPTO_BYTES, message, message_len, pk))
  {
    return -1;
  }

  memmove(m, message, message_len);
  *mlen = message_len;

  return 0;
}
