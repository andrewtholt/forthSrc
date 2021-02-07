
\ 
\ Compiles into flash and runs on reset
\ 
\ for dev comment out compiletoflash
\ 
\ To return to base Forth run:
\ 
\ eraseflash
\ 
compiletoflash
$40011000 constant GPIOC        \ 

GPIOC $00 + constant GPIOC_CRL 
GPIOC $04 + constant GPIOC_CRH
GPIOC $0C + constant GPIOC_ODR
GPIOC $10 + constant GPIOC_BSRR
GPIOC $18 + constant GPIOC_APB2ENR

\ 
\ Make a msk for the port mode register for the specified bit
\ Modes are
\ 
$00 constant GPIO_IN
$01 constant GPIO_OUT
$02 constant GPIO_ALT
$03 constant GPIO_ANALOG

: setup
    $1C GPIOC_APB2ENR !     \ Enable GPIO Clocks.
    $44444444 GPIOC_CRL !   \ Reset control registers
    $44444444 GPIOC_CRH !

    $00100000 GPIOC_CRH !   \ Set GPIOC Pin 13 as output
;

: led-off
    1 13 lshift gpioc_bsrr !    \ Toggle PB13 Hi
;

: led-on
    1 29 lshift gpioc_bsrr !    \ Toggle PB12 Low
;

: delay 900000 0 do loop ;             \ time delay so we can see the LED blinking

: blink
    setup

    begin
        led-off
        delay
        led-on
        delay

        key?
    until
;

: INIT
    blink
;

compiletoram
