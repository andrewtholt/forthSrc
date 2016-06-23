( )
( Forth data structures from Forth Dimension UK )
( )

.( Loading struct ) cr

: dofield
does> ( c d )
 dup @  ( c d o )
 swap   ( c o d )
 cell+ @      ( c o s )
 -rot   ( s c o )
 + swap drop \ lose the length here, I always seem to drop this anyway.
;

: field   ( offset size )
  create 
    2dup  
    swap 
    ,    
    ,   
    +  
  dofield
;

0 constant struct

: endstruct
  create
    ,
  does>
    @
;

\ Example

\ struct
\ 10 chars field first-name
\ 20 chars field  surname
\ endstruct name
\ 
\ name allocate abort" Allocation Failed" value name-buffer
\
\ name-buffer name erase
\ 
\ name-buffer surname
\
\ The above returns the address and the size of the surname field: e.g:
\
\ 1234 20
