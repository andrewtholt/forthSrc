    
 


marker mqtt-client

: iam s" heater" ;

fl led.fth

false value init-run?

false value logic-state
false value old-logic-state

false value mqtt-state
mqtt-state value old-mqtt-state


0 value sun_rise
0 value sun_set
-1 value now
0 value dow

0 value am_on_time
0 value am_off_time

0 value pm_on_time
0 value pm_off_time

true value first-time

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

: publish ( topic n msg n -- )    
    msg-buffer place    
    topic-buffer place    
    msg-buffer count topic-buffer count 0 0 mqtt-publish-qos0    
    mqtt-fd do-tcp-poll
;    
    
: publish-retain ( topic n msg n -- )    
    msg-buffer place    
    topic-buffer place    
    msg-buffer count topic-buffer count 0 1 mqtt-publish-qos0    
    mqtt-fd do-tcp-poll
;

: set-lwt-online 
    s" Online"

    s" /home/office/heater/LWT" s" Online" publish

;

: set-lwt-offline 
    s" Offline"

    s" /home/office/heater/LWT" s" Offline" publish-retain

;

fl time.fth

: to-int ( addr - n -- )

    base @ >r
    decimal
    $number abort" Not a number."
    r> base !
    
;

: weekend    
    dow dup 0= swap 6 = or     
;    
    
: weekday    
    weekend invert    
;

: day ( -- flag )                     
    sun_rise sun_set now between    
;    
    
: night ( -- flag )    
    day invert    
;

also mqtt-topics definitions

: /home/office/heater/cmnd/power

    ." Power " depth .d
    led-state? to old-mqtt-state
    s" ON" $= if
        true  to mqtt-state 
        relay-on

        ." MQTT on" cr
        s" /home/office/heater/POWER" s" ON" publish
    else
        false to mqtt-state 
        ." MQTT off" cr
        relay-off

        s" /home/office/heater/POWER" s" OFF" publish
    then
    ." Power " depth .d cr

    mqtt-fd do-tcp-poll
;

: /test/start
    ." Test start:" 
    type cr

;

: /home/environment/SUNRISE

    ." SUNRISE " 2dup type cr
    time dup 0>= if
        to sun_rise
    else
        drop
    then
;

: /home/environment/SUNSET

    ." SUNSET  " 2dup type cr
    time to sun_set
;

: /home/environment/TIME
    ." Time " cr
    ." IN:" depth .d cr
    2dup
    dump
    2dup
    time dup 0>= if 
        to now 
        ." TIME=" type cr
        led-toggle
    else
        depth . cr
        drop
        2drop
        ." Bad time ========================================" cr
    then

    get-msecs #1000 / .d cr
    ." OUT:" depth .d cr
;

: /home/environment/DOW

    ." DOW " 2dup type cr
    to-int to dow
;

: /ctl/porchlight/AM_ON_TIME    
    ." AM_ON_TIME "    
    2dup       
    type cr    
    
    time to am_on_time    
;

: /ctl/porchlight/AM_OFF_TIME    
    ." AM_OFF_TIME "    
    2dup       
    type cr    
    
    time to am_off_time    
;

: /ctl/porchlight/PM_ON_TIME    
    ." PM_ON_TIME "    
    2dup       
    type cr    
    
    time to pm_on_time    
;

: /ctl/porchlight/PM_OFF_TIME    
    ." PM_OFF_TIME "    
    2dup       
    type cr    
    
    time to pm_off_time    
;

previous definitions

: setup
    s" 06:00" time to am_on_time
    s" 08:30" time to am_off_time

    s" 17:00" time to pm_on_time
    s" 23:00" time to pm_off_time

;

:noname s" Offline" s" /home/office/heater/LWT" ; to mqtt-will$


: wait-for-time
    begin
        mqtt-fd do-tcp-poll
        100 ms
        now 0>
    until
;

