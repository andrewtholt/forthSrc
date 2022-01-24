
0 value init-run?
$20 value i2c-slave

-1 value i2c-fd

pin-d1 constant scl
pin-d2 constant sda

01 constant relay01

: i2c-init
    init-run? 0= if
        scl sda i2c-open to i2c-fd
\        pin-d1 pin-d2 i2c-open to i2c-fd

        -1 to init-run?
    then
;

: i2c-finished
    init-run? if
        i2c-fd i2c-close

        0 to init-run?
        -1 to i2c-fd
    then
;

1 buffer: i2c-byte
4 buffer: i2c-in

: i2c!  ( b -- )
   i2c-byte c! 
   i2c-byte 1  i2c-byte 0  i2c-slave  false
   i2c-write-read abort" LCD I2C op failed"
;

: relay-on ( relay -- )
    i2c-init
    invert $ff and
    i2c-byte c@ and i2c-byte c!

    i2c-byte 1  i2c-in 4  i2c-slave  false
    i2c-write-read abort" LCD I2C op failed"
;

: relay-off ( relay -- )
    i2c-init
    i2c-byte c@ or i2c-byte c!

    i2c-byte 1  i2c-in 4  i2c-slave  false
    i2c-write-read abort" LCD I2C op failed"
;

: i2c-scan
    i2c-init
    7f 0 do
\        i .
        0 0 i i2c-b!
        if
\            ." Not found" cr
        else
            i .
            ." *** found" cr
        then
        10 ms
    loop
;

: i2c-get
    0 0 i2c-in 1 i2c-slave 0 i2c-write-read abort" i2c-get failed."
;

: relay-get ( relay -- state )
    i2c-get i2c-in c@ and 0=
;

: relay-toggle ( relay -- )
    dup relay-get false =
    if
        relay-on
    else
        relay-off
    then

;







