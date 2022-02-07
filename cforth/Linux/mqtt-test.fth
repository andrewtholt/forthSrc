
fl ../utils.fth

0 value init-run?
0 variable fred
0 variable old-fred

#32 constant /msg-buffer
#255 constant /topic-buffer

/msg-buffer   buffer: msg-buffer
/topic-buffer buffer: topic-buffer


: base-topic " /home/office/forth/" ;

: tst1    
    base-topic pad place    
    s" STATE" pad +place    
    pad count    
;

: tst-pub 
    base-topic topic-buffer place
    " state" topic-buffer +place

    fred @ to-string msg-buffer place

    msg-buffer count topic-buffer count 0 0 mqtt-publish-qos0

;

also mqtt-topics definitions

: /home/office/forth/cmnd/POWER
    type cr
    1 fred +!
;

previous definitions


: mqtt-init
    init-run? 0= if
        mqtt-start
        0 " /home/office/forth/cmnd/POWER" 1 #1235 mqtt-subscribe
        1 to init-run?
    then
;

: mqtt-run

    mqtt-init
\    led-init

    clear
    mqtt-fd non-blocking
    begin
        mqtt-fd mqtt-poll
        #50 ms

        old-fred @ fred @ < if
            tst-pub
            fred @ old-fred !
        then
        key?
    until
;

