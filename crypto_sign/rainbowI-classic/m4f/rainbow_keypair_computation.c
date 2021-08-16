/// @file rainbow_keypair_computation.c
/// @brief Implementations for functions in rainbow_keypair_computation.h
///

#include "rainbow_keypair.h"
#include "rainbow_keypair_computation.h"

#include "blas_comm.h"
#include "blas.h"
#include "rainbow_blas.h"

#include <stdlib.h>
#include <stdint.h>
#include <string.h>


////////////////////////////////////////////////////////////////




void extcpk_to_pk( pk_t * pk , const ext_cpk_t * cpk )
{
    const unsigned char * idx_l1 = cpk->l1_Q1;
    const unsigned char * idx_l2 = cpk->l2_Q1;
    for(unsigned i=0;i<_V1;i++) {
        for(unsigned j=i;j<_V1;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            memcpy( & pk->pk[ _PUB_M_BYTE*pub_idx ] , idx_l1 , _O1_BYTE );
            memcpy( (&pk->pk[ _PUB_M_BYTE*pub_idx ]) + _O1_BYTE , idx_l2 , _O2_BYTE );
            idx_l1 += _O1_BYTE;
            idx_l2 += _O2_BYTE;
        }
    }
    idx_l1 = cpk->l1_Q2;
    idx_l2 = cpk->l2_Q2;
    for(unsigned i=0;i<_V1;i++) {
        for(unsigned j=_V1;j<_V1+_O1;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            memcpy( & pk->pk[ _PUB_M_BYTE*pub_idx ] , idx_l1 , _O1_BYTE );
            memcpy( (&pk->pk[ _PUB_M_BYTE*pub_idx ]) + _O1_BYTE , idx_l2 , _O2_BYTE );
            idx_l1 += _O1_BYTE;
            idx_l2 += _O2_BYTE;
        }
    }
    idx_l1 = cpk->l1_Q3;
    idx_l2 = cpk->l2_Q3;
    for(unsigned i=0;i<_V1;i++) {
        for(unsigned j=_V1+_O1;j<_PUB_N;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            memcpy( & pk->pk[ _PUB_M_BYTE*pub_idx ]             , idx_l1 , _O1_BYTE );
            memcpy( (&pk->pk[ _PUB_M_BYTE*pub_idx ]) + _O1_BYTE , idx_l2 , _O2_BYTE );
            idx_l1 += _O1_BYTE;
            idx_l2 += _O2_BYTE;
        }
    }
    idx_l1 = cpk->l1_Q5;
    idx_l2 = cpk->l2_Q5;
    for(unsigned i=_V1;i<_V1+_O1;i++) {
        for(unsigned j=i;j<_V1+_O1;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            memcpy( & pk->pk[ _PUB_M_BYTE*pub_idx ]             , idx_l1 , _O1_BYTE );
            memcpy( (&pk->pk[ _PUB_M_BYTE*pub_idx ]) + _O1_BYTE , idx_l2 , _O2_BYTE );
            idx_l1 += _O1_BYTE;
            idx_l2 += _O2_BYTE;
        }
    }
    idx_l1 = cpk->l1_Q6;
    idx_l2 = cpk->l2_Q6;
    for(unsigned i=_V1;i<_V1+_O1;i++) {
        for(unsigned j=_V1+_O1;j<_PUB_N;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            memcpy( & pk->pk[ _PUB_M_BYTE*pub_idx ]             , idx_l1 , _O1_BYTE );
            memcpy( (&pk->pk[ _PUB_M_BYTE*pub_idx ]) + _O1_BYTE , idx_l2 , _O2_BYTE );
            idx_l1 += _O1_BYTE;
            idx_l2 += _O2_BYTE;
        }
    }
    idx_l1 = cpk->l1_Q9;
    idx_l2 = cpk->l2_Q9;
    for(unsigned i=_V1+_O1;i<_PUB_N;i++) {
        for(unsigned j=i;j<_PUB_N;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            memcpy( & pk->pk[ _PUB_M_BYTE*pub_idx ]             , idx_l1 , _O1_BYTE );
            memcpy( (&pk->pk[ _PUB_M_BYTE*pub_idx ]) + _O1_BYTE , idx_l2 , _O2_BYTE );
            idx_l1 += _O1_BYTE;
            idx_l2 += _O2_BYTE;
        }
    }
}


