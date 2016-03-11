
-1 value sock1
-1 value sock2

-1 value buffer
-1 value run-flag

8081 constant  port

variable shortBuffer

false value initRun

1024 constant /buffer

: addcr ( addr n | addr n+1 )
    2dup +
    0x0d swap c!
    1+
;

: send-crlf { sock }
    0 shortBuffer !
    0x0d shortBuffer c!
    0x0a shortBuffer 1+ c!

    shortBuffer 2 sock socket-send abort" send-crlf"
    
;

: init
    initRun 0= if
        s" socket" environment? 0= abort" No socket env"
        0= abort" Socket support not available."
    
        /buffer allocate abort" Buffer" to buffer
        buffer /buffer erase

        true to initRun
    then
;

: ok-200
    s" HTTP/1.0 200 OK" 
    sock2 socket-send abort" socket-send ok-200"
    sock2 send-crlf
;

: (head)
    s" Server: Test/Forth" 
    sock2 socket-send abort" socket-send 1"
    sock2 send-crlf

    s" Content-Type: text/plain" 
    sock2 socket-send abort" socket-send 2"
    sock2 send-crlf
    sock2 send-crlf
;

: HEAD  
    bl parse type cr \ path
    bl parse s" HTTP/1.1" compare
    0= if
        ok-200
        (head)
    then
;

: POST
    bl parse type cr \ path
    bl parse type cr

    ok-200
    (head)
;

: process { | cnt }
    \  strtok has changed
    0x0d buffer /buffer strtok
    to cnt

    cnt . cr

    evaluate
;

: main
    init

    socket to sock1

    clr-errno
    port sock1 socket-bind if
        perror
        abort
    then

    ." Connect to " port . cr cr
    sock1 socket-listen abort" listen error."

    begin
        sock1 socket-accept to sock2
        begin
            run-flag 
        while
            buffer /buffer sock2 socket-recv ?dup 0<> if 
                buffer swap dump
                sock2 process
                0 to run-flag
            else
                0 to run-flag
            then
        repeat
\        sock2 socket-close
    again
   
;

\ main
