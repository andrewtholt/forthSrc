
argc @ . cr

\ 1 arg type cr

: tst
    argc @ 0 do 
\        i . ." :" 
        next-arg type space
    loop
    cr
;

tst
.s

bye

