
s" POSIX_IPC" environment? 0= abort" POSIX_IPC Not available" drop

load lib.fth
load struct.fth

struct
    uint8_t field NID_PACKET
    uint8_t field length
    uint8_t field sender
    
    uint8_t field N_058_VERMAJOR
    uint8_t field N_058_VERMID
    uint8_t field N_058_VERMINOR
    uint8_t field N_035_VERMAJOR
    uint8_t field N_035_VERMID
    uint8_t field N_035_VERMINOR
    uint8_t field N_SRS_VERMAJOR
    uint8_t field N_SRS_VERMID
    uint8_t field N_SRS_VERMINOR
endstruct /stm1

0 value initRun

-1 value mqd-dispatch
-1 value mqd-send

-1 value buffer
-1 value once

255 constant /buffer

: init
    initRun 0= if
    s" /STMDistpatch" O_RDWR mq-open abort" mq_open" to mqd-dispatch
    s" /STMSend" O_RDWR mq-open abort" mq_open" to mqd-send

    -1 to initRun
    
    1024 allocate abort" Allocate failed." to buffer
    buffer /buffer erase
then
;

: stm1
    buffer /buffer erase
    0x01 buffer NID_PACKET drop c!
    /stm1 buffer length drop c!
    0x33 buffer sender drop c!
    /stm1
;

: main
    init
    stm1

    begin
        mqd-dispatch MQ_CURMSGS mq-getattr abort" mq-getattr failed" 
        ." Number of waiting messages:" . cr

        mqd-dispatch buffer /stm1 0 mq-send abort" mq-recv Failed." .s

        buffer /stm1 dump
        ." =========================" cr
        750 ms
        once
    until

    mqd-dispatch mq-close abort" mq-close failed."
    buffer free  abort" free failed."

    -1 to buffer
    0 to initRun
;

: dispatch
    init
    bl word find 0= abort" send" execute  \ length
    >r

    mqd-dispatch buffer r@ 0 mq-send abort" mq-recv Failed." .s

    buffer r> dump
    ." =========================" cr

;

: send
    init
    bl word find 0= abort" send" execute  \ length
    >r

    mqd-send buffer r@ 0 mq-send abort" mq-recv Failed." .s

    buffer r> dump
    ." =========================" cr

;







