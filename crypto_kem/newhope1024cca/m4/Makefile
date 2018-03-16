CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar 

OBJECTS= cpapke.o kem.o newhope_asm.o poly.o precomp.o reduce.o verify.o
HEADERS= api.h cpapke.h ntt.h params.h poly.h reduce.h verify.h 


libpqm4.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.S $(HEADERS)
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<


.PHONY: clean

clean:
	-rm libpqm4.a
	-rm *.o 
