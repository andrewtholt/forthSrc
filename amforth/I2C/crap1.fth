load lib.fth

hex
load myCrc.fth

: wa+ ( addr index --- addr1 )
    2* +
;


: ($crc16)  ( crc adr len -- crc' )
 bounds  ?do              ( crc )
    wbsplit  swap         ( b.high b.low )
    i c@                  ( b.high b.low c )
    xor                   ( b.high b.low^c )
    crc16tab swap wa+ w@  ( b.high w.tabval )
    xor                   ( crc' )
loop
;

-1 value buffer
0 value init-run
32 constant /buffer

: init
    init-run 0= if
        /buffer allocate abort" Allocate failed" to buffer
    then
;


: tst
    init
    buffer /buffer erase

    0x04 buffer c!
    0x11 buffer 1+ c!

    0 buffer 2 ($crc16) .s
;

: brute
    tst drop

    0x100 0 do
        i buffer 2 ($crc16) 0x4333 = if
            ." HIT! " i . cr
        then
    loop
;



