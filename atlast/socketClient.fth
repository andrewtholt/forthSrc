-1 constant true
0 constant false

32 string hostname

0 variable ?server-ok

256 constant /buflen
/buflen string cmd
/buflen string reply

6379 constant port
variable sock

variable ?init-run

: init
    ?init-run @ 0= if
        "localhost" hostname strcpy
        -1 ?init-run !
    then
;

: +pong
    true ?server-ok !
;

: ping
    "PING\n" dup strlen sock @ socket-send 0<> if
        "Send failed\n" type
        abort
    then
    reply /buflen sock @ socket-recv 
\    reply swap dump

    reply evaluate
;

: main
    init

    hostname port socket-connect 0= if
        sock !
    else
        "Failed to connect" type cr
        abort
    then

    ping

    ?server-ok false = if 
        "Ping failed.\n" type
        abort
    else 
        "Server OK.\n" type
    then
;


