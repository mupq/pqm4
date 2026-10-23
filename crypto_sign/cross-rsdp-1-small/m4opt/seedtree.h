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

#include "csprng_hash.h"
#include "parameters.h"

#if defined(NO_TREES)
void seed_leaves_intermed(
        unsigned char quad_seed[4*SEED_LENGTH_BYTES],
        const unsigned char root_seed[SEED_LENGTH_BYTES],
        const unsigned char salt[SALT_LENGTH_BYTES],
        CSPRNG_STATE_T *csprng_state);

void seed_leaves_inc(unsigned char round_seed[SEED_LENGTH_BYTES],
                     CSPRNG_STATE_T* csprng_state,
                     unsigned char quad_seed[4*SEED_LENGTH_BYTES],
                     uint8_t* pos_in_quad,
                     uint16_t round_ctr,
                     uint8_t salt[SALT_LENGTH_BYTES]);

int seed_leaves(unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],
                const unsigned char root_seed[SEED_LENGTH_BYTES],
                const unsigned char salt[SALT_LENGTH_BYTES]);

int seed_path(unsigned char *seed_storage,
              const unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],
              const unsigned char indices_to_publish[T]);

uint8_t rebuild_leaves(unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],                           
                       const unsigned char indices_to_publish[T],
                       const unsigned char *seed_storage);
#else

/******************************************************************************/
void seed_leaves(unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],
                 unsigned char seed_tree[NUM_NODES_SEED_TREE*SEED_LENGTH_BYTES]);

/******************************************************************************/
void gen_seed_tree(unsigned char seed_tree[NUM_NODES_SEED_TREE * SEED_LENGTH_BYTES],
               const unsigned char root_seed[SEED_LENGTH_BYTES],
               const unsigned char salt[SALT_LENGTH_BYTES]);

/******************************************************************************/
/* returns the number of seeds which have been published */
int seed_path(unsigned char *seed_storage,
              const unsigned char
              seed_tree[NUM_NODES_SEED_TREE*SEED_LENGTH_BYTES],
              // binary array denoting if node has to be released (cell == 0) or not
              const unsigned char indices_to_publish[T]);

/******************************************************************************/
/* returns 1 if padding was correct 0 if there was a mistake */
uint8_t rebuild_tree(unsigned char
                     seed_tree[NUM_NODES_SEED_TREE*SEED_LENGTH_BYTES],
                     const unsigned char indices_to_publish[T],
                     const unsigned char *stored_seeds,
                     const unsigned char salt[SALT_LENGTH_BYTES]);   // input

void init_seed_tree_inc(unsigned char seed_tree_inc[2*LOG2(T)*SEED_LENGTH_BYTES],
                        uint16_t seed_tree_inc_pos[2*LOG2(T)],
                        const unsigned char root_seed[SEED_LENGTH_BYTES],
                        const unsigned char salt[SALT_LENGTH_BYTES]);

void seed_path_inc(unsigned char seed_tree_inc[2*LOG2(T)*SEED_LENGTH_BYTES],
                  uint8_t* path,
                  unsigned char flag_tree[NUM_NODES_SEED_TREE],
                  uint8_t total_published,
                  uint16_t* last_copied,
                  uint16_t seed_tree_inc_pos[2*LOG2(T)],
                  uint16_t* pos_in_mtree,
                  uint8_t* curr_level);

int init_rebuild_tree_inc(unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE],
                              const unsigned char indices_to_publish[T]);
uint8_t rebuild_tree_inc(uint8_t* target_pos,
                         uint8_t* directly_from_sig,
                         unsigned char seed_tree_inc[2*LOG2(T)*SEED_LENGTH_BYTES],
                         unsigned char flag_tree[NUM_NODES_SEED_TREE],
                         uint8_t total_published,
                         uint16_t seed_tree_inc_pos[2*LOG2(T)],
                         uint16_t* pos_in_mtree,
                         uint8_t* curr_level,
                         const unsigned char *stored_seeds,
                         const unsigned char salt[SALT_LENGTH_BYTES],
                         const unsigned char skip_from_sig);
#endif

void psalt(unsigned char salt[SALT_LENGTH_BYTES]);
void pseed(unsigned char seed[SEED_LENGTH_BYTES]);
void ptree(unsigned char seed_tree[NUM_NODES_SEED_TREE * SEED_LENGTH_BYTES]);
