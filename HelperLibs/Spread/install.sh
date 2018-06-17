#!/bin/bash

if [ ! -f libspreadhelper.so ]; then 
    make
fi

echo "Moving libspreadhelper.so"
sudo mv libspreadhelper.so /usr/local/lib/
sudo ldconfig

