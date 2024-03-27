# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
DEVICE=stm32l476rg
OPENCM3_TARGET=lib/stm32/l4

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/ov-Ip% \
	mupq/crypto_sign/falcon-1024-tree% \
	mupq/crypto_sign/snova-43-25-16-2-esk% \
	mupq/crypto_sign/snova-61-33-16-2-esk% \
	mupq/crypto_sign/snova-60-10-16-4-esk% \
	mupq/crypto_sign/snova-66-15-16-3-esk% \
	mupq/crypto_sign/snova-49-11-16-3-esk% \
	mupq/crypto_sign/snova-37-8-16-4-esk% \
	mupq/crypto_sign/meds55604% \
	mupq/crypto_sign/meds167717% \
	mupq/crypto_sign/meds134180% \
	mupq/crypto_sign/tuov% \
	crypto_sign/ov-Ip% \
	
include mk/opencm3.mk
