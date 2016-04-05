

include(defs.fth)

: init
    RELAY OUT pinMode
    RELAY OFF pinWrite

;

: main
    init

    RELAY pinRead OFF = if
        LDR analogRead
        LOW < if
            RELAY ON pinWrite
        then
    else
        LDR analogRead
        HIGH > if
            RELAY OFF pinWrite
        then
    then
;


