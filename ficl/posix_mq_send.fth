
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
-1 value mqd
-1 value buffer
0 value count

: init
    initRun 0= if
    s" /Local" O_WRONLY mq-open abort" mq_open" to mqd
    -1 to initRun
    
    1024 allocate abort" Allocate failed." to buffer
    buffer 1024 erase
then
;

: msg
\    0x01 buffer NID_PACKET drop c!
\    /stm1 buffer length drop c!
\    0x33 buffer sender drop c!

    count s>d <# # # # #s #> buffer swap move
;

: main
    init

    begin
        mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed" 
        ." Number of waiting messages:" . cr

        msg

        mqd buffer /stm1 count mq-send abort" mq-recv Failed." .s
        buffer /stm1 dump
        ." =========================" cr

        count 1+ 2 mod to count
        1750 ms
    again

mqd mq-close abort" mq-close failed."
buffer free  abort" free failed."

-1 to buffer
0 to initRun
;


