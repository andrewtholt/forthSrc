
0 value init-run?
0 variable fred

fl led.fth

also mqtt-topics definitions

: /home/office/officeLights/POWER
    2dup type cr
    1 fred +!

    s" ON" $= if
        led-on
    else
        led-off
    then
;

previous definitions

: init
    init-run? 0= if
        0 " /home/office/officeLights/POWER" 1 #1235 mqtt-subscribe
        1 to init-run?
    then
;

: run

    init
    led-init

    clear
    begin
        mqtt-fd do-tcp-poll
        100 ms

        key?
    until
;

