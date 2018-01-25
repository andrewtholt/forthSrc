load lib.fth

only 
also oop definitions

object --> sub c-powerLoad

c-byte   obj: .status
c-byte   obj: .old-status
c-string obj: .topic
c-string obj: .on-msg
c-string obj: .off-msg

: init { 2:this }
    this --> super --> init
    0 this --> .status     --> set
    0 this --> .old-status --> set
    s" ON"  this --> .on-msg  --> set
    s" OFF" this --> .off-msg --> set
;

: setTopic { t l 2:this }
    t l this --> .topic --> set
;

: display { 2:this }
    cr
    ." Status     :"
    this --> .status --> get
    . cr
    ." Topic      :" this --> .topic   --> get type cr
    ." On  message:" this --> .on-msg  --> get type cr
    ." Off message:" this --> .off-msg --> get type cr
;

: trigger { 2:this }
    this --> .status --> get
    this --> .old-status --> get
    <> if
        ." different" cr
        this --> .status --> get
        this --> .old-status --> set
    else
        ." No change" cr
    then
;

: setBit { f bit 2:this }
    f 0<> if
        bit bmask + c@ 
        this --> .status --> get 
        or
        this --> .status --> set 
    else
        bit bmask + c@ invert
        this --> .status --> get 
        and
        this --> .status --> set 
    then
    this --> trigger
;

: setOutput { 2:this }
    this --> .topic --> get type cr

    0<> if
        this --> .on-msg 
    else
        this --> .off-msg 
    then

    --> get type cr

;

end-class


c-powerload --> new lamp

s" /home/house/DHL" lamp --> setTopic

