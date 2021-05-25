\ 
\ 
\ See ~/Source/Tools/Timers
\ 
-1 value libc 
-1 value timers
-1 value tim

" libc.so.6" 1 dlopen to libc

s" usleep" libc dlsym abort" Not Found" acall: usleep { i.microseconds -- h.error? }


" /tmp/libnewtimers.so" 1 dlopen to timers
s" createMaster" timers dlsym abort" Not found" acall: create-master { i.flag -- a.ptr }

s" display" timers dlsym abort" timer-display Not found" acall: timer-display { a.ptr -- }

1 create-master to tim
tim timer-display

