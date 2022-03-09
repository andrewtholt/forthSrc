0 value pa0
1 value pa1
2 value pa2
3 value pa3

0 value init-run?

: init-io
    init-run? 0= if
        out_pp #0 gpioa gpio-open to pa0
        out_pp #1 gpioa gpio-open to pa1

        in_floating #2 gpioa gpio-open to pa2
        in_floating #3 gpioa gpio-open to pa3

        -1 to init-run?
    then
;

: gpio-toggle ( gpio -- )
    dup gpio-pin@ if
        gpio-clr
    else
        gpio-set
    then
;

: r-button 
    pa2 gpio-pin@ 0=
;

: blinky
    init-io

    begin
        200 ms
        pa0 gpio-toggle

        r-button
    until
;

