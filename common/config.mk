ifndef _CONFIG
_CONFIG :=

ifndef SRCDIR
SRCDIR := $(CURDIR)
endif

##############################
# Include retained variables #
##############################

RETAINED_VARS :=

-include obj/.config.mk

obj/.config.mk:
	$(Q)[ -d $(@D) ] || mkdir -p $(@D)
	@echo "# These variables are retained and can't be changed without a clean" > $@
	@$(foreach var,$(RETAINED_VARS),echo "$(var) := $($(var))" >> $@; echo "LAST_$(var) := $($(var))" >> $@;)

###############
# Some Macros #
###############
objs = $(addprefix obj/,$(addsuffix .o,$(1)))
hashprofobjs = $(addprefix obj/hashprof/,$(addsuffix .o,$(1)))
hostobjs = $(addprefix obj-host/,$(addsuffix .o,$(1)))

Q ?= @

PLATFORM ?=

ifeq (,$(PLATFORM))
$(error No PLATFORM specified (e.g., PLATFORM=sam3x8e for the Arduino Due or PLATFORM=lm3s for the QEmu)!)
endif

ifeq (,$(wildcard $(SRCDIR)/common/$(PLATFORM).mk))
$(error Unknown platform!)
endif

# The platform file should set all necessary CC/CXX/AR/LD variables
include common/$(PLATFORM).mk

RETAINED_VARS += PLATFORM

Q ?= @

HOST_CC := cc
HOST_AR := ar
HOST_LD := $(HOST_CC)

################
# Common Flags #
################

SYSROOT ?= $(shell $(CC) --print-sysroot)

CFLAGS += \
	--sysroot=$(SYSROOT) \
	-I$(SRCDIR)/common \
	-I$(SRCDIR)/mupq/common

DEBUG ?=
OPT_SIZE ?=
LTO ?=
AIO ?=

RETAINED_VARS += DEBUG OPT_SIZE LTO AIO

ifeq ($(DEBUG),1)
CFLAGS += -O0 -g3
else ifeq ($(OPT_SIZE),1)
CFLAGS += -Os -g3
else
CFLAGS += -O3 -g3
endif

ifeq ($(AIO),1)
# AIO flag is handled in schemes.mk
else ifeq ($(LTO),1)
CFLAGS += -flto
LDFLAGS += -flto
endif

CFLAGS += \
	-Wall -Wextra -Wshadow \
	-MMD \
	-fno-common \
	-ffunction-sections \
	-fdata-sections \
	$(CPPFLAGS)

LDFLAGS += \
	-Lobj \
	-Wl,--gc-sections

LDLIBS += -lm

HOST_CFLAGS += \
	-I$(SRCDIR)/mupq/common \
	-Wall -Wextra -Wshadow \
	-MMD

HOST_LDFLAGS += \
	-Lobj-host

# Check if the retained variables have been changed
define VAR_CHECK =
ifneq ($$(origin LAST_$(1)),undefined)
ifneq "$$($(1))" "$$(LAST_$(1))"
$$(error "You changed the $(1) variable, you must run make clean!")
endif
endif
endef

$(foreach VAR,$(RETAINED_VARS),$(eval $(call VAR_CHECK,$(VAR))))
endif
