#ifndef HAETAE_ENCODING_H
#define HAETAE_ENCODING_H

#include "params.h"
#include <stdint.h>
#include <stddef.h>

#define encode_h HAETAE_NAMESPACE(encode_h)
uint16_t encode_h(uint8_t *buf, const int32_t *h);
#define decode_h HAETAE_NAMESPACE(decode_h)
uint16_t decode_h(int32_t *h, const uint8_t *buf, uint16_t size_in);
#define encode_hb_z1 HAETAE_NAMESPACE(encode_hb_z1)
uint16_t encode_hb_z1(uint8_t *buf, const int32_t *hb_z1);
#define decode_hb_z1 HAETAE_NAMESPACE(decode_hb_z1)
uint16_t decode_hb_z1(int32_t *hb_z1, const uint8_t *buf, uint16_t size_in);

#endif // HAETAE_ENCODING_H
