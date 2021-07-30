#include "hal.h"
#include <sys/cdefs.h>

#define SERIAL_BAUD 38400

#include <libopencm3/cm3/dwt.h>
#include <libopencm3/cm3/nvic.h>
#include <libopencm3/cm3/systick.h>

#if defined(STM32F407VG)

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/stm32/flash.h>
#include <libopencm3/stm32/rng.h>
#define SERIAL_GPIO GPIOA
#define SERIAL_USART USART2
#define SERIAL_PINS (GPIO2 | GPIO3)
#define STM32
#define DISCOVERY_BOARD

/* 24 MHz */
const struct rcc_clock_scale benchmarkclock = {
  .pllm = 8, //VCOin = HSE / PLLM = 1 MHz
  .plln = 192, //VCOout = VCOin * PLLN = 192 MHz
  .pllp = 8, //PLLCLK = VCOout / PLLP = 24 MHz (low to have 0WS)
  .pllq = 4, //PLL48CLK = VCOout / PLLQ = 48 MHz (required for USB, RNG)
  .pllr = 0,
  .hpre = RCC_CFGR_HPRE_DIV_NONE,
  .ppre1 = RCC_CFGR_PPRE_DIV_2,
  .ppre2 = RCC_CFGR_PPRE_DIV_NONE,
  .pll_source = RCC_CFGR_PLLSRC_HSE_CLK,
  .voltage_scale = PWR_SCALE1,
  .flash_config = FLASH_ACR_DCEN | FLASH_ACR_ICEN | FLASH_ACR_LATENCY_0WS,
  .ahb_frequency = 24000000,
  .apb1_frequency = 12000000,
  .apb2_frequency = 24000000,
};

#elif defined(STM32L476RG)
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/stm32/flash.h>
#include <libopencm3/stm32/rng.h>

#define SERIAL_GPIO GPIOA
#define SERIAL_USART USART2
#define SERIAL_PINS (GPIO2 | GPIO3)
#define STM32
#define NUCLEO_BOARD
#elif defined(STM32F303RCT7)
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/stm32/flash.h>

#define SERIAL_GPIO GPIOA
#define SERIAL_USART USART1
#define SERIAL_PINS (GPIO9 | GPIO10)
#define STM32
#define CW_BOARD
#else
#error Unsupported libopencm3 board
#endif

#define _RCC_CAT(A, B) A ## _ ## B
#define RCC_ID(NAME) _RCC_CAT(RCC, NAME)

__attribute__((unused))
static uint32_t _clock_freq;

#ifdef STM32F2
extern uint32_t rcc_apb1_frequency;
extern uint32_t rcc_apb2_frequency;
#endif

static void clock_setup(enum clock_mode clock)
{
#if defined(DISCOVERY_BOARD)
  switch(clock) {
  case CLOCK_BENCHMARK:
    rcc_clock_setup_pll(&benchmarkclock);
    break;
  case CLOCK_FAST:
  default:
    rcc_clock_setup_pll(&rcc_hse_8mhz_3v3[RCC_CLOCK_3V3_168MHZ]);
    break;
  }

  rcc_periph_clock_enable(RCC_RNG);
  rng_enable();

  flash_prefetch_enable();
#elif defined(CW_BOARD)
  /* Some STM32 Platform */
  rcc_periph_clock_enable(RCC_GPIOH);
  rcc_osc_off(RCC_HSE);
  rcc_osc_bypass_enable(RCC_HSE);
  rcc_osc_on(RCC_HSE);
  rcc_wait_for_osc_ready(RCC_HSE);

  rcc_ahb_frequency = 7372800;
  rcc_apb1_frequency = 7372800;
  rcc_apb2_frequency = 7372800;
  _clock_freq = 7372800;
  rcc_set_hpre(RCC_CFGR_HPRE_DIV_NONE);
  rcc_set_ppre1(RCC_CFGR_PPRE1_DIV_NONE);
  rcc_set_ppre2(RCC_CFGR_PPRE2_DIV_NONE);
  rcc_set_sysclk_source(RCC_CFGR_SW_HSE);
  rcc_wait_for_sysclk_status(RCC_HSE);
#elif defined(NUCLEO_BOARD)
  /* NUCLEO-L476RG Board */
  switch (clock) {
  case CLOCK_BENCHMARK:
    /* Benchmark straight from the HSI16 without prescaling */
    rcc_osc_on(RCC_HSI16);
    rcc_wait_for_osc_ready(RCC_HSI16);
    rcc_ahb_frequency = 16000000;
    rcc_apb1_frequency = 16000000;
    rcc_apb2_frequency = 16000000;
    _clock_freq = 16000000;
    rcc_set_hpre(RCC_CFGR_HPRE_NODIV);
    rcc_set_ppre1(RCC_CFGR_PPRE1_NODIV);
    rcc_set_ppre2(RCC_CFGR_PPRE2_NODIV);
    flash_dcache_enable();
    flash_icache_enable();
    flash_set_ws(FLASH_ACR_LATENCY_0WS);
    flash_prefetch_enable();
    rcc_set_sysclk_source(RCC_CFGR_SW_HSI16);
    rcc_wait_for_sysclk_status(RCC_HSI16);
    break;
  case CLOCK_FAST:
  default:
    rcc_osc_on(RCC_HSI16);
    rcc_wait_for_osc_ready(RCC_HSI16);
    rcc_ahb_frequency = 80000000;
    rcc_apb1_frequency = 80000000;
    rcc_apb2_frequency = 80000000;
    _clock_freq = 80000000;
    rcc_set_hpre(RCC_CFGR_HPRE_NODIV);
    rcc_set_ppre1(RCC_CFGR_PPRE1_NODIV);
    rcc_set_ppre2(RCC_CFGR_PPRE2_NODIV);
    rcc_osc_off(RCC_PLL);
    while(rcc_is_osc_ready(RCC_PLL));
    /* Configure the PLL oscillator (use CUBEMX tool -> scale HSI16 to 80MHz). */
    rcc_set_main_pll(RCC_PLLCFGR_PLLSRC_HSI16, 1, 10, RCC_PLLCFGR_PLLP_DIV7, RCC_PLLCFGR_PLLQ_DIV2, RCC_PLLCFGR_PLLR_DIV2);
    /* Enable PLL oscillator and wait for it to stabilize. */
    rcc_osc_on(RCC_PLL);
    rcc_wait_for_osc_ready(RCC_PLL);
    flash_dcache_enable();
    flash_icache_enable();
    flash_set_ws(FLASH_ACR_LATENCY_4WS);
    flash_prefetch_enable();
    rcc_set_sysclk_source(RCC_CFGR_SW_PLL);
    rcc_wait_for_sysclk_status(RCC_PLL);
    break;
  }

  rcc_periph_clock_enable(RCC_RNG);
  rng_enable();
#else
#error Unsupported platform
#endif
}

