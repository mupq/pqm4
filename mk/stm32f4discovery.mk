# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
DEVICE=stm32f407vg
OPENCM3_TARGET=lib/stm32/f4

EXCLUDED_SCHEMES = \
	mupq/pqclean/crypto_kem/mceliece% \
	mupq/crypto_sign/tuov% \
	mupq/crypto_sign/ov-Ip% \
	mupq/crypto_sign/snova-43-25-16-2-esk% \
	mupq/crypto_sign/snova-61-33-16-2-esk% \
	mupq/crypto_sign/snova-60-10-16-4-esk% \
	mupq/crypto_sign/snova-66-15-16-3-esk% \
	mupq/crypto_sign/snova-49-11-16-3-esk% \
	mupq/crypto_sign/snova-37-8-16-4-esk% \
	mupq/crypto_sign/meds55604% \
	mupq/crypto_sign/meds167717% \
	mupq/crypto_sign/meds134180% \
	crypto_sign/ov-Ip% \
	mupq/crypto_sign/falcon-1024-tree%

include mk/opencm3.mk

elf/boardtest.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_CCM
elf/boardtest-fast.elf: CPPFLAGS+=-DSRAM_TIMING_TEST -DHAS_SRAM2 -DHAS_CCM

elf/crypto_kem_frodokem640aes_m4_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/mupq_pqclean_crypto_kem_frodokem640shake_opt_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/crypto_sign_dilithium5_m4f_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/crypto_sign_perk-256-%_m4_testvectors.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/crypto_sign_perk-256-fast%_m4_test.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/crypto_sign_haetae5_m4f_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
elf/crypto_sign_haetae5_ref_%.elf: LDSCRIPT=ldscripts/stm32f4discovery_fullram.ld
