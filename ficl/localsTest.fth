

: fred { | flag -- }
    flag . cr

    begin
        true to flag
    flag until
    flag . cr
;

