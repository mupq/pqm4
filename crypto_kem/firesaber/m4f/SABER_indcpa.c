#include <string.h>
#include <stdint.h>
#include "SABER_indcpa.h"
#include "poly.h"
#include "pack_unpack.h"
#include "randombytes.h"
#include "fips202.h"
#include "SABER_params.h"
#include "NTT.h"


const int root_table[64] = {2921358, -10203707, -1203107, 6577444, 1776511, -4194664, 5735629, 7301157, -4359117, 5669200, -9600669, 10575964, 8064557, -819256, -9084979, -7944926, 1686897, -588496, -8693794, -7460755, 2723061, -11637995, -4810496, 7146164, 4092287, -3261033, -5563113, -11307548, -7261676, -4293923, -6267356, -9567042, 11980428, 6931502, 2510833, 4034819, -1988985, -8060830, -10319196, -6726360, 10171507, 8693725, 647681, -9344183, 2733537, -42688, 10505644, -9502337, 10910265, 2695651, 11450840, -12030083, 5318976, -1134236, -614272, -6236460, -2559945, -908786, -2665284, 5184115, -1069349, -9233574, 12174351};
const int mul_table[64] = {-9600669, 9600669, 10575964, -10575964, 8064557, -8064557, -819256, 819256, -588496, 588496, -8693794, 8693794, -7460755, 7460755, 2723061, -2723061, 4092287, -4092287, -3261033, 3261033, -5563113, 5563113, -11307548, 11307548, -9567042, 9567042, 11980428, -11980428, 6931502, -6931502, 2510833, -2510833, -10319196, 10319196, -6726360, 6726360, 10171507, -10171507, 8693725, -8693725, -42688, 42688, 10505644, -10505644, -9502337, 9502337, 10910265, -10910265, 5318976, -5318976, -1134236, 1134236, -614272, 614272, -6236460, 6236460, 5184115, -5184115, -1069349, 1069349, -9233574, 9233574, 12174351, -12174351};
const int inv_root_table[65] = {2559945, 2665284, 908786, -12174351, 9233574, 1069349, -5184115, -2695651, 12030083, -11450840, 6236460, 614272, 1134236, -5318976, -647681, -2733537, 9344183, -10910265, 9502337, -10505644, 42688, -4034819, 8060830, 1988985, -8693725, -10171507, 6726360, 10319196, 7261676, 6267356, 4293923, -2510833, -6931502, -11980428, 9567042, 11637995, -7146164, 4810496, 11307548, 5563113, 3261033, -4092287, 9084979, -1686897, 7944926, -2723061, 7460755, 8693794, 588496, -7301157, -5669200, 4359117, 819256, -8064557, -10575964, 9600669, -11182464, 1203107, 10203707, -5735629, 4194664, -1776511, -6577444, 7689784, RmodM};


/*-----------------------------------------------------------------------------------
	This routine generates a=[Matrix K x K] of 256-coefficient polynomials
-------------------------------------------------------------------------------------*/

#define h1 4 //2^(EQ-EP-1)

#define h2 ( (1<<(SABER_EP-2)) - (1<<(SABER_EP-SABER_ET-1)) + (1<<(SABER_EQ-SABER_EP-1)) )

void InnerProd(uint16_t pkcl[SABER_K][SABER_N],uint16_t skpv[SABER_K][SABER_N],uint16_t mod,uint16_t res[SABER_N]);
void MatrixVectorMul(polyvec *a, uint16_t skpv[SABER_K][SABER_N], uint16_t res[SABER_K][SABER_N], uint16_t mod, int16_t transpose);

void POL2MSG(uint16_t *message_dec_unpacked, unsigned char *message_dec);