#if (16 == _O1_BYTE)&&(16 == _O2_BYTE)&& ((96 == _PUB_N) || (100 == _PUB_N))
#define _CONVERT_PK_INPLACE_
#endif

#if defined(_CONVERT_PK_INPLACE_)

static inline
void _swap_16(unsigned char* data, uint16_t *idx_to_loc, uint16_t *loc_to_idx, unsigned dst_loc, unsigned src_idx )
{
    unsigned src_loc = idx_to_loc[src_idx];
    if(src_loc == dst_loc ) return;

    gf256v_add( data + dst_loc*16 , data + src_loc*16 , 16 );
    gf256v_add( data + src_loc*16 , data + dst_loc*16 , 16 );
    gf256v_add( data + dst_loc*16 , data + src_loc*16 , 16 );

    unsigned dst_idx = loc_to_idx[dst_loc];
    idx_to_loc[dst_idx] = src_loc;
    loc_to_idx[src_loc] = dst_idx;
}

void extcpk_to_pk_inplace( pk_t * pk )
{
#if (16 != _O1_BYTE)||(16 != _O2_BYTE)|| ((96 != _PUB_N) && (100 != _PUB_N))
error: un-supported.
#endif
    #if _PUB_N == 96
    uint16_t idx_to_loc[8192+1024+128]; // 8192+1024+129 > N_TRIANGLE_TERMS(96)*2
    uint16_t loc_to_idx[8192+1024+128];
    #else 
    uint16_t idx_to_loc[ N_TRIANGLE_TERMS(_PUB_N)*2 + 1];
    uint16_t loc_to_idx[ N_TRIANGLE_TERMS(_PUB_N)*2 + 1];
    #endif
    for(unsigned i=0;i<sizeof(idx_to_loc)/sizeof(idx_to_loc[0]);i++) idx_to_loc[i] = i;
    for(unsigned i=0;i<sizeof(loc_to_idx)/sizeof(loc_to_idx[0]);i++) loc_to_idx[i] = i;
    unsigned char *data = pk->pk;
    unsigned idx_l1 = 0;
    unsigned idx_l2 = N_TRIANGLE_TERMS(_PUB_N);
    // Q1
    for(unsigned i=0;i<_V1;i++) {
        for(unsigned j=i;j<_V1;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2    , idx_l1++ );
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2 + 1, idx_l2++ );
        }
    }
    // Q2
    for(unsigned i=0;i<_V1;i++) {
        for(unsigned j=_V1;j<_V1+_O1;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2    , idx_l1++ );
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2 + 1, idx_l2++ );
        }
    }
    // Q3
    for(unsigned i=0;i<_V1;i++) {
        for(unsigned j=_V1+_O1;j<_PUB_N;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2    , idx_l1++ );
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2 + 1, idx_l2++ );
        }
    }
    // Q5
    for(unsigned i=_V1;i<_V1+_O1;i++) {
        for(unsigned j=i;j<_V1+_O1;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2    , idx_l1++ );
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2 + 1, idx_l2++ );
        }
    }
    // Q6
    for(unsigned i=_V1;i<_V1+_O1;i++) {
        for(unsigned j=_V1+_O1;j<_PUB_N;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2    , idx_l1++ );
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2 + 1, idx_l2++ );
        }
    }
    // Q9
    for(unsigned i=_V1+_O1;i<_PUB_N;i++) {
        for(unsigned j=i;j<_PUB_N;j++) {
            unsigned pub_idx = idx_of_trimat(i,j,_PUB_N);
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2    , idx_l1++ );
            _swap_16( data, idx_to_loc, loc_to_idx, pub_idx*2 + 1, idx_l2++ );
        }
    }
}
#endif  //defined(_CONVERT_PK_INPLACE_)


