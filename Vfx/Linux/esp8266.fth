
c" lib_base" MacroSet? 0= [if]
    c" /usr/local/lib/Forth" setmacro lib_base
[then]

c" common_lib" MacroSet? 0= [if]
    mc" %lib_base%/common" setmacro common_lib
[then]

include %vfxpath%/Lib/Lin32/Genio/Serial.fth
include %common_lib%/strings.fth
include ap.fth

0 value init-run
0 value ?connected
0 value ?host-connected

128 constant /inbuff
128 constant /outbuff

/inbuff  buffer: inbuff
/outbuff buffer: outbuff

0 constant NORMAL_TX_MODE
1 constant PASSTHROUGH

SerDev: sd

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
\ ** USB serial device, plug it in and then type the following
\ ** on the command line:
\ *C   dmesg | tail
\ *P One of the last few lines tells you the device code,
\ ** e.g. /dev/ttyUSB0.
 ", /dev/ttyUSB0 115200 baud no parity 8 data 1 stop"


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

: get-line
    [io
        sd setIO
        inbuff /inbuff erase
        inbuff /inbuff accept 
    io]
;

: wait-for-ok
    begin
        inbuff /inbuff accept drop

        s" OK"   inbuff dup zstrlen instring 
        s" FAIL" inbuff dup zstrlen instring or
        s" ERROR" inbuff dup zstrlen instring or
        s" ready" inbuff dup zstrlen  instring or
    until
    s" OK"    inbuff dup zstrlen instring 0<>
    s" ready" inbuff dup zstrlen instring 0<> or
    0=
;

: set-sta-mode 
    init
    [io
        sd setIO
        flushkeys
        s" AT+CWMODE=1" type crlf$ count type
        wait-for-ok
    io]
;

: set-tx-mode \ 0|1 --
    inbuff /inbuff erase
    [io
        sd setIO
        flushkeys
        s" AT+CIPMODE=1" type crlf$ count type
        wait-for-ok
        
        flushkeys
        s" AT+CIPSEND" type crlf$ count type
        wait-for-ok
    io]
;

: exit-passthrough
    [io
        sd setIO
        s" +++" type
        1000 ms
        flushkeys
    io]
;


: factory-reset
    init
    [io
        sd setIO
        s" AT+RESTORE" type crlf$ count type
        wait-for-ok
        flushkeys
    io]
    0 to ?connected
    0 to ?host-connected
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

    [io
        sd setIO
        wait-for-ok
    io]
;


: connect-to-network
    init
    s" AT+CWJAP=" outbuff place
    outbuff [char] " cappend

    essid count outbuff append
    outbuff [char] " cappend

    outbuff [char] , cappend
    outbuff [char] " cappend

    passwd count  outbuff append
    outbuff [char] " cappend

    inbuff /inbuff erase

    outbuff count type cr

    [io
        sd setIO
        flushkeys
        outbuff count type crlf$ count type
        100 ms
        inbuff dup /inbuff accept 
        
    io]
    inbuff 32 dump cr

    s" WIFI DISCONNECT" str= if
        ." disconnect" cr
        500 ms

        inbuff 32 dump cr

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
    [io
        sd setIO
        wait-for-OK
    io]
        -1 to ?connected
    then

    flushkeys
;

: connect-to-host
    init

    ?connected if
        outbuff /outbuff erase
    [io
        sd setIO

        s" AT+CIPSTART=" outbuff place
        outbuff [char] " cappend
        s" TCP" outbuff append
        outbuff [char] " cappend
        outbuff [char] , cappend

        outbuff [char] " cappend
\        s" 192.168.10.149" outbuff append
        s" 192.168.10.136" outbuff append
        outbuff [char] " cappend

        s" ,8888" outbuff append

        outbuff count type crlf$ count type
        inbuff /inbuff erase
        inbuff dup /inbuff accept type cr
        flushkeys
io]
    outbuff count type cr
        -1 to ?host-connected
    then
;

: itoa \ n --- addr len
    s>d <# #s #>
;

: disconnect-from-host
    ?host-connected if
    [io
        sd setIO
        s" AT+CIPCLOSE" type crlf$ count type
        inbuff /inbuff erase
        inbuff dup /inbuff accept type cr
        wait-for-ok
    io]
        0 to ?host-connected
    then
;

: send-data \ addr len ---
    outbuff /outbuff erase

[io
    sd setIO
    s" AT+CIPSEND=" type

    dup . crlf$ count type
    inbuff dup /inbuff accept type
    inbuff 2 accept

    type
io]

;

: tst
    init
    0 cmd-echo abort" Failed to set echo"
    set-sta-mode abort" Failed to set sta-mode"
[io
    sd setIO

    flushkeys
    s" AT" type crlf$ count type
    wait-for-ok
\    inbuff /inbuff accept drop
\    inbuff /inbuff erase
\    inbuff /inbuff accept
io]
\    inbuff 32 dump
    ." Here" cr
;

: fix 
[io
    sd setIO
    0x0a emit
    wait-for-ok
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

: test-data
[io
    sd setio

    ." Hello there" crlf$ count type
io]
;

: setup
    tst
    100 ms
    connect-to-network ?connected . cr
    500 ms
    connect-to-host    ?host-connected . cr
;
