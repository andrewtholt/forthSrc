\
\
\
fl struct.fth

struct
    10 chars field first-name
    20 chars field  surname
    cell field get-cb
endstruct name


: tst
    create
        here
        name allot
        dup get-cb 42 swap !
    does>
;

tst fred

s" Holt" fred surname place