/////////////////////////////////////////////////////////


static
void calculate_Q_from_F_ref( ext_cpk_t * Qs, const sk_t * Fs , const sk_t * Ts )
{
/*
    Layer 1
    Computing :
    Q_pk.l1_F1s[i] = F_sk.l1_F1s[i]

    Q_pk.l1_F2s[i] = (F1* T1 + F2) + F1tr * t1
    Q_pk.l1_F5s[i] = UT( T1tr* (F1 * T1 + F2) )
*/
    const unsigned char * t2 = Ts->t4;

    memcpy( Qs->l1_Q1 , Fs->l1_F1 , _O1_BYTE * N_TRIANGLE_TERMS(_V1) );

    memcpy( Qs->l1_Q2 , Fs->l1_F2 , _O1_BYTE * _V1 * _O1 );
    batch_trimat_madd( Qs->l1_Q2 , Fs->l1_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O1_BYTE );    // F1*T1 + F2

    memset( Qs->l1_Q3 , 0 , _O1_BYTE * _V1 * _O2 );
    memset( Qs->l1_Q5 , 0 , _O1_BYTE * N_TRIANGLE_TERMS(_O1) );
    memset( Qs->l1_Q6 , 0 , _O1_BYTE * _O1 * _O2 );
    memset( Qs->l1_Q9 , 0 , _O1_BYTE * N_TRIANGLE_TERMS(_O2) );

    // l1_Q5 : _O1_BYTE * _O1 * _O1    <-- assuming the largest space required.
    // l1_Q9 : _O1_BYTE * _O2 * _O2
    // l2_Q5 : _O2_BYTE * _O1 * _O1
    // l2_Q9 : _O2_BYTE * _O2 * _O2
#define _SIZE_TEMPQ  (_O1_BYTE*_O1*_O1)
#if ( _O1_BYTE*_O2*_O2 > _SIZE_TEMPQ )||( _O2_BYTE*_O1*_O1 > _SIZE_TEMPQ )||( _O2_BYTE*_O2*_O2 > _SIZE_TEMPQ )
error: incorrect buffer size.
#endif
    unsigned char tempQ[_SIZE_TEMPQ];

    memset( tempQ , 0 , _O1_BYTE * _O1 * _O1 );   // l1_Q5
    batch_matTr_madd( tempQ , Ts->t1 , _V1, _V1_BYTE, _O1, Qs->l1_Q2, _O1, _O1_BYTE );  // t1_tr*(F1*T1 + F2)
    UpperTrianglize( Qs->l1_Q5 , tempQ , _O1, _O1_BYTE );    // UT( ... )   // Q5

    batch_trimatTr_madd( Qs->l1_Q2 , Fs->l1_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O1_BYTE );    // Q2
/*
    Computing:
    F1_T2     = F1 * t2
    F2_T3     = F2 * t3
    F1_F1T_T2 + F2_T3 = F1_T2 + F2_T3 + F1tr * t2
    Q_pk.l1_F3s[i] =         F1_F1T_T2 + F2_T3
    Q_pk.l1_F6s[i] = T1tr* ( F1_F1T_T2 + F2_T3 ) + F2tr * t2
    Q_pk.l1_F9s[i] = UT( T2tr* ( F1_T2 + F2_T3 ) )
*/
    batch_trimat_madd( Qs->l1_Q3 , Fs->l1_F1 , t2 , _V1, _V1_BYTE , _O2, _O1_BYTE );         // F1*T2
    batch_mat_madd( Qs->l1_Q3 , Fs->l1_F2 , _V1, Ts->t3 , _O1, _O1_BYTE , _O2, _O1_BYTE );   // F1_T2 + F2_T3

    memset( tempQ , 0 , _O1_BYTE * _O2 * _O2 );                                              // l1_Q9
    batch_matTr_madd( tempQ , t2 , _V1, _V1_BYTE, _O2, Qs->l1_Q3, _O2, _O1_BYTE );           // T2tr * ( F1_T2 + F2_T3 )
    UpperTrianglize( Qs->l1_Q9 , tempQ , _O2 , _O1_BYTE );                                   // Q9

    batch_trimatTr_madd( Qs->l1_Q3 , Fs->l1_F1 , t2 , _V1, _V1_BYTE, _O2, _O1_BYTE );        // F1_F1T_T2 + F2_T3  // Q3

    batch_bmatTr_madd( Qs->l1_Q6 , Fs->l1_F2, _O1, t2, _V1, _V1_BYTE, _O2, _O1_BYTE );       // F2tr*T2
    batch_matTr_madd( Qs->l1_Q6 , Ts->t1, _V1, _V1_BYTE, _O1, Qs->l1_Q3, _O2, _O1_BYTE );    // Q6

/*
    layer 2
    Computing:
    Q1 = F1
    Q2 = F1_F1T*T1 + F2
    Q5 = UT( T1tr( F1*T1 + F2 )  + F5 )
*/
    memcpy( Qs->l2_Q1 , Fs->l2_F1 , _O2_BYTE * N_TRIANGLE_TERMS(_V1) );

    memcpy( Qs->l2_Q2 , Fs->l2_F2 , _O2_BYTE * _V1 * _O1 );
    batch_trimat_madd( Qs->l2_Q2 , Fs->l2_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O2_BYTE );      // F1*T1 + F2

    memcpy( Qs->l2_Q5 , Fs->l2_F5 , _O2_BYTE * N_TRIANGLE_TERMS(_O1) );
    memset( tempQ , 0 , _O2_BYTE * _O1 * _O1 );                                               // l2_Q5
    batch_matTr_madd( tempQ , Ts->t1 , _V1, _V1_BYTE, _O1, Qs->l2_Q2, _O1, _O2_BYTE );        // t1_tr*(F1*T1 + F2)
    UpperTrianglize( Qs->l2_Q5 , tempQ , _O1, _O2_BYTE );                                     // UT( ... )   // Q5

    batch_trimatTr_madd( Qs->l2_Q2 , Fs->l2_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O2_BYTE );    // Q2

/*
    Computing:
    F1_T2     = F1 * t2
    F2_T3     = F2 * t3
    F1_F1T_T2 + F2_T3 = F1_T2 + F2_T3 + F1tr * t2

    Q3 =        F1_F1T*T2 + F2*T3 + F3
    Q9 = UT( T2tr*( F1*T2 + F2*T3 + F3 )  +      T3tr*( F5*T3 + F6 ) )
    Q6 = T1tr*( F1_F1T*T2 + F2*T3 + F3 )  + F2Tr*T2 + F5_F5T*T3 + F6
*/
    memcpy( Qs->l2_Q3 , Fs->l2_F3 , _O2_BYTE * _V1 * _O2 );
    batch_trimat_madd( Qs->l2_Q3 , Fs->l2_F1 , t2 , _V1, _V1_BYTE , _O2, _O2_BYTE );         // F1*T2 + F3
    batch_mat_madd( Qs->l2_Q3 , Fs->l2_F2 , _V1, Ts->t3 , _O1, _O1_BYTE , _O2, _O2_BYTE );   // F1_T2 + F2_T3 + F3

    memset( tempQ , 0 , _O2_BYTE * _O2 * _O2 );                                              // l2_Q9
    batch_matTr_madd( tempQ , t2 , _V1, _V1_BYTE, _O2, Qs->l2_Q3, _O2, _O2_BYTE );           // T2tr * ( ..... )

    memcpy( Qs->l2_Q6 , Fs->l2_F6 , _O2_BYTE * _O1 *_O2 );

    batch_trimat_madd( Qs->l2_Q6 , Fs->l2_F5 , Ts->t3 , _O1, _O1_BYTE, _O2, _O2_BYTE );      // F5*T3 + F6
    batch_matTr_madd( tempQ , Ts->t3 , _O1, _O1_BYTE, _O2, Qs->l2_Q6, _O2, _O2_BYTE );       // T2tr*( ..... ) + T3tr*( ..... )
    memset( Qs->l2_Q9 , 0 , _O2_BYTE * N_TRIANGLE_TERMS(_O2) );
    UpperTrianglize( Qs->l2_Q9 , tempQ , _O2 , _O2_BYTE );                                   // Q9

    batch_trimatTr_madd( Qs->l2_Q3 , Fs->l2_F1 , t2 , _V1, _V1_BYTE, _O2, _O2_BYTE );        // F1_F1T_T2 + F2_T3 + F3 // Q3

    batch_bmatTr_madd( Qs->l2_Q6 , Fs->l2_F2, _O1, t2, _V1, _V1_BYTE, _O2, _O2_BYTE );       //  F5*T3 + F6 +  F2tr*T2
    batch_trimatTr_madd( Qs->l2_Q6 , Fs->l2_F5 , Ts->t3 , _O1, _O1_BYTE, _O2, _O2_BYTE );    //   F2tr*T2 + F5_F5T*T3 + F6
    batch_matTr_madd( Qs->l2_Q6 , Ts->t1, _V1, _V1_BYTE, _O1, Qs->l2_Q3, _O2, _O2_BYTE );    // Q6

    memset( tempQ , 0 , _SIZE_TEMPQ );
}





