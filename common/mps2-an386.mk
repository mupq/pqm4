MPS2_DATA_IN_FLASH = 1
CROSS_PREFIX ?= arm-none-eabi
CC := $(CROSS_PREFIX)-gcc
CPP := $(CROSS_PREFIX)-cpp
AR := $(CROSS_PREFIX)-ar
LD := $(CC)
OBJCOPY := $(CROSS_PREFIX)-objcopy
SIZE := $(CROSS_PREFIX)-size

LDSCRIPT = obj/ldscript.ld

ARCH_FLAGS += -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

CFLAGS += \
	$(ARCH_FLAGS) \
	--specs=nano.specs \
	--specs=nosys.specs

LDFLAGS += \
	--specs=nano.specs \
	--specs=nosys.specs \
	-Wl,--wrap=_sbrk \
	-ffreestanding \
	-T$(LDSCRIPT) \
	$(ARCH_FLAGS)

LIBHAL_SRC := \
	common/mps2/startup_MPS2.S \
	common/hal-mps2.c

obj/libpqm4hal.a: $(call objs,$(LIBHAL_SRC))
obj/libpqm4hal.a: CFLAGS += -Icommon/mps2
$(LDSCRIPT): CPPFLAGS += $(if $(MPS2_DATA_IN_FLASH),-DDATA_IN_FLASH)
obj/common/mps2/startup_MPS2.S.o: CFLAGS += $(if $(MPS2_DATA_IN_FLASH),-DDATA_IN_FLASH)

LDLIBS += -lpqm4hal
LIBDEPS += obj/libpqm4hal.a

$(LDSCRIPT): common/mps2/MPS2.ld
	@printf "  GENLNK  $@\n"; \
	[ -d $(@D) ] || $(Q)mkdir -p $(@D); \
	arm-none-eabi-gcc -x assembler-with-cpp -E -Wp,-P $(CPPFLAGS) $< -o $@

$(LDSCRIPT): CFLAGS += -Icommon/mps2

LINKDEPS += $(LDSCRIPT) $(LIBDEPS)

ENABLE_QEMU_TESTS = 1
QEMU = qemu-system-arm
QEMUFLAGS = -M mps2-an386 -nographic -semihosting
