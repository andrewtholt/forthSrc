
load struct.fth

4 constant node-list-size

0 value current-state

: array
    create
        here dup , 
        node-list-size cells allot
        node-list-size cells erase
    does>
        swap cells +
;

: noop ;

: null-cause
    false
;

defer default-cause
defer default-effect

here node-list-size cells allot constant nodes

nodes node-list-size cells erase

' null-cause is default-cause
' noop is default-effect

struct
    1 cells field cause
    1 cells field effect
    1 cells field nextArc
    1 cells field nextState
endstruct arc

: mk-arc
    create 
        ['] default-cause ,
        ['] default-effect ,
        0 ,
        0 ,
    does>
;

: set-cause ( xt addr -- )
    cause !
;

: get-cause ( addr -- xt )
    cause @
;

: set-effect ( xt addr -- )
    effect !
;

: get-effect ( addr -- xt )
    effect @
;

: set-next ( n addr -- )
    nextArc !
;

: get-next ( addr -- n )
    nextArc @
;

: set-state ( n addr -- )
    nextState !
;

: get-state ( addr -- n )
    nextState @
;

: run-state ( state machine )
    
;

: (state-ptr)
    swap cells +
;

: state-ptr ( state machine -- addr )
    (state-ptr) @
;

\ Add n to the the head of the list.
\ 
: addToFront ( n head ) 
    dup @ 0= if
        !
    else
        
    then
;


: addArc ( state machine  arc  )
    -rot
    (state-ptr) dup @ ?dup

    if
        ." Set" cr
    else
        ." Empty" cr 

    then
;

here 4 cells allot constant machine
mk-arc one

:noname true ; one set-cause
:noname noop ; one set-effect

1 one set-state

