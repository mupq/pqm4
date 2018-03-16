CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

OBJECTS = sign.o polyvec.o packing.o poly.o reduce.o ntt.o rounding.o
HEADERS = api.h params.h sign.h polyvec.h packing.h poly.h reduce.h ntt.h \
  rounding.h


libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<



.PHONY: clean

clean:
	-rm -f libpqm4.a
	-rm -f *.o 
