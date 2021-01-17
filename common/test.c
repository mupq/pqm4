#include <hal.h>
#include <sendfn.h>

int main(void)
{
  hal_setup(CLOCK_FAST);
  hal_send_str("Hello world");
  send_unsigned("Stack Size", hal_get_stack_size());
  return 0;
}
