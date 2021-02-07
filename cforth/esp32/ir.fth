
\ IR remote.
\ buttons arranged in 3 columns of 7
\ central column wont be used.
\ so 14 functions
\ 
\ setup mqtt.fth
\ 
fl mqtt-settings.fth

hex
0 value init-run?

$5e constant /size  \ size of button table
$20 constant /topic \ Size of MQTT topic
$20 constant /msg   \ Size of MQTT msg
\ 
\ Add a byte value to a value in memory
\ 
: +c!
    dup c@ rot +
    swap c!
;

\ 
\ c1 holds a counted string,
\ addr and len are a string to be appended to the end of it
\
: $cat { c1 addr len }
    c1 count + addr swap len cmove 
    len c1 +c!
;

create button-table /size cells allot

create topic /topic allot
create msg /msg allot

: base-topic
    topic /topic erase
\    s" /home/ir/row" topic place
    stub-topic topic place
;

: index-table ( idx -- ptr )
    cells button-table +
;

: not-set 
    topic /topic erase
    msg /msg erase
; 

: ch-
    s" ON" msg place
    base-topic 
    topic s" 1" $cat
;

: ch
    s" OFF msg place
    base-topic 
    topic s" _ALL" $cat
;

: ch+
    s" OFF" msg place
    base-topic 
    topic s" 1" $cat
;

: prev
    s" ON" msg place
    base-topic 
    topic s" 2" $cat
;

: play
    s" OFF" msg place
    base-topic 
    topic s" 2" $cat
;

: minus
    s" ON" msg place
    base-topic 
    topic s" 3" $cat
;

: eq
    s" OFF" msg place
    base-topic 
    topic s" 3" $cat
;

: zero
    s" ON" msg place
    base-topic 
    topic s" 4" $cat
;

: 2hundred
    s" OFF" msg place
    base-topic 
    topic s" 4" $cat
;

: one
    s" ON" msg place
    base-topic 
    topic s" 5" $cat
;

: three
    s" OFF" msg place
    base-topic 
    topic s" 5" $cat
;

: four
    s" ON" msg place
    base-topic 
    topic s" 6" $cat
;

: six
    s" OFF" msg place
    base-topic 
    topic s" 6" $cat
;

: seven
    s" ON" msg place
    base-topic 
    topic s" 7" $cat
;

: nine
    s" OFF" msg place
    base-topic 
    topic s" 7" $cat
;

: init-table
    /size 0 do
        ['] not-set i index-table !
    loop
\ 
\ row 1    
\ 
    ['] ch-  $45 index-table ! 
    ['] ch   $46 index-table ! 
    ['] ch+  $47 index-table ! 
\ 
\ row 2
\ 
    ['] prev $44 index-table ! 
    ['] play $43 index-table ! 
\ 
\ row 3
\
    ['] minus $07 index-table ! 
    ['] eq    $09 index-table ! 
\ 
\ row 4
\ 
    ['] zero     $16 index-table ! 
    ['] 2hundred $0d index-table ! 
\ 
\ row 5
\ 
    ['] one   $0c index-table ! 
    ['] three $5e index-table ! 
\ 
\ row 6
\ 
    ['] four $08 index-table ! 
    ['] six  $5a index-table ! 
\ 
\ row 7
\ 
    ['] seven $42 index-table ! 
    ['] nine  $4a index-table ! 

;

: execute-button ( btn-code --- ptr )
    dup /size > if
        drop
        ." Invalid key code" cr
        0
    else
        index-table @ execute
    then

    topic /topic dump 
    cr cr
    msg /msg dump
    cr
;

: init
    init-run? 0= if
        init-table
        init-uart1

        uart1-flush

        -1 to init-run?
    then
;

1 value ir-state

: publish
    topic c@ 0<> if
        msg count
        topic count
        0 0
        mqtt-publish-qos0
    then
;

: wb1
    begin
        uart1-key 0=
    until
    2 to ir-state
;

: wb2 
    uart1-key $ff =
    if
        3 to ir-state
    else
        1 to ir-state
    then
;

0 value exit-flag

: wb3 
    uart1-key dup $52 = if
        -1 to exit-flag
    then
    execute-button
    publish
;

: state-machine
    1 to ir-state
    0 to exit-flag
    begin
        ir-state case
            1 of wb1 endof
            2 of wb2 endof
            3 of wb3 endof
        endcase
        exit-flag
    until
;


: main
    init
    state-machine
;




