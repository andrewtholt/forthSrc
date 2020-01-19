-1 value libc 
-1 value librt

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
    >r null-terminate r> swap .s (mq_open)
;

: test
    s" /fred" null-terminate 1 swap (mq_open) .
;

