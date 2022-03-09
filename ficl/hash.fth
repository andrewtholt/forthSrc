
: hash ( addr len )
    0 -rot
    over + swap do 
        i c@ +
    loop

    5 mod .
;

