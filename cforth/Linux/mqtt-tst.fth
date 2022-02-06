
fl mqtt.fth

0 value mosq
false value tst-init-run?

: host
    s" 192.168.10.124"
;

10 value keep-alive

: tst-init
    clear
    tst-init-run? 0= if
        mqtt-buffer 1 0 mqtt-new ?dup 0= abort" new failed." to client

\        keep-alive port host client mqtt-client 0= abort" client failed."

\        client callback-init
        true to tst-init-run?
    then
;
.s

: tst
    tst-init

    client mqtt-loop-start

;

