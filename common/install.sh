#!/bin/sh

# set -x

LIB_TARGET=/usr/local/lib/Forth
CATEGORY="common"

if [ -d $LIB_TARGET ]; then
    echo "Base exists ..."

    if [ -d ${LIB_TARGET}/${CATEGORY} ]; then
        echo "... Category directory exists ..."
        sudo cp *.fth ${LIB_TARGET}/${CATEGORY}
    fi
fi

