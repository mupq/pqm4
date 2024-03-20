# SPDX-License-Identifier: Apache-2.0 or CC0-1.0
LIBHAL_SRC := \
	common/hal-opencm3.c \
	common/randombytes.c

obj/libpqm4hal.a: $(call objs,$(LIBHAL_SRC))
obj/libpqm4hal-nornd.a: $(call objs,$(filter-out common/randombytes.c,$(LIBHAL_SRC)))

ifeq ($(AIO),1)
LDLIBS +=
LIBDEPS += $(if $(NO_RANDOMBYTES),$(filter-out common/randombytes.c,$(LIBHAL_SRC)),$(LIBHAL_SRC))
else
LDLIBS += -lpqm4hal$(if $(NO_RANDOMBYTES),-nornd)
LIBDEPS += obj/libpqm4hal$(if $(NO_RANDOMBYTES),-nornd).a
endif

LDLIBS += -lc -lgcc

export OPENCM3_DIR := $(CURDIR)/libopencm3

_git_submodule_update_opencm3 := $(shell git submodule update --init --recursive $(OPENCM3_DIR))

ifeq ($(DEVICE),)
$(warning no DEVICE specified for linker script generator)
endif

DEVICES_DATA ?= $(OPENCM3_DIR)/ld/devices.data

genlink_family		:=$(shell $(OPENCM3_DIR)/scripts/genlink.py $(DEVICES_DATA) $(DEVICE) FAMILY)
genlink_subfamily	:=$(shell $(OPENCM3_DIR)/scripts/genlink.py $(DEVICES_DATA) $(DEVICE) SUBFAMILY)
genlink_cpu		:=$(shell $(OPENCM3_DIR)/scripts/genlink.py $(DEVICES_DATA) $(DEVICE) CPU)
genlink_fpu		:=$(shell $(OPENCM3_DIR)/scripts/genlink.py $(DEVICES_DATA) $(DEVICE) FPU)
genlink_cppflags	:=$(shell $(OPENCM3_DIR)/scripts/genlink.py $(DEVICES_DATA) $(DEVICE) CPPFLAGS)

ifeq ($(genlink_family),)
$(warning $(DEVICE) not found in $(DEVICES_DATA))
endif

CPPFLAGS	+= $(genlink_cppflags)

ARCH_FLAGS	:=-mcpu=$(genlink_cpu)
ifeq ($(genlink_cpu),$(filter $(genlink_cpu),cortex-m0 cortex-m0plus cortex-m3 cortex-m4 cortex-m7))
ARCH_FLAGS    +=-mthumb
endif

ifeq ($(genlink_fpu),soft)
ARCH_FLAGS	+= -msoft-float
else ifeq ($(genlink_fpu),hard-fpv4-sp-d16)
ARCH_FLAGS	+= -mfloat-abi=hard -mfpu=fpv4-sp-d16
else ifeq ($(genlink_fpu),hard-fpv5-sp-d16)
ARCH_FLAGS      += -mfloat-abi=hard -mfpu=fpv5-sp-d16
else
$(warning No match for the FPU flags)
endif

LIBNAME = opencm3_$(genlink_family)

LDLIBS += -l$(LIBNAME)
LIBDEPS += $(OPENCM3_DIR)/lib/lib$(LIBNAME).a

LDFLAGS += -L$(OPENCM3_DIR)/lib
CPPFLAGS += -I$(OPENCM3_DIR)/include

$(OPENCM3_DIR)/lib/lib$(LIBNAME).a:
	$(MAKE) -C $(OPENCM3_DIR) $(OPENCM3_TARGET)

obj/common/hal-opencm3.c.o: $(OPENCM3_DIR)/lib/lib$(LIBNAME).a

ifeq ($(wildcard ldscripts/$(PLATFORM).ld),)
LDSCRIPT = obj/generated.$(DEVICE).ld
$(LDSCRIPT): $(OPENCM3_DIR)/ld/linker.ld.S $(OPENCM3_DIR)/ld/devices.data $(CONFIG)
	@printf "  GENLNK  $(DEVICE)\n"
	$(Q)mkdir -p $(@D)
	$(Q)$(CPP) $(ARCH_FLAGS) $(shell $(OPENCM3_DIR)/scripts/genlink.py $(DEVICES_DATA) $(DEVICE) DEFS) -P -E $< -o $@
else
LDSCRIPT = ldscripts/$(PLATFORM).ld
endif

CROSS_PREFIX ?= arm-none-eabi
CC := $(CROSS_PREFIX)-gcc
CPP := $(CROSS_PREFIX)-cpp
AR := $(CROSS_PREFIX)-gcc-ar
LD := $(CC)
OBJCOPY := $(CROSS_PREFIX)-objcopy
SIZE := $(CROSS_PREFIX)-size

CFLAGS += \
	$(ARCH_FLAGS) \

LDFLAGS += \
	--specs=nosys.specs \
	-Wl,--wrap=_sbrk \
	-Wl,--wrap=_close \
	-Wl,--wrap=_isatty \
	-Wl,--wrap=_kill \
	-Wl,--wrap=_lseek \
	-Wl,--wrap=_read \
	-Wl,--wrap=_write \
	-Wl,--wrap=_fstat \
	-Wl,--wrap=_getpid \
	-nostartfiles \
	-ffreestanding \
	-T$(LDSCRIPT) \
	$(ARCH_FLAGS)

.PHONY: libclean

libclean:
	make -C $(OPENCM3_DIR) clean

LINKDEPS += $(LDSCRIPT) $(LIBDEPS)
