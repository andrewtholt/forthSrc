
#02 constant led
0 value init-run?

: gpio-out-off  ( gpio# -- )  0 over gpio-pin!  gpio-is-output  ;

: init
    init-run? 0= if
        led gpio-out-off
        -1 to init-run?
    then
;

: led-on
    init
    1 led gpio-pin!
;


: led-off
    init
    0 led gpio-pin!
;

: blinky
    init
    begin
        led-on
        250 ms
        led-off
        250 ms
    again
;



