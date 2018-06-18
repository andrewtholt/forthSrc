
fl spread.fth

-1 value private-group

variable mbox 0 mbox !

variable endian 0 endian !

variable mess_type 0 mess_type !

variable num_groups 0 num_groups !

variable service_type 0 service_type !


d# 16 buffer: iam
d# 16 buffer: server
MAX_GROUP_NAME buffer: sender
MAX_GROUP_NAME buffer: target

MAX_GROUP_NAME d# 100 * constant /target_groups
/target_groups buffer: target_groups

MAX_MESSLEN buffer: message


" 4803@192.168.0.65" server place
" cforth" iam place

MAX_GROUP_NAME allocate drop to private-group

: fred
    private-group mbox 1 0 s" cforth" s" 4803@192.168.0.65"
    sp-connect

    mbox @ 0> if
        s" global" mbox @ sp-join
    else
        ." Connect failed." cr
        abort
    then

    clear
    s" This is a test" 1 s" global" AGREED_MESS mbox @ sp-multicast 

    message MAX_MESSLEN endian mess_type target_groups num_groups d# 100 sender service_type mbox @
    sp-receive

    s" global" mbox @ sp-leave
;
