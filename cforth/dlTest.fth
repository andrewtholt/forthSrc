-1 value libc 
-1 value librt
-1 value mqFd

" libc.so.6" 1 dlopen to libc

s" usleep" libc dlsym abort" Not Found" acall: usleep { i.microseconds -- h.error? }

" librt.so" 1 dlopen to librt

s" mq_open" librt dlsym abort" mq_open not found" acall: (mq_open) { a.name i.flags  -- i.fd }

: null-terminate ( addr len -- c-addr )
    2dup 
    + 0 swap c!
    drop
;

: mq_open ( addr n flag -- fd )
    -rot  \ flag addr n
    null-terminate \ flag addr
    (mq_open)
;

: test
    s" /fred" 1 mq_open to mqFd
;

