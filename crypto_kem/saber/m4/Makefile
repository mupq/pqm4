CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

HEADERS = api.h cbd.h kem.h pack_unpack.h poly.h poly_mul.h recon.h SABER_indcpa.h SABER_params.h verify.h
SOURCES = cbd.c kem.c pack_unpack.c poly.c poly_mul.c recon.c SABER_indcpa.c verify.c
OBJECTS = cbd.o kem.o pack_unpack.o poly.o poly_mul.o recon.o SABER_indcpa.o verify.o

libpqm4.a: mult_toom4_256_16.o $(OBJECTS)
	$(AR) rcs $@ $< $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm -f libpqm4.a
	-rm -f *.o
