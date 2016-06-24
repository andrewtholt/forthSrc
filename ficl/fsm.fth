
load ./struct.fth

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

: .arc ( ptr -- )
    ?dup 0= if
        ." Empty" cr
    else
        dup ." Cause     : " cause     @ . cr
        dup ." Effect    : " effect    @ . cr
        dup ." Next      : " nextArc   @ . cr
            ." Next State: " nextState @ . cr
    then
    
;

: mk-arc
    here arc allot >r
    r@ arc erase

    ['] default-cause  r@ cause !
    ['] default-effect r@ effect !
    0 r@ nextArc   !
    0 r@ nextState !
    r>
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
    else \ n head
        2dup @   \ n head n p
        swap set-next   \ n head
        !
        
    then
;

: dump-list ( head )
    dup @ ?dup 0= if
        ." Empty" cr
        drop
    else
        ." Not Empty" cr

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

mk-arc value one
\ mk-arc one
\ 
\ :noname true ; one set-cause
\ :noname noop ; one set-effect
\ 
\ 1 one set-state
\ 
