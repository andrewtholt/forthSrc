\ 
\ Join two strings.
\ 
-1 value p1
-1 value n1


: join ( p1 n1 p2 n2 -- p1 n3 )
    dup 4 pick +
    >r
    4 pick 4 pick +
    swap move
    drop r>
;

: join-test 
    32 allocate abort" Allocate" to p1
    4 to n1

    s" Test" p1 swap move
    p1 10 dump
    cr

    p1 n1 s" ing" join

    10 + dump
;

cr
.( Enter join-test to run test ) cr cr
    


