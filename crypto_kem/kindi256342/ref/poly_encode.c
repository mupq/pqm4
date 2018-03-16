#include "poly.h"

#define MIN(a,b) ((a<b)? a :b)


// convert polynomial to byte-array with coefficients centered around 0
void poly_neg_tobytes_bitlen(unsigned char* b, const poly_d p, const int bitlen) {

	poly_d tmp;
	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		tmp[i] = p[i] + (1 << (bitlen - 1)); //make coefficients positive

	poly_tobytes_bitlen(b, tmp, bitlen);
}

// convert byte-array to polynomial with coefficients centered around 0
void poly_neg_frombytes_bitlen(poly_d p, const unsigned char* b,
		const int bitlen) {

	poly_d tmp;
	poly_frombytes_bitlen(tmp, b, bitlen);

	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		p[i] = tmp[i] - (1 << (bitlen - 1)); //center coefficients

}

//convert polynomial with positive coefficients to byte-array
void poly_tobytes_bitlen(unsigned char* b, const poly_d p, const int bitlen) {

	int i;

	switch (bitlen) {

	  case 2:

	      for (i = 0; i < KINDI_KEM_N / 4; i++)
	        b[i] = p[4 * i + 0] | (p[4 * i + 1] << 2) | (p[4 * i + 2] << 4)  | (p[4 * i + 3] << 6);

	      break;
	case 3:
		for (i = 0; i < KINDI_KEM_N / 8; i++) {

			b[3 * i + 0] = ((p[8 * i + 0] & 0x07) << 5)
					| ((p[8 * i + 1] & 0x07) << 2) | (p[8 * i + 2] >> 1);
			b[3 * i + 1] = ((p[8 * i + 2] & 0x01) << 7)
					| ((p[8 * i + 3] & 0x07) << 4)
					| ((p[8 * i + 4] & 0x07) << 1) | (p[8 * i + 5] >> 2);
			b[3 * i + 2] = ((p[8 * i + 5] & 0x03) << 6)
					| ((p[8 * i + 6] & 0x07) << 3) | p[8 * i + 7];
		}
		break;
	case 4:

		for (i = 0; i < KINDI_KEM_N / 2; i++)
			b[i] = p[2 * i + 0] | (p[2 * i + 1] << 4);

		break;

	case 8:
		for (i = 0; i < KINDI_KEM_N; i++)
			b[i] = p[i] & 0xff;

		break;

	case 12:

		for (i = 0; i < KINDI_KEM_N / 2; i++) {
			b[3 * i + 0] = p[2 * i + 0] & 0xff;
			b[3 * i + 1] = (p[2 * i + 0] >> 8) | ((p[2 * i + 1] & 0x0f) << 4);
			b[3 * i + 2] = p[2 * i + 1] >> 4;
		}

		break;

	case 13:

		for (i = 0; i < KINDI_KEM_N / 8; i++) {

			b[13 * i + 0] = p[8 * i + 0] & 0xff;
			b[13 * i + 1] = (p[8 * i + 0] >> 8) | ((p[8 * i + 1] & 0x07) << 5);
			b[13 * i + 2] = (p[8 * i + 1] >> 3) & 0xff;
			b[13 * i + 3] = (p[8 * i + 1] >> 11) | ((p[8 * i + 2] & 0x3f) << 2);
			b[13 * i + 4] = (p[8 * i + 2] >> 6) | ((p[8 * i + 3] & 0x01) << 7);
			b[13 * i + 5] = (p[8 * i + 3] >> 1) & 0xff;
			b[13 * i + 6] = (p[8 * i + 3] >> 9) | ((p[8 * i + 4] & 0x0f) << 4);
			b[13 * i + 7] = (p[8 * i + 4] >> 4) & 0xff;
			b[13 * i + 8] = (p[8 * i + 4] >> 12) | ((p[8 * i + 5] & 0x7f) << 1);
			b[13 * i + 9] = (p[8 * i + 5] >> 7) | ((p[8 * i + 6] & 0x03) << 6);
			b[13 * i + 10] = (p[8 * i + 6] >> 2) & 0xff;
			b[13 * i + 11] = (p[8 * i + 6] >> 10)
					| ((p[8 * i + 7] & 0x1f) << 3);
			b[13 * i + 12] = p[8 * i + 7] >> 5;
		}
		break;
	case 14:

		for (i = 0; i < KINDI_KEM_N / 4; i++) {

			b[7 * i + 0] = p[4 * i + 0] & 0xff;
			b[7 * i + 1] = (p[4 * i + 0] >> 8) | ((p[4 * i + 1] & 0x03) << 6);
			b[7 * i + 2] = (p[4 * i + 1] >> 2) & 0xff;
			b[7 * i + 3] = (p[4 * i + 1] >> 10) | ((p[4 * i + 2] & 0x0f) << 4);
			b[7 * i + 4] = (p[4 * i + 2] >> 4) & 0xff;
			b[7 * i + 5] = (p[4 * i + 2] >> 12) | ((p[4 * i + 3] & 0x3f) << 2);
			b[7 * i + 6] = p[4 * i + 3] >> 6;

		}
		break;
	case 15:

		for (i = 0; i < KINDI_KEM_N / 8; i++) {

			b[15 * i + 0] = p[8 * i + 0] & 0xff;
			b[15 * i + 1] = (p[8 * i + 0] >> 8) | ((p[8 * i + 1] & 0x01) << 7);
			b[15 * i + 2] = (p[8 * i + 1] >> 1) & 0xff;
			b[15 * i + 3] = (p[8 * i + 1] >> 9) | ((p[8 * i + 2] & 0x03) << 6);
			b[15 * i + 4] = (p[8 * i + 2] >> 2) & 0xff;
			b[15 * i + 5] = (p[8 * i + 2] >> 10) | ((p[8 * i + 3] & 0x07) << 5);
			b[15 * i + 6] = (p[8 * i + 3] >> 3) & 0xff;
			b[15 * i + 7] = (p[8 * i + 3] >> 11) | ((p[8 * i + 4] & 0x0f) << 4);
			b[15 * i + 8] = (p[8 * i + 4] >> 4) & 0xff;
			b[15 * i + 9] = (p[8 * i + 4] >> 12) | ((p[8 * i + 5] & 0x1f) << 3);
			b[15 * i + 10] = (p[8 * i + 5] >> 5) & 0xff;
			b[15 * i + 11] = (p[8 * i + 5] >> 13)
					| ((p[8 * i + 6] & 0x3f) << 2);
			b[15 * i + 12] = (p[8 * i + 6] >> 6) & 0xff;
			b[15 * i + 13] = (p[8 * i + 6] >> 14)
					| ((p[8 * i + 7] & 0x7f) << 1);
			b[15 * i + 14] = (p[8 * i + 7] >> 7) & 0xff;

		}
		break;
	case 16:

		for (i = 0; i < KINDI_KEM_N; i++) {

			b[2 * i + 0] = p[i] & 0xff;
			b[2 * i + 1] = p[i] >> 8;
		}
		break;
	}
}

