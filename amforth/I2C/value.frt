#require synonym.frt

: Uvalue ( n offs -- )
    (value)
    dup ,
    ['] Udefer@ ,
    ['] Udefer! ,
    up@ + !
;

: Rvalue ( n -- )
    (value)
    here ,
    ['] Rdefer@ ,
    ['] Rdefer! ,
    here ! 2 allot
;

: Evalue ( n -- )
    (value)
    ehere ,
    ['] Edefer@ ,
    ['] Edefer! ,
    ehere dup cell+ to ehere !e
;


synonym value Rvalue

