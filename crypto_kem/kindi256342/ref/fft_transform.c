#include "poly.h"

static void bitrev(poly_f r) {
	double t;
#if KINDI_KEM_N == 256
#include "data_fft/bitrev256.code"
#endif
#if KINDI_KEM_N == 512
#include "data_fft/bitrev512.code"
#endif
}

void fft_transform(poly_f out_real, poly_f out_img, const poly_f o_real,
		const poly_f o_img) {

	int s, m, i;

	bitrev(out_real);
	bitrev(out_img);

	double t_real = 0;
	double t_img = 0;

	double c_real = 0;
	double c_img = 0;

	for (m = 2; m <= KINDI_KEM_N; m = m * 2) {

		for (s = 0; s < KINDI_KEM_N; s += m) {

			for (i = 0; i < (m / 2); i++) {

				t_real = (o_real[i + (m / 2)] * out_real[s + i + (m / 2)])
				- (o_img[i + (m / 2)] * out_img[s + i + (m / 2)]);

				t_img = (o_real[i + (m / 2)] * out_img[s + i + (m / 2)])
				+ (o_img[i + (m / 2)] * out_real[s + i + (m / 2)]);

				c_real = out_real[s + i];
				c_img = out_img[s + i];

				out_real[s + i] = c_real + t_real;
				out_img[s + i] = c_img + t_img;
				out_real[s + i + (m / 2)] = c_real - t_real;
				out_img[s + i + (m / 2)] = c_img - t_img;
			}

		}

	}

}
