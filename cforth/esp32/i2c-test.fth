
0 value init-run?
$40 value i2c-slave

-1 value i2c-fd

#27 constant scl
#14 constant sda

: i2c-init
    init-run? 0= if
        scl sda i2c-open to i2c-fd

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

: lcd-i2c!  ( b -- )
   i2c-byte c!  i2c-byte 1  i2c-byte 0  i2c-slave  false
   i2c-write-read abort" LCD I2C op failed"
;

: i2c-scan
    i2c-init
    7f 0 do
        i .
        0 0 i i2c-b!
        if
            ." Not found" cr
        else
            ." *** found" cr
        then
        10 ms
    loop
;


