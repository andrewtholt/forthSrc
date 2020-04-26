include %vfxpath%/Lib/Lin32/Genio/Serial.fth

0 value init-run
0 value ?connected

128 constant /inbuff
128 constant /outbuff

/inbuff  buffer: inbuff
/outbuff buffer: outbuff

SerDev: sd

: cappend \ c-addr char --
    over        \ c-addr char addr
    dup c@ + 1+ \ c-addr char addr 
    c!

    1 swap c+!
;

: comma-to-space \ addr count -- 
    2dup
    bounds do
        i c@ [char] , = if
            bl i c!
        then
    loop
;

: quote-to-space
    2dup
    bounds do
        i c@ [char] " = if
            bl i c!
        then
    loop
;


create ser$ \ -- addr
\ *G Configuration string used for the serial port. If using a
\ ** USB serial device, plu it in and then type the following
\ ** on the command line:
\ *C   dmesg | tail
\ *P One of the last few lines tells you the device code,
\ ** e.g. /dev/ttyUSB0.
 ", /dev/ttyUSB2  115200 baud no parity 8 data 1 stop"


: open-serial-port \ -- ;
\ *G open the serial port for Modbus RTU
  ser$ count R/W sd open-gio if
    ." Cannot open Rtu port"
\  else
\    sd setRAW
  then
  drop
;

: +CIFSR:STAIP \ AT for get IP
    bl parse-word type cr
;

: init
    init-run 0= if
        open-serial-port
        -1 to init-run
    then
;

: set-sta-mode 
    init
    [io
        sd setIO
        flushkeys
        s" AT+CWMODE=1" type crlf$ count type
        500 ms 
        inbuff /inbuff erase
        inbuff /inbuff accept drop
        flushkeys
    io]
    inbuff 32 dump
;

: factory-reset
    init
    [io
        sd setIO
        s" AT+RESTORE" type crlf$ count type
        1000 ms 
        flushkeys
    io]
    0 to ?connected
;

: cmd-echo \ true|false --
    init
    if 
        ." Echo on" cr
    [io
        sd setIO
        s" ATE1" type crlf$ count type
    io]
    else
        ." Echo off" cr
    [io
        sd setIO
        s" ATE0" type crlf$ count type
    io]
    then
    100 ms
    flushkeys
;


: connect-to-network

    init
    s" AT+CWJAP=" outbuff place
    outbuff [char] " cappend
    s" HoltAtHome4" outbuff append
    outbuff [char] " cappend

    outbuff [char] , cappend

    outbuff [char] " cappend
    s" anthony050192" outbuff append
    outbuff [char] " cappend

    inbuff /inbuff erase

    [io
        sd setIO
        outbuff count type crlf$ count type
        inbuff dup /inbuff accept 
        
    io]

    s" WIFI DISCONNECT" str= if
        500 ms

        inbuff /inbuff erase

        [io
            sd setIO
            inbuff /inbuff accept drop
        io]
    then

    inbuff /inbuff erase

    [io
        sd setIO

        inbuff /inbuff accept drop
    io]

    inbuff dup zstrlen s" WIFI GOT IP " compare 0= if
        cr ." Connected" cr
        -1 to ?connected
    then
    flushkeys
;

: connect-to-host
    init

    ?connected if
    [io
        sd setIO

        s" AT+CIPSTART=" outbuff place
        outbuff [char] " cappend
        s" TCP" outbuff append
        outbuff [char] " cappend
        outbuff [char] , cappend

        outbuff [char] " cappend
        s" 192.168.10.149" outbuff append
        outbuff [char] " cappend

        s" ,8888" outbuff append
    io]
    outbuff 64 dump
    then
;


: tst
init
    0 cmd-echo
    1 set-sta-mode
[io
    sd setIO

    s" AT" type crlf$ count type
    100 ms
    inbuff /inbuff accept drop
    inbuff /inbuff erase
    inbuff /inbuff accept
io]
    flushkeys
    inbuff swap dump
;

: fix 
[io
    sd setIO
    0x0a emit
io]
;

: get-ip
    init
[io
    sd setIO

    inbuff /inbuff erase
    s" AT+CIFSR" type crlf$ count type
    500 ms
    inbuff /inbuff accept drop  \ AP IP
    100 ms
    inbuff /inbuff accept drop  \ Station MAC
    100 ms
    inbuff /inbuff erase
    inbuff /inbuff accept       \ Station IP
    100 ms
    flushkeys
io]
    inbuff 0x20 dump
    ?dup 0= if 
        ." Not connected to network" cr
        0 to ?connected
    then
\    inbuff swap comma-to-space
\    2dup quote-to-space
\    evaluate
;

: more
[io
    sd setIO
    inbuff /inbuff erase
    500 ms
    inbuff /inbuff accept
io]
    inbuff /inbuff dump
;

