// Implemented by Ming-Shing Chen, Tung Chou and Markus Krausz.
// public domain

#ifndef _RUN_CONFIG_H_
#define _RUN_CONFIG_H_

#if defined(STM32F4)

#define _M4_ASM_
//#define _USE_CCM_IF_STM32F4_   // l1 can run with < 112KB SRAM. no need to use CCM

#endif

#endif
