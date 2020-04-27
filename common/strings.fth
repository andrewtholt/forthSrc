\
\ address length --
\
: mk-string ( fa len  -- )
    create
        len allocate drop to na
        na fa len move
\         dup allocate drop dup ,
\         swap dup , move 
    does>
        2@ swap
;

\ s" Hello," strsave 2value first
\ s" world!" strsave 2value second
\ 
\ Take a string of the form addr len and 
\ create a counted string at addr2
\ 
: place ( str len add2 -- )
    2dup c!  \ str len add2
    1+      \ str len add2+1
    swap move
;
\ 
\ take 2 counted string and appaend addr2 to the end of addr1
\ There must be sufficient space for the new string at addr1
\ 
: cjoin { addr1 addr2 }
    addr1 count +    \ end
    addr2 count \ end addr len
    rot     \ addr len end
    swap    \ addr end len
    move
;


: join { addr len addr1 len1 | addr2 len2 -- addr2 len2 }
    len len1 + dup allocate abort" Allocate failed"  to addr2 to len2

    addr addr2 len move
    addr1 addr2 len + len1 move


    addr2 len2
;

: delete ( addr len -- )
    2dup erase
    drop free abort" Free failed."
;

: grow { addr len add | na nl -- addr len }

    add len + to nl

    nl allocate abort" Allocate failed." to na

    na nl erase

    addr na len move
    na nl
;

\
\ Append a charcter to the end of a counted string
\
: cappend \ c-addr char --
    over        \ c-addr char addr
    dup c@ + 1+ \ c-addr char addr
    c!

    1 swap c+!
;
\ 
\ Bracket a string with the given char.
\ e.g.
\ If the counted string at addr is:
\ 04 T E S T
\ Then
\ addr char " 
\ Will result in 
\ 06 " T E S T " 
\ 
: quote {: c-addr c :}

    c-addr dup count 1+ move

    1 c-addr c+!

    c c-addr 1+ c!  \ leading char

    c c-addr count + c! \ trailing char

    1 c-addr c+!
;


: append-char ( c addr len -- )
    + c!
;

: append-cr ( addr len -- )
    0x0a -rot append-char
;

: place-char ( c idx  addr -- )
    swap append-char
;




