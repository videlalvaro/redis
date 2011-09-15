#!/usr/sbin/dtrace -CZs
/*
 * Sample script to trace syscalls that happen in during a GET command.
 */
redis$target:::get-entry
{
  self->traceIt = 1;
  printf("get called with key: %s\n", copyinstr(arg0));
}

syscall:::entry
/self->traceIt/
{
  printf("%s:%s\n", probemod, probefunc);
}

redis$target:::get-return
{
  self->traceIt = 0;
  printf("get returned: %d for key:%s\n", arg1, copyinstr(arg0));
}