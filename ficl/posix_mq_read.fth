
s" POSIX_IPC" environment? 0= abort" POSIX_IPC Not available" drop

0 value initRun
-1 value mqd
-1 value buffer

: init
    initRun 0= if
\        s" /STMSend" O_RDWR mq-open abort" mq_open" to mqd
        s" /Local" O_RDWR mq-open abort" mq_open" to mqd
        -1 to initRun

        1024 allocate abort" Allocate failed." to buffer
        buffer 1024 erase
    then
;

: main
    init

    mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed" 

    ." Number of waiting messages:" . cr

    begin
        ." Test" cr
\        mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed"  0<>
        -1
    while
        ." Loop" cr

\        mqd buffer 1024 0 1500 mq-timedrecv abort" mq-recv Failed." .s
        mqd buffer 1024 mq-recv abort" mq-recv Failed." 

        swap
        ." Priority : " . cr

        buffer swap dump
        ." =====================================" cr
        1500 ms
    repeat

    mqd mq-close abort" mq-close failed."
    buffer free  abort" free failed."

    -1 to buffer
    0 to initRun
;


