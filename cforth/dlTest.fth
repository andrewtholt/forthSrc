-1 value libc 

" libc.so.6" 1 dlopen to libc

s" usleep" libc dlsym abort" Not Found" acall: usleep { i.microseconds -- h.error? }

