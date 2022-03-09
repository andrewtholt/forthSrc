
: server$ " 192.168.10.124" ;

mqtt-start

" OFF" " /home/office/officeLights/cmnd/power" 0 0 mqtt-publish-qos0

" ON" " /home/office/officeLight/cmnd/power" 0 0 mqtt-publish-qos0

