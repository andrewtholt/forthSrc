#!/bin/sh

if [ ! -f libutils.so ]; then
    make
fi

echo "Moving libutils.so"
sudo mv libutils.so /usr/local/lib
sudo ldconfig

echo "Copying utils.fth"
FICL_DIR="/usr/local/lib/ficl"
sudo mkdir -p $FICL_DIR
sudo cp ./utils.fth $FICL_DIR
