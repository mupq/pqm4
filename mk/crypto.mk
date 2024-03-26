# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
SYMCRYPTO_SRC = \
	mupq/common/fips202.c \
	mupq/common/sp800-185.c \
	mupq/common/nistseedexpander.c \
	common/keccakf1600.S \
	common/aes.c \
	common/aes-encrypt.S \
	common/aes-keyschedule.S \
	common/aes-publicinputs.c \
	common/aes-publicinputs.S \
	mupq/common/sha2.c \
	common/crypto_hashblocks_sha512_inner32.s \
	common/crypto_hashblocks_sha512.c

obj/libsymcrypto.a: $(call objs,$(SYMCRYPTO_SRC))

obj/libsymcrypto-hashprof.a: CPPFLAGS+=-DPROFILE_HASHING
obj/libsymcrypto-hashprof.a: $(call hashprofobjs,$(SYMCRYPTO_SRC))

ifeq ($(AIO),1)
LDLIBS +=
LIBDEPS += $(SYMCRYPTO_SRC)
CPPFLAGS+=$(if $(PROFILE_HASHING),-DPROFILE_HASHING)
else
LDLIBS += -lsymcrypto$(if $(PROFILE_HASHING),-hashprof)
LIBDEPS += obj/libsymcrypto$(if $(PROFILE_HASHING),-hashprof).a
endif

