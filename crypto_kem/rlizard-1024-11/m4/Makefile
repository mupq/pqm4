CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -flto
AR     = arm-none-eabi-gcc-ar

OBJECTS = RLizard.o libkeccak/SP800-185.o libkeccak/KeccakSpongeWidth1600.o libkeccak/KeccakP-1600-inplace-32bi-armv7m-le-gcc.o mult_toom4_1024_16.o 
 
libpqm4.a: $(OBJECTS) 
	$(AR) rcs $@ $(OBJECTS) 


%.o: %.c
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<


.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm -f libpqm4.a
	-rm -f *.o
	-rm -f libkeccak/*.o
