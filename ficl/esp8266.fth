
0 value init-run
0 value serialPort

0 value outBuffer
0 value inBuffer

64 constant /buffer


: init
    init-run 0= if
        /buffer allocate abort" outBuffer Allocate failed" to outBuffer
        outBuffer /buffer erase

        /buffer allocate abort" inBuffer Allocate failed" to inBuffer
        inBuffer /buffer erase

        s" /dev/ttyUSB0" 115200 open-serial dup 0= abort" open-serial failed"
        to serialPort
        -1 to init-run
    then
;

: add-crlf ( addr ) 
    /buffer 0 do
        i outBuffer + c@ 0x20 < if
            0x0d outBuffer i + c!
            0x0a outBuffer i + 1+ c!
            leave
        then
            
    loop
;

: getReply { | cnt -- }
    10 to cnt
    inBuffer /buffer erase
    begin
        clr-errno
        inBuffer /buffer serialPort read-line 
        -rot 2drop
        0<> if
                errno 11 = if
                cnt 1- dup to cnt 0= if
                    1
                else
                    10 ms   \ Wait a little while
                    0       \ then around again
                then
            then
        else
            inBuffer c@ dup [char] A = swap 0x0d = or if
                ." Command echo" cr
                0
            else
                1
            then
        then
    until
;

: sendCmd ( addr len -- )
    >r
    outBuffer r@ move add-crlf
    outBuffer r> 2+ serialPort write-file abort" Write-file failed" 
;

: echo ( flag -- )
    if
        s" ATE1" sendCmd
    else
        s" ATE0" sendCmd
    then
;

: check
    s" AT" sendCmd
;

: main
    init

    outBuffer /buffer erase
    inBuffer /buffer erase

    s" AT" sendCmd
    getReply

    inBuffer 10 dump
;

