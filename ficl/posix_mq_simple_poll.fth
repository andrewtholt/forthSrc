
-1 value mqd
0 value initRun
-1 value buffer
255 constant /buffer
0 value count
-1 value ptr

: .pending
    mqd MQ_CURMSGS mq-getattr abort" mq-getattr failed"
    ." Pending " . cr
;

: getsize \ mqd -- size
    mqd MQ_MSGSIZE mq-getattr abort" mq-getattr failed"
;

: .size
    mqd getsize
    ." Max Message " . cr
;

: init
    initRun 0= if 
        /buffer allocate abort" allocate failed" to buffer
        buffer /buffer erase

        16 allocate abort" allocate small failed." to ptr

        s" /TEST" O_RDWR mq-create abort" mq-open failed" to mqd
    then
;

: tst
    init

    mqd s" This is a test" 0 mq-send abort" Test Failed." .s
;

: tx
    init

    mqd
    count s>d <# # # # #s #> 0 mq-send abort" Test Failed." .s

    count 1+ to count
;

: rx
    init

    1 ptr c!
    mqd ptr 1+ c!

    ." before." cr
    ptr 8 dump
    ptr poll

    ." After." cr
    ptr 8 dump
    cr

    mqd buffer getsize  0 mq-recv abort" mq-recv Failed."

    buffer swap 0x10 + dump
;

