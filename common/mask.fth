\
\ Mask for setting, clearing and testing 32 bit values.
\

10 value tmpBase

base @ to tmpBase
hex

create (mask)
    00000001 , 
    00000002 , 
    00000004 , 
    00000008 , 
    00000010 , 
    00000020 , 
    00000040 , 
    00000080 , 
    00000100 , 
    00000200 , 
    00000400 , 
    00000800 , 
    00001000 , 
    00002000 , 
    00004000 , 
    00008000 , 
    00010000 , 
    00020000 , 
    00040000 , 
    00080000 , 
    00100000 , 
    00200000 , 
    00400000 , 
    00800000 , 
    01000000 , 
    02000000 , 
    04000000 , 
    08000000 , 
    10000000 , 
    20000000 , 
    40000000 , 
    80000000 , 

\
\ Mask for setting, clearing and testing 16 bit values.
\
create (wmask)
    0001 , 
    0002 , 
    0004 , 
    0008 , 
    0010 , 
    0020 , 
    0040 , 
    0080 , 
    0100 , 
    0200 , 
    0400 , 
    0800 , 
    1000 , 
    2000 , 
    4000 , 
    8000 ,
\
\ mask for 8 bit values
\
create (bmask) 
    01 c, 
    02 c, 
    04 c, 
    08 c, 
    10 c, 
    20 c, 
    40 c, 
    80 c,

: mask  cells (mask) + @ ;

: wmask cells (wmask) + @ ffff and ;

: bmask chars (bmask) + c@ ff and ;

tmpBase base !



