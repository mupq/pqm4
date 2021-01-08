_git_submodule_update_mupq := $(shell git submodule update --init --recursive mupq)

KEM_SEARCH_PATHS = \
	crypto_kem \
	mupq/crypto_kem \
	mupq/pqclean/crypto_kem

SIGN_SEARCH_PATHS = \
	crypto_sign \
	mupq/crypto_sign \
	mupq/pqclean/crypto_sign

IGNORE_IMPLEMENTATIONS ?= \
	-name avx \
	-or -name avx2 \
	-or -name sse \
	-or -name vec \
	-or -name aesni

.PHONY: obj/.schemes.mk
obj/.schemes.mk:
	$(Q)touch $@; \
	printf "KEM_SCHEMES :=" > $@; \
	find $(KEM_SEARCH_PATHS) -mindepth 2 -maxdepth 2 -type d \! \( $(IGNORE_IMPLEMENTATIONS) \) -print0 | xargs -0 printf " \\\\\\n\\t%s" >> $@; \
	printf "\n\nSIGN_SCHEMES :=" >> $@; \
	find $(SIGN_SEARCH_PATHS) -mindepth 2 -maxdepth 2 -type d \! \( $(IGNORE_IMPLEMENTATIONS) \) -print0 | xargs -0 printf " \\\\\\n\\t%s" >> $@;

-include obj/.schemes.mk

KEM_SCHEMES := $(filter-out $(EXCLUDED_SCHEMES),$(KEM_SCHEMES))
SIGN_SCHEMES := $(filter-out $(EXCLUDED_SCHEMES),$(SIGN_SCHEMES))

schemename = $(subst /,_,$(1))
schemesrc = $(wildcard $(1)/*.c) $(wildcard $(1)/*.s) $(wildcard $(1)/*.S)
namespace = $(shell echo $(if $(filter mupq_pqclean_%,$(1)),$(subst mupq_pqclean_crypto_$(2)_,pqclean_,$(1))_) | tr '[:lower:]' '[:upper:]' | tr -d '-')

define compiletest =
	@echo "  CC      $@"
	$(Q)[ -d $(@D) ] || mkdir -p $(@D)
	$(Q)$(CC) $(filter-out --specs=%,$(CFLAGS)) $(LDFLAGS) -o $@ $(if $(AIO),$(filter %.c %.S %.s,$^),$<) -Wl,--start-group $(LDLIBS) -Wl,--end-group
endef

define schemelib =
obj/lib$(2).a: $(call objs,$(call schemesrc,$(1)))
libs: obj/lib$(2).a
elf/$(2)_%.elf: CPPFLAGS+=-I$(1)
elf/$(2)_%.elf: CPPFLAGS+=-DMUPQ_NAMESPACE=$(call namespace,$(2),$(3))
elf/$(2)_hashing.elf: PROFILE_HASHING=1
ifeq ($(AIO),1)
elf/$(2)_%.elf: mupq/crypto_$(3)/%.c $(call schemesrc,$(1)) $(LINKDEPS)
	$$(compiletest)
else
elf/$(2)_%.elf: LDLIBS+=-l$(2)
elf/$(2)_%.elf: mupq/crypto_$(3)/%.c obj/lib$(2).a $(LINKDEPS)
	$$(compiletest)
endif

tests: elf/$(2)_test.elf elf/$(2)_speed.elf elf/$(2)_hashing.elf elf/$(2)_stack.elf elf/$(2)_testvectors.elf
tests-bin: bin/$(2)_test.bin bin/$(2)_speed.bin bin/$(2)_hashing.bin bin/$(2)_stack.bin bin/$(2)_testvectors.bin
tests-hex: bin/$(2)_test.hex bin/$(2)_speed.hex bin/$(2)_hashing.hex bin/$(2)_stack.hex bin/$(2)_testvectors.hex
endef

elf/mupq_pqclean_%.elf: MUPQ_NAMESPACE=$(shell tr)

$(foreach scheme,$(KEM_SCHEMES), \
	$(eval $(call schemelib,$(scheme),$(call schemename,$(scheme)),kem)))
$(foreach scheme,$(SIGN_SCHEMES), \
	$(eval $(call schemelib,$(scheme),$(call schemename,$(scheme)),sign)))
