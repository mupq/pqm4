///  @file parallel_matrix_op.c
///  @brief the standard implementations for functions in parallel_matrix_op.h
///
///  the standard implementations for functions in parallel_matrix_op.h
///

#include "blas_comm.h"
#include "blas.h"

#include "parallel_matrix_op.h"
#include "rainbow_asm.h"

////////////////    Section: triangle matrix <-> rectangle matrix   ///////////////////////////////////


void UpperTrianglize( unsigned char * btriC , const unsigned char * bA , unsigned Awidth, unsigned size_batch )
{
    unsigned char * runningC = btriC;
    unsigned Aheight = Awidth;
    for(unsigned i=0;i<Aheight;i++) {
        for(unsigned j=0;j<i;j++) {
            unsigned idx = idx_of_trimat(j,i,Aheight);
            gf256v_add( btriC + idx*size_batch , bA + size_batch*(i*Awidth+j) , size_batch );
        }
        gf256v_add( runningC , bA + size_batch*(i*Awidth+i) , size_batch*(Aheight-i) );
        runningC += size_batch*(Aheight-i);
    }
}




/////////////////  Section: matrix multiplications  ///////////////////////////////



void batch_trimat_madd_gf16( unsigned char * bC , const unsigned char* btriA ,
        const unsigned char* B , unsigned Bheight, unsigned size_Bcolvec , unsigned Bwidth, unsigned size_batch )
{
    unsigned Awidth = Bheight;
    unsigned Aheight = Awidth;
    for(unsigned i=0;i<Aheight;i++) {
        for(unsigned j=0;j<Bwidth;j++) {
            gf16v_bitslice_asm(bC, size_batch>>4);
            for(unsigned k=0;k<Bheight;k++) {
                if(k<i) continue;
                gf16v_madd_u32_normal_bitsliced( bC , & btriA[ (k-i)*size_batch ] , gf16v_get_ele( &B[j*size_Bcolvec] , k ) , size_batch );
            }
            gf16v_bitslice_asm(bC, size_batch>>4);
            bC += size_batch;
        }
        btriA += (Aheight-i)*size_batch;
    }
}


void batch_trimatTr_madd_gf16( unsigned char * bC , const unsigned char* btriA ,
        const unsigned char* B , unsigned Bheight, unsigned size_Bcolvec , unsigned Bwidth, unsigned size_batch )
{
    unsigned Aheight = Bheight;
    for(unsigned i=0;i<Aheight;i++) {
        for(unsigned j=0;j<Bwidth;j++) {
            gf16v_bitslice_asm(bC, size_batch>>4);
            for(unsigned k=0;k<Bheight;k++) {
                if(i<k) continue;
                gf16v_madd_u32_normal_bitsliced( bC , & btriA[ size_batch*(idx_of_trimat(k,i,Aheight)) ] , gf16v_get_ele( &B[j*size_Bcolvec] , k ) , size_batch );
            }
            gf16v_bitslice_asm(bC, size_batch>>4);
            bC += size_batch;
        }
    }
}


void batch_2trimat_madd_gf16( unsigned char * bC , const unsigned char* btriA ,
        const unsigned char* B , unsigned Bheight, unsigned size_Bcolvec , unsigned Bwidth, unsigned size_batch )
{
    unsigned Aheight = Bheight;
    for(unsigned i=0;i<Aheight;i++) {
        for(unsigned j=0;j<Bwidth;j++) {
            gf16v_bitslice_asm(bC, size_batch>>4);
            for(unsigned k=0;k<Bheight;k++) {
                if(i==k) continue;
                gf16v_madd_u32_normal_bitsliced( bC , & btriA[ size_batch*(idx_of_2trimat(i,k,Aheight)) ] , gf16v_get_ele( &B[j*size_Bcolvec] , k ) , size_batch );
            }
            gf16v_bitslice_asm(bC, size_batch>>4);
            bC += size_batch;
        }
    }
}


void batch_matTr_madd_gf16( unsigned char * bC , const unsigned char* A_to_tr , unsigned Aheight, unsigned size_Acolvec, unsigned Awidth,
        const unsigned char* bB, unsigned Bwidth, unsigned size_batch )
{
    unsigned Atr_height = Awidth;
    unsigned Atr_width  = Aheight;
    for(unsigned i=0;i<Atr_height;i++) {
        gf16v_bitslice_asm(bC, (size_batch*Bwidth)>>4);
        for(unsigned j=0;j<Atr_width;j++) {
            gf16v_madd_u32_normal_bitsliced( bC , & bB[ j*Bwidth*size_batch ] , gf16v_get_ele( &A_to_tr[size_Acolvec*i] , j ) , size_batch*Bwidth );
        }
        gf16v_bitslice_asm(bC, (size_batch*Bwidth)>>4);
        bC += size_batch*Bwidth;
    }
}

void batch_bmatTr_madd_gf16( unsigned char *bC , const unsigned char *bA_to_tr, unsigned Awidth_before_tr,
        const unsigned char *B, unsigned Bheight, unsigned size_Bcolvec, unsigned Bwidth, unsigned size_batch )
{
    const unsigned char *bA = bA_to_tr;
    unsigned Aheight = Awidth_before_tr;
    for(unsigned i=0;i<Aheight;i++) {
        for(unsigned j=0;j<Bwidth;j++) {
            gf16v_bitslice_asm(bC, size_batch>>4);
            for(unsigned k=0;k<Bheight;k++) {
                gf16v_madd_u32_normal_bitsliced( bC , & bA[ size_batch*(i+k*Aheight) ] , gf16v_get_ele( &B[j*size_Bcolvec] , k ) , size_batch );
            }
            gf16v_bitslice_asm(bC, size_batch>>4);
            bC += size_batch;
        }
    }
}

void batch_mat_madd_gf16( unsigned char * bC , const unsigned char* bA , unsigned Aheight,
        const unsigned char* B , unsigned Bheight, unsigned size_Bcolvec , unsigned Bwidth, unsigned size_batch )
{
    unsigned Awidth = Bheight;
    for(unsigned i=0;i<Aheight;i++) {
        for(unsigned j=0;j<Bwidth;j++) {
            gf16v_bitslice_asm(bC, size_batch>>4);
            for(unsigned k=0;k<Bheight;k++) {
                gf16v_madd_u32_normal_bitsliced( bC , & bA[ k*size_batch ] , gf16v_get_ele( &B[j*size_Bcolvec] , k ) , size_batch );
            }
            gf16v_bitslice_asm(bC, size_batch>>4);
            bC += size_batch;
        }
        bA += (Awidth)*size_batch;
    }
}
