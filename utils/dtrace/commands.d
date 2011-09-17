#!/usr/sbin/dtrace -CZs
/*
 * Sample script to calculate the avg time spent inside commands
 * Run it like this: sudo dtrace -qs commands.d -p `pgrep redis`
 */
redis$target:::command-entry
{
  self->ts = timestamp;
}

redis$target:::command-return
/self->ts/
{
  printf("%s %d", copyinstr(arg0), timestamp - self->ts);
  @time[copyinstr(arg0)] = avg(timestamp - self->ts);
  @timeq[copyinstr(arg0)] = quantize(timestamp - self->ts);
  self->ts = 0;
}