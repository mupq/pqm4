#ifndef CONFIG_H
#define CONFIG_H

#define CORTEX_M4 4
#define CORTEX_M3 3


#define PLATFORM CORTEX_M4
#define DILITHIUM_MODE 4
#define SIGN_STACKSTRATEGY 2

#if !defined(PLATFORM) || (PLATFORM != CORTEX_M3  && PLATFORM != CORTEX_M4)
#error PLATFORM must be 3 or 4
#endif
#endif
