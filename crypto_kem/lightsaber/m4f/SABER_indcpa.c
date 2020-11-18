#include <string.h>
#include <stdint.h>
#include "SABER_indcpa.h"
#include "poly.h"
#include "pack_unpack.h"
#include "randombytes.h"
#include "fips202.h"
#include "SABER_params.h"
#include "NTT.h"


const int mul_table[64] = {9259893, -9259893, 7725652, -7725652, -741305, 741305, 5430861, -5430861, 8941483, -8941483, -1904165, 1904165, -1510590, 1510590, 4179776, -4179776, 1087096, -1087096, 5477510, -5477510, 4288247, -4288247, -4589585, 4589585, 4406378, -4406378, -962293, 962293, -4903106, 4903106, -3217734, 3217734, -4768008, 4768008, -10114282, 10114282, -1582389, 1582389, -9352320, 9352320, 2044676, -2044676, -1889742, 1889742, -3496807, 3496807, -5815793, 5815793, -1035446, 1035446, 8431160, -8431160, 563090, -563090, -4899008, 4899008, 9979851, -9979851, -8135419, 8135419, -3075030, 3075030, 7867132, -7867132};
const int root_table[64] = {1126591, -5474819, -547396, -5772959, 4437632, 2009459, -8766387, 5132106, -9595122, -3921010, 9259893, 7725652, -741305, 5430861, -3392653, 6496586, -9784786, 8941483, -1904165, -1510590, 4179776, 3590343, -8974179, 1102780, 1087096, 5477510, 4288247, -4589585, -245695, 1446745, -440588, 4406378, -962293, -4903106, -3217734, 9479185, 710543, 7712526, -4768008, -10114282, -1582389, -9352320, 1213433, -9241782, -4253525, 2044676, -1889742, -3496807, -5815793, -2968645, -8075200, 9346672, -1035446, 8431160, 563090, -4899008, -5531124, 8159833, 1229943, 9979851, -8135419, -3075030, 7867132};
const int inv_root_table[65] = {5531124, -1229943, -8159833, -7867132, 3075030, 8135419, -9979851, 2968645, -9346672, 8075200, 4899008, -563090, -8431160, 1035446, -1213433, 4253525, 9241782, 5815793, 3496807, 1889742, -2044676, -9479185, -7712526, -710543, 9352320, 1582389, 10114282, 4768008, 245695, 440588, -1446745, 3217734, 4903106, 962293, -4406378, -3590343, -1102780, 8974179, 4589585, -4288247, -5477510, -1087096, 3392653, 9784786, -6496586, -4179776, 1510590, 1904165, -8941483, -5132106, 3921010, 9595122, -5430861, 741305, -7725652, -9259893, -179895, 547396, 5474819, 8766387, -2009459, -4437632, 5772959, 8870406, RmodM};


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
	for(int i = 0; i < SABER_K; i++){
		NTT_forward(a[i].vec[0].coeffs, root_table, MOD, Mprime, &matrix_temp[i][0][0]);
	}
	NTT_forward(&skpv[0][0],  root_table, MOD, Mprime, &vector_temp[0][0]);

	// multiplication
	if (transpose == 1) {
		for(int j = 0; j < SABER_K; j++){
			my_mul(&vector_temp[0][0], mul_table, MOD, Mprime, &matrix_temp[0][j][0],
				   &matrix_temp[1][j][0], &mul_out[j][0]);
		}
	} else {
		for(int j = 0; j < SABER_K; j++){
			my_mul(&vector_temp[0][0], mul_table, MOD, Mprime, &matrix_temp[j][0][0],
				   &matrix_temp[j][1][0], &mul_out[j][0]);
		}
	}

	// inverse NTT
	NTT_inv(&mul_out[0][0], inv_root_table, MOD, Mprime, &res[0][0], mod);
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

	int pkcl_temp[SABER_K][SABER_N];
	int skpv_temp[SABER_K][SABER_N];
	int res_temp[SABER_N];

	NTT_forward_pk(&pkcl[0][0], root_table, MOD, Mprime, &pkcl_temp[0][0]);
	NTT_forward_pk(&skpv[0][0],  root_table, MOD, Mprime, &skpv_temp[0][0]);

	my_mul(&skpv_temp[0][0], mul_table, MOD, Mprime, &pkcl_temp[0][0],
		   &pkcl_temp[1][0], &res_temp[0]);

	NTT_inv_inner(&res_temp[0], inv_root_table, MOD, Mprime, &res[0], mod);
}
