\ Language: cforth
\ Access to util lib.
\ 
.( Loading utils.fth ) cr

-1 value libutils
\ -1 value libc


s" libutils.so" 1 dlopen to libutils
    libutils 0= [if] .( Failed to open libutils ) cr abort [then]

\ s" libc.so.6" 1 dlopen to libc
\    libc 0= [if] .( Failed to open libc ) cr abort [then]

s" expandPath"  libutils dlsym ?dup 0= [if] ." Not found" cr abort [then]
    acall: expand-path { $.dirList $.file a.buffer -- i.rc }

\ 0 2 s" memDump"     libutils dlsym abort" Not Found" mkfunc dump
\ 
\ s" usleep" libc dlsym ?dup 0= [if] ." Not found" cr abort [then]
\    acall: usleep { i.us -- i.is }
    
\ 1 0 s" sched_yield" libc     dlsym abort" Not Found" mkfunc (yield)
\ 
\ 1 0 s" athQkey"     libutils dlsym abort" Not Found" mkfunc ?key
\ 1 0 s" athGetKey"   libutils dlsym abort" Not Found" mkfunc key
\ 1 4 s" strCat"      libutils dlsym abort" Not Found" mkfunc strcat
\ 1 3 s" strCpy"      libutils dlsym abort" Not Found" mkfunc strcpy
\ 
\ 1024 mk-buffer drop value location
\ 1024 mk-buffer drop value path-list
\ 
\ : us ( us -- )
\     (usleep) drop
\ ;
\ 
\ : ms ( ms -- ) 
\     1000 * us
\ ;
\ 
\ : yield
\     (yield) drop
\ ;
\ \  Take a string addres and length and make into null
\ \ terminated C string.
\ \ 
\ : >c \ addr n - addr
\     2dup + 0 swap c!  \ addr n
\     drop
\ ;
\ 
\ 
\ \ : test
\ \     path-list s" PATH" getenv
\ \ 
\ \     drop s" ls" drop location expand-path
\ \ 
\ \ ;
\  
\ 
