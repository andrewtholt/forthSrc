00 constant O_RDONLY
01 constant O_WRONLY
02 constant O_RDWR

variable prio
0 prio !

fl struct.fth 

struct
    4 field mq_flags
    4 field mq_maxmsg
    4 field mq_msgsize
    4 field mq_curmsgd
endstruct mq_attr

-1 value mqSettings
mq_attr allocate abort" Allocation failure" drop  to  mqSettings

-1 value librt
-1 value mqFd

$ff constant /mqBuffer
/mqBuffer buffer: txBuffer
/mqBuffer buffer: rxBuffer

" librt.so" 1 dlopen to librt

s" mq_open" librt dlsym abort" mq_open not found" acall: (mq_open) { a.name i.flags  -- i.fd }

s" mq_getattr" librt dlsym abort" mq_getattr not found" acall: (mq_getattr) { i.fd a.ptr -- i.rc }
s" mq_close" librt dlsym abort" mq_close not found" acall: mq_close { i.fd -- i.rc }

s" mq_send" librt dlsym abort" mq_send not found" acall: (mq_send) { i.fd a.ptr i.len i.pri -- i.rc }


s" mq_receive" librt dlsym abort" mq_receive not found" acall: (mq_receive) { i.fd a.ptr i.len i.pri -- i.rc }

: mq_getattr ( i.fd a.ptr -- i.rc ) 
    swap (mq_getattr)
;

: 3reverse ( a b c -- c b a )
    -rot swap
;

: 4reverse ( a b c d -- d c b a )
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
    4reverse (mq_send) 
;
: mq_receive
    4reverse (mq_receive) 
;

: test-write
    s" /fred" O_RDWR mq_open to mqFd

    mqFd s" this is a test" 0 mq_send .s

    0 < if 
        errno . cr
    then

    mqFd mq_close drop
;

: test-read
    s" /fred" O_RDONLY mq_open to mqFd

    mqFd rxBuffer $ff prio mq_receive .s cr

    0 < if 
        errno . cr
    else
        rxBuffer 20 dump
    then

    mqFd mq_close drop
;


