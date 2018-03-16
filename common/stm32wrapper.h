#ifndef STMWRAP_H
#define STMWRAP_H

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/cm3/nvic.h>
#include <libopencm3/cm3/scs.h>
#include <libopencm3/cm3/dwt.h>
#include <libopencm3/stm32/dma.h>
#include <libopencm3/stm32/flash.h>
#include <libopencm3/stm32/rng.h>
#include <libopencm3/cm3/systick.h>

enum clock_mode {
    CLOCK_FAST,
    CLOCK_BENCHMARK
};

void clock_setup(const enum clock_mode);
void gpio_setup(void);
void usart_setup(int baud);
void systick_setup(void);
void dma_transmit_setup(void);
void dma_request_setup(void);
void dma_request(void* buffer, const int datasize);
void dma_transmit(const void* buffer, const int datasize);
int dma_done(void);
void signal_host(void);
void send_USART_str(const char* in);
void send_USART_bytes(const unsigned char* in, int n);
void recv_USART_bytes(unsigned char* out, int n);

#endif
