
ANALOG
marker ANALOG

$01 constant WGM00
$02 constant WGM01
$80 constant COM0A1

$01 constant CS00
$02 constant CS01
$04 constant CS02

PORTD 6 portpin: pwm
PORTB 2 portpin: INH
PORTB 3 portpin: ANE

: */ ( a b c -- a * b / c )
    >r * r> /
;

: -rot ( a b c --- c a b )
    rot rot
;

: mk-mask
    create 
        0 , 1 , 2 , 4 , 8 ,
    does>
        + @i
;

: >= ( a b -- f )
    < invert
;


mk-mask portb-mask

: scale ( val from_min from_max to_min to_max )
    swap -          \ val from_min from_max to_diff
    -rot swap -     \ val to_diff from_diff
    */
;


: or-c! ( n addr -- )
    dup c@  \ n addr d
    rot or  \ addr n
    swap c!
;

: set-mux \ n --
    $03 and
    PORTB c@ $f8 and
    or PORTB c!
;

: set-amux \ n --
    $03 and
    4 lshift
    PORTB c@ $cf and or
    PORTB c!
;

variable readings 4 cells allot

: init
    adc.init
    readings 4 cells 0 fill
    pwm pin_output
    INH high
    INH pin_output
    ANE pin_output
    ANE low

    $3f DDRB c!   \ Set botom 3 bits as outputs, 
                \ B0, B1 MUx select
                \ B2 INHibit, when hi
                \ B3 Analog EN (active High)
                \ B4 O_MUX_A
                \ B5 O_MUX_B

    3 set-mux
    $10 OCR0A c!  \ 50% duty cycle.

    COM0A1 WGM00 or WGM01 or TCCR0A or-c!

\    CS01 TCCR0B or-c!
    CS01 TCCR0B or-c!

    INH low
    ANE high
;

: set-pwm ( percent -- )
    0 100 0 255 scale OCR0A c!
    100 ms
;

: get-pwm 
    OCR0A c@
;

: read-tx
    analog.1 adc.get 
;

: read-rx
    analog.0 adc.get 
;



: analog-test
    adc.init
    10 ms
    0
    4 0 do 
        analog.0 adc.get dup
        readings i cells + !
        +
        5 ms
    loop
;

variable count
variable total
variable old
variable samples
4 samples !

: in-range  ( n -- )
    dup old !
    1 count +!
    total +!
;

: out-range ( n -- )
    dup old !
    old !
    0 count !
    0 total !
;

: measure-tx ( -- v )
    0 total !
    0 count !
    analog.1 adc.get 1024 min old !
    begin
        10 ms
        analog.1 adc.get 1023 min dup
        old @ 5 - old @ 5 + within
        if
            in-range
        else
            out-range
        then
        count @ samples @ >=
    until

    total @ samples @ /
;

: measure-rx ( -- v )
    0 total !
    0 count !
    analog.0 adc.get 1024 min old !
    begin
        10 ms
        analog.0 adc.get 1023 min dup
        old @ 5 - old @ 5 + within
        if
            in-range
        else
            out-range
        then
        count @ samples @ >=
    until

    total @ samples @ /
;


: read-channel ( ch -- )
    set-amux
    analog.0 adc.get
    . cr
;

: scan
3 0 do 
    i . 09 emit
    i set-amux
    500 ms
loop
;

: t2
    init 
    0 set-pwm
    0 set-mux
    0 set-amux
    4 samples !

    100 0 do
        i 0= if
            3 set-mux
        else
            0 set-mux
            i set-pwm
        then

        i . 09 emit
        100 ms
\        measure-tx 92 - .
\        09 emit
        measure-rx 82 - .
        cr
        10
    +loop
;




