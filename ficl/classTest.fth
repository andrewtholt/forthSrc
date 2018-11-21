
only forth 
also oop 
definitions

object --> sub io-point
    c-string obj: .topic
    c-string obj: .name
    c-byte obj: .really

    : init { 2:THIS -- }
        this --> super --> init
    ;

    : set-topic ( a l 2:this -- ) 
        --> .topic --> set
    ;

    : set-name ( a l 2:this -- ) 
        --> .name --> set
    ;

    : subscribe ( 2:this ) 
        --> .topic --> get
    ;

    : dump { 2:this -- }
        cr

        ." Topic : " this --> .topic --> type cr
        ." Name  : " this --> .name --> type cr
        this --> .really --> get . cr
    ;

end-class


io-point --> new START
s" START" START --> set-name 
s" /test/StartSwitch" START --> set-topic
START --> dump

io-point --> new STOP
s" STOP" STOP --> set-name 
s" /test/StopSwitch" STOP --> set-topic
STOP --> dump

io-point --> new BACK-LIGHT
s" BACK-LIGHT" BACK-LIGHT --> set-name
s" /home/outside/BackFloodlight/cmnd/power" BACK-LIGHT --> set-topic
BACK-LIGHT --> dump

