#!/bin/bash

# set -x

if [ $# -ne 1 ]; then
    echo "Usage: extractStruct <name of struct>"

    exit 0
fi


awk -v structName=$1 'BEGIN {
    inStruct=0;
}

{
    if (inStruct != 0) {
        print $0
    }
}

/struct / {
    if( inStruct == 0) {
        if ( $2 == structName ) {
            inStruct=1;
            print $1,$2, "{"
            }
    } else {
        print $0
    }
}


/};/ {
    inStruct = 0;
}' 

