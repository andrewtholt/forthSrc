
s" libc.so.6" 1 dlopen to libc
   libc 0= [if] .( Failed to open libc ) cr abort [then]

s" usleep" libc dlsym ?dup 0= [if] ." Not found" cr abort [then]
        acall: usleep { i.us -- i.is }


