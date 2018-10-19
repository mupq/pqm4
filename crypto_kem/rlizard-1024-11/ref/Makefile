CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CFLAGS_HOST = -Wall -Wextra -O3
AR_HOST = gcc-ar

OBJECTS = RLizard.o libkeccak/SP800-185.o libkeccak/KeccakSpongeWidth1600.o 
 
OBJECTS_HOST = $(patsubst %.o,%_host.o,$(OBJECTS))

libpqm4.a: $(OBJECTS) libkeccak/KeccakP-1600-inplace-32bi-armv7m-le-gcc.o 
	$(AR) rcs $@ $(OBJECTS) libkeccak/KeccakP-1600-inplace-32bi-armv7m-le-gcc.o 


libpqhost.a: $(OBJECTS_HOST) libkeccak/KeccakP-1600-reference_host.o 
	$(AR_HOST) rcs $@ $(OBJECTS_HOST) libkeccak/KeccakP-1600-reference_host.o



%_host.o: %.c $(HEADERS)
	$(CC_HOST) -I$(INCPATH) $(CFLAGS_HOST) -c -o $@ $<

%.o: %.c
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) -I$(INCPATH) $(CFLAGS) -c -o $@ $<
  

.PHONY: clean
.INTERMEDIATE: $(OBJECTS) $(OBJECTS_HOST)

clean:
	-rm -f libpqhost.a
	-rm -f libpqm4.a
	-rm -f *.o
	-rm -f libkeccak/*.o
