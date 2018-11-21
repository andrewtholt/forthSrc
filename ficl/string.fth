only forth
also oop definitions

variable op
: !OREG
    op !
;

OBJECT --> SUB C-LED


C-BYTE OBJ: .STATE
C-STRING OBJ: .NAME

: INIT   { 2:THIS -- }
    THIS --> SUPER --> INIT
    ." Initializing an instance of "
    THIS --> CLASS --> ID TYPE CR ;
: ON   { LED# 2:THIS -- }
    THIS --> .STATE --> GET
    1 LED# LSHIFT OR DUP !OREG
    THIS --> .STATE --> SET  ;
: OFF   { LED# 2:THIS -- }
    THIS --> .STATE --> GET
    1 LED# LSHIFT INVERT AND DUP !OREG
    THIS --> .STATE --> SET
;
END-CLASS
