
\ join two strings
\ e.g.
\ s" hello" pad place
\ pad count type
\ s"  there!" pad +place
\ pad count type

: +place  
  2dup c@ dup >r + over c! r> 1+ + swap move 
;

: to-string ( n -- addr c )  
    base @ >r
    decimal
    s>d <# #s #>
    r> base !
; 

: fred

    10 0 do
        i to-string type cr
    loop
;

