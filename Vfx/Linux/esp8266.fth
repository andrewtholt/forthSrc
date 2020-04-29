
c" lib_base" MacroSet? 0= [if]
    c" /usr/local/lib/Forth" setmacro lib_base
[then]

c" common_lib" MacroSet? 0= [if]
    mc" %lib_base%/common" setmacro common_lib
[then]

include %vfxpath%/Lib/Lin32/Genio/Serial.fth
include %common_lib%/strings.fth
include ap.fth

include cfg.fth

0 value init-run
0 value ?connected
0 value ?host-connected


128 constant /inbuff
128 constant /outbuff

/inbuff  buffer: inbuff
/outbuff buffer: outbuff

0 constant NORMAL_TX_MODE
1 constant PASSTHROUGH

NORMAL_TX_MODE value ?passthrough

SerDev: sd

: itoa \ n --- addr len
    s>d <# #s #>
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
\ ** USB serial device, plug it in and then type the following
\ ** on the command line:
\ *C   dmesg | tail
\ *P One of the last few lines tells you the device code,
\ ** e.g. /dev/ttyUSB0.
 ", /dev/ttyUSB3 115200 baud no parity 8 data 1 stop"


: open-serial-port \ -- ;
\ *G open the serial port for Modbus RTU
  ser$ count R/W sd open-gio if
    ." Cannot open ESP01 port"
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
        0 to ?connected
        0 to ?host-connected
    then
;

: get-line
    [io
        sd setIO
        inbuff /inbuff erase
        inbuff /inbuff accept 
    io]
;

: send-to-esp  \ addr len -- flag
    outbuff place
    crlf$ count outbuff append
[io
    sd setIO
    flushkeys
    outbuff count type
io]
    
;


: wait-for-ok
    begin
    [io
        sd setIO
        inbuff /inbuff accept drop
    io]
        s" OK"   inbuff dup zstrlen instring 
        s" FAIL" inbuff dup zstrlen instring or
        s" ERROR" inbuff dup zstrlen instring or
        s" ready" inbuff dup zstrlen  instring or
        100 ms
    until
    s" OK"    inbuff dup zstrlen instring 0<>
    s" ready" inbuff dup zstrlen instring 0<> or
    0=
;

: ok
    s" AT" send-to-esp
    wait-for-ok 
;

: set-sta-mode 
    init
    s" AT+CWMODE=1" send-to-esp
    wait-for-ok
;

64 constant /cmd-assembly
/cmd-assembly buffer: cmd-assembly

: set-tx-mode \ 0|1 --
    dup to ?passthrough
    inbuff  /inbuff erase
    outbuff /outbuff erase
    cmd-assembly /cmd-assembly erase

    s" AT+CIPMODE=" cmd-assembly place
    itoa cmd-assembly append
    cmd-assembly count send-to-esp
    wait-for-ok

    s" AT+CIPSEND" send-to-esp
    wait-for-ok 
;

: exit-passthrough
    [io
        sd setIO
        s" +++" type
        1500 ms
        flushkeys
    io]
;


: factory-reset
    init
    s" AT+RESTORE" send-to-esp
    wait-for-ok

    0 to ?connected
    0 to ?host-connected
;

: cmd-echo \ true|false --
    init
    if 
        ." Echo on" cr
        s" ATE1" send-to-esp
        wait-for-ok
    else
        ." Echo off" cr
        s" ATE0" send-to-esp
        wait-for-ok
    then
;


: connect-to-network
    init

    cmd-assembly /cmd-assembly erase

    s" AT+CWJAP=" cmd-assembly place
    cmd-assembly [char] " cappend

    essid count cmd-assembly append
    cmd-assembly [char] " cappend

    cmd-assembly [char] , cappend
    cmd-assembly [char] " cappend

    passwd count  cmd-assembly append
    cmd-assembly [char] " cappend

    cmd-assembly count send-to-esp
    wait-for-ok 0= to ?connected
;

: connect-to-host
    init

    ?connected if
        cmd-assembly /cmd-assembly erase

        s" AT+CIPSTART=" cmd-assembly place
        cmd-assembly [char] " cappend
        s" TCP" cmd-assembly append
        cmd-assembly [char] " cappend
        cmd-assembly [char] , cappend

        cmd-assembly [char] " cappend
\        s" 192.168.10.149" cmd-assembly append
\        s" 192.168.10.136" cmd-assembly append
        host count cmd-assembly append
        cmd-assembly [char] " cappend

        s" ,8888" cmd-assembly append

        cmd-assembly count send-to-esp
        wait-for-ok 0= to ?host-connected
    then
;

: disconnect-from-host
    ?host-connected if
        s" AT+CIPCLOSE" send-to-esp
        wait-for-ok
    then    
;

: send-data \ addr len ---
    outbuff /outbuff erase
    ?passthrough PASSTHROUGH = if

        ." Passthrough" cr

    [io
        sd setIO
        type
    io]
    else
    ." Normal" cr 
    [io
        sd setIO
        s" AT+CIPSEND=" type

        dup . crlf$ count type
        inbuff dup /inbuff accept type
        inbuff 2 accept

        type
    io]
    then
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
    init
    ok abort" ESP did not respond to AT"

    connect-to-network ?connected . cr
    connect-to-host    ?host-connected . cr

    PASSTHROUGH set-tx-mode 
;



