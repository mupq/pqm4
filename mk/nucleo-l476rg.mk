# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
DEVICE=stm32l476rg
OPENCM3_TARGET=lib/stm32/l4

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/falcon-1024-tree% \
	crypto_sign/ov-Ip%

include mk/opencm3.mk
