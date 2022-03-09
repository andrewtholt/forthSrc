
load lib.fth


variable shift-register \ 8 bit
variable crc-bit        \ 8 bit
variable crc-register   \ 16 bit
variable data-bit       \ 8 bit

0 value init-run

-1 value buffer
32 constant /buffer
0x8005 constant polynom

hex
: atCRC ( addr length -- crc )

    bounds do 
        i . cr

        0 crc-bit !
        0 data-bit !
        0x01 shift-register !

        begin
            shift-register c@ 0>
        while
            ." Shift Register " shift-register c@ . cr
            ." CRC   Register " crc-register w@ . cr
            ." Data  Bit      " data-bit c@ . cr
            i c@ shift-register c@ and if
                1
            else
                0
            then
            0xff and data-bit c!

            crc-register w@ 15 rshift crc-bit c!

            crc-register w@ 1 lshift 0xffff and crc-register w!

            ." CRC   Bit      " crc-bit c@ . cr
            cr 
            data-bit c@ crc-bit c@ <> if
                crc-register w@ polynom xor crc-register w!
            then
            shift-register c@ 1 lshift 0xff and shift-register c!
        repeat
    loop
;

: init
    init-run 0= if
        buffer /buffer allocate abort" Allocate failed" to buffer
        -1 to init-run
    then
;

: main
    init

    buffer /buffer erase
    0 crc-register !
    0x04 buffer c!
    0xff buffer 1+ c!

    buffer 2 atCRC crc-register w@ .
;

main

