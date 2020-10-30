
\needs struct fl struct.fth
\needs set fl cmds.fth
.( variables ) cr

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

