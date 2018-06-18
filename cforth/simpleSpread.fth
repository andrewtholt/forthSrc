-1 value libspreadhelper
s" libspreadhelper.so" 1 dlopen ?dup 0= [if] ." no libspreadhelper" cr abort [then] to libspreadhelper

s" getUser" libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then]
    acall: get-user { -- s.user }

s" setUser" libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then] 
    acall: set-user { $.name -- }

s" getIam"  libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then]
    acall: get-iam { -- s.iam }

s" getServer" libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then]
    acall: get-server { -- s.server }

s" setServer" libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then] 
    acall: set-server { $.server -- }

s" SPConnectSimple" libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then]
    acall: sp-connect { -- i.rc }

s" dump" libspreadhelper dlsym ?dup 0= [if] ." Not found" cr abort [then]
    acall: sp-dump { --  }

