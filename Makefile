OPENCM3DIR  = ./libopencm3
OPENCM3NAME = opencm3_stm32f4
OPENCM3FILE = $(OPENCM3DIR)/lib/lib$(OPENCM3NAME).a
LDSCRIPT    = $(OPENCM3DIR)/lib/stm32/f4/stm32f405x6.ld

PREFIX     ?= arm-none-eabi
CC          = $(PREFIX)-gcc
LD          = $(PREFIX)-gcc
OBJCOPY     = $(PREFIX)-objcopy
OBJDUMP     = $(PREFIX)-objdump
GDB         = $(PREFIX)-gdb

ARCH_FLAGS  = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
DEFINES     = -DSTM32F4
OBJS        = obj/stm32f4_wrapper.o obj/fips202.o obj/keccakf1600.o obj/crypto_hash_sha512.o
RANDOMBYTES = obj/randombytes.o

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

OBJS_HOST  = obj-host/fips202.o obj-host/keccakf1600.o obj-host/crypto_hash_sha512.o

KEMLIBS=$(wildcard crypto_kem/*/*)
SIGNLIBS=$(wildcard crypto_sign/*/*)

# specifically select the ref implementations to use these as 'canonical'
# to prevent having duplicate targets, append _host
KEMLIBS_REF=$(wildcard crypto_kem/*/ref)
SIGNLIBS_REF=$(wildcard crypto_sign/*/ref)
KEMLIBS_M4=$(filter-out crypto_kem/%/ref, $(KEMLIBS))
SIGNLIBS_M4=$(filter-out crypto_sign/%/ref, $(SIGNLIBS))

KEMTESTS=$(patsubst %,bin/%,$(patsubst %,%_test.bin,$(subst /,_,$(KEMLIBS))))
SIGNTESTS=$(patsubst %,bin/%,$(patsubst %,%_test.bin,$(subst /,_,$(SIGNLIBS))))

KEMTESTVECTORS=$(patsubst %,bin/%,$(patsubst %,%_testvectors.bin,$(subst /,_,$(KEMLIBS))))
SIGNTESTVECTORS=$(patsubst %,bin/%,$(patsubst %,%_testvectors.bin,$(subst /,_,$(SIGNLIBS))))

# on the host, we are only interested in the reference implementations
KEMTESTVECTORS_HOST=$(patsubst %,bin-host/%,$(patsubst %,%_testvectors,$(subst /,_,$(KEMLIBS_REF))))
SIGNTESTVECTORS_HOST=$(patsubst %,bin-host/%,$(patsubst %,%_testvectors,$(subst /,_,$(SIGNLIBS_REF))))

KEMSPEEDS=$(patsubst %,bin/%,$(patsubst %,%_speed.bin,$(subst /,_,$(KEMLIBS))))
SIGNSPEEDS=$(patsubst %,bin/%,$(patsubst %,%_speed.bin,$(subst /,_,$(SIGNLIBS))))

KEMSTACK=$(patsubst %,bin/%,$(patsubst %,%_stack.bin,$(subst /,_,$(KEMLIBS))))
SIGNSTACK=$(patsubst %,bin/%,$(patsubst %,%_stack.bin,$(subst /,_,$(SIGNLIBS))))

OWNDIR=$(shell pwd)
INCPATH=$(OWNDIR)/common


all: tests testvectors speeds stack

libs: $(KEMLIBS_M4) $(SIGNLIBS_M4) $(KEMLIBS_REF) $(SIGNLIBS_REF)
tests: libs $(KEMTESTS) $(SIGNTESTS)
testvectors: libs $(KEMTESTVECTORS) $(SIGNTESTVECTORS) $(KEMTESTVECTORS_HOST) $(SIGNTESTVECTORS_HOST)
speeds: libs $(KEMSPEEDS) $(SIGNSPEEDS)
stack: libs $(KEMSTACK) $(SIGNSTACK)


.PHONY: force
export INCPATH

# TODO: currently the libraries are not rebuilt when a file changes in a scheme
#  but specifying `libs` as as a dependency of the .elfs causes everything to
#  be constantly rebuilt. Suggestions welcome how to fix this nicely.
# Currently the workaround is to `make clean` after modifying schemes.

$(KEMLIBS_M4): force
	make -C $@ libpqm4.a

$(SIGNLIBS_M4): force
	make -C $@ libpqm4.a

$(KEMLIBS_REF): force
	make -C $@ libpqm4.a
	make -C $@ libpqhost.a