//convert byte-array to polynomial with positive coefficients
void poly_frombytes_bitlen(poly_d p, const unsigned char* b, const int bitlen) {

	int i;
	uint8_t tmp;
	switch (bitlen) {

	case 2:
	      for (i = 0; i < KINDI_KEM_N / 4; i++) {
	        tmp = b[i];
	        p[4 * i + 0] = tmp & 0x03;
	        p[4 * i + 1] = (tmp >> 2) & 0x03;
	        p[4 * i + 2] = (tmp >> 4) & 0x03;
	        p[4 * i + 3] = tmp >> 6;
	      }
	      break;

	case 3:

		for (i = 0; i < KINDI_KEM_N / 8; i++) {
			tmp = b[3 * i + 0];
			p[8 * i + 0] = (tmp >> 5) & 0x07;
			p[8 * i + 1] = (tmp >> 2) & 0x07;
			p[8 * i + 2] = (tmp & 0x03) << 1;
			tmp = b[3 * i + 1];
			p[8 * i + 2] |= (tmp >> 7) & 0x01;
			p[8 * i + 3] = (tmp >> 4) & 0x07;
			p[8 * i + 4] = (tmp >> 1) & 0x07;
			p[8 * i + 5] = (tmp & 0x01) << 2;
			tmp = b[3 * i + 2];
			p[8 * i + 5] |= (tmp >> 6) & 0x03;
			p[8 * i + 6] = (tmp >> 3) & 0x07;
			p[8 * i + 7] = tmp & 0x07;
		}
		break;

	case 4:
		for (i = 0; i < KINDI_KEM_N / 2; i++) {
			tmp = b[i];
			p[2 * i + 0] = tmp & 0x0f;
			p[2 * i + 1] = tmp >> 4;
		}
		break;

	case 8:
		for (i = 0; i < KINDI_KEM_N; i++)
			p[i] = b[i];
		break;

	case 12:

		for (i = 0; i < KINDI_KEM_N / 2; i++) {

			p[2 * i + 0] = b[3 * i + 0]
					| (((uint64_t) b[3 * i + 1] & 0x0f) << 8);
			p[2 * i + 1] = (b[3 * i + 1] >> 4)
					| (((uint64_t) b[3 * i + 2]) << 4);

		}
		break;

	case 13:
		for (i = 0; i < KINDI_KEM_N / 8; i++) {

			p[8 * i + 0] = b[13 * i + 0]
					| (((uint64_t) b[13 * i + 1] & 0x1f) << 8);
			p[8 * i + 1] = (b[13 * i + 1] >> 5)
					| ((uint64_t) b[13 * i + 2] << 3)
					| (((uint64_t) b[13 * i + 3] & 0x03) << 11);
			p[8 * i + 2] = (b[13 * i + 3] >> 2)
					| (((uint64_t) b[13 * i + 4] & 0x7f) << 6);
			p[8 * i + 3] = (b[13 * i + 4] >> 7)
					| ((uint64_t) b[13 * i + 5] << 1)
					| (((uint64_t) b[13 * i + 6] & 0x0f) << 9);
			p[8 * i + 4] = (b[13 * i + 6] >> 4)
					| ((uint64_t) b[13 * i + 7] << 4)
					| (((uint64_t) b[13 * i + 8] & 0x01) << 12);
			p[8 * i + 5] = (b[13 * i + 8] >> 1)
					| (((uint64_t) b[13 * i + 9] & 0x3f) << 7);
			p[8 * i + 6] = (b[13 * i + 9] >> 6)
					| ((uint64_t) b[13 * i + 10] << 2)
					| (((uint64_t) b[13 * i + 11] & 0x07) << 10);
			p[8 * i + 7] = (b[13 * i + 11] >> 3)
					| ((uint64_t) b[13 * i + 12] << 5);

		}
		break;

	case 14:
		for (i = 0; i < KINDI_KEM_N / 4; i++) {

			p[4 * i + 0] = b[7 * i + 0]
					| (((uint64_t) b[7 * i + 1] & 0x3f) << 8);
			p[4 * i + 1] = (b[7 * i + 1] >> 6)
					| (((uint64_t) b[7 * i + 2]) << 2)
					| (((uint64_t) b[7 * i + 3] & 0x0f) << 10);
			p[4 * i + 2] = (b[7 * i + 3] >> 4) | ((uint64_t) b[7 * i + 4] << 4)
					| (((uint64_t) b[7 * i + 5] & 0x03) << 12);
			p[4 * i + 3] = (b[7 * i + 5] >> 2) | ((uint64_t) b[7 * i + 6] << 6);
		}
		break;

	case 15:
		for (i = 0; i < KINDI_KEM_N / 8; i++) {

			p[8 * i + 0] = b[15 * i + 0]
					| (((uint64_t) b[15 * i + 1] & 0x7f) << 8);
			p[8 * i + 1] = (b[15 * i + 1] >> 7)
					| ((uint64_t) b[15 * i + 2] << 1)
					| (((uint64_t) b[15 * i + 3] & 0x3f) << 9);
			p[8 * i + 2] = (b[15 * i + 3] >> 6)
					| ((uint64_t) b[15 * i + 4] << 2)
					| (((uint64_t) b[15 * i + 5] & 0x1f) << 10);
			p[8 * i + 3] = (b[15 * i + 5] >> 5)
					| ((uint64_t) b[15 * i + 6] << 3)
					| (((uint64_t) b[15 * i + 7] & 0x0f) << 11);
			p[8 * i + 4] = (b[15 * i + 7] >> 4)
					| ((uint64_t) b[15 * i + 8] << 4)
					| (((uint64_t) b[15 * i + 9] & 0x07) << 12);
			p[8 * i + 5] = (b[15 * i + 9] >> 3)
					| ((uint64_t) b[15 * i + 10] << 5)
					| (((uint64_t) b[15 * i + 11] & 0x03) << 13);
			p[8 * i + 6] = (b[15 * i + 11] >> 2)
					| ((uint64_t) b[15 * i + 12] << 6)
					| (((uint64_t) b[15 * i + 13] & 0x01) << 14);
			p[8 * i + 7] = (b[15 * i + 13] >> 1)
					| ((uint64_t) b[15 * i + 14] << 7);

		}
		break;
	case 16:
		for (i = 0; i < KINDI_KEM_N; i++)
			p[i] = b[2 * i + 0] | ((uint64_t) b[2 * i + 1] << 8);
		break;

	}

}
