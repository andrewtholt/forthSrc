
s" dynamic.fth" sfind nip 0= [if]
    load dynamic.fth
[then]

.( Loading utils.fth ) cr

-1 value libutils
-1 value libc


s" libutils.so" dlopen abort" failed" to libutils
s" libc.so.6"                  dlopen abort" failed" to libc

1 3 s" expandPath"  libutils dlsym abort" Not Found" mkfunc expand-path
0 2 s" memDump"     libutils dlsym abort" Not Found" mkfunc dump

1 1 s" usleep"      libc     dlsym abort" Not Found" mkfunc (usleep)
1 0 s" sched_yield" libc     dlsym abort" Not Found" mkfunc (yield)

1 0 s" athQkey"     libutils dlsym abort" Not Found" mkfunc ?key
1 0 s" athGetKey"   libutils dlsym abort" Not Found" mkfunc key
1 4 s" strCat"      libutils dlsym abort" Not Found" mkfunc strcat
1 3 s" strCpy"      libutils dlsym abort" Not Found" mkfunc strcpy

1024 mk-buffer drop value location
1024 mk-buffer drop value path-list

: us ( us -- )
    (usleep) drop
;

: ms ( ms -- ) 
    1000 * us
;

: yield
    (yield) drop
;
\  Take a string addres and length and make into null
\ terminated C string.
\ 
: >c \ addr n - addr
    2dup + 0 swap c!  \ addr n
    drop
;


\ : test
\     path-list s" PATH" getenv
\ 
\     drop s" ls" drop location expand-path
\ 
\ ;
 