/////////////////////////////////////////////////////

static
void calculate_F_from_Q_ref( sk_t * Fs , const sk_t * Qs , sk_t * Ts )
{
    // Layer 1
    // F_sk.l1_F1s[i] = Q_pk.l1_F1s[i]
    memcpy( Fs->l1_F1 , Qs->l1_F1 , _O1_BYTE * N_TRIANGLE_TERMS(_V1) );

    // F_sk.l1_F2s[i] = ( Q_pk.l1_F1s[i] + Q_pk.l1_F1s[i].transpose() ) * T_sk.t1 + Q_pk.l1_F2s[i]
    memcpy( Fs->l1_F2 , Qs->l1_F2 , _O1_BYTE * _V1*_O1 );
    batch_2trimat_madd( Fs->l1_F2 , Qs->l1_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O1_BYTE );

/*
    Layer 2
    computations:

    F_sk.l2_F1s[i] = Q_pk.l2_F1s[i]

    Q1_T1 = Q_pk.l2_F1s[i]*T_sk.t1
    F_sk.l2_F2s[i] =              Q1_T1 + Q_pk.l2_F2s[i]     + Q_pk.l2_F1s[i].transpose() * T_sk.t1
    F_sk.l2_F5s[i] = UT( t1_tr* ( Q1_T1 + Q_pk.l2_F2s[i] ) ) + Q_pk.l2_F5s[i]

    Q1_Q1T_T4 =  (Q_pk.l2_F1s[i] + Q_pk.l2_F1s[i].transpose()) * t4
    #Q1_Q1T_T4 =  Q1_Q1T * t4
    Q2_T3 = Q_pk.l2_F2s[i]*T_sk.t3
    F_sk.l2_F3s[i] =           Q1_Q1T_T4 + Q2_T3 + Q_pk.l2_F3s[i]
    F_sk.l2_F6s[i] = t1_tr * ( Q1_Q1T_T4 + Q2_T3 + Q_pk.l2_F3s[i] )
                    +  Q_pk.l2_F2s[i].transpose() * t4
                    + (Q_pk.l2_F5s[i] + Q_pk.l2_F5s[i].transpose())*T_sk.t3   + Q_pk.l2_F6s[i]

*/
    memcpy( Fs->l2_F1 , Qs->l2_F1 , _O2_BYTE * N_TRIANGLE_TERMS(_V1) );        // F_sk.l2_F1s[i] = Q_pk.l2_F1s[i]


    // F_sk.l2_F2s[i] =              Q1_T1 + Q_pk.l2_F2s[i]     + Q_pk.l2_F1s[i].transpose() * T_sk.t1
    // F_sk.l2_F5s[i] = UT( t1_tr* ( Q1_T1 + Q_pk.l2_F2s[i] ) ) + Q_pk.l2_F5s[i]
    memcpy( Fs->l2_F2 , Qs->l2_F2 , _O2_BYTE * _V1*_O1 );
    batch_trimat_madd( Fs->l2_F2 , Qs->l2_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O2_BYTE );    // Q1_T1+ Q2

    unsigned char tempQ[_O1*_O1*_O2_BYTE] = {0};
    batch_matTr_madd( tempQ , Ts->t1 , _V1, _V1_BYTE, _O1, Fs->l2_F2, _O1, _O2_BYTE );     // t1_tr*(Q1_T1+Q2)
    memcpy( Fs->l2_F5, Qs->l2_F5, _O2_BYTE * N_TRIANGLE_TERMS(_O1) );                      // F5
    UpperTrianglize( Fs->l2_F5 , tempQ , _O1, _O2_BYTE );                                  // UT( ... )
    memset( tempQ , 0 , _O1*_O1*_O2_BYTE );

    batch_trimatTr_madd( Fs->l2_F2 , Qs->l2_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O2_BYTE );  // F2 = Q1_T1 + Q2 + Q1^tr*t1

    // Q1_Q1T_T4 =  (Q_pk.l2_F1s[i] + Q_pk.l2_F1s[i].transpose()) * t4
    // Q2_T3 = Q_pk.l2_F2s[i]*T_sk.t3
    // F_sk.l2_F3s[i] =           Q1_Q1T_T4 + Q2_T3 + Q_pk.l2_F3s[i]
    memcpy( Fs->l2_F3 , Qs->l2_F3 , _V1*_O2*_O2_BYTE );
    batch_2trimat_madd( Fs->l2_F3 , Qs->l2_F1 , Ts->t4 , _V1, _V1_BYTE , _O2, _O2_BYTE );   // Q1_Q1T_T4
    batch_mat_madd( Fs->l2_F3 , Qs->l2_F2 , _V1, Ts->t3 , _O1, _O1_BYTE , _O2, _O2_BYTE );  // Q2_T3

    // F_sk.l2_F6s[i] = t1_tr * ( Q1_Q1T_T4 + Q2_T3 + Q_pk.l2_F3s[i] )
    //                +  Q_pk.l2_F2s[i].transpose() * t4
    //                + (Q_pk.l2_F5s[i] + Q_pk.l2_F5s[i].transpose())*T_sk.t3   + Q_pk.l2_F6s[i]
    memcpy( Fs->l2_F6 , Qs->l2_F6 , _O1*_O2*_O2_BYTE );
    batch_matTr_madd( Fs->l2_F6 , Ts->t1 , _V1, _V1_BYTE, _O1, Fs->l2_F3, _O2, _O2_BYTE );  // t1_tr * ( Q1_Q1T_T4 + Q2_T3 + Q_pk.l2_F3s[i] )
    batch_2trimat_madd( Fs->l2_F6 , Qs->l2_F5 , Ts->t3, _O1, _O1_BYTE, _O2, _O2_BYTE );     // (Q_pk.l2_F5s[i] + Q_pk.l2_F5s[i].transpose())*T_sk.t3
    batch_bmatTr_madd( Fs->l2_F6 , Qs->l2_F2, _O1, Ts->t4, _V1, _V1_BYTE, _O2, _O2_BYTE );

}


