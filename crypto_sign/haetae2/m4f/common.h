// SPDX-License-Identifier: MIT

#ifndef HAETAE_COMMON_H
#define HAETAE_COMMON_H

#define HAETAE_CONCAT_(x1, x2) x1##x2
#define HAETAE_CONCAT(x1, x2) HAETAE_CONCAT_(x1, x2)

#define HAETAE_STR_(x) #x
#define HAETAE_STR(x) HAETAE_STR_(x)

#endif /* !HAETAE_COMMON_H */
