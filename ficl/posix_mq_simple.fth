
-1 value mqd
0 value initRun
-1 value buffer
255 constant /buffer
0 value count

: init
    initRun 0= if 
        /buffer allocate abort" allocate failed" to buffer
        buffer /buffer erase
        s" /Local" O_RDWR mq-open abort" mq-open failed" to mqd
    then
;

: tst
    init

    mqd s" This is a test" 0 mq-send abort" Test Failed." .s
;

: tst1
    init

    mqd
    count s>d <# # # # #s #> 0 mq-send abort" Test Failed." .s

    count 1+ to count
;
