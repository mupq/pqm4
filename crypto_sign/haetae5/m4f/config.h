// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Team HAETAE
// Copyright (c) 2026 YoungBeom Kim (Cortex-M4 modifications)

#ifndef HAETAE_CONFIG_H
#define HAETAE_CONFIG_H

#include "common.h"

#define HAETAE_MODE2 0
#define HAETAE_MODE3 1
#define HAETAE_MODE5 2

#if !defined(HAETAE_CONFIG_MODE)
#define HAETAE_CONFIG_MODE HAETAE_MODE5
#endif

#if (HAETAE_CONFIG_MODE != HAETAE_MODE2) &&                                    \
    (HAETAE_CONFIG_MODE != HAETAE_MODE3) &&                                    \
    (HAETAE_CONFIG_MODE != HAETAE_MODE5)
#error "Invalid HAETAE_CONFIG_MODE"
#endif

#if !defined(HAETAE_CONFIG_MODE_STRING)
#if HAETAE_CONFIG_MODE == HAETAE_MODE2
#define HAETAE_CONFIG_MODE_STRING mode2
#elif HAETAE_CONFIG_MODE == HAETAE_MODE3
#define HAETAE_CONFIG_MODE_STRING mode3
#elif HAETAE_CONFIG_MODE == HAETAE_MODE5
#define HAETAE_CONFIG_MODE_STRING mode5
#endif
#endif

#if !defined(HAETAE_CONFIG_NAMESPACE_PREFIX)
#define HAETAE_CONFIG_NAMESPACE_PREFIX cryptolab_haetae_
#endif

#if !defined(HAETAE_CONFIG_NAMESPACE_PREFIX_MODE)
#define HAETAE_ADD_MODE(s) HAETAE_CONCAT(s, HAETAE_CONFIG_MODE_STRING)
#define HAETAE_CONFIG_NAMESPACE_PREFIX_MODE                                    \
  HAETAE_CONCAT(HAETAE_ADD_MODE(HAETAE_CONFIG_NAMESPACE_PREFIX), _m4f_)
#endif

#endif /* !HAETAE_CONFIG_H */
