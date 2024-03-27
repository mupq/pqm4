# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
DEVICE=stm32f303rct7
OPENCM3_TARGET=lib/stm32/f3

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_sign/sphincs-shake-256f% \
	mupq/pqclean/crypto_sign/sphincs-sha2-256f% \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/falcon-1024% \
	mupq/crypto_sign/falcon-512% \
	mupq/crypto_sign/tuov_is% \
	mupq/crypto_sign/tuov_ip% \
	mupq/crypto_sign/tuov_iii% \
	mupq/crypto_sign/tuov_v% \
	mupq/crypto_sign/snova-43-25-16-2% \
	mupq/crypto_sign/snova-61-33-16-2% \
	mupq/crypto_sign/snova-25-8-16-3% \
	mupq/crypto_sign/snova-60-10-16-4% \
	mupq/crypto_sign/snova-66-15-16-3% \
	mupq/crypto_sign/snova-49-11-16-3% \
	mupq/crypto_sign/snova-28-17-16-2% \
	mupq/crypto_sign/snova-37-8-16-4% \
	mupq/crypto_sign/sphincs-a-sha2-256f% \
	mupq/crypto_sign/sphincs-a-shake-256f% \
	mupq/crypto_sign/ov-Ip% \
	mupq/crypto_sign/cross-sha2-r-sdp-5-small% \
	mupq/crypto_sign/cross-sha3-r-sdp-5-small% \
	mupq/crypto_sign/cross-sha2-r-sdp-5-fast% \
	mupq/crypto_sign/cross-sha3-r-sdp-5-fast% \
	mupq/crypto_sign/meds55604% \
	mupq/crypto_sign/meds41711% \
	mupq/crypto_sign/meds167717% \
	mupq/crypto_sign/meds134180% \
	mupq/crypto_sign/mirith_hypercube_Ia% \
	crypto_sign/falcon-1024% \
	crypto_sign/falcon-512% \
	crypto_sign/ov-Ip% \

include mk/opencm3.mk