static void GenMatrix(polyvec *a, const unsigned char *seed)
{
  unsigned int one_vector=13*SABER_N/8;
  unsigned int byte_bank_length=SABER_K*SABER_K*one_vector;
  unsigned char buf[byte_bank_length];

  uint16_t temp_ar[SABER_N];

  int i,j,k;

  shake128(buf,byte_bank_length,seed,SABER_SEEDBYTES);

  for(i=0;i<SABER_K;i++)
  {
    for(j=0;j<SABER_K;j++)
    {
	BS2POL(buf+(i*SABER_K+j)*one_vector,temp_ar);
	for(k=0;k<SABER_N;k++){
		// a[i].vec[j].coeffs[k] = (temp_ar[k])& mod ;
		a[i].vec[j].coeffs[k] = (temp_ar[k]);
	}
    }
  }


}


void indcpa_kem_keypair(unsigned char *pk, unsigned char *sk)
{
  polyvec a[SABER_K];// skpv;

  uint16_t skpv[SABER_K][SABER_N];

  unsigned char seed[SABER_SEEDBYTES];
  unsigned char noiseseed[SABER_COINBYTES];
  int32_t i,j;
  uint16_t mod_q=SABER_Q-1;


  uint16_t res[SABER_K][SABER_N];

  randombytes(seed, SABER_SEEDBYTES);
  shake128(seed, SABER_SEEDBYTES, seed, SABER_SEEDBYTES); // for not revealing system RNG state
  randombytes(noiseseed, SABER_COINBYTES);

  GenMatrix(a, seed);	//sample matrix A

  GenSecret(skpv,noiseseed);//generate secret from constant-time binomial distribution

  //------------------------do the matrix vector multiplication and rounding------------

	for(i=0;i<SABER_K;i++){
		for(j=0;j<SABER_N;j++){
			res[i][j]=0;
		}
	}

	MatrixVectorMul(a,skpv,res,SABER_Q-1,1);

	//-----now rounding
	for(i=0;i<SABER_K;i++){ //shift right 3 bits
		for(j=0;j<SABER_N;j++){
			res[i][j]=(res[i][j] + h1) & (mod_q);
			res[i][j]=(res[i][j]>>(SABER_EQ-SABER_EP));
		}
	}

	//------------------unload and pack sk=3 x (256 coefficients of 14 bits)-------

	POLVEC2BS(sk, skpv, SABER_Q);

	//------------------unload and pack pk=256 bits seed and 3 x (256 coefficients of 11 bits)-------


	POLVEC2BS(pk, res, SABER_P); // load the public-key coefficients



	for(i=0;i<SABER_SEEDBYTES;i++){ // now load the seedbytes in PK. Easy since seed bytes are kept in byte format.
		pk[SABER_POLYVECCOMPRESSEDBYTES + i]=seed[i];
	}

}


