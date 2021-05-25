\ test-socket.fth
\ Example code for using client sockets
\ Connects to an SSH server (port 22) on localhost (127.0.0.1)
\ and reads/displays the identification message

1 constant SOCK_STREAM  \ from /usr/include/*/bits/socket_type.h
2 constant PF_INET      \ from /usr/include/*/bits/socket.h
0 constant IPPROTO_IP   \ from /usr/include/netinet/in.h

#16 constant /sockaddr
#255 constant /buffer
0 value init-run

/sockaddr buffer: sockaddr  \ w.pf bew.port ip[4] padding[8]

/buffer buffer: in-buffer
/buffer buffer: out-buffer

-1 value socket-fd
create localhost #127 c, 0 c, 0 c, 1 c,
#10001 constant myclient-port

: be-w!   ( w adr -- )
    >r  wbsplit  r@ c!  r> 1+ c!
;

: addcr ( addr len -- addr len+1 )
    2dup
    +       \ addr len ptr
    $0a swap c! \ addr len
    1+
;

: open-socket  ( -- )
   IPPROTO_IP SOCK_STREAM PF_INET socket dup 0= abort" socket"  to socket-fd
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
   /sockaddr sockaddr socket-fd connect  
;
\ 
\ create localhost #127 c, 0 c, 0 c, 1 c,
\ #22 constant ssh-port
\ 
\ : probe-ssh  ( -- )
\    open-socket
\    localhost ssh-port connect-socket
\    pad $100 socket-fd h-read-file  ( actual )
\    dup ?posix-err                  ( actual )
\    pad swap type                   ( )
\    close-socket                    ( )
\ ;
\ 

-1 value cmd-len

: command ( address len -- len )
    out-buffer /buffer erase
    addcr dup to cmd-len out-buffer swap move
    out-buffer cmd-len socket-fd h-write-file 
;

: response ( -- len )
    in-buffer /buffer erase
    in-buffer /buffer socket-fd h-read-file 
;

: check
    command drop

    response in-buffer swap dump
;

: init
    init-run 0= if
        in-buffer /buffer erase
        out-buffer /buffer erase

        open-socket
        localhost myclient-port connect-socket
        in-buffer /buffer socket-fd h-read-file

        -1 to init-run
    then
;

: test
    init

    s" ^load sqliteCmds.txt" addcr dup to cmd-len out-buffer swap move
    out-buffer cmd-len socket-fd h-write-file .

    in-buffer /buffer erase
    in-buffer /buffer socket-fd h-read-file .
    in-buffer $20 dump

    out-buffer /buffer erase
    in-buffer /buffer erase
    s" ^connect" addcr dup to cmd-len out-buffer swap move
    out-buffer cmd-len socket-fd h-write-file .

    in-buffer /buffer socket-fd h-read-file cr .
    cr
    in-buffer $30 dump

\    close-socket                    ( )
;

\ Usage example:
\ 
\ $ cd build/bluez64
\ -- Put the file test-socket.fth in this directory --
\ $ make
\ <compilation messages elided>
\ $ ./forth test-socket.fth -
\ ok probe-ssh
\ SSH-2.0-OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.7
\ 

