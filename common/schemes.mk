ifndef IMPLEMENTATION_PATH
# If IMPLEMENTATION_PATH isn't defined (usually with the call to make), all
# default search paths will be searched

KEM_SEARCH_PATHS = \
	crypto_kem \
	mupq/crypto_kem \
	mupq/pqclean/crypto_kem

SIGN_SEARCH_PATHS = \
	crypto_sign \
	mupq/crypto_sign \
	mupq/pqclean/crypto_sign

# Ignore all platform specific implementations from pqclean
IGNORE_IMPLEMENTATIONS ?= \
	-name avx \
	-or -name avx2 \
	-or -name sse \
	-or -name vec \
	-or -name aesni

# This is the implementation finding mechanism. This target will create a
# makefile, that essentially just contains two variables {KEM,SIGN}_SCHEMES,
# each containing the list of paths of schemes.
.PHONY: obj/.schemes.mk
obj/.schemes.mk:
	$(Q)[ -d $(@D) ] || mkdir -p $(@D); \
	touch $@; \
	printf "KEM_SCHEMES :=" > $@; \
	find $(KEM_SEARCH_PATHS) -mindepth 2 -maxdepth 2 -type d \! \( $(IGNORE_IMPLEMENTATIONS) \) -print0 | xargs -0 printf " \\\\\\n\\t%s" >> $@; \
	printf "\n\nSIGN_SCHEMES :=" >> $@; \
	find $(SIGN_SEARCH_PATHS) -mindepth 2 -maxdepth 2 -type d \! \( $(IGNORE_IMPLEMENTATIONS) \) -print0 | xargs -0 printf " \\\\\\n\\t%s" >> $@;

# We include the makefile that is created above. Since it's marked as PHONY,
# Make will always remake it first before including it. Hence, the
# {KEM,SIGN}_SCHEMES variables will always contain an up-to-date list of all
# schemes in the search paths.
-include obj/.schemes.mk

# The platforms may optionally contain a list of ignored schemes (usually the
# ones that won't build properly).
KEM_SCHEMES := $(filter-out $(EXCLUDED_SCHEMES),$(KEM_SCHEMES))
SIGN_SCHEMES := $(filter-out $(EXCLUDED_SCHEMES),$(SIGN_SCHEMES))

else

# If, however, the IMPLEMENTAION_PATH is defined, only the path it points to
# will be added to the {KEM,SIGN}_SCHEMES lists. Since the python scripts for
# automatic test running will call make with this, remaking the list is skipped,
# saving a bit of time.
KEM_SCHEMES := $(if $(findstring crypto_kem,$(IMPLEMENTATION_PATH)),$(IMPLEMENTATION_PATH))
SIGN_SCHEMES := $(if $(findstring crypto_sign,$(IMPLEMENTATION_PATH)),$(IMPLEMENTATION_PATH))

endif

# These are small macros to be called with the $(call) mechanism of make
# Derives a name for a scheme from its path.
schemename = $(subst /,_,$(1))
# Derives the list of source files from a path.
schemesrc = $(wildcard $(1)/*.c) $(wildcard $(1)/*.s) $(wildcard $(1)/*.S)
# Derives a namespace for the implementation (pqclean uses namespaced function
# names) from an implementation name.
namespace = $(shell echo $(if $(filter mupq_pqclean_%,$(1)),$(subst mupq_pqclean_crypto_$(2)_,pqclean_,$(1))_) | tr '[:lower:]' '[:upper:]' | tr -d '-')

# The default compilation rule.
define compiletest =
	@echo "  CC      $@"
	$(Q)[ -d $(@D) ] || mkdir -p $(@D)
	$(Q)$(CC) $(filter-out --specs=%,$(CFLAGS)) $(LDFLAGS) -o $@ $(if $(AIO),$(filter %.c %.S %.s,$^),$<) -Wl,--start-group $(LDLIBS) -Wl,--end-group
endef

# This template defines all the targets for a scheme: a library file containing
# all the compiled objects, and an elf file for each test.
define schemelib =
obj/lib$(2).a: $(call objs,$(call schemesrc,$(1)))
libs: obj/lib$(2).a
elf/$(2)_%.elf: CPPFLAGS+=-I$(1)
elf/$(2)_%.elf: CPPFLAGS+=-DMUPQ_NAMESPACE=$(call namespace,$(2),$(3))
elf/$(2)_hashing.elf: PROFILE_HASHING=1

# The {test,stack,speed,...}.c file is compiled directly into the elf file,
# since the code depends on the preprocessor definitions in the api.h file of
# the scheme.

ifeq ($(AIO),1)
# Compile all sources in one.
elf/$(2)_%.elf: mupq/crypto_$(3)/%.c $(call schemesrc,$(1)) $(LINKDEPS)
	$$(compiletest)
else
# Compile just the test and link against the library.
elf/$(2)_%.elf: LDLIBS+=-l$(2)
elf/$(2)_%.elf: mupq/crypto_$(3)/%.c obj/lib$(2).a $(LINKDEPS)
	$$(compiletest)
endif

# Add the elf,bin and hex files to the tests target.
tests: elf/$(2)_test.elf elf/$(2)_speed.elf elf/$(2)_hashing.elf elf/$(2)_stack.elf elf/$(2)_testvectors.elf
tests-bin: bin/$(2)_test.bin bin/$(2)_speed.bin bin/$(2)_hashing.bin bin/$(2)_stack.bin bin/$(2)_testvectors.bin
tests-hex: bin/$(2)_test.hex bin/$(2)_speed.hex bin/$(2)_hashing.hex bin/$(2)_stack.hex bin/$(2)_testvectors.hex
endef

.PHONY: tests tests-bin tests-hex

# Now, for all schemes, the template above is evaluated.
$(foreach scheme,$(KEM_SCHEMES), \
	$(eval $(call schemelib,$(scheme),$(call schemename,$(scheme)),kem)))
$(foreach scheme,$(SIGN_SCHEMES), \
	$(eval $(call schemelib,$(scheme),$(call schemename,$(scheme)),sign)))

# If the platform can be executed with QEMU, we also define a
# run-{speed,stack,hashing}-tests target.
ifeq ($(ENABLE_QEMU_TESTS),1)

benchmarks/%/frommake:
	@echo "  RUN     $<"
	$(Q)[ -d $(@D) ] || mkdir -p $(@D); \
	$(QEMU) $(QEMUFLAGS) -kernel $< > $@ < /dev/null

define runtest =
benchmarks/$(3)/$(1)/frommake: elf/$(2)_$(3).elf
run-$(3)-tests: benchmarks/$(3)/$(1)/frommake
endef

$(foreach test,speed stack hashing, \
	$(foreach scheme,$(KEM_SCHEMES), \
		$(eval $(call runtest,$(scheme),$(call schemename,$(scheme)),$(test)))) \
	$(foreach scheme,$(SIGN_SCHEMES), \
		$(eval $(call runtest,$(scheme),$(call schemename,$(scheme)),$(test)))))

endif
