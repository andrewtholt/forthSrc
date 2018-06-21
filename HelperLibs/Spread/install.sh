#!/bin/bash

LIB_TARGET="/usr/local/lib"
CFORTH_TARGET=${LIB_TARGET}/cforth

if [ ! -d $LIB_TARGET ]; then
    echo "Fatal Error:${LIB_TARGET} does not exist"
    exit 1
fi

if [ ! -f libspreadhelper.so ]; then 
    make
fi

echo "Moving libspreadhelper.so"
sudo mv libspreadhelper.so $LIB_TARGET
sudo ldconfig

if [ ! -d $CFORTH_TARGET ]; then
    echo "Error:${CFORTH_TARGET} does not exist, creating ..."
    sudo mkdir -p ${CFORTH_TARGET}
    echo "... done"
fi

echo "Copy cforth source libs ...."
sudo cp simpleSpread.fth $CFORTH_TARGET
echo "... done"

