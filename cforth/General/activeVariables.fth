\
\
\

.( activeVariables ) cr

\needs struct fl struct.fth
\needs set fl cmds.fth

struct
    cell field data-value
    cell field get-cb
    cell field set-cb
endstruct struct-boolean

: data-value! \ n addr --
    data-value !
;

: data-value@   \ addr -- n
    data-value @
;


: get-cb! \ n addr -- addr
    dup -rot get-cb !
;

: set-cb! \ n addr -- addr
    dup -rot set-cb !
;

0 value ab-ptr

\ get set --
: mk-active-boolean
    create
        here                \ g s here
        dup to ab-ptr
        struct-boolean allot
        ab-ptr struct-boolean erase
        set-cb!             \ g here
        get-cb! drop
    does>  \ stack: cmd struct-ptr
        to ab-ptr
        case
            set of
                    safe-parse-word $find
                    if
                        ab-ptr swap execute
                        ab-ptr data-value !
                        ab-ptr set-cb @

                        ab-ptr set-cb @ ." ab-ptr set-cb is " . cr
                        ?dup 0<>
                        if
                            execute
                        else
                            drop
                        then
                    then
                endof
            get of

                    ab-ptr get-cb @ 0<> if
                            ab-ptr dup get-cb @
                            execute
                            ab-ptr data-value @ if ." TRUE" else ." FALSE" then cr
                        else
                            ." ENOPERM" cr
                        then
                        0 ab-ptr data-value!
                endof
            to-stack of
                ab-ptr data-value @
            endof
            drop
        endcase
\        0 to ab-ptr
;
