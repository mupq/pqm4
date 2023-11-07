#include <hal.h>
#include <randombytes.h>
#include <sendfn.h>
#include <stdint.h>

#if defined(SRAM_TIMING_TEST)
#define TEST_BLOCK_SIZE 4096

/* Don't use opencm3 here, since not all platforms might use opencm3, but all
   have these DWT registers */
#define DWT_CTRL           (*(volatile uint32_t*)(0xE0001000u + 0x00))
#define DWT_CYCCNT         (*(volatile uint32_t*)(0xE0001000u + 0x04))
#define DWT_CTRL_CYCCNTENA (1 << 0)
#define SCS_DEMCR          (*(volatile uint32_t*)(0xE000E000u + 0xDFC))
#define SCS_DEMCR_TRCENA   (1 << 24)
/* Need a really precise cycle counter. */
static void cyccnt_enable()
{
	SCS_DEMCR |= SCS_DEMCR_TRCENA;
	DWT_CYCCNT = 0;
	DWT_CTRL |= DWT_CTRL_CYCCNTENA;
}
static inline void cyccnt_start()
{
	DWT_CYCCNT = 0;
}
static inline uint32_t cyccnt_get()
{
  return DWT_CYCCNT;
}

__attribute__((noinline))
static uint32_t test_load(volatile unsigned* ram_block)
{
  asm volatile("cpsid if");
  cyccnt_start();
#define NL "\n\t"
  asm volatile("_MEMLOOP%=:" NL
               "ldr r12, [%0], #4" NL
               "cmp %0, %1" NL
               "bne _MEMLOOP%=" NL
               :"+r" (ram_block): "r" (ram_block + (TEST_BLOCK_SIZE / sizeof(unsigned))): "r12", "cc");
  uint32_t result = cyccnt_get();
  asm volatile("cpsie if");
  return result;
}

__attribute__((noinline))
static uint32_t test_unalignedload(volatile void* ram_block)
{
  volatile unsigned char* ram_block8 = ram_block;
  ram_block8 += 2;
  asm volatile("cpsid if");
  cyccnt_start();
#define NL "\n\t"
  asm volatile("_MEMLOOP%=:" NL
               "ldr r12, [%0], #4" NL
               "cmp %0, %1" NL
               "blt _MEMLOOP%=" NL
               :"+r" (ram_block8): "r" (ram_block8 + TEST_BLOCK_SIZE): "r12", "cc");
  uint32_t result = cyccnt_get();
  asm volatile("cpsie if");
  return result;
}

__attribute__((noinline))
static uint32_t test_store(volatile unsigned* ram_block)
{
  cyccnt_start();
#define NL "\n\t"
  asm volatile("_MEMLOOP%=:" NL
               "str r12, [%0], #4" NL
               "cmp %0, %1" NL
               "bne _MEMLOOP%=" NL
               :"+r" (ram_block): "r" (ram_block + (TEST_BLOCK_SIZE / sizeof(unsigned))): "r12", "cc");
  return cyccnt_get();
}

__attribute__((noinline))
static uint32_t test_loadstore(volatile unsigned* ram_block)
{
  cyccnt_start();
#define NL "\n\t"
  asm volatile("_MEMLOOP%=:" NL
               "str r12, [%0]" NL
               "add r12, r12, #1" NL
               "ldr r12, [%0], #4" NL
               "cmp %0, %1" NL
               "bne _MEMLOOP%=" NL
               :"+r" (ram_block): "r" (ram_block + (TEST_BLOCK_SIZE / sizeof(unsigned))): "r12", "cc");
  return cyccnt_get();
}

static void memory_timing_test(void)
{
  cyccnt_enable();
#define RAMBLK(BLK)                                                       \
  static volatile unsigned ram ## BLK ## _block[TEST_BLOCK_SIZE / sizeof(unsigned) + 1] __attribute__((section(".ram" #BLK)))

#define TEST(BLK) \
  test_load(ram ## BLK ## _block); \
  test_unalignedload(ram ## BLK ## _block);  \
  test_store(ram ## BLK ## _block); \
  test_loadstore(ram ## BLK ## _block); \
  send_unsigned("ram" #BLK " load", test_load(ram ## BLK ## _block)); \
  send_unsigned("ram" #BLK " unalignedload", test_unalignedload(ram ## BLK ## _block));   \
  send_unsigned("ram" #BLK " store", test_store(ram ## BLK ## _block)); \
  send_unsigned("ram" #BLK " loadstore", test_loadstore(ram ## BLK ## _block));

  static volatile unsigned ram1_block[TEST_BLOCK_SIZE / sizeof(unsigned) + 1];
  TEST(1);
#if defined(HAS_SRAM2)
  RAMBLK(2);
  TEST(2);
#endif
#if defined(HAS_SRAM3)
  RAMBLK(3);
  TEST(3);
#endif
#if defined(HAS_CCM)
  static volatile unsigned ramccm_block[TEST_BLOCK_SIZE / sizeof(unsigned) + 1] __attribute__((section(".ccmram")));
  TEST(ccm);
#endif
}
#endif

#ifndef CLOCK_TEST
#define CLOCK_TEST CLOCK_BENCHMARK
#endif

void stacktest(size_t size)
{
  volatile uint32_t mem[size] __attribute__((unused));
  for (unsigned i = 0; i < size; ++i) {
    mem[i] = 0;
  }
}

int main(void)
{
  hal_setup(CLOCK_TEST);
  hal_send_str("Hello world");
  send_unsigned("Stack Size", hal_get_stack_size());
  unsigned rnd;
  randombytes((unsigned char*) &rnd, sizeof(unsigned));
  send_unsigned("Random number", rnd);
  size_t stack;
  hal_spraystack();
  stacktest(100);
  stack = hal_checkstack();
  send_unsigned("stackusage1", stack);
  hal_spraystack();
  stacktest(200);
  stack = hal_checkstack();
  send_unsigned("stackusage2", stack);
#if defined(SRAM_TIMING_TEST)
  memory_timing_test();
#endif
  return 0;
}
