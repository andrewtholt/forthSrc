
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
    @ ?dup 0= if
        ." Empty" cr
    else
        ." Not Empty" cr

        begin
            dup .arc cr
            get-next ?dup 0=
        until
    then
;

\ given an arc it will execute the cause, of that return true then,
\ it will execute the effect and return the next state.
\ 
\ A return of < 0 indicates that no state change should take place
\ 
: executeArc ( arc -- ns|-1 )
    dup get-cause ?dup 0<> if 
        execute if
            dup get-effect ?dup 0<> if
                execute
                get-state
            else 
                drop -1
            then
        else
            drop -1
        then
    else
        drop -1
    then
;

: execute-node ( head )
    ?dup 0<> if
        @
        begin
            dup executeArc dup 0< if    \ condition to change state not true
                swap
                get-next
                ?dup 0=
            else                        \ new state
                nip
                dup 0< invert
            then
        until
    then
;

\ 
\ e.g. 0 nodes one
\ 
: addArc ( state machine arc  )
    >r      \ 0 nodes
    swap cells + \ head
    r> swap addToFront
;

: .machine ( machine )
    node-list-size 0 do
        i . 09 emit
        dup i cells + @ .
        cr
    loop
    drop
;

\ given the current state and the machine return a pointer to
\ the head of the lists of arcs
\ 
: get-active-node ( state machine -- head )
    swap cells + 
;

: run-machine ( machine )
    >r
    begin
        ." State is "
        current-state . cr

        current-state cells r@ + @
        executeArc dup 0< invert if \ 0>=
            to current-state
        else
            drop
        then

        1000 ms
        .s
        ?key
    until
    r> drop
;

mk-arc value one
:noname true ; one set-cause
1 one set-state
one .arc

mk-arc value two
' null-cause two set-cause
' noop two set-effect
0 two set-state

0 nodes one addArc
1 nodes two addArc

\ :noname noop ; one set-effect
\ 
\ 1 one set-state
\ 
