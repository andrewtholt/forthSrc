#!/bin/sh

# set -x

LIB_TARGET=/usr/local/lib/Forth
CATEGORY="common"

if [ -d $LIB_TARGET ]; then
    echo "Base exists ..."
else
    echo "Base does no exist, creating  ..."
    sudo mkdir -p $LIB_TARGET
fi

if [ -d ${LIB_TARGET}/${CATEGORY} ]; then
    echo "... Category directory exists ..."
else
    echo "... Category directory does not exist ..."
    sudo mkdir -p ${LIB_TARGET}/${CATEGORY}
fi

echo "... Copying files ..."
sudo cp *.fth ${LIB_TARGET}/${CATEGORY}
echo "... done."

