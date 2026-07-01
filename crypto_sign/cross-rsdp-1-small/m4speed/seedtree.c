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
#include <string.h> // memcpy(...), memset(...)
#include <stdlib.h> // abort()

#include "seedtree.h"

#define LEFT_CHILD(i) (2*(i)+1)
#define RIGHT_CHILD(i) (2*(i)+2)
#define PARENT(i) ( ((i)%2) ? (((i)-1)/2) : (((i)-2)/2) )
#define SIBLING(i) ( ((i)%2) ? (i)+1 : (i)-1 )

/* Seed tree implementation. The binary seed tree is linearized into an array
 * from root to leaves, and from left to right.
 */

/****************************** Pretty Printers ******************************/

#include <stdio.h>
void pseed(unsigned char seed[SEED_LENGTH_BYTES]){
     fprintf(stderr,"-");
   for (int i = 0 ; i < SEED_LENGTH_BYTES; i++){
     fprintf(stderr,"%02X", seed[i]);
   }
     fprintf(stderr,"- ");
}

void psalt(unsigned char salt[SALT_LENGTH_BYTES]){
     fprintf(stderr,"-");
   for (int i = 0 ; i < SALT_LENGTH_BYTES; i++){
     fprintf(stderr,"%02X", salt[i]);
   }
     fprintf(stderr,"- ");
}

void ptree(unsigned char seed_tree[NUM_NODES_SEED_TREE * SEED_LENGTH_BYTES]){
   const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
   int node_idx =0;
   fprintf(stderr,"Tree dump\n");
   int ancestors = 0;
   for (int level = 0; level < LOG2(T)+1; level++){
      fprintf(stderr,"level %d ", level);
      for (int idx_in_level = 0; idx_in_level < npl[level]; idx_in_level++ ) {
          node_idx = ancestors + idx_in_level ;
          fprintf(stderr," [%d] ",node_idx);
          pseed(seed_tree+node_idx*SEED_LENGTH_BYTES);
      }
      ancestors += npl[level];
      fprintf(stderr,"\n");
   }
   fprintf(stderr,"\n");
}


#define TO_PUBLISH 1
#define NOT_TO_PUBLISH 0

#if defined(NO_TREES)

void seed_leaves_intermed(
        unsigned char quad_seed[4*SEED_LENGTH_BYTES],
        const unsigned char root_seed[SEED_LENGTH_BYTES],
        const unsigned char salt[SALT_LENGTH_BYTES],
        CSPRNG_STATE_T *csprng_state){
    const uint32_t csprng_input_len = SALT_LENGTH_BYTES +
                                      SEED_LENGTH_BYTES;
    unsigned char csprng_input[csprng_input_len];
    memcpy(csprng_input,root_seed,SEED_LENGTH_BYTES);   
    memcpy(csprng_input+SEED_LENGTH_BYTES,salt,SALT_LENGTH_BYTES);
    csprng_initialize(csprng_state, csprng_input, csprng_input_len, CSPRNG_DOMAIN_SEP_CONST);
    csprng_randombytes(quad_seed,4*SEED_LENGTH_BYTES,csprng_state);
}

void seed_leaves_inc(unsigned char round_seed[SEED_LENGTH_BYTES],
                     CSPRNG_STATE_T* csprng_state,
                     unsigned char quad_seed[4*SEED_LENGTH_BYTES],
                     uint8_t* pos_in_quad,
                     uint16_t round_ctr,
                     uint8_t salt[SALT_LENGTH_BYTES]){
    const uint32_t csprng_input_len = SALT_LENGTH_BYTES +
                                      SEED_LENGTH_BYTES;
    unsigned char csprng_input[csprng_input_len];
    memcpy(csprng_input+SEED_LENGTH_BYTES,salt,SALT_LENGTH_BYTES);
    int remainders[4] = {0};
    if(T%4 > 0){ remainders[0] = 1; }
    if(T%4 > 1){ remainders[1] = 1; }
    if(T%4 > 2){ remainders[2] = 1; }
    
    if(round_ctr == 0 || round_ctr == (T/4)+remainders[0] || round_ctr == 2*(T/4)+remainders[0]+remainders[1] || round_ctr == 3*(T/4)+remainders[0]+remainders[1]+remainders[2]){
       memcpy(csprng_input,&quad_seed[(*pos_in_quad)*SEED_LENGTH_BYTES],SEED_LENGTH_BYTES);
       *pos_in_quad += 1;
       csprng_initialize(csprng_state, csprng_input, csprng_input_len, CSPRNG_DOMAIN_SEP_CONST + (*pos_in_quad));
    }
    csprng_randombytes(round_seed,
                       SEED_LENGTH_BYTES,
                       csprng_state);
}

