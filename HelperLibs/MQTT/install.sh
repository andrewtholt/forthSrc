#!/bin/bash

if [ ! -f libmqttcallback.so ]; then 
    make
fi

echo "Moving libmqttcallback.so"
sudo mv libmqttcallback.so /usr/local/lib/
sudo ldconfig

FICL_DIR="/usr/local/lib/ficl"
sudo mkdir -p $FICL_DIR

echo "Copying mqtt.fth"
sudo cp ./mqtt.fth $FICL_DIR

echo "Copying haLoadClass.fth"
sudo cp ./haLoadClass.fth $FICL_DIR
