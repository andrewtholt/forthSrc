
#17 constant RLY

: relay-init
    ?map-gpio
    RLY gpio-is-output

;

: relay-on
    RLY gpio-set
;

: relay-off
    RLY gpio-clr
;

: relay-tst
    RLY gpio-set
    #500 ms
    RLY gpio-clr
    #500 ms
;