//////////////////////////////////////////////////////////////////////////////////////////////////

static
void calculate_Q_from_F_cyclic_ref( cpk_t * Qs, const sk_t * Fs , const sk_t * Ts )
{
// Layer 1: Computing Q5, Q3, Q6, Q9

//  Q_pk.l1_F5s[i] = UT( T1tr* (F1 * T1 + F2) )
    const unsigned char * t2 = Ts->t4;

#define _SIZE_BUFFER_F2 (_O1_BYTE * _V1 * _O1)
    unsigned char buffer_F2[_SIZE_BUFFER_F2];
    memcpy( buffer_F2 , Fs->l1_F2 , _O1_BYTE * _V1 * _O1 );
    batch_trimat_madd( buffer_F2 , Fs->l1_F1 , Ts->t1 , _V1, _V1_BYTE , _O1, _O1_BYTE );      // F1*T1 + F2

#define _SIZE_BUFFER_F3 (_O1_BYTE * _V1 * _O2)
    unsigned char buffer_F3[_SIZE_BUFFER_F3];
    memset( buffer_F3 , 0 , _O1_BYTE * _V1 * _O2 );
    batch_matTr_madd( buffer_F3 , Ts->t1 , _V1, _V1_BYTE, _O1, buffer_F2, _O1, _O1_BYTE );  // T1tr*(F1*T1 + F2) , release buffer_F2
    memset( Qs->l1_Q5 , 0 , _O1_BYTE * N_TRIANGLE_TERMS(_O1) );
    UpperTrianglize( Qs->l1_Q5 , buffer_F3 , _O1, _O1_BYTE );                        // UT( ... )   // Q5 , release buffer_F3

/*
    F1_T2     = F1 * t2
    F2_T3     = F2 * t3
    F1_F1T_T2 + F2_T3 = F1_T2 + F2_T3 + F1tr * t2
    Q_pk.l1_F3s[i] =         F1_F1T_T2 + F2_T3
    Q_pk.l1_F6s[i] = T1tr* ( F1_F1T_T2 + F2_T3 ) + F2tr * t2
    Q_pk.l1_F9s[i] = UT( T2tr* ( F1_T2 + F2_T3 ) )
*/
    memset( Qs->l1_Q3 , 0 , _O1_BYTE * _V1 * _O2 );
    memset( Qs->l1_Q6 , 0 , _O1_BYTE * _O1 * _O2 );
    memset( Qs->l1_Q9 , 0 , _O1_BYTE * N_TRIANGLE_TERMS(_O2) );

    batch_trimat_madd( Qs->l1_Q3 , Fs->l1_F1 , t2 , _V1, _V1_BYTE , _O2, _O1_BYTE );        // F1*T2
    batch_mat_madd( Qs->l1_Q3 , Fs->l1_F2 , _V1, Ts->t3 , _O1, _O1_BYTE , _O2, _O1_BYTE );  // F1_T2 + F2_T3

    memset( buffer_F3 , 0 , _O1_BYTE * _V1 * _O2 );
    batch_matTr_madd( buffer_F3 , t2 , _V1, _V1_BYTE, _O2, Qs->l1_Q3, _O2, _O1_BYTE );    // T2tr *  ( F1_T2 + F2_T3 )
    UpperTrianglize( Qs->l1_Q9 , buffer_F3 , _O2 , _O1_BYTE );                            // Q9 , release buffer_F3

    batch_trimatTr_madd( Qs->l1_Q3 , Fs->l1_F1 , t2 , _V1, _V1_BYTE, _O2, _O1_BYTE );       // F1_F1T_T2 + F2_T3  // Q3

    batch_bmatTr_madd( Qs->l1_Q6 , Fs->l1_F2, _O1, t2, _V1, _V1_BYTE, _O2, _O1_BYTE );      // F2tr*T2
    batch_matTr_madd( Qs->l1_Q6 , Ts->t1, _V1, _V1_BYTE, _O1, Qs->l1_Q3, _O2, _O1_BYTE );   // Q6
/*
    Layer 2
    Computing Q9:

    F1_T2     = F1 * t2
    F2_T3     = F2 * t3
    Q9 = UT( T2tr*( F1*T2 + F2*T3 + F3 )  +  T3tr*( F5*T3 + F6 ) )
*/
#if _SIZE_BUFFER_F3 < _O2_BYTE * _V1 * _O2
error: incorrect buffer size.
#endif
    memcpy( buffer_F3 , Fs->l2_F3 , _O2_BYTE * _V1 * _O2 );
    batch_trimat_madd( buffer_F3 , Fs->l2_F1 , t2 , _V1, _V1_BYTE , _O2, _O2_BYTE );       // F1*T2 + F3
    batch_mat_madd( buffer_F3 , Fs->l2_F2 , _V1, Ts->t3 , _O1, _O1_BYTE , _O2, _O2_BYTE ); // F1_T2 + F2_T3 + F3

#if _SIZE_BUFFER_F2 < _O2_BYTE * _V1 * _O2
error: incorrect buffer size.
#endif
    memset( buffer_F2 , 0 , _O2_BYTE * _V1 * _O2 );
    batch_matTr_madd( buffer_F2 , t2 , _V1, _V1_BYTE, _O2, buffer_F3, _O2, _O2_BYTE );   // T2tr * ( ..... )  , release buffer_F3

#if _SIZE_BUFFER_F3 < _O2_BYTE*_O1*_O2
error: incorrect buffer size.
#endif
    memcpy( buffer_F3 , Fs->l2_F6 , _O2_BYTE * _O1 *_O2 );
    batch_trimat_madd( buffer_F3 , Fs->l2_F5 , Ts->t3 , _O1, _O1_BYTE, _O2, _O2_BYTE );     // F5*T3 + F6

    batch_matTr_madd( buffer_F2 , Ts->t3 , _O1, _O1_BYTE, _O2, buffer_F3, _O2, _O2_BYTE ); // T2tr*( ..... ) + T3tr*( ..... )
    memset( Qs->l2_Q9 , 0 , _O2_BYTE * N_TRIANGLE_TERMS(_O2) );
    UpperTrianglize( Qs->l2_Q9 , buffer_F2 , _O2 , _O2_BYTE );                              // Q9

    memset( buffer_F2 , 0 , _SIZE_BUFFER_F2 );
    memset( buffer_F3 , 0 , _SIZE_BUFFER_F2 );
}



