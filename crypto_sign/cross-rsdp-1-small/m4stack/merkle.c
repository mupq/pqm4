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

#include <stdint.h>
#include <string.h>
#include <stdbool.h>

#include "csprng_hash.h"
#include "merkle_tree.h"
#include "parameters.h"

#if defined(NO_TREES)

#define TO_PUBLISH 1
#define NOT_TO_PUBLISH 0

void tree_intermed_inc(CSPRNG_STATE_T* cmt_0_inc_state, uint8_t cmt_0_intermed[4*HASH_DIGEST_LENGTH], uint8_t* cmt_0_pos, uint8_t* cmt_0_i_input, uint16_t round_idx){
    int remainders[4] = {0};
    if(T%4 > 0){ remainders[0] = 1; } 
    if(T%4 > 1){ remainders[1] = 1; } 
    if(T%4 > 2){ remainders[2] = 1; }

    if(round_idx == 0 || round_idx == T/4+remainders[0] || round_idx == 2*(T/4)+remainders[0]+remainders[1] || round_idx == 3*(T/4)+remainders[0]+remainders[1]+remainders[2]){
        hash_init(cmt_0_inc_state);
    }
    hash_update(cmt_0_inc_state, cmt_0_i_input, HASH_DIGEST_LENGTH);
    if(round_idx == T/4+remainders[0]-1 || round_idx == 2*(T/4)+remainders[0]+remainders[1]-1 || round_idx == 3*(T/4)+remainders[0]+remainders[1]+remainders[2]-1 || round_idx == T-1){
        hash_fin_and_squeeze(cmt_0_inc_state, cmt_0_intermed+(*cmt_0_pos)*HASH_DIGEST_LENGTH, HASH_DOMAIN_SEP_CONST);
        *cmt_0_pos += 1;
    }
}

void tree_root(uint8_t root[HASH_DIGEST_LENGTH],
                              uint8_t leaves[T][HASH_DIGEST_LENGTH]){

   int remainders[4] = {0};
   if(T%4 > 0){ remainders[0] = 1; } 
   if(T%4 > 1){ remainders[1] = 1; } 
   if(T%4 > 2){ remainders[2] = 1; }

   uint8_t hash_input[4*HASH_DIGEST_LENGTH];

   int offset = 0;
   for (int i = 0; i < 4; i++){
       hash(&hash_input[i*HASH_DIGEST_LENGTH],leaves[(T/4)*i+offset],(T/4+remainders[i])*HASH_DIGEST_LENGTH, HASH_DOMAIN_SEP_CONST);
       offset += remainders[i];  
   }

   hash(root,hash_input,sizeof(hash_input), HASH_DOMAIN_SEP_CONST);
}

uint16_t tree_proof(uint8_t mtp[W*HASH_DIGEST_LENGTH],
                                   uint8_t leaves[T][HASH_DIGEST_LENGTH],
                                   const uint8_t leaves_to_reveal[T]){
    uint16_t published = 0;
    for(int i=0; i<T; i++){
       if(leaves_to_reveal[i] == TO_PUBLISH){
          memcpy(&mtp[HASH_DIGEST_LENGTH*published],
                 &leaves[i],
                 HASH_DIGEST_LENGTH);
          published++;
       }
    }
    return published;    
}

uint8_t recompute_root(uint8_t root[HASH_DIGEST_LENGTH],
                       uint8_t recomputed_leaves[T][HASH_DIGEST_LENGTH],
                       const uint8_t mtp[W*HASH_DIGEST_LENGTH],
                       const uint8_t leaves_to_reveal[T]){
    uint16_t published = 0;
    for(int i=0; i<T; i++){
       if(leaves_to_reveal[i] == TO_PUBLISH){
          memcpy(&recomputed_leaves[i],
                 &mtp[HASH_DIGEST_LENGTH*published],
                 HASH_DIGEST_LENGTH);
          published++;
       }
    }
    tree_root(root,recomputed_leaves);
    return 1;
}