$(SIGNLIBS_REF): force
	make -C $@ libpqm4.a
	make -C $@ libpqhost.a

bin-host/crypto_kem_%:  $(OBJS_HOST) obj-host/$(patsubst %,crypto_kem_%.o,%)
	mkdir -p bin-host
	$(LD_HOST) -o $@ \
	$(patsubst bin-host/%,obj-host/%.o,$@) \
	$(patsubst %testvectors,%libpqhost.a,$(patsubst bin-host/crypto/kem%,crypto_kem%,$(subst _,/,$@))) \
	$(OBJS_HOST) $(LDFLAGS_HOST) -lm

bin-host/crypto_sign_%:  $(OBJS_HOST) obj-host/$(patsubst %,crypto_sign_%.o,%)
	mkdir -p bin-host
	$(LD_HOST) -o $@ \
	$(patsubst bin-host/%,obj-host/%.o,$@) \
	$(patsubst %testvectors,%libpqhost.a,$(patsubst bin-host/crypto/sign%,crypto_sign%,$(subst _,/,$@))) \
	$(OBJS_HOST) $(LDFLAGS_HOST) -lm

bin/%.bin: elf/%.elf
	mkdir -p bin
	$(OBJCOPY) -Obinary $^ $@



elf/crypto_kem_%_test.elf: $(OBJS) $(RANDOMBYTES) $(LDSCRIPT) obj/$(patsubst %,crypto_kem_%_test.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %test.elf,%libpqm4.a,$(patsubst elf/crypto/kem%,crypto_kem/%,$(subst _,/,$@))) \
	$(OBJS) $(RANDOMBYTES) $(LDFLAGS) -l$(OPENCM3NAME) -lm


elf/crypto_sign_%_test.elf: $(OBJS) $(RANDOMBYTES) $(LDSCRIPT) obj/$(patsubst %,crypto_sign_%_test.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %test.elf,%libpqm4.a,$(patsubst elf/crypto/sign%,crypto_sign/%,$(subst _,/,$@))) \
	$(OBJS) $(RANDOMBYTES) $(LDFLAGS) -l$(OPENCM3NAME) -lm


elf/crypto_kem_%_testvectors.elf: $(OBJS) $(LDSCRIPT) obj/$(patsubst %,crypto_kem_%_testvectors.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %testvectors.elf,%libpqm4.a,$(patsubst elf/crypto/kem%,crypto_kem/%,$(subst _,/,$@))) \
	$(OBJS) $(LDFLAGS) -l$(OPENCM3NAME) -lm

elf/crypto_sign_%_testvectors.elf: $(OBJS) $(LDSCRIPT) obj/$(patsubst %,crypto_sign_%_testvectors.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %testvectors.elf,%libpqm4.a,$(patsubst elf/crypto/sign%,crypto_sign/%,$(subst _,/,$@))) \
	$(OBJS) $(LDFLAGS) -l$(OPENCM3NAME) -lm


elf/crypto_kem_%_speed.elf: $(OBJS) $(LDSCRIPT) obj/$(patsubst %,crypto_kem_%_speed.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %speed.elf,%libpqm4.a,$(patsubst elf/crypto/kem%,crypto_kem/%,$(subst _,/,$@))) \
	$(OBJS) $(RANDOMBYTES) $(LDFLAGS) -l$(OPENCM3NAME) -lm

elf/crypto_sign_%_speed.elf: $(OBJS) $(LDSCRIPT) obj/$(patsubst %,crypto_sign_%_speed.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %speed.elf,%libpqm4.a,$(patsubst elf/crypto/sign%,crypto_sign/%,$(subst _,/,$@))) \
	$(OBJS) $(RANDOMBYTES) $(LDFLAGS) -l$(OPENCM3NAME) -lm

elf/crypto_kem_%_stack.elf: $(OBJS) $(LDSCRIPT) $(RANDOMBYTES) obj/$(patsubst %,crypto_kem_%_stack.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %stack.elf,%libpqm4.a,$(patsubst elf/crypto/kem%,crypto_kem/%,$(subst _,/,$@))) \
	$(OBJS) $(RANDOMBYTES) $(LDFLAGS) -l$(OPENCM3NAME) -lm

