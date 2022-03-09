s" mqtt.fth" sfind nip 0= [if]
    load mqtt.fth
[then]

only 
also oop definitions

object --> sub c-powerLoad

c-byte   obj: .status
c-byte   obj: .old-status
c-string obj: .topic
c-string obj: .on-msg
c-string obj: .off-msg
c-byte   obj: .output

: init { 2:this }
    this --> super --> init

    0 this my=[ .status set ]

    0 this my=[ .old-status set ]

    0 this my=[ .output set ]

    s" ON"  this my=[  .on-msg set ]

    s" OFF"  this my=[  .off-msg set ]

    0 this --> setOutput
;

: setTopic { t l 2:this }
    t l this my=[ .topic set ]
;

: display { 2:this }
    cr
    ." Status     :" this my=[ .status get ] . cr

    ." Topic      :" this my=[ .topic   get ] type cr
    ." On  message:" this my=[ .on-msg  get ] type cr
    ." Off message:" this my=[ .off-msg get ] type cr
    ." Output     :" this my=[ .output  get ] . cr
;

: toggleOutput { 2:this }
    this my=[ .output  get ]
    1+ 1 and 
    this my=[ .output  set ]
;

: trigger { 2:this }
    this my=[ .status      get ]
    this my=[ .old-status  get ]
    <> if
        ." different" cr
        this my=[ .status     get ]
        this my=[ .old-status set ]

        this my=[ .status get ]
        this --> toggleOutput
        this my=[ .output get ]
        this --> setOutput
    else
        ." No change" cr
    then
;

: setBit { f bit 2:this }
    f 0<> if
        bit bmask + c@ 
        this my=[ .status get ]
        or
        this my=[ .status set ]
    else
        bit bmask + c@ invert
        this my=[ .status get ]
        and
        this my=[ .status set ]
    then
    this --> trigger
;

: setOutput { f 2:this }
    this my=[ .topic get ]

    f 0<> if
        this --> .on-msg 
    else
        this --> .off-msg 
    then

    --> get 
    mqtt-pub

;

end-class
\ 
\ c-powerload --> new lamp
\ 
\ s" /home/outside/BackFloodlight/cmnd/power" lamp --> setTopic
\ 
\ lamp --> display
\ 
\ 
