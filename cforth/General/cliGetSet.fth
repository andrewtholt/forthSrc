
1 constant set
2 constant get


\ 
\ Usage:
\ On command line:
\ 
\ mk-boolean <name>
\ 
\ e.g.
\ mk-boolean fred
\ set fred true
\ 
\ get fred
\ 
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

\ <set-xt> <get-xt> mk-active-boolean <name>
\ 
\ the xt's are of words to run when set or get are called.
\ If they are 0 this acts like set-boolean
\ 
\ e.g: ' get-act ' set-act mk-active-boolean fred
\ 
: mk-active-boolean
    create
        0 ,     \ value
        ,     \ SET action
        ,     \ GET action
    does>
    \ 
    \ Stack : <cmd> <addr of value>
    \ 
    swap
    case
        set of 
            \ Stack: <addr>
            safe-parse-word $find
            if
                execute 
                .s cr
                over !
            then

            dup cell+ @ ?dup if
                swap @ swap
                execute
            else
                drop
            then
        endof

        get of 
            dup
            @
            swap 2 cells + @ ?dup if
                execute
            else
                drop
            then
        endof
        drop
    endcase
;

\ 
\ Usage: mk-int <name>
\ 
\ e.g.
\ mk-int bill
\ set bill 1234
\ get bill
\ If the value is not a number the existing value is retained.
\ 
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
\ 
\ mk-string <name>
\ 
\ e.g.
\ mk-string joe
\ set joe testing
\ get joe
\ 
\ returns a pointer to a counted string.
\ 
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

: set-act
    ." SET Action" cr
    ." TOS is " . cr
;

: get-act
    ." GET Action" cr
    ." TOS is " . cr
;

' get-act ' set-act mk-active-boolean fred
\ mk-string joe
\ mk-boolean fred
\ mk-int bill
