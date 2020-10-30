
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
\ Executed when an active variable is set.
\
\ stack: <ptr to struct boolean> --
\ NOTE: Must add nothing to the stack.
\
: set-act
    ." set-act" cr
    .s
    drop
;

defer connect-act

' set-act to connect-act


: no-get-allowed
    drop
    ." ENOPERM" cr
;


\ 0 0 mk-active-boolean fred
\ ' get-act ' set-act mk-active-boolean wifi-connect
\ ' connect-act ' set-act mk-active-boolean wifi-connect
0 ' connect-act mk-active-boolean wifi-connect

\ 0 ' set-act mk-active-boolean bill
0 0 mk-active-boolean bill
\ s" Holt" fred surname place

mk-boolean wifi-connected
mk-string wifi-ssid
mk-string wifi-password

set wifi-ssid HoltAtHome4








