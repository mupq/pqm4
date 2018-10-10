CC     = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -O3 -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
AR     = arm-none-eabi-gcc-ar

CC_HOST = gcc
CFLAGS_HOST = -Wall -Wextra -O3
AR_HOST = gcc-ar

OBJECTS = dec.o enc.o int32_sort.o keypair.o r3_mult.o r3_recip.o random32.o randomsmall.o randomweightw.o rq.o rq_mult.o rq_recip3.o rq_round3.o rq_rounded.o small.o swap.o crypto_verify_32.o

HEADERS = api.h crypto_kem.h crypto_kem_sntrup4591761.h int32_sort.h mod3.h modq.h params.h r3.h randomweightw.c rq.h small.h swap.h crypto_verify_32.h

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