: mqtt-all
    ['] mqtt-topics follow
    begin  another?  while
        mqtt-fd do-tcp-poll
        >name$
        ." Subscribing to " 2dup type cr
        0 -rot  1 #1235 mqtt-subscribe
        #10 ms
    repeat
;

: mqtt-init

    init-run? 0= if
        ['] mqtt-start catch .s

        0<> if
            ." mqtt-init failed" cr
            #1000 ms
            bye
        then

        1 to mqtt-will-retain
        set-lwt-offline
        mqtt-fd do-tcp-poll
        
        errno #128 = if
            ." Failed to read." cr
            #5000 ms
            bye
        then

        0 " /home/environment/TIME"  1 #1235 mqtt-subscribe

        mqtt-fd do-tcp-poll

        0 " /home/office/heater/cmnd/power" 1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll

        0 " /home/environment/SUNRISE"  1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll
        0 " /home/environment/SUNSET"  1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll

        0 " /home/environment/DOW"  1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll

        0 s" /ctl/porchlight/AM_ON_TIME" 1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll
        0 s" /ctl/porchlight/AM_OFF_TIME" 1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll

        0 s" /ctl/porchlight/PM_OFF_TIME" 1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll


        ." Waiting for time ..." cr
        wait-for-time
        ." ... over." cr
        mqtt-fd do-tcp-poll

        0 s" /ctl/porchlight/PM_ON_TIME" 1 #1235 mqtt-subscribe
        mqtt-fd do-tcp-poll
        s" /home/office/heater/LWT" s" Offline" publish-retain

        true to init-run?
    then
;


: logic 
    am_on_time am_off_time now between
    pm_on_time pm_off_time now between or
    night and
    weekday and to logic-state
;

: logic-changed?
    old-logic-state logic-state <>
    logic-state to old-logic-state
;

: mqtt-changed?
    old-mqtt-state mqtt-state <>
    mqtt-state to old-mqtt-state
;

: btn-changed?
    btn-state? to btn-state
    btn-state old-btn-state <>

    btn-state to old-btn-state
;

false value mqtt-debug?

: btn-testing
    begin
        #100 ms
        btn-changed?
        if
            ." Button changed to " btn-state . cr
        then
        key?
    until
;

: btn-proc
    btn-changed?
    if
        ." Button changed to " btn-state . cr

        btn-state if
            led-toggle
        then
    then
;

: logic-proc
    logic 
    logic-changed? first-time or if
        ." logic changed." cr
        logic-state led-to-state
        logic-state relay-to-state
        s" /home/office/heater/POWER" logic-state logic-to-string publish
        0 to first-time
    then
;

: mqtt-proc
    mqtt-changed? if
        ." mqtt changed." cr
        mqtt-state led-to-state
        mqtt-state relay-to-state
    then
;

variable connection-count
#10 connection-count !

: wait-for-connection
    begin
        ip-connected? false =
    while
        ." No ip addrress"
        connection-count @ .d cr
        led-on
        #500 ms
        led-off
        #500 ms
        -1 connection-count +!
        connection-count @ 0 <= if
            bye
        then
    repeat
    #10 connection-count !
;

0 value loop-counter

: loop-counter++
    loop-counter 1+
    to loop-counter
;

#600 constant update-frequency

: update-state
    ." Update state" cr
    s" /home/office/heater/POWER" logic-state logic-to-string publish
;

: update-state-loop

    loop-counter update-frequency mod 0= if
        update-state
        set-lwt-online
    then
    loop-counter++
;


: mqtt-run

    setup
    led-init

    led-on

    wait-for-connection
    
    mqtt-init

    true to first-time

    set-lwt-online
    led-off

    false to old-logic-state 
    false to logic-state

    begin
        clear 
        wait-for-connection

        mqtt-buffer /mqtt-buffer erase
        mqtt-fd do-tcp-poll

        errno #128 = if
            bye
        then

        btn-proc
        logic-proc
        mqtt-proc

        update-state-loop
        50 ms

        key?
    until
    set-lwt-offline
    ." Resetting ========" cr
    bye
;

mqtt-run


