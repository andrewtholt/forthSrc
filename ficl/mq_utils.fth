
\ 
\ Empty a posix queue
\
: flushq { mqd | buffer }

    8192 allocate abort" flushq allocate failed" to buffer
    
    mqd MQ_CURMSGS mq-getattr abort" mq-getattr" 
    ." Number of waiting messages " . cr
    begin
        mqd MQ_CURMSGS mq-getattr abort" mq-getattr" 
    while
        mqd buffer 8192 0 mq-recv abort" mq-recv" 
        ." Length :" . cr
    repeat
    
    buffer free
;
