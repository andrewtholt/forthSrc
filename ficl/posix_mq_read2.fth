
s" POSIX_IPC" environment? 0= abort" POSIX_IPC Not available" drop

0 value initRun
-1 value mqd
-1 value buffer

: init
    initRun 0= if
        s" /STMSend" O_RDWR mq-open abort" mq_open" to mqd
        -1 to initRun

        1024 allocate abort" Allocate failed." to buffer
        buffer 1024 erase
    then
;

: main
    init


    begin
        mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed" 
        ." Number of waiting messages:" . cr

        mqd buffer 1024 0 5000 mq-timedrecv 0<> if
            ." timed out." cr
        else
\        mqd buffer 1024 0 mq-recv abort" mq-recv Failed." 

            buffer swap dump
        ." =====================================" cr
        then
\        1500 ms
    again

    mqd mq-close abort" mq-close failed."
    buffer free  abort" free failed."

    -1 to buffer
    0 to initRun
;


