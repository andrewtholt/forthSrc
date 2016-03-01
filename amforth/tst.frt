
\ s" START" find-name [if]
\ drop
\ START
\ [then]

marker START
#require ms.frt

$08 constant WDRF
$04 constant BORF
$02 constant EXTRF
$01 constant PORF

PORTB 5 portpin: led

: tst 
  10 0 do
    i . cr
  loop
;

: blinky ( n -- )
    led pin_output
    led low

    0 do
        led high
        500 ms
        led low 
        500 ms
    loop
;

: get-reset ( -- n )
    MCUSR c@
;

: por? ( -- flag )
    get-reset PORF and
;

