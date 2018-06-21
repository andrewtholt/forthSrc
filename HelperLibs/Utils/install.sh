#!/bin/sh

LIB_TARGET="/usr/local/lib"
CFORTH_TARGET=${LIB_TARGET}/cforth

if [ ! -d $LIB_TARGET ]; then
    echo "Fatal Error:${LIB_TARGET} does not exist"
    exit 1
fi

if [ ! -f libutils.so ]; then
    make
fi

echo "Moving libutils.so"
sudo mv libutils.so /usr/local/lib
sudo ldconfig

if [ ! -d $CFORTH_TARGET ]; then
    echo "Error:${CFORTH_TARGET} does not exist, creating ..."
    sudo mkdir -p ${CFORTH_TARGET}
    echo "... done"
fi

exit 0

echo "Copying utils.fth"
FICL_DIR="/usr/local/lib/ficl"
sudo mkdir -p $FICL_DIR
sudo cp ./utils.fth $FICL_DIR