int seed_leaves(unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],
                const unsigned char root_seed[SEED_LENGTH_BYTES],
                const unsigned char salt[SALT_LENGTH_BYTES]){
   const uint32_t csprng_input_len = SALT_LENGTH_BYTES +
                                     SEED_LENGTH_BYTES;
   unsigned char csprng_input[csprng_input_len];
   memcpy(csprng_input,root_seed,SEED_LENGTH_BYTES);   
   memcpy(csprng_input+SEED_LENGTH_BYTES,salt,SALT_LENGTH_BYTES);

   unsigned char quad_seed[4*SEED_LENGTH_BYTES];
   CSPRNG_STATE_T csprng_states[4];
   csprng_initialize(&csprng_states[0], csprng_input, csprng_input_len, CSPRNG_DOMAIN_SEP_CONST);
   csprng_randombytes(quad_seed,4*SEED_LENGTH_BYTES,&csprng_states[0]);

   int remainders[4] = {0};
   if(T%4 > 0){ remainders[0] = 1; } 
   if(T%4 > 1){ remainders[1] = 1; } 
   if(T%4 > 2){ remainders[2] = 1; } 
   
   int offset = 0;
   uint16_t dsc_counter = 0;
   for (int i = 0; i < 4; i++){
       memcpy(csprng_input,&quad_seed[i*SEED_LENGTH_BYTES],SEED_LENGTH_BYTES);
       dsc_counter += 1;
       csprng_initialize(&csprng_states[i], csprng_input, csprng_input_len, CSPRNG_DOMAIN_SEP_CONST + dsc_counter);
       
       csprng_randombytes(&rounds_seeds[((T/4)*i+offset)*SEED_LENGTH_BYTES],
                          (T/4+remainders[i])*SEED_LENGTH_BYTES,
                          &csprng_states[i]);
       offset += remainders[i];
   }
   return T;
}

int seed_path(unsigned char *seed_storage,
              const unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],
              const unsigned char indices_to_publish[T]){
    int published = 0;
    for(int i=0; i<T; i++){
       if(indices_to_publish[i] == TO_PUBLISH){
          memcpy(&seed_storage[SEED_LENGTH_BYTES*published],
                 &rounds_seeds[i*SEED_LENGTH_BYTES],
                 SEED_LENGTH_BYTES);
          published++;
       }
    }
    return published;
}

/* simply picks seeds out of the storage and places them in the in-memory array */
uint8_t rebuild_leaves(unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],                           
                           const unsigned char indices_to_publish[T],
                           const unsigned char *seed_storage){
    int published = 0;
    for(int i=0; i<T; i++){
       if(indices_to_publish[i] == TO_PUBLISH){
           memcpy(&rounds_seeds[i*SEED_LENGTH_BYTES],
                  &seed_storage[SEED_LENGTH_BYTES*published],
                  SEED_LENGTH_BYTES);
           published++;
       }
   }      
   return 1;
}
#else
/*****************************************************************************/
/**
 * const unsigned char *indices: input parameter denoting an array
 * with a number of binary cells equal to "leaves" representing
 * the labels of the nodes identified as leaves of the tree[...]
 * passed as second parameter.
 * A label = 1 means that the byteseed of the node having the same index
 * has to be released; = 0, otherwise.
 *
 * unsigned char *tree: input/output parameter denoting an array
 * with a number of binary cells equal to "2*leaves-1";
 * the first "leaves" cells (i.e., the ones with positions from 0 to leaves-1)
 * are the ones that will be modified by the current subroutine,
 * the last "leaves" cells will be a copy of the input array passed as first
 * parameter.
 *
 * uint64_t leaves: input parameter;
 *
 */

