
-1 constant tst.fth

\needs mk-active-boolean fl activeVariables.fth
\needs mk-boolean fl variables.fth

\
\ Executed ehen an active variable is set.
\
\ stack: <ptr to struct boolean> --
\ NOTE: Must add nothing to the stack.
\
: get-act
    ." get-act" cr
    .s
    drop
;

\
\ Executed ehen an active variable is set.
\
\ stack: <ptr to struct boolean> --
\ NOTE: Must add nothing to the stack.
\
: set-act
    ." set-act" cr
    .s
    drop
;

: no-get-allowed
    drop
    ." ENOPERM" cr
;


\ 0 0 mk-active-boolean fred
' get-act ' set-act mk-active-boolean fred

\ 0 ' set-act mk-active-boolean bill
0 0 mk-active-boolean bill
\ s" Holt" fred surname place
