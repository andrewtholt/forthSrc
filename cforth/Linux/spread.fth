-1 value libspread 

h#     10 constant AGREED_MESS
d#     32 constant MAX_GROUP_NAME
d# 102400 constant MAX_MESSLEN

s" libspread.so" 1 dlopen to libspread

s" SP_connect" libspread dlsym abort" Not Found" acall: sp-connect 
{ a.private_group i.mbox i.group_membership i.priority $.name $.spread_name -- i.result }

s" SP_join" libspread dlsym abort" Not Found" acall: sp-join { $.group i.mbox -- }

s" SP_multicast" libspread dlsym abort" Not Found" acall: sp-multicast { a.msg i.len i.const $.group i.svc_type i.mbox -- i.ret }

s" SP_leave" libspread dlsym abort" Not Found" acall: sp-leave { $.group i.mbox -- i.ret }

s" SP_receive" libspread dlsym abort" Not Found" acall: sp-receive 
    { a.msg i.len i.endian  a.mess_type a.target_groups i.max_groups a.sender a.service_type i.mbox -- i.ret }
