-1 constant true
0 constant false

32 string hostname

0 variable ?server-ok

256 constant /buflen
/buflen string cmd
/buflen string reply

4444 constant port
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

: sock-test
    sock @ 1 socket-poll

    drop

    >r 
    reply /buflen r> socket-recv
    reply /buflen dump
;

: main
    init

    hostname port socket-connect 0= if
        sock !
    else
        "Failed to connect" type cr
        abort
    then

;