static
void label_leaves(unsigned char flag_tree[NUM_NODES_SEED_TREE],
                     const unsigned char indices_to_publish[T])
{
    const uint16_t cons_leaves[TREE_SUBROOTS] = TREE_CONSECUTIVE_LEAVES;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    unsigned int cnt = 0;
    for (size_t i=0; i<TREE_SUBROOTS; i++) {
        for (size_t j=0; j<cons_leaves[i]; j++) {
            flag_tree[leaves_start_indices[i]+j] = indices_to_publish[cnt];
            cnt++;
        }
    }
}

static void compute_seeds_to_publish(
    /* linearized binary tree of boolean nodes containing
     * flags for each node 1-filled nodes are to be released */
    unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE],
    /* Boolean Array indicating which of the T seeds must be
     * released convention as per the above defines */
    const unsigned char indices_to_publish[T]) {
    /* the indices to publish may be less than the full leaves, copy them
     * into the linearized tree leaves */
    label_leaves(flags_tree_to_publish, indices_to_publish);

    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    /* compute the value for the internal nodes of the tree starting from the
     * the leaves, right to left */
    unsigned int start_node = leaves_start_indices[0];
    for (int level=LOG2(T); level>0; level--) {
        for (int i=npl[level]-2; i>=0; i-=2) {
            uint16_t current_node = start_node + i;
            uint16_t parent_node = PARENT(current_node) + (off[level-1] >> 1);

            flags_tree_to_publish[parent_node] = (flags_tree_to_publish[current_node] == TO_PUBLISH)
                && (flags_tree_to_publish[SIBLING(current_node)] == TO_PUBLISH);
        }
        start_node -= npl[level-1];
    }
} /* end compute_seeds_to_publish */

static void compute_seeds_to_publish_inc(
    /* linearized binary tree of boolean nodes containing
     * flags for each node 1-filled nodes are to be released */
    unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE],
    /* Boolean Array indicating which of the T seeds must be
     * released convention as per the above defines */
    const unsigned char indices_to_publish[T]) {
    /* the indices to publish may be less than the full leaves, copy them
     * into the linearized tree leaves */
    label_leaves(flags_tree_to_publish, indices_to_publish);

    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    /* compute the value for the internal nodes of the tree starting from the
     * the leaves, right to left */
    unsigned int start_node = leaves_start_indices[0];
    for (int level=LOG2(T); level>0; level--) {
        for (int i=npl[level]-2; i>=0; i-=2) {
            uint16_t current_node = start_node + i;
            uint16_t parent_node = PARENT(current_node) + (off[level-1] >> 1);

            if((flags_tree_to_publish[current_node] == TO_PUBLISH)
                && (flags_tree_to_publish[SIBLING(current_node)] == TO_PUBLISH)){
                flags_tree_to_publish[parent_node] = (flags_tree_to_publish[current_node] == TO_PUBLISH)
                    && (flags_tree_to_publish[SIBLING(current_node)] == TO_PUBLISH);
                flags_tree_to_publish[current_node] = NOT_TO_PUBLISH;
                flags_tree_to_publish[SIBLING(current_node)] = NOT_TO_PUBLISH;
            }
        }
        start_node -= npl[level-1];
    }
} /* end compute_seeds_to_publish */

