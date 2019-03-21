OPENCM3DIR  = ./libopencm3
OPENCM3NAME = opencm3_stm32f4
OPENCM3FILE = $(OPENCM3DIR)/lib/lib$(OPENCM3NAME).a
LDSCRIPT    = stm32f405x6.ld

PREFIX     ?= arm-none-eabi
CC          = $(PREFIX)-gcc
LD          = $(PREFIX)-gcc
OBJCOPY     = $(PREFIX)-objcopy

ARCH_FLAGS  = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
DEFINES     = -DSTM32F4

CFLAGS     += -O3 \
              -Wall -Wextra -Wimplicit-function-declaration \
              -Wredundant-decls -Wmissing-prototypes -Wstrict-prototypes \
              -Wundef -Wshadow \
              -I$(OPENCM3DIR)/include \
              -fno-common $(ARCH_FLAGS) -MD $(DEFINES)
LDFLAGS    += --static -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group \
              -T$(LDSCRIPT) -nostartfiles -Wl,--gc-sections \
               $(ARCH_FLAGS) -L$(OPENCM3DIR)/lib -lm -l$(OPENCM3NAME)

CC_HOST    = gcc
LD_HOST    = gcc

CFLAGS_HOST = -O3 -Wall -Wextra -Wpedantic
LDFLAGS_HOST =


# TODO this does not work as desired, as it blocks 'make clean'
# ifndef TYPE
# $(error Please supply a TYPE (i.e. kem or sign))
# endif
# ifndef SCHEME
# $(error Please supply a SCHEME (e.g. 'kyber768'))
# endif
# ifndef IMPLEMENTATION
# $(error Please supply a IMPLEMENTATION (e.g. 'ref'))
# endif

# override as desired
PROJECT=pqm4
TYPE=kem
SCHEME=kyber768
IMPLEMENTATION=ref

COMMONSOURCES=mupq/common/fips202.c mupq/common/sha2.c mupq/common/aes.c mupq/common/rijndael.c
COMMONSOURCES_HOST=$(COMMONSOURCES) mupq/common/keccakf1600.c
COMMONSOURCES_M4=$(COMMONSOURCES) common/keccakf1600.S

COMMONINCLUDES=-I"mupq/common"
COMMONINCLUDES_M4=$(COMMONINCLUDES) -I"common"

RANDOMBYTES_M4=common/randombytes.c

DEST_HOST=bin-host
DEST=bin

all: $(DEST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors.bin \
	 $(DEST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_test.bin \
	 $(DEST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_speed.bin \
	 $(DEST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_stack.bin \
	 $(DEST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_hashing.bin \
	 $(DEST_HOST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors

$(DEST_HOST)/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors: $(COMMONSOURCES_HOST) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c
	mkdir -p $(DEST_HOST)
	$(CC_HOST) -o $@ $(CFLAGS_HOST) crypto_$(TYPE)/testvectors-host.c $(COMMONSOURCES_HOST) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) $(COMMONINCLUDES) $(LDFLAGS_HOST) -lm

$(DEST)/%.bin: elf/%.elf
	mkdir -p $(DEST)
	$(OBJCOPY) -Obinary $^ $@

# pattern rules, intended to match % to the type of test (i.e. test, speed, stack)
# note that this excludes testvectors, as that is a special case that provides its own randombytes
# TODO use notrandombytes more generically rather than included in testvectors.c
elf/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_%.elf: $(COMMONSOURCES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/hal-stm32f4.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) \
	crypto_$(TYPE)/$*.c $(COMMONSOURCES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/hal-stm32f4.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) $(COMMONINCLUDES_M4) $(LDFLAGS)

elf/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors.elf: $(COMMONSOURCES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/hal-stm32f4.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) \
	crypto_$(TYPE)/testvectors.c $(COMMONSOURCES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/hal-stm32f4.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) $(COMMONINCLUDES_M4) $(LDFLAGS)

elf/$(PROJECT)_crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_hashing.elf: $(COMMONSOURCES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/hal-stm32f4.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) -DPROFILE_HASHING \
	crypto_$(TYPE)/hashing.c $(COMMONSOURCES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/hal-stm32f4.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) $(COMMONINCLUDES_M4) $(LDFLAGS)

$(OPENCM3FILE):
	@if [ ! "`ls -A $(OPENCM3_DIR)`" ] ; then \
		printf "######## ERROR ########\n"; \
		printf "\tlibopencm3 is not initialized.\n"; \
		printf "\tPlease run (in the root directory):\n"; \
		printf "\t$$ git submodule init\n"; \
		printf "\t$$ git submodule update\n"; \
		printf "\tbefore running make.\n"; \
		printf "######## ERROR ########\n"; \
		exit 1; \
		fi
	make -C $(OPENCM3DIR)

.PHONY: clean libclean

clean:
	find . -name \*.o -type f -exec rm -f {} \;
	find . -name \*.d -type f -exec rm -f {} \;
	find crypto_kem -name \*.a -type f -exec rm -f {} \;
	find crypto_sign -name \*.a -type f -exec rm -f {} \;
	rm -rf elf/
	rm -rf bin/
	rm -rf bin-host/
	rm -rf obj/
	rm -rf obj-host/
	rm -rf testvectors/
	rm -rf benchmarks/

libclean:
	make -C $(OPENCM3DIR) clean
