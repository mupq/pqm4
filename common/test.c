#include <hal.h>

int main(void)
{
  hal_setup(CLOCK_FAST);
  hal_send_str("Hello World!");
  return 0;
}