#else 

#define PARENT(i) ( ((i)%2) ? (((i)-1)/2) : (((i)-2)/2) )
#define SIBLING(i) ( ((i)%2) ? (i)+1 : (i)-1 )

#define CHALLENGE_PROOF_VALUE 0
#define NOT_COMPUTED 0
#define COMPUTED 1

/*****************************************************************************/
void get_curr_pos_in_tree(uint16_t* pos,
                           uint8_t* curr_level,
                           uint8_t* curr_si,
                           uint16_t* curr_node_in_level)
{
    const uint16_t cons_leaves[TREE_SUBROOTS] = TREE_CONSECUTIVE_LEAVES;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;
    const uint16_t leaves_per_level[LOG2(T) + 1] = TREE_LEAVES_PER_LEVEL;
    if (*curr_node_in_level == cons_leaves[*curr_si]){
        *curr_node_in_level = 0;
        *curr_si += 1;
        uint8_t next_layer_found = 0;
        for(int i = LOG2(T) - *curr_level - 1; i >= 0; i--){
            if(leaves_per_level[i] == 0 && next_layer_found == 0){
                *curr_level += 1;
            }
            else if (leaves_per_level[i] != 0 && next_layer_found == 0){
                next_layer_found = 1;
                *curr_level += 1;
            }
        }
    }
    *pos = leaves_start_indices[*curr_si] + *curr_node_in_level;
    *curr_node_in_level += 1;
}

/*****************************************************************************/

/*****************************************************************************/
static
void label_leaves(unsigned char flag_tree[NUM_NODES_MERKLE_TREE],
                     const unsigned char challenge[T])
{
    const uint16_t cons_leaves[TREE_SUBROOTS] = TREE_CONSECUTIVE_LEAVES;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    unsigned int cnt = 0;
    for (size_t i=0; i<TREE_SUBROOTS; i++) {
        for (size_t j=0; j<cons_leaves[i]; j++) {
            if (challenge[cnt] == CHALLENGE_PROOF_VALUE) {
                flag_tree[leaves_start_indices[i]+j] = COMPUTED;
            }
            cnt++;
        }
    }
}

/* Determine whether the recomputed leave is left or right based on the 
 * current state of the incremental tree and provide the address to the 
 * respective layer */
void recompute_root_mtree_inc_recomp(uint8_t* mtree_inc_target_address,
                                      bool* recurse_through_tree,
                                      uint8_t mtree_inc_flags[LOG2(T) + 1],
                                      uint8_t* layer)
{
    uint8_t layer_target = LOG2(T) - *layer;
    if(mtree_inc_flags[layer_target] == 0) {
        *mtree_inc_target_address = layer_target;
        mtree_inc_flags[layer_target] = 1;
    }
    else{
        *mtree_inc_target_address = layer_target + 1;
        *recurse_through_tree = true;
    }
}

/* Retrieve the provided nodes from the signature and insert them
 * in the respective layer, either as left or right node */
