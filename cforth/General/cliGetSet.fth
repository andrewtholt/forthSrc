
1 constant set
2 constant get


: mk-boolean
    create
    does>
    swap
    case
        set of 
            safe-parse-word $find
            if
                execute swap !
            then
        endof

        get of 
            @
        endof
        drop
    endcase
;

: mk-int
    create
    does>
    swap
    case
        set of 
            safe-parse-word $number
            0= if 
                swap !
            else
                drop
            then
        endof

        get of 
            @
        endof
        drop
    endcase
;

32 constant STRING-LENGTH

: mk-string
    create
        STRING-LENGTH allot
    does>
    swap
    case
        set of 
            safe-parse-word rot place
        endof

        get of 
        \ Just return the storage address
        endof
        drop
    endcase
;

mk-string joe
mk-boolean fred
mk-int bill
