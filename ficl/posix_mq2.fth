
s" POSIX_IPC" environment? 0= abort" POSIX_IPC Not available" drop

0 value initRun
-1 value mqd
-1 value buffer
8192 constant /buffer

: init
    initRun 0= if
        s" /Local" O_RDWR mq-open abort" mq_open" to mqd
        -1 to initRun

        /buffer allocate abort" Allocate failed." to buffer
        buffer /buffer erase
    then
;

: main
    init

    mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed" 

    ." Number of waiting messages:" . cr

    begin
        mqd buffer /buffer 0 3500 mq-timedrecv .s abort" mq-recv Failed."
        buffer swap dump
        ." =====================================" cr
    again

    mqd mq-close abort" mq-close failed."
    buffer free  abort" free failed."

    -1 to buffer
    0 to initRun
;