void recompute_root_mtree_inc_proof(uint8_t* mtree_inc_target_address,
                                           uint16_t* flag_tree_address,
                                           uint8_t flag_tree[NUM_NODES_MERKLE_TREE],
                                           uint8_t* mtree_last_taken,
                                           uint8_t mtree_inc_flags[LOG2(T) + 1],
                                           uint16_t* curr_pos_in_mtree,
                                           uint8_t* starting_level,
                                           bool* recurse_through_tree)
{
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    uint8_t layer_target = LOG2(T) - *starting_level;
    uint16_t current_node = *curr_pos_in_mtree;
    *mtree_inc_target_address = 0;
    if (flag_tree[current_node] != NOT_COMPUTED){
        if (mtree_inc_flags[layer_target] == 0){
            *mtree_inc_target_address = layer_target;
            mtree_inc_flags[layer_target] = 2;
            *flag_tree_address = current_node;
        }
        else{
            *mtree_inc_target_address = layer_target + 1;
            *recurse_through_tree = true;
            *flag_tree_address = current_node;
        }
    }
    else{
        for(int level = layer_target; level > 1; level--){
            current_node = PARENT(current_node) + (off[level-1] >> 1);
            layer_target = level - 1;
            if(flag_tree[current_node] != NOT_COMPUTED && flag_tree[current_node] != *mtree_last_taken){
                *mtree_inc_target_address = LOG2(T) - layer_target;
                *mtree_last_taken = flag_tree[current_node];
                if (mtree_inc_flags[layer_target] == 0){
                    *mtree_inc_target_address = layer_target;
                    mtree_inc_flags[layer_target] = 2;
                    *flag_tree_address = current_node;
                }
                else if (mtree_inc_flags[layer_target] != 2){
                    *mtree_inc_target_address = layer_target + 1;
                    *recurse_through_tree = true;
                    *flag_tree_address = current_node;
                }
                level = 0;
            }
        }
    }
}

/* Recompute some of the upper layers of the tree when two siblings are both available */
void recompute_root_mtree_inc(uint8_t mtree_inc[(LOG2(T) + 1) * HASH_DIGEST_LENGTH],
                                     bool* recurse_through_tree,
                                     uint8_t mtree_inc_flags[LOG2(T)+1])
{
    bool right_filled = false;
    bool get_start = true;
    uint8_t target_offset;
    /* Iterate through the tree segment, leaves to root */
    for(int i = LOG2(T); i >= 0; i--){
        /* If a node is filled this means that the left node is there, as this function was called this also means that a right node should also be there, i.e. we can compute the parent of those two... */
        if(mtree_inc_flags[i] != 0 && (get_start == true || right_filled == true)){
            get_start = false;
            right_filled = false;
            mtree_inc_flags[i] = 0;
            /* we have to figure out where to store the parent, it is a left node, if the next layer has a left node free or it is a right node in case the left node is already filled */
            if(mtree_inc_flags[i - 1] != 0) {
                /* Target right node */
                target_offset = 0;
                right_filled = true;
            }else{
                /* Target left node */
                target_offset = 1;
                mtree_inc_flags[i - 1] = 1;
            }
            hash(mtree_inc + (i - target_offset) * HASH_DIGEST_LENGTH, mtree_inc + i * HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH * 2, HASH_DOMAIN_SEP_CONST);
        }
    }
    *recurse_through_tree = false;
}

