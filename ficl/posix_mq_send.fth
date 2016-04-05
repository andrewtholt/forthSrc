
s" POSIX_IPC" environment? 0= abort" POSIX_IPC Not available" drop

load lib.fth

0 value initRun
-1 value mqd
-1 value buffer
1024 constant /buffer
0 value count
0x7f value counter

: init
    initRun 0= if
        s" /Local" O_WRONLY mq-open abort" mq_open" to mqd
        -1 to initRun
    
        /buffer allocate abort" Allocate failed." to buffer
        buffer /buffer erase
    then
;

: msg

    count s>d <# # # # #s #> buffer 1+ swap move
    counter 0xff and buffer c!
    counter 1+ to counter
;

: main
    init

    begin
        mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed" 
        ." Number of waiting messages:" . cr

        msg

        mqd buffer 32 count mq-send abort" mq-recv Failed." .s
        buffer 32 dump
        ." =========================" cr

        count 1+ 2 mod to count
        1750 ms
    again

    mqd mq-close abort" mq-close failed."
    buffer free  abort" free failed."

    -1 to buffer
    0 to initRun
;


