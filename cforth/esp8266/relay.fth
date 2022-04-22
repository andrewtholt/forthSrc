3 constant relay


0 gpio-output relay gpio-mode


: relay-on
    0 relay gpio-pin!
;


: relay-off
    1 relay gpio-pin!
;


