#!/usr/sbin/dtrace -CZs
/*
 * Sample script to trace syscalls that happen during a GET command.
 * Run it like this: sudo dtrace -qs gets.d -p `pgrep redis`
 */
redis$target:::command-entry
/copyinstr(arg0) == "get"/
{
  self->traceIt = 1;
  printf("get called with key: %s\n", copyinstr(arg0));
}

syscall:::entry
/self->traceIt/
{
  printf("%s:%s\n", probemod, probefunc);
}

redis$target:::command-return
/copyinstr(arg0) == "get"/
{
  self->traceIt = 0;
  printf("get returned: %d for key:%s\n", arg1, copyinstr(arg0));
}