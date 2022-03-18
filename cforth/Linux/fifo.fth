
$100 constant /line
/line buffer: line-buffer

-1 value fd-in
-1 value fd-out

0 value counter

: tst-read ( -- len )
    line-buffer /line erase
    
    fd-in 0< if
        s" /tmp/tst"  h-open-file to fd-in
    then

    fd-in non-blocking
        line-buffer /line fd-in h-read-file dup 0> if
        line-buffer swap dump cr
    then

\    fd-in h-close-handle 
;


: tst-write
    counter 1+ to counter
    line-buffer /line erase
    s" /tmp/cforth.txt"  w/o open-file throw to fd-out

    fd-out file-size abort" Size" 
    fd-out reposition-file abort" Seek"
    
\    " Testing" fd-out write-file abort" Write"

    counter s>d <# $0a hold #S  #> fd-out write-file abort" Write"
    fd-out close-file abort" Close."
;

: tst ( u -- )
    <# # # #46 HOLD #S #36 HOLD #>
    TYPE
;

: tst1 ( u -- )
    <# $0a hold # # #S  #>
    TYPE
;

: tst2
    begin
        tst-write
        500 ms
    again
;

