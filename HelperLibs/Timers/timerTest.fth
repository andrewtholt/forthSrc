
s" timers.fth" sfind nip 0= [if]
    .( Loading timers ... ) cr
    load timers.fth
    .( ... done ) cr
[then]

0 value boss
-1 value idx
0 value setup-run
0 value call

: setup

    setup-run 0= if
        new-timer-master to boss
        -1 to setup-run
    then

;

: ficl-callback
    ." FICL Runs" cr
;

' ficl-callback to call

: main
    setup

    ." Add timer" cr
    boss 15 add-timer to idx

    ." Start timer" cr
    boss idx start-timer drop
    boss timer-display

    ." Set callback" cr
    boss idx set-callback
    boss timer-display

    ." Set callback parameters" cr
\    boss idx get-vm call set-callback-parameters
    boss idx get-vm s" ficl-callback" drop set-callback-parameters
    boss timer-display

    ." Stop timer" cr
    boss idx stop-timer drop
    boss timer-display


    ." update-timers" cr
    boss 5  update-timers drop
    boss timer-display

    ." Reset timer" cr
    boss idx reset-timer drop
    boss timer-display

    ." Start timer" cr
    boss idx start-timer drop
    boss timer-display

    3 0 do
    ." update-timers" cr
    boss 5  update-timers drop
    boss timer-display
    loop

;

main

