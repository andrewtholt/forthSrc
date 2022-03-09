\ Example code for using client sockets
\ Connects to my home automation server and 
\ provides cmd-get, cmd-get and ping

s" server" $find nip [if]
    server
[else]
    drop
[then]

marker server

1 constant SOCK_STREAM \ from /usr/include//bits/socket_type.h
2 constant PF_INET \ from /usr/include//bits/socket.h
0 constant IPPROTO_IP \ from /usr/include/netinet/in.h

#16 constant /sockaddr
/sockaddr buffer: sockaddr \ c.len c.pf bew.port ip[4] padding[8]

#255 constant /buffer
/buffer buffer: in-buffer
/buffer buffer: out-buffer


-1 value socket-fd

: open-socket ( -- )
   IPPROTO_IP SOCK_STREAM PF_INET socket to socket-fd
   socket-fd 0< abort" open-socket failed"  \ !
;
: close-socket ( -- )
   socket-fd 0>= if
      socket-fd lwip-close  \ !
      -1 to socket-fd
   then
;

[ifndef] cscount
: cscount  ( adr -- adr len )
   dup                               ( adr cur-adr )
   begin  dup c@  while  1+  repeat  ( adr end-adr )
   over -                            ( adr len )
;
[then]
: ?posix-err  ( n -- )
   0<  if
      \ EALREADY is not really a problem
      errno  dup #114 =  if  drop exit  then  ( n )
      ." Syscall error " dup .d               ( n )
      strerror cscount type                   ( )
      cr
      abort
   then
;

: connect-socket ( 'ip port -- )
   sockaddr /sockaddr '0' fill ( 'ip port )

   \ Linux and LWIP have different defs for sockaddr:
   \  Linux:  struct sockaddr_in { unsigned short sin_family; ... }
   \  LWIP:   struct sockaddr_in { u8_t sin_len; u8_t sin_family; ... }

   /sockaddr sockaddr c!    ( 'ip port )
   PF_INET sockaddr ca1+ c!  ( 'ip port )

   sockaddr wa1+ be-w! ( 'ip )
   sockaddr 2 wa+ 4 move ( )
   /sockaddr sockaddr socket-fd connect
   ?posix-err
;

create host #192 c, #168 c, #10 c, #124 c,
#9191 constant port

: probe-port  ( -- )
   open-socket
   host port connect-socket

\   s" This is a test" socket-fd lwip-write ( actual )
\   " PING"n" socket-fd lwip-write ( actual )
   pad $100 socket-fd lwip-read    ( actual )
   dup ?posix-err                  ( actual )
   pad swap type                   ( )
   close-socket                    ( )
;

: input-flag ( -- flag )
    " ON" in-buffer 2 $=
;

: +c!        
    dup c@ rot +        
    swap c!    
;        
        
\        
\ c1 holds a counted string,        
\ addr and len are a string to be appended to the end of it        
\        
: $cat { c1 addr len }    
    c1 count + addr swap len cmove        
    len c1 +c!    
;    

: add-char ( char c-str -- )

    dup 1 swap +c!
    dup c@ + c!

;

: client-init
    socket-fd 0< if
        open-socket
        host port connect-socket
    then
;


: cmd-ping
    client-init

    s" PING" out-buffer place
    $0a out-buffer add-char

    out-buffer count socket-fd lwip-write ( actual )
    drop

    pad $100 socket-fd lwip-read    ( actual )
    dup ?posix-err                  ( actual )

    1- dup 
    pad swap in-buffer 1+ swap move
    in-buffer c!

    in-buffer count s" +PONG" $=
;

: cmd-get ( $name -- )
    client-init

    s" GET " out-buffer place
    out-buffer -rot $cat
    $0a out-buffer add-char

    out-buffer /buffer dump

    out-buffer count socket-fd lwip-write
    drop

    pad $100 socket-fd lwip-read    ( actual )
    dup ?posix-err                  ( actual )
\ 
    in-buffer /buffer erase
    pad swap in-buffer swap move
;

: cmd-set ( $value $name -- )
    client-init

    s" SET " out-buffer place
    out-buffer -rot $cat
    bl out-buffer add-char

    out-buffer -rot $cat
    $0a out-buffer add-char

    out-buffer count socket-fd lwip-write
    drop

    out-buffer /buffer dump

    pad $100 socket-fd lwip-read    ( actual )
    dup ?posix-err                  ( actual )

    in-buffer /buffer erase
    pad swap in-buffer swap move
;

: cmd-close
    socket-fd 0> if

        s" CLOSE\n" sprintf socket-fd lwip-write ( actual )
        drop

        pad $100 socket-fd lwip-read    ( actual )
        dup ?posix-err                  ( actual )

        pad swap in-buffer swap move

        close-socket
    then
;
