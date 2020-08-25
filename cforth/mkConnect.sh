#!/bin/bash

WIFI_BASE=""
WIFI_PASSWORD=""
OP="/dev/tty"

while getopts b:ho:p: val
do
    case $val in
        b) WIFI_BASE="$OPTARG";;
        h) printf "Usage -h -b <BASE NAME> -p <PASSWORD> -o <OUTPUT_FILE>\n" 
            exit 2;;
        o) OP="$OPTARG";;
        p) WIFI_PASSWORD="$OPTARG";;
        *) usage;;
    esac
done

if [ -z "$WIFI_BASE" ]; then
    echo "Set WIFI_BASE"
    exit
fi


if [ -z "$WIFI_PASSWORD" ]; then
    echo "Set WIFI_PASSWORD"
    exit
fi


echo ":noname \" ${WIFI_BASE}\" ; to wifi-sta-ssid"  > $OP
echo ":noname \" ${WIFI_PASSWORD}\" ; to wifi-sta-password" >> $OP

echo "wifi-sta-on" >> $OP

