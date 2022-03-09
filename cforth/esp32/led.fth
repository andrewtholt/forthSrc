
\ #02 constant led
#22 constant led

false value led-init-ran?

: gpio-out-off  ( gpio# -- )
    0 over gpio-pin!
    gpio-is-output
;

: led-on
    1 led gpio-pin!
;


: led-off
    0 led gpio-pin!
;

: led-init
    led-init-ran? not if
        led gpio-out-off

        true to led-init-ran?
    then
;

