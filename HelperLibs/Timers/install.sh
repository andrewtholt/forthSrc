#!/bin/bash

# set -x

HERE=$(pwd)
make

sudo mv libficltimer.so.1.0 /usr/local/lib

if [ -L /usr/local/lib/libficltimer.so ]; then
    sudo rm -f /usr/local/lib/libficltimer.so
fi

cd /usr/local/lib

sudo ln -s libficltimer.so.1.0 libficltimer.so

cd $HERE
sudo ldconfig
