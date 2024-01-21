ifdef SRCDIR

VPATH = $(SRCDIR)

.PHONY: all
all: tests tests-bin

include mupq/mk/config.mk
include mk/config.mk
include mk/crypto.mk
include mupq/mk/host-crypto.mk
include mupq/mk/rules.mk
include mupq/mk/schemes.mk
include mk/tests.mk

.PHONY: clean libclean

.SECONDARY:

else

################################
# Out-of-tree build mechanism  #
# You shouldn't anything below #
################################
.SUFFIXES:

-include build/.config.mk

ifeq (,$(PLATFORM))
$(error No PLATFORM specified (see README.md for a list of supported platforms)!)
endif

OBJDIR := build-$(PLATFORM)

.PHONY: $(OBJDIR)
$(OBJDIR): %:
	+@[ -d $@ ] || mkdir -p $@
	+@$(MAKE) --no-print-directory -r -I$(CURDIR) -C $@ -f $(CURDIR)/Makefile SRCDIR=$(CURDIR) $(MAKECMDGOALS)

Makefile : ;
%.mk :: ;
% :: $(OBJDIR) ;

.PHONY: clean
clean:
	rm -rf $(OBJDIR)

endif
