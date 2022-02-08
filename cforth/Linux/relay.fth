
#17 constant RLY

: relay-init
    ?map-gpio
    RLY gpio-is-output

;

: relay-on
    RLY gpio-clr
;

: relay-off
    RLY gpio-set
;

: relay-tst
    RLY gpio-set
    #500 ms
    RLY gpio-clr
    #500 ms
;