void init_seed_tree_inc(unsigned char seed_tree_inc[2*LOG2(T)*SEED_LENGTH_BYTES],
                        uint16_t seed_tree_inc_pos[2*LOG2(T)],
                        const unsigned char root_seed[SEED_LENGTH_BYTES],
                        const unsigned char salt[SALT_LENGTH_BYTES])
{
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    /* input buffer to the CSPRNG, contains the seed to be expanded, a salt,
     * and the integer index of the node being expanded for domain separation */
    const uint32_t csprng_input_len = SALT_LENGTH_BYTES +
        SEED_LENGTH_BYTES;
    unsigned char csprng_input[csprng_input_len];
    CSPRNG_STATE_T tree_csprng_state;
    memcpy(csprng_input+SEED_LENGTH_BYTES, salt, SALT_LENGTH_BYTES);

    /* prepare the CSPRNG input to expand the father node */
    memcpy(csprng_input,
           root_seed,
           SEED_LENGTH_BYTES);

    /* Domain separation using father node index */
    uint16_t domain_sep = CSPRNG_DOMAIN_SEP_CONST;
    csprng_initialize(&tree_csprng_state, csprng_input, csprng_input_len, domain_sep);
    csprng_randombytes(seed_tree_inc,
                       2*SEED_LENGTH_BYTES,
                       &tree_csprng_state);
    seed_tree_inc_pos[0] = 1;
    seed_tree_inc_pos[1] = 2;
    uint16_t parent_node = 1;
    /* prepare the CSPRNG input to expand the father node */
    memcpy(csprng_input,
           seed_tree_inc,
           SEED_LENGTH_BYTES);
                for(int level_inc = 1; level_inc < LOG2(T); level_inc++){
                    //Init CSPRNG and put output to next level
                    domain_sep = CSPRNG_DOMAIN_SEP_CONST + parent_node;
                    /* expand the children (stored contiguously), by construction always two children */
                    csprng_initialize(&tree_csprng_state, csprng_input, csprng_input_len, domain_sep);
                    csprng_randombytes(seed_tree_inc + level_inc * 2 * SEED_LENGTH_BYTES,
                        2*SEED_LENGTH_BYTES,
                        &tree_csprng_state);
                    //Update nodes
                    seed_tree_inc_pos[level_inc * 2] = LEFT_CHILD(parent_node) - off[level_inc];
                    seed_tree_inc_pos[level_inc * 2 + 1] = RIGHT_CHILD(parent_node) - off[level_inc];
                    parent_node = LEFT_CHILD(parent_node) - off[level_inc];
                    memcpy(csprng_input, seed_tree_inc + (level_inc * 2)*SEED_LENGTH_BYTES, SEED_LENGTH_BYTES);
                }
}

/**
 * unsigned char *seed_tree:
 * it is intended as an output parameter;
 * storing the linearized seed tree
 *
 * The root seed is taken as a parameter.
 * The seed of its TWO children are computed expanding (i.e., shake128...) the
 * entropy in "salt" + "seedBytes of the parent" +
 *            "int, encoded over 16 bits - uint16_t,  associated to each node
 *             from roots to leaves layer-by-layer from left to right,
 *             counting from 0 (the integer bound with the root node)"
 */
void gen_seed_tree(unsigned char seed_tree[NUM_NODES_SEED_TREE * SEED_LENGTH_BYTES],
                   const unsigned char root_seed[SEED_LENGTH_BYTES],
                   const unsigned char salt[SALT_LENGTH_BYTES])
{
    /* input buffer to the CSPRNG, contains the seed to be expanded, a salt,
     * and the integer index of the node being expanded for domain separation */
    const uint32_t csprng_input_len = SALT_LENGTH_BYTES +
        SEED_LENGTH_BYTES;
    unsigned char csprng_input[csprng_input_len];
    CSPRNG_STATE_T tree_csprng_state;
    memcpy(csprng_input+SEED_LENGTH_BYTES, salt, SALT_LENGTH_BYTES);

    /* Set the root seed in the tree from the received parameter */
    memcpy(seed_tree,root_seed,SEED_LENGTH_BYTES);

    /* off contains the offsets required to move between two layers in order
     * to compensate for the truncation.
     * npl contains the number of nodes per level.
     * lpl contains the number of leaves per level 
     * */
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t lpl[LOG2(T)+1] = TREE_LEAVES_PER_LEVEL;

    /* Generate the log_2(t) layers from the root, each iteration generates a tree
     * level; iterate on nodes of the parent level; the leaf nodes on each level 
     * don't need to be expanded, thus only iterate to npl[level]-lpl[level] */
    int start_node = 0;
    for (int level = 0; level < LOG2(T); level++){
        for (int node_in_level = 0; node_in_level < npl[level]-lpl[level]; node_in_level++ ) {
            uint16_t father_node = start_node + node_in_level;
            uint16_t left_child_node = LEFT_CHILD(father_node) - off[level];

            /* prepare the CSPRNG input to expand the father node */
            memcpy(csprng_input,
                    seed_tree + father_node*SEED_LENGTH_BYTES,
                    SEED_LENGTH_BYTES);

            /* Domain separation using father node index */
            uint16_t domain_sep = CSPRNG_DOMAIN_SEP_CONST + father_node;

            /* Generate the children (stored contiguously).
             * By construction, the tree has always two children */
            csprng_initialize(&tree_csprng_state, csprng_input, csprng_input_len, domain_sep);
            csprng_randombytes(seed_tree + left_child_node*SEED_LENGTH_BYTES,
                    2*SEED_LENGTH_BYTES,
                    &tree_csprng_state);
        }
        start_node += npl[level];
    }
} /* end generate_seed_tree */


