PREFIX ?= arm-none-eabi
CC      = $(PREFIX)-gcc
LD      = $(PREFIX)-gcc
AR      = $(PREFIX)-ar
OBJCOPY = $(PREFIX)-objcopy

ARCH_FLAGS  = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
DEFINES     = -DEFM32GG11B820F2048GL192

INCLUDES    = -Iefm32-base/device/EFM32GG11B/Include \
              -Iefm32-base/cmsis/Include -Iefm32-base/emlib/inc

CFLAGS += -O3 \
          -Wall -Wextra -Wimplicit-function-declaration \
          -Wredundant-decls -Wmissing-prototypes -Wstrict-prototypes \
          -Wundef -Wshadow \
          -fno-common $(ARCH_FLAGS) -MD $(DEFINES) $(INCLUDES)

EFM32GG11BOBJ    = GCC/startup_efm32gg11b.o system_efm32gg11b.o
LIBEFM32GG11BOBJ = $(addprefix build/efm32-base/device/EFM32GG11B/Source/,$(EFM32GG11BOBJ))
LIBEFM32GG11B    = build/efm32-base/device/EFM32GG11B/libdevice.a

EMLIBSRC = $(wildcard efm32-base/emlib/src/*.c)
EMLIBOBJ = $(addprefix build/,$(EMLIBSRC:.c=.o))
EMLIB    = build/efm32-base/emlib/emlib.a

LDSCRIPT = efm32-base/device/EFM32GG11B/Source/GCC/efm32gg11b.ld
LDFLAGS  =  $(ARCH_FLAGS) -fno-builtin -ffunction-sections -fdata-sections \
           -fomit-frame-pointer -T$(LDSCRIPT) -lgcc -lc -lnosys\
		   $(LIBEFM32GG11B) $(EMLIB)

CC_HOST    = gcc
LD_HOST    = gcc

CFLAGS_HOST = -O3 -Wall -Wextra -Wpedantic
LDFLAGS_HOST = -lm

# override as desired
TYPE=kem

COMMONSOURCES=mupq/common/fips202.c mupq/common/sp800-185.c mupq/common/nistseedexpander.c
COMMONSOURCES_HOST=$(COMMONSOURCES) mupq/common/keccakf1600.c mupq/pqclean/common/aes.c mupq/pqclean/common/sha2.c
COMMONSOURCES_M4=$(COMMONSOURCES) common/keccakf1600.S mupq/common/aes.c common/aes.S mupq/common/sha2.c common/crypto_hashblocks_sha512.c common/crypto_hashblocks_sha512_inner32.s

COMMONINCLUDES=-I"mupq/common"
COMMONINCLUDES_M4=$(COMMONINCLUDES) -I"common"

RANDOMBYTES_M4=common/randombytes.c

DEST_HOST=bin-host
DEST=bin
TARGET_NAME = $(shell echo $(IMPLEMENTATION_PATH) | sed 's@/@_@g')
TYPE = $(shell echo $(IMPLEMENTATION_PATH) | sed 's@^\([^/]*/\)*crypto_\([^/]*\)/.*$$@\2@')
IMPLEMENTATION_SOURCES = $(wildcard $(IMPLEMENTATION_PATH)/*.c) $(wildcard $(IMPLEMENTATION_PATH)/*.s) $(wildcard $(IMPLEMENTATION_PATH)/*.S)
IMPLEMENTATION_HEADERS = $(IMPLEMENTATION_PATH)/*.h



.PHONY: all
all:
	@echo "Please use the scripts in this directory instead of using the Makefile"
	@echo
	@echo "If you really want to use it, please specify IMPLEMENTATION_PATH=path/to/impl"
	@echo "and a target binary, e.g.,"
	@echo "make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_test.bin"
	@echo "make clean also works"

$(DEST_HOST)/%_testvectors: $(COMMONSOURCES_HOST) $(IMPLEMENTATION_SOURCES) $(IMPLEMENTATION_HEADERS)
	mkdir -p $(DEST_HOST)
	$(CC_HOST) -o $@ \
		$(CFLAGS_HOST) -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE)\
		mupq/crypto_$(TYPE)/testvectors-host.c \
		$(COMMONSOURCES_HOST) \
		$(IMPLEMENTATION_SOURCES) \
		-I$(IMPLEMENTATION_PATH) \
		$(COMMONINCLUDES) \
		$(LDFLAGS_HOST)

$(DEST)/%.bin: elf/%.elf
	mkdir -p $(DEST)
	$(OBJCOPY) -Obinary $^ $@


elf/$(TARGET_NAME)_%.elf: mupq/crypto_$(TYPE)/%.c $(COMMONSOURCES_M4) $(RANDOMBYTES_M4) $(IMPLEMENTATION_SOURCES) $(IMPLEMENTATION_HEADERS) $(EMLIB) $(LIBEFM32GG11B) common/hal-efm32gg.c 
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE) \
		$< $(COMMONSOURCES_M4) $(RANDOMBYTES_M4) $(IMPLEMENTATION_SOURCES) common/hal-efm32gg.c \
		-I$(IMPLEMENTATION_PATH) $(COMMONINCLUDES_M4) $(LDFLAGS)


elf/$(TARGET_NAME)_testvectors.elf: mupq/crypto_$(TYPE)/testvectors.c $(COMMONSOURCES_M4) $(IMPLEMENTATION_SOURCES) $(IMPLEMENTATION_HEADERS) $(EMLIB) $(LIBEFM32GG11B) common/hal-efm32gg.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE)\
		$< $(COMMONSOURCES_M4) $(IMPLEMENTATION_SOURCES) common/hal-efm32gg.c \
		-I$(IMPLEMENTATION_PATH) $(COMMONINCLUDES_M4) $(LDFLAGS)

elf/$(TARGET_NAME)_hashing.elf: mupq/crypto_$(TYPE)/hashing.c $(COMMONSOURCES_M4) $(IMPLEMENTATION_SOURCES) $(IMPLEMENTATION_HEADERS) $(EMLIB) $(LIBEFM32GG11B) common/hal-efm32gg.c
	mkdir -p elf
	$(CC) -o $@ $(CFLAGS) -DPROFILE_HASHING -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE) \
		$< $(COMMONSOURCES_M4) $(RANDOMBYTES_M4) $(IMPLEMENTATION_SOURCES) common/hal-efm32gg.c \
		-I$(IMPLEMENTATION_PATH) $(COMMONINCLUDES_M4) $(LDFLAGS)

obj/$(TARGET_NAME)_%.o: $(IMPLEMENTATION_PATH)/%.c $(IMPLEMENTATION_HEADERS)
	mkdir -p obj
	$(CC) -o $@ -c $(CFLAGS) -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE) \
		-I$(IMPLEMENTATION_PATH) $(COMMONINCLUDES_M4) $<

obj/$(TARGET_NAME)_%.o: $(IMPLEMENTATION_PATH)/%.s $(IMPLEMENTATION_HEADERS)
	mkdir -p obj
	$(CC) -o $@ -c $(CFLAGS) -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE) \
		-I$(IMPLEMENTATION_PATH) $(COMMONINCLUDES_M4) $<

obj/$(TARGET_NAME)_%.o: $(IMPLEMENTATION_PATH)/%.S $(IMPLEMENTATION_HEADERS)
	mkdir -p obj
	$(CC) -o $@ -c $(CFLAGS) -DMUPQ_NAMESPACE=$(MUPQ_NAMESPACE) \
		-I$(IMPLEMENTATION_PATH) $(COMMONINCLUDES_M4) $<


$(EMLIB): $(EMLIBOBJ)
	$(AR) qc $@ $?

$(LIBEFM32GG11B): $(LIBEFM32GG11BOBJ)
	$(AR) qc $@ $?

build/%.o: %.S
	mkdir -p $(@D)
	$(CC) -o $@ -c $(CFLAGS) $<

build/%.o: %.c
	mkdir -p $(@D)
	$(CC) -o $@ -c $(CFLAGS) $<

.PHONY: clean libclean
clean:
	rm -rf elf/
	rm -rf bin/
	rm -rf bin-host/
	rm -rf obj/
	rm -rf testvectors/
	rm -rf benchmarks/

libclean:
	rm -rf build/
