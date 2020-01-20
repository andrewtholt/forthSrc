00 constant O_RDONLY
01 constant O_WRONLY
02 constant O_RDWR

-1 value librt
-1 value mqFd

255 constant /mqBuffer
/mqBuffer buffer: txBuffer
/mqBuffer buffer: rxBuffer

" librt.so" 1 dlopen to librt

s" mq_open" librt dlsym abort" mq_open not found" acall: (mq_open) { a.name i.flags  -- i.fd }

s" mq_close" librt dlsym abort" mq_close not found" acall: mq_close { i.fd -- i.rc }

s" mq_send" librt dlsym abort" mq_send not found" acall: (mq_send) { i.fd a.ptr i.len i.pri -- i.rc }

: 4reverse
    swap 2swap swap
;

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

: mq_send
    4reverse (mq_send) .s
;

: test
    s" /fred" O_WRONLY mq_open to mqFd

    mqFd s" this is a test" 1 mq_send .s

    0 < if 
        errno . cr
    then
;