/*****************************************************************************/
void seed_leaves(unsigned char rounds_seeds[T*SEED_LENGTH_BYTES],
                 unsigned char seed_tree[NUM_NODES_SEED_TREE*SEED_LENGTH_BYTES])
{
    const uint16_t cons_leaves[TREE_SUBROOTS] = TREE_CONSECUTIVE_LEAVES;
    const uint16_t leaves_start_indices[TREE_SUBROOTS] = TREE_LEAVES_START_INDICES;

    unsigned int cnt = 0;
    for (size_t i=0; i<TREE_SUBROOTS; i++) {
        for (size_t j=0; j<cons_leaves[i]; j++) {
            memcpy(rounds_seeds + cnt*SEED_LENGTH_BYTES,
                   seed_tree + (leaves_start_indices[i]+j)*SEED_LENGTH_BYTES,
                   SEED_LENGTH_BYTES);
            cnt++;
        }
    }
}

void seed_path_inc(unsigned char seed_tree_inc[2*LOG2(T)*SEED_LENGTH_BYTES],
                  uint8_t* path,
                  /* unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE], */
                  uint8_t flag_tree[NUM_NODES_SEED_TREE],
                  uint8_t total_published,
                  uint16_t* last_copied,
                  uint16_t seed_tree_inc_pos[2*LOG2(T)],
                  uint16_t* pos_in_mtree,
                  uint8_t* curr_level)
{
    uint16_t current_node = *pos_in_mtree;
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    for(int level = LOG2(T) - *curr_level; level > 0; level--){
        if(flag_tree[current_node] != 0 && current_node != *last_copied){
            // Copy this node to its respective position in the path...
            // Check left node on this level
            if(seed_tree_inc_pos[(level-1)*2] == current_node){
                memcpy(path + (total_published - flag_tree[current_node]) * SEED_LENGTH_BYTES, seed_tree_inc + (level-1)*2*SEED_LENGTH_BYTES, SEED_LENGTH_BYTES);
            }else if(seed_tree_inc_pos[(level)*2 - 1] == current_node){
                memcpy(path + (total_published - flag_tree[current_node]) * SEED_LENGTH_BYTES, seed_tree_inc + (level*2-1) * SEED_LENGTH_BYTES, SEED_LENGTH_BYTES);
            }else{
                abort();
            }
            *last_copied = current_node;
            level = 0;
        }
        if(level-1 >= 0) {
            current_node = PARENT(current_node) + (off[level-1] >> 1);
        }
    }
}

/*****************************************************************************/
int seed_path(unsigned char *seed_storage,
              // OUTPUT: sequence of seeds to be released
              const unsigned char
              seed_tree[NUM_NODES_SEED_TREE*SEED_LENGTH_BYTES],
              // INPUT: linearized seedtree array with 2T-1 nodes each of size SEED_LENGTH_BYTES
              const unsigned char indices_to_publish[T]
              // INPUT: binary array denoting which node has to be released (cell == TO_PUBLISH) or not
              ){
    /* complete linearized binary tree containing boolean values determining
     * if a node is to be released or not according to convention above.
     * */
    unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE] = {NOT_TO_PUBLISH};
    compute_seeds_to_publish(flags_tree_to_publish, indices_to_publish);

    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;

    /* no sense in trying to publish the root node, start examining from level 1 */
    int start_node = 1;
    int num_seeds_published = 0;
    for (int level = 1; level <= LOG2(T); level++){
        for (int node_in_level = 0; node_in_level < npl[level]; node_in_level++ ) {
            uint16_t current_node = start_node + node_in_level;
            uint16_t father_node = PARENT(current_node) + (off[level-1] >> 1);

            /* if seed is to published and its ancestor/parent node is not,
             * add it to the seed storage */
            if ( (flags_tree_to_publish[current_node] == TO_PUBLISH) &&
                (flags_tree_to_publish[father_node] == NOT_TO_PUBLISH) ) {
                memcpy(seed_storage + num_seeds_published*SEED_LENGTH_BYTES,
                        seed_tree + current_node*SEED_LENGTH_BYTES,
                        SEED_LENGTH_BYTES);
                num_seeds_published++;
            }
        }
        start_node += npl[level];
    }
   return num_seeds_published;
} /* end publish_seeds */

