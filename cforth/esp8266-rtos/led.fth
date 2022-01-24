
#00 constant relay
#02 constant led
false value led-init-ran?

: gpio-out-off  ( gpio# -- )
    0 over gpio-pin!
    gpio-is-output
;

: gpio-out-on  ( gpio# -- )
    1 over gpio-pin!
    gpio-is-output
;

: led-off
    1 led gpio-pin!
;

: led-on
    0 led gpio-pin!
;

: relay-off
    0 relay gpio-pin!
;

: relay-on
    1 relay gpio-pin!
;

: led-init
    led-init-ran? not if
        led gpio-out-on
        relay gpio-out-off

        true to led-init-ran?
    then
;