void indcpa_kem_enc(unsigned char *message_received, unsigned char *noiseseed, const unsigned char *pk, unsigned char *ciphertext)
{
	uint32_t i,j,k;
	polyvec a[SABER_K];		// skpv;
	unsigned char seed[SABER_SEEDBYTES];
	uint16_t pkcl[SABER_K][SABER_N]; 	//public key of received by the client



	uint16_t skpv1[SABER_K][SABER_N];

	uint16_t message[SABER_KEYBYTES*8];

	uint16_t res[SABER_K][SABER_N];
	uint16_t mod_p=SABER_P-1;
	uint16_t mod_q=SABER_Q-1;

	uint16_t vprime[SABER_N];



	unsigned char msk_c[SABER_SCALEBYTES_KEM];

	for(i=0;i<SABER_SEEDBYTES;i++){ // extract the seedbytes from Public Key.
		seed[i]=pk[ SABER_POLYVECCOMPRESSEDBYTES + i];
	}

	GenMatrix(a, seed);

	GenSecret(skpv1,noiseseed);//generate secret from constant-time binomial distribution

	//-----------------matrix-vector multiplication and rounding

	for(i=0;i<SABER_K;i++){
		for(j=0;j<SABER_N;j++){
			res[i][j]=0;
		}
	}

	MatrixVectorMul(a,skpv1,res,SABER_Q-1,0);

	  //-----now rounding

	for(i=0;i<SABER_K;i++){ //shift right 3 bits
		for(j=0;j<SABER_N;j++){
			res[i][j]=( res[i][j]+ h1 ) & mod_q;
			res[i][j]=(res[i][j]>> (SABER_EQ-SABER_EP) );
		}
	}

	POLVEC2BS(ciphertext, res, SABER_P);

//*******************client matrix-vector multiplication ends************************************

	//------now calculate the v'

	//-------unpack the public_key

	//pkcl is the b in the protocol
	BS2POLVEC(pk,pkcl,SABER_P);



	for(i=0;i<SABER_N;i++)
		vprime[i]=0;

	for(i=0;i<SABER_K;i++){
		for(j=0;j<SABER_N;j++){
			skpv1[i][j]=skpv1[i][j] & (mod_p);
		}
	}

	// vector-vector scalar multiplication with mod p
	InnerProd(pkcl,skpv1,mod_p,vprime);

	//addition of h1 to vprime
	for(i=0;i<SABER_N;i++)
		vprime[i]=vprime[i]+h1;


	// unpack message_received;
	for(j=0; j<SABER_KEYBYTES; j++)
	{
		for(i=0; i<8; i++)
		{
			message[8*j+i] = ((message_received[j]>>i) & 0x01);
		}
	}

	// message encoding
	for(i=0; i<SABER_N; i++)
	{
		message[i] = (message[i]<<(SABER_EP-1));
	}




	for(k=0;k<SABER_N;k++)
	{
		vprime[k]=( (vprime[k] - message[k]) & (mod_p) )>>(SABER_EP-SABER_ET);
	}


	#if Saber_type == 1
		SABER_pack_3bit(msk_c, vprime);
	#elif Saber_type == 2
		SABER_pack_4bit(msk_c, vprime);
	#elif Saber_type == 3
		SABER_pack_6bit(msk_c, vprime);
	#endif


	for(j=0;j<SABER_SCALEBYTES_KEM;j++){
		ciphertext[SABER_POLYVECCOMPRESSEDBYTES + j] = msk_c[j];
	}
}


void indcpa_kem_dec(const unsigned char *sk, const unsigned char *ciphertext, unsigned char message_dec[])
{

	uint32_t i,j;


	uint16_t sksv[SABER_K][SABER_N]; //secret key of the server


	uint16_t pksv[SABER_K][SABER_N];

	uint8_t scale_ar[SABER_SCALEBYTES_KEM];

	uint16_t mod_p=SABER_P-1;

	uint16_t v[SABER_N];

	uint16_t op[SABER_N];


	BS2POLVEC(sk, sksv, SABER_Q); //sksv is the secret-key
	BS2POLVEC(ciphertext, pksv, SABER_P); //pksv is the ciphertext

	// vector-vector scalar multiplication with mod p
	for(i=0;i<SABER_N;i++)
		v[i]=0;

	for(i=0;i<SABER_K;i++){
		for(j=0;j<SABER_N;j++){
			sksv[i][j]=sksv[i][j] & (mod_p);
		}
	}

	InnerProd(pksv,sksv,mod_p,v);


	//Extraction
	for(i=0;i<SABER_SCALEBYTES_KEM;i++){
		scale_ar[i]=ciphertext[SABER_POLYVECCOMPRESSEDBYTES+i];
	}

	#if Saber_type == 1
		SABER_un_pack3bit(scale_ar, op);
	#elif Saber_type == 2
		SABER_un_pack4bit(scale_ar, op);
	#elif Saber_type == 3
		SABER_un_pack6bit(scale_ar, op);
	#endif


	//addition of h1
	for(i=0;i<SABER_N;i++){
		v[i]= ( ( v[i] + h2 - (op[i]<<(SABER_EP-SABER_ET)) ) & (mod_p) ) >> (SABER_EP-1);
	}

	// pack decrypted message

	POL2MSG(v, message_dec);


}

