
s" dynamic.fth" sfind nip 0= [if]
    load dynamic.fth
[then]

0 value init-run
-1 value libmosquitto
-1 value libhelper
-1 value client
1883 constant port

-1 value mqtt-buffer

struct
     2 chars field msg-flag
    64 chars field topic
    32 chars field payload
endstruct /mqtt-msg    


: mqtt-init
    init-run 0= if
        s" libmosquitto.so.1" dlopen abort" What." to libmosquitto
        s" libmqttcallback.so" dlopen abort" What."  to libhelper

        -1 to init-run
    then
;

mqtt-init
1 0 s" sizeOfMessage" libhelper dlsym abort" Not found" mkfunc /mqtt-buffer

0 1 s" init"          libhelper dlsym abort" Not found" mkfunc callback-init

1 3 s" mosquitto_new"      libmosquitto dlsym abort" Not found" mkfunc mqtt-new 
1 4 s" mosquitto_connect"  libmosquitto dlsym abort" Not found" mkfunc mqtt-client 
1 0 s" mosquitto_lib_init" libmosquitto dlsym abort" Not found" mkfunc mqtt-init \ Returns 0
0 2 s" mosquitto_message_callback_set" libmosquitto dlsym abort" Not found" mkfunc mqtt-msg-callback-set 
1 1 s" mosquitto_loop_start"  libmosquitto dlsym abort" Not found" mkfunc mqtt-loop-start
1 3 s" mosquitto_loop"       libmosquitto dlsym abort" Not found" mkfunc mqtt-loop 
1 4 s" mosquitto_subscribe"  libmosquitto dlsym abort" Not found" mkfunc (mqtt-sub)
1 7 s" mosquitto_publish"    libmosquitto dlsym abort" Not found" mkfunc (mqtt-pub)


/mqtt-buffer allocate abort" Allocate failed" to mqtt-buffer
mqtt-buffer /mqtt-buffer erase

s" messageCallback" libhelper dlsym abort" Not found" constant msg-callback

: mqtt-sub { topic tlen -- rc }
    client 0 topic 0 (mqtt-sub)
;

: mqtt-pub { topic tlen payload plen -- rc }
   client 0 topic plen payload 0 1 (mqtt-pub)
;