elf/crypto_sign_%_stack.elf: $(OBJS) $(LDSCRIPT) $(RANDOMBYTES) obj/$(patsubst %,crypto_sign_%_stack.o,%) $(OPENCM3FILE)
	mkdir -p elf
	$(LD) -o $@ \
	$(patsubst elf/%.elf,obj/%.o,$@) \
	$(patsubst %stack.elf,%libpqm4.a,$(patsubst elf/crypto/sign%,crypto_sign/%,$(subst _,/,$@))) \
	$(OBJS) $(RANDOMBYTES) $(LDFLAGS) -l$(OPENCM3NAME) -lm


obj/crypto_kem_%_test.o: crypto_kem/test.c $(patsubst %,%/api.h,$(patsubst %,crypto_kem/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %test.o,%,$(patsubst obj/%,%,$(subst crypto/kem,crypto_kem,$(subst _,/,$@)))) \
	-I./common/

obj/crypto_sign_%_test.o: crypto_sign/test.c $(patsubst %,%/api.h,$(patsubst %,crypto_sign/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %test.o,%,$(patsubst obj/%,%,$(subst crypto/sign,crypto_sign,$(subst _,/,$@)))) \
	-I./common/


obj/crypto_kem_%_testvectors.o: crypto_kem/testvectors.c $(patsubst %,%/api.h,$(patsubst %,crypto_kem/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %testvectors.o,%,$(patsubst obj/%,%,$(subst crypto/kem,crypto_kem,$(subst _,/,$@)))) \
	-I./common/

obj/crypto_sign_%_testvectors.o: crypto_sign/testvectors.c $(patsubst %,%/api.h,$(patsubst %,crypto_sign/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %testvectors.o,%,$(patsubst obj/%,%,$(subst crypto/sign,crypto_sign,$(subst _,/,$@)))) \
	-I./common/

obj-host/crypto_kem_%_testvectors.o: crypto_kem/testvectors-host.c $(patsubst %,%/api.h,$(patsubst %,crypto_kem/%,$(subst _,/,$%)))
	mkdir -p obj-host
	$(CC_HOST) $(CFLAGS_HOST) -o $@ -c $< \
	-I$(patsubst %testvectors.o,%,$(patsubst obj-host/%,%,$(subst crypto/kem,crypto_kem,$(subst _,/,$@)))) \
	-I./common/

obj-host/crypto_sign_%_testvectors.o: crypto_sign/testvectors-host.c $(patsubst %,%/api.h,$(patsubst %,crypto_sign/%,$(subst _,/,$%)))
	mkdir -p obj-host
	$(CC_HOST) $(CFLAGS_HOST) -o $@ -c $< \
	-I$(patsubst %testvectors.o,%,$(patsubst obj-host/%,%,$(subst crypto/sign,crypto_sign,$(subst _,/,$@)))) \
	-I./common/


obj/crypto_kem_%_speed.o: crypto_kem/speed.c $(patsubst %,%/api.h,$(patsubst %,crypto_kem/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %speed.o,%,$(patsubst obj/%,%,$(subst crypto/kem,crypto_kem,$(subst _,/,$@)))) \
	-I./common/

obj/crypto_sign_%_speed.o: crypto_sign/speed.c $(patsubst %,%/api.h,$(patsubst %,crypto_sign/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %speed.o,%,$(patsubst obj/%,%,$(subst crypto/sign,crypto_sign,$(subst _,/,$@)))) \
	-I./common/

obj/crypto_kem_%_stack.o: crypto_kem/stack.c $(patsubst %,%/api.h,$(patsubst %,crypto_kem/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %stack.o,%,$(patsubst obj/%,%,$(subst crypto/kem,crypto_kem,$(subst _,/,$@)))) \
	-I./common/

obj/crypto_sign_%_stack.o: crypto_sign/stack.c $(patsubst %,%/api.h,$(patsubst %,crypto_sign/%,$(subst _,/,$%)))
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $< \
	-I$(patsubst %stack.o,%,$(patsubst obj/%,%,$(subst crypto/sign,crypto_sign,$(subst _,/,$@)))) \
	-I./common/


obj/randombytes.o: common/randombytes.c
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $^

obj/stm32f4_wrapper.o:  common/stm32f4_wrapper.c
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $^

obj/fips202.o:  common/fips202.c
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $^

obj/keccakf1600.o:  common/keccakf1600.S
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $^


obj/crypto_hash_sha512.o:  common/crypto_hash_sha512.c
	mkdir -p obj
	$(CC) $(CFLAGS) -o $@ -c $^

obj-host/%.o: common/%.c
	mkdir -p obj-host
	$(CC_HOST) $(CFLAGS_HOST) -o $@ -c $^

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
