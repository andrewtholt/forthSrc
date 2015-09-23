
-1 value mqd
0 value initRun
-1 value buffer
255 constant /buffer

: init
    initRun 0= if 
        /buffer allocate abort" allocate failed" to buffer
        buffer /buffer erase
        s" /Remote" O_RDWR mq-open abort" mq-open failed" to mqd
    then
;

: tst
    init

    mqd s" This is a test" 0 mq-send abort" Test Failed." .s
;

