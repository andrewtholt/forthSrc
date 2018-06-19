-1 value libspreadhelper
-1 value libspread

s" libspread.so" 1 dlopen to libspread
    libspread 0= [if] .( Failed to open libspread ) cr abort [then]

s" SP_error" libspread dlsym acall: sp-error { i.error -- }

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

s" SPJoinSimple"  libspreadhelper dlsym acall: sp-join 
    { $.group -- i.rc }

s" SPLeaveSimple" libspreadhelper dlsym acall: sp-leave
    { $.group -- i.rc }

s" SPTxSimple" libspreadhelper dlsym acall: sp-tx 
    { $.group $.message -- i.rc }

s" SPRxSimple" libspreadhelper dlsym acall: sp-rx 
    { i.len i.msg -- i.rc }

s" SPPollSimple" libspreadhelper dlsym acall: sp-poll 
    { -- i.rc }
