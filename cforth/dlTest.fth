-1 value libc 
-1 value librt

" libc.so.6" 1 dlopen to libc

s" usleep" libc dlsym abort" Not Found" acall: usleep { i.microseconds -- h.error? }

" librt.so" 1 dlopen to librt

s" mq_open" librt dlsym abort" mq_open not found" acall: mq_open { $.name i.flags -- i.fd }

