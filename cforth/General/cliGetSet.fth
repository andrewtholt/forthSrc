
1 constant set          \ Set name to value, return nothing
2 constant get          \ get value assigned to name return value to stdout
3 constant to-stack     \  get value assigned to name onto stack.
\
\ <set-xt> <get-xt> mk-active-boolean <name>
\
\ the xt's are of words to run when set or get are called.
\ If they are 0 this acts like set-boolean
\
\ e.g: ' get-act ' set-act mk-active-boolean fred
\
\ Note: A read is destructive it sets the variable to false after every read.
\ TODO: Pass address to SET/GET callbacks.
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
            \
            \ First save the value.
            \ Stack: <addr>
            safe-parse-word $find
            if
                execute
                over !
            then
            \
            \ Now if the set action is non zero execute it.
            \
            dup cell+ @ ?dup if
                swap @ swap
                execute
            else
                drop
            then
        endof

        get of
            dup dup
            @
            swap 0 swap !
            swap 2 cells + @ ?dup if
                execute
            else
                drop
            then
        endof
        to-stack of
            dup @               \ addr n
            swap 0 swap !
        endof
        drop
    endcase
;
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
        0 ,
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
                @ if ." TRUE" else ." FALSE" then cr
            endof

            to-stack of
                @
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
        0 ,
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
            @ . cr
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
\ Send the cr terminated string to stdout
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
            count type cr
        endof
        drop
    endcase
;

: set-act
    ." SET Action" cr
    ." TOS is " . cr
;

: get-act
\    ." GET Action" cr
\    ." TOS is " . cr

    if
        ." TRUE" cr
    else
        ." FALSE" cr
    then
;

true constant TEST

TEST [if]
' get-act ' set-act mk-active-boolean ted
mk-string joe
mk-boolean fred
mk-int bill
[then]

