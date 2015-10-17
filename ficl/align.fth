\ 
\ Align to a boundry of w bytes.
\ 
: align ( a w )
    dup -rot + swap mod - 
;
