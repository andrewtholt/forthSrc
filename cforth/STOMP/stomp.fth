\ fl ../../cforth/printf.fth
#100 buffer: abort-msg

: sprintf-abort  ( ? pattern$ -- )
   sprintf abort-msg pack  'abort$ !
   -2 throw
;

\needs wbsplit  : wbsplit  ( w -- b.low b.high )  ;
\needs be-w! : be-w!  ( w adr -- )  >r  wbsplit r@ c! r> 1+ c!  ;

: ?posix-err  ( n -- )
   0<  if
      \ EALREADY is not really a problem
      errno  dup #114 =  if  drop exit  then
      dup >r strerror cscount r>
      " Syscall error %d: %s" sprintf-abort
   then
;

\ test-socket.fth
\ Example code for using client sockets
\ Connects to an SSH server (port 22) on localhost (127.0.0.1)
\ and reads/displays the identification message

1 constant SOCK_STREAM  \ from /usr/include/*/bits/socket_type.h
2 constant PF_INET      \ from /usr/include/*/bits/socket.h
0 constant IPPROTO_IP   \ from /usr/include/netinet/in.h

#16 constant /sockaddr
/sockaddr buffer: sockaddr  \ w.pf bew.port ip[4] padding[8]

-1 value socket-fd
: open-socket  ( -- )
   IPPROTO_IP SOCK_STREAM PF_INET socket dup ?posix-err to socket-fd
;
: close-socket  ( -- )
   socket-fd 0>=  if
      socket-fd h-close-handle
      -1 to socket-fd
   then
;

: connect-socket  ( 'ip port -- )
   sockaddr /sockaddr '0' fill   ( 'ip port )
   PF_INET sockaddr w!           ( 'ip port )
   sockaddr wa1+ be-w!           ( 'ip )
   sockaddr 2 wa+  4 move        ( )
   /sockaddr sockaddr socket-fd connect  ?posix-err
;

create hostname #192 c, #168 c, #10 c, #112 c,
#2020 value port

: probe-port  ( -- )
   open-socket
   hostname port connect-socket
   s" I'm talking to myself." socket-fd h-write-file ( actual )
   pad $100 socket-fd h-read-file  ( actual )
   dup ?posix-err                  ( actual )
   pad swap type                   ( )
   close-socket                    ( )
;

#21 constant /buffer
/buffer buffer: op-buffer ( 32 is arbritrary, but should be enough )
/buffer buffer: ip-buffer 

\ compare the given string with ERROR, non-destructively
\ returns true if matches
\ 
: stomp-error { addr len -- addr len 0|-1 }
    addr len " ERROR" compare if 
        addr len 0
    else
        -1
    then
;

: stomp-connected { addr len -- addr len 0|-1 }
    addr len " CONNECTED" compare if 
        addr len 0
    else
        -1
    then
;

0 value connected

: stomp-connect ( -- ) 
    #61613 to port
    open-socket 
    hostname port connect-socket

    " CONNECT" " %s\n" sprintf socket-fd h-write-file drop
    " accept-version:1.1" " %s\n\n" sprintf socket-fd h-write-file drop

    op-buffer 4 erase
    op-buffer 1 socket-fd h-write-file drop

    ." Test " .s cr
    ip-buffer /buffer socket-fd h-read-file drop

    ." Test 1" .s cr

    ip-buffer /buffer -trailing .s $0a left-parse-string
    2swap 2drop 

    stomp-error if 
        ." connect failed" cr
        close-socket
        0 to connected
    then

    stomp-connected if
        ." Connected" cr
        -1 to connected
    else
        0 to connected
    then

;

: flush-socket
    begin
        ip-buffer /buffer socket-fd h-read-file 
        ip-buffer /buffer dump
        0=
    until
;

: stomp-subscribe ( dest len -- )
    connected if
        " SUBSCRIBE" " %s\n" sprintf socket-fd h-write-file drop
        " id:0" " %s\n" sprintf socket-fd h-write-file drop
        " destination:%s\n" sprintf socket-fd h-write-file drop

        " ack:auto" " %s\n\n" sprintf socket-fd h-write-file drop

        op-buffer 4 erase
        op-buffer 1 socket-fd h-write-file drop

        ip-buffer /buffer erase
        ip-buffer /buffer socket-fd h-read-file drop
        ip-buffer /buffer dump
    else
        ." Error: Not connected" cr
    then
;

stomp-connect


