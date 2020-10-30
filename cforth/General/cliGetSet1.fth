\
\
\
32 constant STRING-LENGTH

fl struct.fth
fl enum.fth

1 enum get
  enum set
  enum to-stack
drop

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
                        ab-ptr swap
                        execute
                        ab-ptr data-value !
                    then
                endof
            get of
                    ab-ptr data-value @ if ." TRUE" else ." FALSE" then cr

                    ab-ptr get-cb @ 0<> if
                            ab-ptr dup get-cb @
                            execute
                        then
                        0 ab-ptr data-value!
                endof
            to-stack of
                ab-ptr data-value @
            endof
            drop
        endcase
        0 to ab-ptr
;

: get-act
    ." get-act" cr
    .s
;

: set-act
    ." set-act" cr
    .s
;


\ 0 0 mk-active-boolean fred
' get-act ' set-act mk-active-boolean fred
\ s" Holt" fred surname place
