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

#if defined(NO_TREES)

void tree_intermed_inc(CSPRNG_STATE_T* cmt_0_inc_state, uint8_t cmt_0_intermed[4*HASH_DIGEST_LENGTH], uint8_t* cmt_0_pos, uint8_t* cmt_0_i_input, uint16_t round_idx);

void tree_root(uint8_t root[HASH_DIGEST_LENGTH],
               uint8_t leaves[T][HASH_DIGEST_LENGTH]);

uint16_t tree_proof(uint8_t mtp[W*HASH_DIGEST_LENGTH],
                    uint8_t leaves[T][HASH_DIGEST_LENGTH],
                    const uint8_t leaves_to_reveal[T]);

uint8_t recompute_root(uint8_t root[HASH_DIGEST_LENGTH],
                       uint8_t recomputed_leaves[T][HASH_DIGEST_LENGTH],
                       const uint8_t mtp[W*HASH_DIGEST_LENGTH],
                       const uint8_t leaves_to_reveal[T]);

#else

/* Stub of the interface to Merkle tree root computer from all leaves */
void get_curr_pos_in_tree(uint16_t* pos,
                           uint8_t* curr_level,
                           uint8_t* curr_si,
                           uint16_t* curr_node_in_level);

void tree_root(uint8_t root[HASH_DIGEST_LENGTH],
               uint8_t tree[NUM_NODES_MERKLE_TREE * HASH_DIGEST_LENGTH]);

/* Stub interface to the function computing the Merkle tree proof, storing it
 * in the signature. Returns the number of digests in the merkle tree proof */
uint16_t tree_proof(uint8_t mtp[HASH_DIGEST_LENGTH*TREE_NODES_TO_STORE],
                    const uint8_t tree[NUM_NODES_MERKLE_TREE*HASH_DIGEST_LENGTH],
                    const uint8_t leaves_to_reveal[T]);

/* stub of the interface to Merkle tree recomputation given the proof and
 * the computed leaves */
uint8_t recompute_root(uint8_t root[HASH_DIGEST_LENGTH],
                       uint8_t tree[NUM_NODES_MERKLE_TREE * HASH_DIGEST_LENGTH],
                       const uint8_t mtp[HASH_DIGEST_LENGTH*TREE_NODES_TO_STORE],
                       const uint8_t leaves_to_reveal[T]);

void mtree_inc_proof(uint8_t mtree_inc[(LOG2(T) + 1) * HASH_DIGEST_LENGTH],
                     uint8_t* proof,
                     uint8_t flag_tree[NUM_NODES_MERKLE_TREE],
                     uint16_t* pos_in_mtree,
                     uint8_t* starting_layer,
                     bool* recurse_through_tree,
                     uint8_t mtree_inc_flags[LOG2(T)+1]);

void recompute_root_mtree_inc_proof(uint8_t* mtree_inc_target_address,
                                    uint16_t* flag_tree_address,
                                    uint8_t flag_tree[NUM_NODES_MERKLE_TREE],
                                    uint8_t* mtree_last_taken,
                                    uint8_t mtree_inc_flags[LOG2(T) + 1],
                                    uint16_t* curr_pos_in_mtree,
                                    uint8_t* starting_level,
                                    bool* recurse_through_tree);

void recompute_root_mtree_inc_recomp(uint8_t* mtree_inc_target_address,
                                     bool* recurse_through_tree,
                                     uint8_t mtree_inc_flags[LOG2(T) + 1],
                                     uint8_t* layer);

void recompute_root_mtree_inc(uint8_t mtree_inc[(LOG2(T) + 1) * HASH_DIGEST_LENGTH],
                                     bool* recurse_through_tree,
                                     uint8_t mtree_inc_flags[LOG2(T)+1]);
uint8_t recompute_flag_tree(uint8_t flag_tree[NUM_NODES_MERKLE_TREE],
                         const uint8_t leaves_to_reveal[T]);
#endif