void MatrixVectorMul(polyvec *a, uint16_t skpv[SABER_K][SABER_N], uint16_t res[SABER_K][SABER_N], uint16_t mod, int16_t transpose){
	int matrix_temp[SABER_K][SABER_K][SABER_N];
	int vector_temp[SABER_K][SABER_N];
	int mul_out[SABER_K][SABER_N];

	// forward NTT
	NTT_forward(a[0].vec[0].coeffs, root_table, MOD, Mprime, &matrix_temp[0][0][0]);
	NTT_forward(a[0].vec[2].coeffs, root_table, MOD, Mprime, &matrix_temp[0][2][0]);
	NTT_forward(a[1].vec[0].coeffs, root_table, MOD, Mprime, &matrix_temp[1][0][0]);
	NTT_forward(a[1].vec[2].coeffs, root_table, MOD, Mprime, &matrix_temp[1][2][0]);
	NTT_forward(a[2].vec[0].coeffs, root_table, MOD, Mprime, &matrix_temp[2][0][0]);
	NTT_forward(a[2].vec[2].coeffs, root_table, MOD, Mprime, &matrix_temp[2][2][0]);
	NTT_forward(a[3].vec[0].coeffs, root_table, MOD, Mprime, &matrix_temp[3][0][0]);
	NTT_forward(a[3].vec[2].coeffs, root_table, MOD, Mprime, &matrix_temp[3][2][0]);
	NTT_forward(&skpv[0][0],  root_table, MOD, Mprime, &vector_temp[0][0]);
	NTT_forward(&skpv[2][0],  root_table, MOD, Mprime, &vector_temp[2][0]);

	// multiplication
	if (transpose == 1) {
		for(int j = 0; j < SABER_K; j++){
			my_mul(&vector_temp[0][0], mul_table, MOD, Mprime, &matrix_temp[0][j][0],
				&matrix_temp[1][j][0], &matrix_temp[2][j][0], &matrix_temp[3][j][0], &mul_out[j][0]);
		}
	} else {
		for(int j = 0; j < SABER_K; j++){
			my_mul(&vector_temp[0][0], mul_table, MOD, Mprime, &matrix_temp[j][0][0],
				&matrix_temp[j][1][0], &matrix_temp[j][2][0], &matrix_temp[j][3][0], &mul_out[j][0]);
		}
	}

	// inverse NTT
	NTT_inv(&mul_out[0][0], inv_root_table, MOD, Mprime, &res[0][0], mod);
	NTT_inv(&mul_out[2][0], inv_root_table, MOD, Mprime, &res[2][0], mod);
}

void POL2MSG(uint16_t *message_dec_unpacked, unsigned char *message_dec){

	int32_t i,j;

	for(j=0; j<SABER_KEYBYTES; j++)
	{
		message_dec[j] = 0;
		for(i=0; i<8; i++)
		message_dec[j] = message_dec[j] | (message_dec_unpacked[j*8 + i] <<i);
	}

}


void InnerProd(uint16_t pkcl[SABER_K][SABER_N],uint16_t skpv[SABER_K][SABER_N],uint16_t mod,uint16_t res[SABER_N]){
	int pkcl_temp[4][256];
	int skpv_temp[4][256];
	int res_temp[256];

	NTT_forward_pk(&pkcl[0][0], root_table, MOD, Mprime, &pkcl_temp[0][0]);
	NTT_forward_pk(&pkcl[2][0], root_table, MOD, Mprime, &pkcl_temp[2][0]);
	NTT_forward_pk(&skpv[0][0], root_table, MOD, Mprime, &skpv_temp[0][0]);
	NTT_forward_pk(&skpv[2][0], root_table, MOD, Mprime, &skpv_temp[2][0]);

	my_mul(&skpv_temp[0][0], mul_table, MOD, Mprime, &pkcl_temp[0][0],
		&pkcl_temp[1][0], &pkcl_temp[2][0], &pkcl_temp[3][0], &res_temp[0]);

	NTT_inv_inner(&res_temp[0], inv_root_table, MOD, Mprime, &res[0], mod);
}