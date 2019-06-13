#ifndef COMMON_H
#define COMMON_H

int mul_add_as_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A);
int mul_add_sa_plus_e(uint16_t *out, const uint16_t *s, const uint8_t *seed_A);
void sample_n(uint16_t *s, size_t n);
void mul_bs(uint16_t *out, const uint16_t *b, const uint16_t *s);
void mul_add_sb_plus_e(uint16_t *out, const uint16_t *b, const uint16_t *s);
void add(uint16_t *out, const uint16_t *a, const uint16_t *b);
void sub(uint16_t *out, const uint16_t *a, const uint16_t *b);
void key_encode(uint16_t *out, const uint16_t *in);
void key_decode(uint16_t *out, const uint16_t *in);
void pack(uint8_t *out, size_t outlen, const uint16_t *in, size_t inlen, uint8_t lsb);
void unpack(uint16_t *out, size_t outlen, const uint8_t *in, size_t inlen, uint8_t lsb);
void clear_bytes(uint8_t *mem, size_t n);
uint16_t LE_TO_UINT16(uint16_t n);
uint16_t UINT16_TO_LE(uint16_t n);

#endif
