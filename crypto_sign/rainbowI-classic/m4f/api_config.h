/// @file api_config.h
/// @brief Defining which key format used for api.h/sign.c
///
/// Defining which key format used for api.h/sign.c
///

#ifndef _API_CONFIG_H_
#define _API_CONFIG_H_




#if (!defined(_RAINBOW_CLASSIC))&&(!defined(_RAINBOW_CYCLIC))&&(!defined(_RAINBOW_CYCLIC_COMPRESSED))
#define _RAINBOW_CLASSIC
//#define _RAINBOW_CYCLIC
//#define _RAINBOW_CYCLIC_COMPRESSED
#endif


#if defined _RAINBOW_CLASSIC
#define _SUFFIX " - classic"
#elif defined _RAINBOW_CYCLIC
#define _SUFFIX " - cyclic"
#elif defined _RAINBOW_CYCLIC_COMPRESSED
#define _SUFFIX " - cyclic compressed"
#else
error here
#endif



#endif  // _API_CONFIG_H_