/* Recompute some of the upper layers of the tree when two siblings are both available and export them to the path where applicable */
void mtree_inc_proof(uint8_t mtree_inc[(LOG2(T) + 1) * HASH_DIGEST_LENGTH],
                     uint8_t* proof,
                     uint8_t flag_tree[NUM_NODES_MERKLE_TREE],
                     uint16_t* pos_in_mtree,
                     uint8_t* starting_layer,
                     bool* recurse_through_tree,
                     uint8_t mtree_inc_flags[LOG2(T)+1])
{
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    bool right_filled = false;
    bool get_start = true;
    uint8_t target_offset;
    uint16_t current_node = *pos_in_mtree; 
    /* Iterate through the tree segment, leaves to root */
    for(int i = LOG2(T) - *starting_layer; i >= 0; i--){
        if (i > 0){
            current_node = PARENT(current_node) + (off[i-1] >> 1);
        }
        /* If a node is filled this means that the left node is there, as this function was called this also means that a right node should also be there, i.e. we can compute the parent of those two... */
        if(mtree_inc_flags[i] != 0 && (get_start == true || right_filled == true)){
            get_start = false;
            right_filled = false;
            mtree_inc_flags[i] = 0;
            /* we have to figure out where to store the parent, it is a left node, if the next layer has a left node free or it is a right node in case the left node is already filled */
            if(mtree_inc_flags[i - 1] != 0) {
                /* Target right node */
                target_offset = 0;
                right_filled = true;
            }else{
                /* Target left node */
                target_offset = 1;
                mtree_inc_flags[i - 1] = 1;
            }
            hash(mtree_inc + (i - target_offset) * HASH_DIGEST_LENGTH, mtree_inc + i * HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH * 2, HASH_DOMAIN_SEP_CONST);
            if(flag_tree[current_node] != 0){
                // This means that we need this node for the proof
                memcpy(proof + (flag_tree[current_node] - 1) * HASH_DIGEST_LENGTH, mtree_inc + (i - target_offset) * HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
            }
        }
    }
    *recurse_through_tree = false;
}

/* Recompute full flag tree and store address of node from proof
 * in respective nodes */
uint8_t recompute_flag_tree(uint8_t flag_tree[NUM_NODES_MERKLE_TREE],
                         const uint8_t leaves_to_reveal[T])
{
    label_leaves(flag_tree, leaves_to_reveal);
    
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    uint8_t published = 0;
    unsigned int start_node = leaves_start_indices[0];
    for (int level=LOG2(T); level>0; level--) {
        for (int i=npl[level]-2; i>=0; i-=2) {
            uint16_t current_node = start_node + i;
            uint16_t parent_node = PARENT(current_node) + (off[level-1] >> 1);

            /* Both siblings are unused */
            if (flag_tree[current_node] == NOT_COMPUTED && flag_tree[SIBLING(current_node)] == NOT_COMPUTED) {
                continue;
            }
            /* Process left sibling and provide corresponding address from proof if required */
            if (flag_tree[current_node] == NOT_COMPUTED) {
                published++;
                flag_tree[current_node] = published;
            }
            else {
                flag_tree[current_node] = NOT_COMPUTED;
            }
            /* Process right sibling and provide corresponding address from proof if required */
            if (flag_tree[SIBLING(current_node)] == NOT_COMPUTED) {
                published++;
                flag_tree[SIBLING(current_node)] = published;
            }
            else {
                flag_tree[SIBLING(current_node)] = NOT_COMPUTED;
            }
            flag_tree[parent_node] = COMPUTED;
        }
        start_node -= npl[level-1];
    }
    flag_tree[0] = 0;
    return published;
}

/*****************************************************************************/
void tree_root(uint8_t root[HASH_DIGEST_LENGTH],
                                unsigned char tree[NUM_NODES_MERKLE_TREE *HASH_DIGEST_LENGTH])
{
    /* off contains the offsets required to move between two layers in order
     * to compensate for the truncation.
     * npl contains the number of nodes per level.
     * leaves_start_indices contains the index of the leftmost leaf of each full binary subtree
     */
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    /* Start hashing the nodes from right to left, starting always with
     * the left-child node */
    unsigned int start_node = leaves_start_indices[0];
    for (int level=LOG2(T); level>0; level--) {
        for (int i=npl[level]-2; i>=0; i-=2) {
            uint16_t current_node = start_node + i;
            uint16_t parent_node = PARENT(current_node) + (off[level-1] >> 1);

            // Fetch both children
            hash(tree + parent_node*HASH_DIGEST_LENGTH,tree+current_node*HASH_DIGEST_LENGTH,2*HASH_DIGEST_LENGTH, HASH_DOMAIN_SEP_CONST);
        }
        start_node -= npl[level-1];
    }

    /* Root is at first position of the tree */
    memcpy(root, tree, HASH_DIGEST_LENGTH);
}

/*****************************************************************************/
uint16_t tree_proof(uint8_t mtp[HASH_DIGEST_LENGTH*TREE_NODES_TO_STORE],
                               const uint8_t tree[NUM_NODES_MERKLE_TREE*HASH_DIGEST_LENGTH],
                               const uint8_t leaves_to_reveal[T])
{
    /* Label the flag tree to identify computed/valid nodes */
    unsigned char flag_tree[NUM_NODES_MERKLE_TREE] = {NOT_COMPUTED};
    label_leaves(flag_tree, leaves_to_reveal);

    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    int published = 0;
    unsigned int start_node = leaves_start_indices[0];
    for (int level=LOG2(T); level>0; level--) {
        for (int i=npl[level]-2; i>=0; i-=2) {
            uint16_t current_node = start_node + i;
            uint16_t parent_node = PARENT(current_node) + (off[level-1] >> 1);

            flag_tree[parent_node] = (flag_tree[current_node] == COMPUTED) || (flag_tree[SIBLING(current_node)] == COMPUTED);

            /* Add left sibling only if right one was computed but left wasn't */
            if ( (flag_tree[current_node] == NOT_COMPUTED) && (flag_tree[SIBLING(current_node)] == COMPUTED) ) {
                memcpy(mtp + published*HASH_DIGEST_LENGTH, tree + current_node*HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
                published++;
            }

            /* Add right sibling only if left was computed but right wasn't */
            if ( (flag_tree[current_node] == COMPUTED) && (flag_tree[SIBLING(current_node)] == NOT_COMPUTED) ) {
                memcpy(mtp + published*HASH_DIGEST_LENGTH, tree + SIBLING(current_node)*HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
                published++;
            }
        }
        start_node -= npl[level-1];
    }
    return published;
}

/*****************************************************************************/
uint8_t recompute_root(uint8_t root[HASH_DIGEST_LENGTH],
                       uint8_t tree[NUM_NODES_MERKLE_TREE * HASH_DIGEST_LENGTH],
                       const uint8_t mtp[HASH_DIGEST_LENGTH*TREE_NODES_TO_STORE],
                       const uint8_t leaves_to_reveal[T])
{
    uint8_t flag_tree[NUM_NODES_MERKLE_TREE] = {NOT_COMPUTED};
    uint8_t hash_input[2*HASH_DIGEST_LENGTH];

    label_leaves(flag_tree, leaves_to_reveal);

    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    unsigned int published = 0;
    unsigned int start_node = leaves_start_indices[0];
    for (int level=LOG2(T); level>0; level--) {
        for (int i=npl[level]-2; i>=0; i-=2) {
            uint16_t current_node = start_node + i;
            uint16_t parent_node = PARENT(current_node) + (off[level-1] >> 1);

            /* Both siblings are unused */
            if (flag_tree[current_node] == NOT_COMPUTED && flag_tree[SIBLING(current_node)] == NOT_COMPUTED) {
                continue;
            }

            /* Process left sibling from the tree if valid, otherwise take it from the merkle proof */
            if (flag_tree[current_node] == COMPUTED) {
                memcpy(hash_input, tree + current_node*HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
            } else {
                memcpy(hash_input, mtp + published*HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
                published++;
            }

            /* Process right sibling from the tree if valid, otherwise take it from the merkle proof */
            if (flag_tree[SIBLING(current_node)] == COMPUTED) {
                memcpy(hash_input + HASH_DIGEST_LENGTH, tree + SIBLING(current_node)*HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
            } else {
                memcpy(hash_input + HASH_DIGEST_LENGTH, mtp + published*HASH_DIGEST_LENGTH, HASH_DIGEST_LENGTH);
                published++;
            }

            /* Hash it and store the digest at the parent node */
            hash(tree + parent_node*HASH_DIGEST_LENGTH, hash_input, sizeof(hash_input), HASH_DOMAIN_SEP_CONST);
            flag_tree[parent_node] = COMPUTED;
        }
        start_node -= npl[level-1];
    }

    /* Root is at first position of the tree */
    memcpy(root, tree, HASH_DIGEST_LENGTH);

    // Check for correct zero padding in the remaining parth of the Merkle proof to 
    // prevent trivial forgery
    uint8_t error = 0;
    for (int i=published*HASH_DIGEST_LENGTH; i<TREE_NODES_TO_STORE*HASH_DIGEST_LENGTH; i++) {
        error |= mtp[i];
    }
    return (error == 0);
}
#endif
