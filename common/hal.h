#ifndef HAL_H
#define HAL_H

enum clock_mode {
    CLOCK_FAST,
    CLOCK_BENCHMARK
};

void setup(const enum clock_mode clock);
void send_str(const char* in);
uint64_t get_time();


#endif
