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
               $(ARCH_FLAGS) -L$(OPENCM3DIR)/lib

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
TYPE=kem
SCHEME=kyber768
IMPLEMENTATION=ref

COMMONFILES=common/fips202.c common/sha2.c common/aes.c common/rijndael.c
COMMONFILES_HOST=$(COMMONFILES) common/keccakf1600.c
COMMONFILES_M4=$(COMMONFILES) common/keccakf1600.S
RANDOMBYTES_M4=common/randombytes.c

DEST_HOST=bin-host
DEST=bin

all: bin/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors.bin \
	 bin/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_test.bin \
	 bin/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_speed.bin \
	 bin/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_stack.bin

$(DEST_HOST)/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors: $(COMMONFILES) $(COMMONFILES_HOST) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c
	mkdir -p $(DEST_HOST)
	$(CC_HOST) -o $@ $(CFLAGS_HOST) crypto_$(TYPE)/testvectors-host.c $(COMMONFILES) $(COMMONFILES_HOST) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) -Icommon $(LDFLAGS_HOST) -lm

$(DEST)/%.bin: elf/%.elf
	mkdir -p $(DEST)
	$(OBJCOPY) -Obinary $^ $@

elf/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_testvectors.elf: $(COMMONFILES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/stm32f4_wrapper.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) \
	crypto_$(TYPE)/testvectors.c $(COMMONFILES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/stm32f4_wrapper.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) -Icommon $(LDFLAGS) -lm -l$(OPENCM3NAME)

elf/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_speed.elf: $(COMMONFILES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/stm32f4_wrapper.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) \
	crypto_$(TYPE)/speed.c $(COMMONFILES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/stm32f4_wrapper.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) -Icommon $(LDFLAGS) -lm -l$(OPENCM3NAME)

elf/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_stack.elf: $(COMMONFILES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/stm32f4_wrapper.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) \
	crypto_$(TYPE)/stack.c $(COMMONFILES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/stm32f4_wrapper.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) -Icommon $(LDFLAGS) -lm -l$(OPENCM3NAME)

elf/crypto_$(TYPE)_$(SCHEME)_$(IMPLEMENTATION)_test.elf: $(COMMONFILES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c $(OPENCM3FILE) common/stm32f4_wrapper.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) \
	crypto_$(TYPE)/test.c $(COMMONFILES_M4) $(RANDOMBYTES_M4) crypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION)/*.c common/stm32f4_wrapper.c \
	-Icrypto_$(TYPE)/$(SCHEME)/$(IMPLEMENTATION) -Icommon $(LDFLAGS) -lm -l$(OPENCM3NAME)

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
