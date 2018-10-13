
0 value all-done

0 value init-run
0 value cmdBuffer
132 constant /cmdBuffer

: init
    init-run 0= if
        /cmdBuffer allocate abort" allocate failed" to cmdBuffer

        cmdBuffer /cmdBuffer erase

        -1 to init-run
    then
;

: safe-interp
    init
    begin
        all-done 0=
    while
        ." Here>" 
        cmdBuffer /cmdBuffer accept
        bl cmdBuffer /cmdBuffer strtok

        begin
            dup 0> if
                2dup type cr
                drop find .s
                bl 0 /cmdBuffer strtok dup
            then
        0= until

        ." test" cr
        2drop drop
        .s
    repeat
        
;
