#!/bin/bash

# set -x

STATUS=$(which rlwrap > /dev/null)

if [ $? -ne 0 ]; then
    echo "Can't find rlwrap."
    exit 1
fi

if [ -z "$FORTH" ]; then
    FORTH=cforth
fi

if [ "$FORTH" = "ficl" ]; then
    if [ -z "$FICL_PATH" ]; then
        export FICL_PATH="/usr/local/lib/ficl:."
    fi
    if [ "$#" -eq 0 ]; then
        rlwrap -n ficl
    else
        rlwrap -n ficl  $*
    fi
    exit 0
fi

if [ "$FORTH" = "atlast" ]; then
    rlwrap -n atlast $*
fi

if [ "$FORTH" = "gforth" ]; then
    gforth $*
fi

if [ "$FORTH" = "cforth" ]; then
    DICT=/usr/local/etc/app.dic
    cforth $DICT $*
fi

