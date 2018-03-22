CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CC_CLFAGS = -Wall -Wextra -O3
AR_HOST = gcc-ar

HEADERS = api.h cbd.h kem.h pack_unpack.h poly.h poly_mul.h recon.h SABER_indcpa.h SABER_params.h verify.h
SOURCES = cbd.c kem.c pack_unpack.c poly.c poly_mul.c recon.c SABER_indcpa.c verify.c
OBJECTS = cbd.o kem.o pack_unpack.o poly.o poly_mul.o recon.o SABER_indcpa.o verify.o

OBJECTS_HOST = $(patsubst %.o,%_host.o,$(OBJECTS))

libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

libpqhost.a: $(OBJECTS_HOST)
	$(AR_HOST) rcs $@ $(OBJECTS_HOST)

%_host.o: %.c $(HEADERS)
	$(CC_HOST) -I$(INCPATH) $(CFLAGS_HOST) -c -o $@ $<

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm -f libpqhost.a
	-rm -f libpqm4.a
	-rm -f *.o
