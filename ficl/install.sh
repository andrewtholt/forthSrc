#!/bin/sh
DEST=/usr/local/lib/ficl

FILES="dynamic.fth lib.fth struct.fth"

if [ ! -d $DEST ]; then
    echo "Making $DEST"
    mkdir -p $DEST
else
    echo "$DEST exists."
fi

for N in $FILES; do
    echo $N
    cp $N $DEST
done
