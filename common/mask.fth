
\
\ Mask for setting, clearing and testing 32 bit values.
\

create (mask)
    0x00000001 , 
    0x00000002 , 
    0x00000004 , 
    0x00000008 , 
    0x00000010 , 
    0x00000020 , 
    0x00000040 , 
    0x00000080 , 
    0x00000100 , 
    0x00000200 , 
    0x00000400 , 
    0x00000800 , 
    0x00001000 , 
    0x00002000 , 
    0x00004000 , 
    0x00008000 , 
    0x00010000 , 
    0x00020000 , 
    0x00040000 , 
    0x00080000 , 
    0x00100000 , 
    0x00200000 , 
    0x00400000 , 
    0x00800000 , 
    0x01000000 , 
    0x02000000 , 
    0x04000000 , 
    0x08000000 , 
    0x10000000 , 
    0x20000000 , 
    0x40000000 , 
    0x80000000 , 

\
\ Mask for setting, clearing and testing 16 bit values.
\
create (wmask)
    0x0001 , 
    0x0002 , 
    0x0004 , 
    0x0008 , 
    0x0010 , 
    0x0020 , 
    0x0040 , 
    0x0080 , 
    0x0100 , 
    0x0200 , 
    0x0400 , 
    0x0800 , 
    0x1000 , 
    0x2000 , 
    0x4000 , 
    0x8000 ,
\
\ mask for 8 bit values
\
create (bmask) 
    0x01 c, 
    0x02 c, 
    0x04 c, 
    0x08 c, 
    0x10 c, 
    0x20 c, 
    0x40 c, 
    0x80 c,

: mask  cells (mask) + @ ;

: wmask cells (wmask) + @ 0xffff and ;

: bmask chars (bmask) + c@ 0xff and ;


