
00 constant O_RDONLY
01 constant O_WRONLY
02 constant O_RDWR

-1 value librt
-1 value libc 

" libc.so.6" 1 dlopen to libc

" librt.so" 1 dlopen to librt

s" open" libc dlsym abort" Not Found" acall: fred { $.filename i.flags -- i.fd }
." Here" cr

" /tmp/fred.txt" O_RDONLY fred .s
errno .

" mq_open" librt dlsym abort" Not founs" acall: mq_open { a.name i.len i.oflag -- i.fd }
." Here" cr


\ s" /fred" O_WRONLY mq_open .s

\ 
\ -1 value libc 
\ 
\ " libc.so.6" 1 dlopen to libc
\ 
\ s" usleep" libc dlsym abort" Not Found" acall: usleep { i.microseconds -- h.error? }
\ 