/*****************************************************************************/

int init_rebuild_tree_inc(unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE],
                              const unsigned char indices_to_publish[T])
{
    // Compute the flag tree based on the second challenge
    compute_seeds_to_publish_inc(flags_tree_to_publish, indices_to_publish);
    int num_seeds_published = 0;
    for(int i = 0; i < NUM_NODES_SEED_TREE; i++){
        if(flags_tree_to_publish[i] == 1){
            flags_tree_to_publish[i] = num_seeds_published + 1;
            num_seeds_published++;
        }
    }
    return num_seeds_published;
}

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
                         const unsigned char skip_from_sig)
{
    uint8_t error = 0;
    uint8_t starting_level = LOG2(T) - 1 - *curr_level;
    uint16_t current_node = *pos_in_mtree;
    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    *directly_from_sig = 0;
    //Check whether the currently requested pos is already in the tree subset
    if(seed_tree_inc_pos[starting_level * 2] == *pos_in_mtree){
        *target_pos = starting_level * 2;
    }else if(seed_tree_inc_pos[starting_level * 2 + 1] == *pos_in_mtree){
        *target_pos = starting_level * 2 + 1;
    //Check whether the requested pos is directly part of the signature
    }else if(flag_tree[current_node] != 0 && skip_from_sig == 0){
        *directly_from_sig = 1;
        *target_pos = total_published - flag_tree[current_node];
    }else{
        uint16_t parent_node = current_node;
        CSPRNG_STATE_T tree_csprng_state;
        const uint32_t csprng_input_len = SALT_LENGTH_BYTES + SEED_LENGTH_BYTES;
        unsigned char csprng_input[csprng_input_len];
        memcpy(csprng_input + SEED_LENGTH_BYTES, salt, SALT_LENGTH_BYTES);
        int end_level = starting_level;
        for(int level = starting_level - 1; level >= 0; level--){
            //Find the father of the current node
            parent_node = PARENT(parent_node) + (off[level+1] >> 1);
            end_level = level;
            // Check whether the father is already in the precomputed subset, we only have to check the right nodes as the left ones were expanded in the first place anyways...
            if(seed_tree_inc_pos[level * 2 + 1] == parent_node){
                // We found a valid parent which is already in the current subset
                memcpy(csprng_input, seed_tree_inc + (level * 2 + 1)*SEED_LENGTH_BYTES, SEED_LENGTH_BYTES);
                // Recompute lower layers from here and update positions in tree subset accordingly, using the following assumption: We necessarily expanded from a right side node, as this node was already in the tree and we always go left first. We therefore again expand always the left child, except for the first one where this happens automatically...
                level = 0;
            }else if(flag_tree[parent_node] != 0 && skip_from_sig == 0){
                // We found the parent in the signature
                seed_tree_inc_pos[level * 2] = parent_node;
                memcpy(csprng_input, stored_seeds + (total_published - flag_tree[parent_node]) * SEED_LENGTH_BYTES, SEED_LENGTH_BYTES);
                // We just put this one in a "left" spot, as it gets expanded right away and reset the position of its right sibling, this avoids figuring out where to put this one as we'll also not use it anymore anyways...
                level = 0;
            }
        }
        for(int level_inc = end_level + 1; level_inc <= starting_level; level_inc++){
            //Init CSPRNG and put output to next level
            uint16_t domain_sep = CSPRNG_DOMAIN_SEP_CONST + parent_node;
            /* expand the children (stored contiguously), by construction always two children */
            csprng_initialize(&tree_csprng_state, csprng_input, csprng_input_len, domain_sep);
            csprng_randombytes(seed_tree_inc + level_inc * 2 * SEED_LENGTH_BYTES,
                2*SEED_LENGTH_BYTES,
                &tree_csprng_state);
            //Update nodes
            seed_tree_inc_pos[level_inc * 2] = LEFT_CHILD(parent_node) - off[level_inc];
            seed_tree_inc_pos[level_inc * 2 + 1] = RIGHT_CHILD(parent_node) - off[level_inc];
            parent_node = LEFT_CHILD(parent_node) - off[level_inc];
            memcpy(csprng_input, seed_tree_inc + (level_inc * 2)*SEED_LENGTH_BYTES, SEED_LENGTH_BYTES);
        }
        if(seed_tree_inc_pos[starting_level * 2] == *pos_in_mtree){
            *target_pos = starting_level * 2;
        }else if(seed_tree_inc_pos[starting_level * 2 + 1] == *pos_in_mtree){
            *target_pos = starting_level * 2 + 1;
        }
    }
    return (error == 0);
}

