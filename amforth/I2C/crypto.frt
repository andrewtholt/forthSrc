
anew CRYPTO

: .s 
    depth 0= if 
        ." Empty" 
    else 
        depth 1- 0 swap  do 
            i pick  . $20 emit 
        -1 +loop 
        cr 
    then
;

$60 constant ATECC

0 value init-run
1 value low-delay
3 value wake-delay

255 constant /buffer
/buffer buffer: buffer

: empty ( xn ... x0 -- )
    depth
    0 ?do
        drop
    loop
;

: c!++ ( n addr -- addr+1 )
    tuck c! 1+
;

: crypto-init
    buffer /buffer 0 fill
    init-run 0= if
        1 to low-delay
        3 to wake-delay

        i2c.init.default
        3 timer0.init
        1 to init-run
    then
;

: us 
    timer0.start
    begin
        dup \ d d 
        timer0.tick @  \ d d n
        <
    until
    drop
    timer0.stop
;

: wake

    i2c.init.default
    i2c.start
    low-delay us
    i2c.stop
    wake-delay us
    i2c.init.default
;

: wake-msg
    i2c.init.default

    4 0 1 $60 i2c.m>n
;

: sleep
    1 1 $60 i2c.n>    
;

: tst
    crypto-init
    cr
    ." Device "
    wake
    $60 i2c.ping? if 
        ." seen" cr
    else
        ." not seen" cr
    then
;

: setup-buffer
    $03 buffer c!++ \ cmd reg
    $07 swap c!++   \ packet len 
    $30 swap c!++   \ CMD 
    $02 swap c!++   \ State p1 do not update seed

    $00 swap c!++   \ p2
    $00 swap c!++   \ p2

    $00 swap c!++   \ crc lo
    $d8 swap c!

    buffer 10 dump



;

: get-state
    wake 
    4       \ Number of bytes expected
    $d8     \ CRC Hi
    $00     \ CRC lo
    $00     \ P2
    $00     \ P2
    $02     \ OPCODE=State  
    $30     \ CMD=Info
    $07     \ packet length
    $03     \ ADDRESS=$30 i.e. cmd register
    $08     \ 2 bytes to send, i.e. the above. 
    $60     \ i2c address
    i2c.m>n 
;

: get-version
    wake 
    4       \ Number of bytes expected
    $5d     \ CRC Hi
    $03     \ CRC lo
    $00     \ P2
    $00     \ P2
    $00     \ OPCODE=State  
    $30     \ CMD=Info
    $07     \ packet length
    $03     \ ADDRESS=$30 i.e. cmd register
    $08     \ 2 bytes to send, i.e. the above. 
    $60     \ i2c address
    i2c.m>n 
;

: get-data
    wake 
    \ count on stack
    4
    $91
    $1d
    $0      \ Addr
    $0      \ Addr
    $0      \ Zone
    $02     \ CMD
    $05     \ 5 bytes to send
    $60     \ i2c address
    i2c.m>n
;

: get-random
    wake

    32      
    $26     \ crc hi
    $6d     \ crc lo
    $0      \ p2
    $0      \ p2
    $0      \ p2
    $1      \ MODE
    $1b     \ OPCODE =Random
    $08     \ packet len
    $03
    $09     \ bytes to send
    $60
    i2c.m>n 

;

: send-data ( addr -- )
    >r

    r> drop
;

: fred

    $60 buffer c!++ \ i2c address
    $08 swap c!++    \ 2 bytes to send, i.e. the above. 
    $03 swap c!++    \ ADDRESS=$30 i.e. cmd register
    $07 swap c!++    \ packet length
    $30 swap c!++    \ CMD=Info
    $00 swap c!++    \ OPCODE=State  
    $00 swap c!++    \ P2
    $00 swap c!++    \ P2
    $03 swap c!++    \ CRC lo
    $5d swap c!++    \ CRC Hi
    $04 swap c!++    \ Number of bytes expected

    drop            \ Clean up.

;

