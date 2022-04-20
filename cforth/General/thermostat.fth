

#20 value max_temp

max_temp dup #10 / - value min_temp

1 constant cooling
2 constant heating
3 constant disabled

false value op_state

cooling value current_state

: cool
    ." Heat off" cr
    false to op_state

    min_temp < if
        heating to current_state
    then
;
        
: heat 
    ." Heat on" cr
    true to op_state

    max_temp > if
        cooling to current_state
    then
;


: test ( temp --- )
    current_state case
        cooling of
            cool
            endof
        heating of
            heat
            endof
        disabled of
            ." Nothing" cr
        endof
    endcase
;

: start
    cooling to current_state
;

: stop
    ." Heat off" cr
    disabled to current_state
    false to op_state

;

    

: tst-up
    #25 #10 do
        i dup  .d test
    loop
;


: tst-down 
    #10 #25 do
        i dup .d test
        -1 
    +loop
;

