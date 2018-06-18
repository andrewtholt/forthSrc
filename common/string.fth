

\ address length --
\
: mk-string ( addr len  -- )
    create
        dup allocate drop dup ,
        swap dup , move 
    does>
        2@ swap
;