uint8_t rebuild_tree(unsigned char
                      seed_tree[NUM_NODES_SEED_TREE*SEED_LENGTH_BYTES],
                      const unsigned char indices_to_publish[T],
                      const unsigned char *stored_seeds,
                      const unsigned char salt[SALT_LENGTH_BYTES])
{
    /* complete linearized binary tree containing boolean values determining
     * if a node is to be released or not according to aboves convention
     */
    unsigned char flags_tree_to_publish[NUM_NODES_SEED_TREE] = {0};
    compute_seeds_to_publish(flags_tree_to_publish, indices_to_publish);

    const uint32_t csprng_input_len = SALT_LENGTH_BYTES +
        SEED_LENGTH_BYTES;
    unsigned char csprng_input[csprng_input_len];
    CSPRNG_STATE_T tree_csprng_state;

    const uint16_t off[LOG2(T)+1] = TREE_OFFSETS;
    const uint16_t npl[LOG2(T)+1] = TREE_NODES_PER_LEVEL;
    const uint16_t lpl[LOG2(T)+1] = TREE_LEAVES_PER_LEVEL;

    memcpy(csprng_input + SEED_LENGTH_BYTES, salt, SALT_LENGTH_BYTES);

    /* regenerating the seed tree never starts from the root, as it is never
     * disclosed */
    int nodes_used = 0;
    int start_node = 1;
    for (int level = 1; level <= LOG2(T); level++){
        for (int node_in_level = 0; node_in_level < npl[level]; node_in_level++ ) {
            uint16_t current_node = start_node + node_in_level;
            uint16_t father_node = PARENT(current_node) + (off[level-1] >> 1);
            uint16_t left_child = LEFT_CHILD(current_node) - off[level];

            /* if the current node is a seed which was published (thus its father 
             * was not), memcpy it in place */
            if ( flags_tree_to_publish[current_node] == TO_PUBLISH ) {
                if ( flags_tree_to_publish[father_node] == NOT_TO_PUBLISH ) {
                    memcpy(seed_tree + current_node*SEED_LENGTH_BYTES,
                            stored_seeds + nodes_used*SEED_LENGTH_BYTES,
                            SEED_LENGTH_BYTES );
                    nodes_used++;
                }
            }
            /* If the current node is published and not a leaf, CSPRNG-expand its children.
             * Since there is no reason of expanding leaves, only iterate to nodes per level (npl)
             * minus leaves per level (lpl) in each level */
            if ( ( flags_tree_to_publish[current_node] == TO_PUBLISH ) && (node_in_level < npl[level]-lpl[level] ) ) {
                /* prepare the CSPRNG input to expand the children of node current_node */
                memcpy(csprng_input,
                        seed_tree + current_node*SEED_LENGTH_BYTES,
                        SEED_LENGTH_BYTES);

                /* Domain separation using father node index */
                uint16_t domain_sep = CSPRNG_DOMAIN_SEP_CONST + current_node;

                /* expand the children (stored contiguously), by construction always two children */
                csprng_initialize(&tree_csprng_state, csprng_input, csprng_input_len, domain_sep);
                csprng_randombytes(seed_tree + left_child*SEED_LENGTH_BYTES,
                        2*SEED_LENGTH_BYTES,
                        &tree_csprng_state);
            }
        }
        start_node += npl[level];
    }

    // Check for correct zero padding in the remaining parth of the seed path to 
    // prevent trivial forgery
    uint8_t error = 0;
    for (int i=nodes_used*SEED_LENGTH_BYTES; i<TREE_NODES_TO_STORE*SEED_LENGTH_BYTES; i++) {
        error |= stored_seeds[i];
    }
    return (error == 0);
} /* end regenerate_leaves */
#endif
