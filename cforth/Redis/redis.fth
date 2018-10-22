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

#64 constant /buffer
/buffer buffer: op-buffer ( 32 is arbritrary, but should be enough )
/buffer buffer: ip-buffer 

: addlf ( addr len -- addr len+1 )
    2dup
    +
    $0a swap c!
    1+
;

: addcr ( addr len -- addr len+1 )
    2dup
    +
    $0d swap c!
    1+
;

\ compare the given string with ERROR, non-destructively
\ returns true if matches
\ 
: redis-error { addr len -- addr len 0|-1 }
    addr len " ERROR" compare if 
        addr len 0
    else
        -1
    then
;

: redis-connected { addr len -- addr len 0|-1 }
    addr len " CONNECTED" compare if 
        addr len 0
    else
        -1
    then
;

0 value ?connected

variable ch
: redis-readbyte 
    0 ch !
    ch 1 socket-fd h-read-file drop ch c@
;

: redis-sendbyte ( byte -- )
    ch c!
    ch 1 socket-fd h-write-file drop 
;

: tst
    begin
        redis-readbyte dup . $3a emit dup emit cr
        dup $0a = swap 0= or
    until
;

: redis-readline { addr len delim -- count }
    addr  len erase
    len 0 do 
        redis-readbyte dup 0= over delim = or if  \ check if 0 or delim
            drop i leave
        then
        addr i + c!
    loop
    
;

: flush-socket
    begin
        redis-readbyte
        0=
    until
;

: +pong
    true to ?connected

\    flush-socket

    ." Connected" cr
;

: error
    false to ?connected

    ." WTF" cr
;

: (redis-connect)
    #16379 to port
    open-socket 
    hostname port connect-socket

    10 ms
;


: copy-addcr { addr len --  naddr nlen }
    op-buffer /buffer erase
    addr op-buffer len  move
    op-buffer len addcr 2drop
    op-buffer len 1+ addlf 
;

: redis-ping
    " *1" copy-addcr socket-fd h-write-file drop
    " $4" copy-addcr socket-fd h-write-file drop
    " PING" copy-addcr socket-fd h-write-file drop
    
    ip-buffer /buffer $0a redis-readline drop

    ip-buffer c@ [char] - = if
        ." PING Error" cr
    else
        ip-buffer 7 evaluate
    then
;

: redis-setup
    " *3" copy-addcr socket-fd h-write-file drop

    " $3" copy-addcr socket-fd h-write-file drop
    " SET" copy-addcr socket-fd h-write-file drop

    " $6" copy-addcr socket-fd h-write-file drop
    " PREFIX" copy-addcr socket-fd h-write-file drop

    " $13" copy-addcr socket-fd h-write-file drop
    " /home/office/" copy-addcr socket-fd h-write-file drop

    ip-buffer /buffer $0a redis-readline drop
;

: redis-subscribe
    " *2" copy-addcr socket-fd h-write-file drop

    " $9" copy-addcr socket-fd h-write-file drop
    " SUBSCRIBE" copy-addcr socket-fd h-write-file drop

    " $4" copy-addcr socket-fd h-write-file drop
    " test" copy-addcr socket-fd h-write-file drop

    ip-buffer /buffer $0a redis-readline drop

    ip-buffer 1+ 10 evaluate \ get number of elements.
    ." Number of elements " . cr

    ip-buffer /buffer $0a redis-readline 
    ." Len 1st element " ip-buffer 1+ swap evaluate . cr
    ip-buffer /buffer $0a redis-readline 
    09 emit ." [1] " ip-buffer swap type cr

    ip-buffer /buffer $0a redis-readline 
    ." Len 2nd element " ip-buffer 1+ swap evaluate . cr
    ip-buffer /buffer $0a redis-readline 
    09 emit ." [2] " ip-buffer swap type cr

    ip-buffer /buffer $0a redis-readline drop
    ip-buffer 20 dump cr

    ip-buffer c@ [char] : = if
        09 emit ." Number:" ip-buffer 1+ 5 evaluate . cr
    then
;

255 buffer: topic
255 buffer: payload

: test
    evaluate . cr
;

\ Returns true if the words could not be found
\ false, at the top and the results of executing teh word.

: safe-evaluate ( addr len -- x0 --xn false|true )
    $find if
        execute false
    else
        2drop true
    then
;

0 value topic-len

: redis-get-message
    ip-buffer /buffer $0a redis-readline drop
    ip-buffer 20 dump cr

    ip-buffer 1+ 3 evaluate \ Skip leading *, and get count.
                            \ TODO check 1st char actually is a '*'
    ." Number of elements " . cr

    ip-buffer /buffer $0a redis-readline 
    ." Len 1st element " ip-buffer 1+ swap evaluate 

    7 = if 
        ." Could be message" cr
        ip-buffer /buffer $0a redis-readline drop
        ip-buffer 4 " mess" compare 0= if
            ." Yes, it's message" cr
            ip-buffer /buffer $0a redis-readline ip-buffer 1+ swap evaluate \ topic length
            ip-buffer /buffer $0a redis-readline drop \ topic

            .s cr
            >r \ save the topic length

            topic $ff bl fill
            ip-buffer topic r@ move
            
            ip-buffer /buffer $0a redis-readline 1- \ payload
\ TODO clean up with -trailing
\ Something like 
\ ip-buffer $ff -trailing
\ This should leave : ip-buffer len
\ on the stack
\ 
            ip-buffer swap topic r> safe-evaluate if
                ." Unknown topic." cr
                2drop
            then

        else
            ." Nope, not a message." cr
        then
    else
        ." Length is not 7, indicating not a message." cr
    then


    ip-buffer /buffer $0a redis-readline 
    09 emit ." [1] " ip-buffer swap type cr

;


: redis-connect ( -- ) 
    (redis-connect)
    redis-ping

    ?connected if
        redis-setup
        redis-subscribe
    then

\    " PING" copy-addcr socket-fd h-write-file drop
\    " accept-version:1.1" copy-addcr socket-fd h-write-file drop
\    $0a redis-sendbyte
\    $00 redis-sendbyte

\    ip-buffer /buffer $0a redis-readline 
\    ip-buffer swap evaluate

\     ip-buffer /buffer -trailing .s $0a left-parse-string
\     2swap 2drop 
\ 
\     redis-error if 
\         ." connect failed" cr
\         close-socket
\         0 to connected
\     then
\ 
\     redis-connected if
\         ." Connected" cr
\         -1 to connected
\     else
\         0 to connected
\     then

;


redis-connect

