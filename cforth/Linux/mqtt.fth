showstack
fl struct.fth

0 value init-run
-1 value libmosquitto
-1 value libhelper
-1 value client
1883 constant port

#255 constant /mqtt-buffer
/mqtt-buffer buffer: mqtt-buffer

struct
     2 chars field msg-flag
    64 chars field topic
    32 chars field payload
endstruct /mqtt-msg    

: mqtt-init
    ." Init" cr
    init-run 0= if
        s" libmosquitto.so.1"  1 dlopen to libmosquitto 
        s" ./libmqttcallback.so" 1 dlopen to libhelper    

        -1 to init-run
    then
;

mqtt-init
\ s" sizeOfMessage" libhelper dlsym abort" Not found" acall: size-of-message 
 
s" init"          libhelper dlsym abort" Not found" acall: callback-init { a.client -- }
 
s" mosquitto_new" libmosquitto dlsym abort" Not found" acall: mqtt-new { a.name i.clean a.buffer -- i.rc }

s" mosquitto_connect" libmosquitto dlsym abort" Not found" acall: mqtt-client { a.mosq a.host i.port i.keep -- i.rc }

\ 1 0 s" mosquitto_lib_init" libmosquitto dlsym abort" Not found" mkfunc mqtt-init \ Returns 0
\ 0 2 s" mosquitto_message_callback_set" libmosquitto dlsym abort" Not found" mkfunc mqtt-msg-callback-set 
s" mosquitto_loop_start"  libmosquitto dlsym abort" Not found" acall: mqtt-loop-start { a.client -- i.rc }
s" mosquitto_loop"       libmosquitto dlsym abort" Not found" acall: mqtt-loop { a.client i.timeout i.max -- i.rc }
s" mosquitto_subscribe"  libmosquitto dlsym abort" Not found" acall: (mqtt-sub) { a.client a.mid $.topic i.qos -- i.rc }
\ 1 7 s" mosquitto_publish"    libmosquitto dlsym abort" Not found" mkfunc (mqtt-pub)
\ 
\ 
\ /mqtt-buffer allocate abort" Allocate failed" to mqtt-buffer


mqtt-buffer /mqtt-buffer erase

: .msg    
    mqtt-buffer msg-flag drop w@ . cr    
    mqtt-buffer topic   type cr    
    mqtt-buffer payload type cr    
;


: mqtt-sub { topic tlen -- rc }
    client 0 topic tlen 0 (mqtt-sub)
;
\ 
\ : mqtt-pub { topic tlen payload plen -- rc }
\    client 0 topic plen payload 0 1 (mqtt-pub)
\ ;
\ 
