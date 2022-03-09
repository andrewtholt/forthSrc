s" utils.fth sfind nip 0= [if]
    load utils.fth
[then]


s" ./libcpp.so" dlopen abort" Failed to open libcpp" value libcpp

1 0 s" newVector"      libcpp dlsym abort" Not found" mkfunc new-vector
1 1 s" vectorSize"     libcpp dlsym abort" Not found" mkfunc vector-size
1 2 s" vectorGet"      libcpp dlsym abort" Not found" mkfunc vector-get

0 2 s" vectorAppend"   libcpp dlsym abort" Not found" mkfunc vector-append
0 2 s" vectorErase"    libcpp dlsym abort" Not found" mkfunc vector-erase
0 1 s" vectorEraseAll" libcpp dlsym abort" Not found" mkfunc vector-erase-all

1 0 s" newMap"         libcpp dlsym abort" Not found" mkfunc new-map
1 1 s" mapSize"        libcpp dlsym abort" Not found" mkfunc map-size
0 3 s" mapAdd"         libcpp dlsym abort" Not found" mkfunc map-add
1 2 s" mapGet"         libcpp dlsym abort" Not found" mkfunc map-get
1 2 s" mapExists"      libcpp dlsym abort" Not found" mkfunc map-exists

0 1 s" mapEraseAll"    libcpp dlsym abort" Not found" mkfunc map-erase-all
0 2 s" mapErase"       libcpp dlsym abort" Not found" mkfunc map-erase

-1 value v
: test-vector
    new-vector to v

    v s" Test" drop  vector-append

    v vector-size . cr

    v 0 vector-get .s

    v 0 vector-erase

    v vector-size . cr

;

-1 value m

: test-map
    m 0< if
        new-map to m
    then

    m s" Testing 1" >c 1  map-add
    m s" Testing 2" >c 2  map-add
    m s" Testing 3" >c 3  map-add

    m map-size 
    ." map-size:" . cr

\ Need to deal with key doesn't exist
\
    m s" Test" >c map-exists if
	    m s" Test" >c map-get 
	    ." map-get:" . cr
	else
	    ." map-get: Not found" cr
	then
    
    m s" Testing 2" >c map-get 
    ." map-get:" . cr

    m s" Test" >c map-exists 
    ." map-exists:" . cr

    m s" Testing 2" >c map-erase

    m map-size 
    ." map-size:" . cr

;

: test
    test-vector
;