///////////////////////////////////////////////////////////////////////


// Choosing implementations depends on the macros: _BLAS_SSE_ and _BLAS_AVX2_
#if defined(_BLAS_SSE_) || defined(_BLAS_AVX2_)
#include "rainbow_keypair_computation_simd.h"
#define calculate_Q_from_F_impl        calculate_Q_from_F_simd
#define calculate_F_from_Q_impl        calculate_F_from_Q_simd
#define calculate_Q_from_F_cyclic_impl calculate_Q_from_F_cyclic_simd
#else
#define calculate_Q_from_F_impl        calculate_Q_from_F_ref
#define calculate_F_from_Q_impl        calculate_F_from_Q_ref
#define calculate_Q_from_F_cyclic_impl calculate_Q_from_F_cyclic_ref
#endif



void calculate_Q_from_F( ext_cpk_t * Qs, const sk_t * Fs , const sk_t * Ts )
{
    calculate_Q_from_F_impl( Qs , Fs , Ts );
}

void calculate_F_from_Q( sk_t * Fs , const sk_t * Qs , sk_t * Ts )
{
    calculate_F_from_Q_impl( Fs , Qs , Ts );
}

void calculate_Q_from_F_cyclic( cpk_t * Qs, const sk_t * Fs , const sk_t * Ts )
{
    calculate_Q_from_F_cyclic_impl( Qs , Fs , Ts );
}


