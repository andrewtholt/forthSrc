#!/bin/sh

CFORTH_TARGET=${LIB_TARGET}/cforth

if [ ! -d $CFORTH_TARGET ]; then
    echo "Error:${CFORTH_TARGET} does not exist, creating ..."
    sudo mkdir -p ${CFORTH_TARGET}
    echo "... done"
fi

sudo cp lib.fth $CFORTH_TARGET