void usart_setup()
{
#if defined(DISCOVERY_BOARD)
  rcc_periph_clock_enable(RCC_GPIOA);
  rcc_periph_clock_enable(RCC_USART2);
#elif defined(CW_BOARD)
  rcc_periph_clock_enable(RCC_GPIOA);
  rcc_periph_clock_enable(RCC_USART1);
#elif defined(NUCLEO_BOARD)
  rcc_periph_clock_enable(RCC_GPIOA);
  rcc_periph_clock_enable(RCC_USART2);
#else
#error Unsupported platform
#endif

#if defined(DISCOVERY_BOARD) || defined(NUCLEO_BOARD) || defined(CW_BOARD)
  gpio_set_output_options(SERIAL_GPIO, GPIO_OTYPE_OD, GPIO_OSPEED_100MHZ, SERIAL_PINS);
  gpio_set_af(SERIAL_GPIO, GPIO_AF7, SERIAL_PINS);
  gpio_mode_setup(SERIAL_GPIO, GPIO_MODE_AF, GPIO_PUPD_PULLUP, SERIAL_PINS);
  usart_set_baudrate(SERIAL_USART, SERIAL_BAUD);
  usart_set_databits(SERIAL_USART, 8);
  usart_set_stopbits(SERIAL_USART, USART_STOPBITS_1);
  usart_set_mode(SERIAL_USART, USART_MODE_TX_RX);
  usart_set_parity(SERIAL_USART, USART_PARITY_NONE);
  usart_set_flow_control(SERIAL_USART, USART_FLOWCONTROL_NONE);
  usart_disable_rx_interrupt(SERIAL_USART);
  usart_disable_tx_interrupt(SERIAL_USART);
  usart_enable(SERIAL_USART);
#endif
}

void systick_setup()
{
  /* Systick is always the same on libopencm3 */
  systick_set_clocksource(STK_CSR_CLKSOURCE_AHB);
  systick_set_reload(0xFFFFFFu);
  systick_interrupt_enable();
  systick_counter_enable();
}
static volatile unsigned long long overflowcnt = 0;
void hal_setup(const enum clock_mode clock)
{
  clock_setup(clock);
  usart_setup();
  systick_setup();

  // wait for the first systick overflow
  // improves reliability of the benchmarking scripts since it makes it much
  // less likely that the host will miss the start of the output
  unsigned long long old = overflowcnt;
  while(old == overflowcnt);
}

void hal_send_str(const char* in)
{
  const char* cur = in;
  while (*cur) {
    usart_send_blocking(SERIAL_USART, *cur);
    cur += 1;
  }
  usart_send_blocking(SERIAL_USART, '\n');
}

void sys_tick_handler(void)
{
  ++overflowcnt;
}

uint64_t hal_get_time()
{
  while (true) {
    unsigned long long before = overflowcnt;
    unsigned long long result = (before + 1) * 16777216llu - systick_get_value();
    if (overflowcnt == before) {
      return result;
    }
  }
}

/* End of BSS is where the heap starts (defined in the linker script) */
extern char end;
static char* heap_end = &end;

void* __wrap__sbrk (int incr)
{
  char* prev_heap_end;

  prev_heap_end = heap_end;
  heap_end += incr;

  return (void *) prev_heap_end;
}

size_t hal_get_stack_size(void)
{
  register char* cur_stack;
	__asm__ volatile ("mov %0, sp" : "=r" (cur_stack));
  return cur_stack - heap_end;
}
