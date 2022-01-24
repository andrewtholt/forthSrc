
: server$ " 192.168.10.124" ;

: base-topic " /home/office/forth/" ;

: tst1
    base-topic pad place
    s" cmnd/POWER" pad +place
    pad count
;

: tst-set ( string$ -- )
    tst1 0 0 mqtt-publish-qos0
;

mqtt-start

" OFF" " /home/office/forth/cmnd/power" 0 0 mqtt-publish-qos0

" ON" " /home/office/forth/cmnd/power" 0 0 mqtt-publish-qos0

