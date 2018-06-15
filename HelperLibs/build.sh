#!/bin/bash

# set -x

LIST=$(ls)
HERE=$(pwd)
INSTALL="NO"

if [ $# -gt 0 ]; then
    if [  "$1" == "install" ]; then
        INSTALL="YES"
        tput bold
        echo "Perform Install after build"
        tput sgr0
    fi
fi

for N in $LIST; do
    if [ -d $N ]; then
        tput bold
        echo "Entering directory $N"
        tput sgr0

        if [ -f "${N}/Makefile" ]; then
            make -C $N 
            if [ $INSTALL == "YES" ]; then
                make -C $N install
            fi
        else
            echo "No Makefile"
        fi
        cd $HERE
    fi
done


