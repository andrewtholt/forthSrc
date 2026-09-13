#!/usr/bin/bash
#
# set -x

TARGET="/usr/local/lib/atlast"
if [ -d "$TARGET" ]; then
    echo "$TARGET exists"
else
    echo "$TARGET doesn't exist, creating ..."
    sudo mkdir $TARGET
    echo "... created."
fi

echo "Copying files to $TARGET ..."
sudo cp *.atl $TARGET
echo "... done."


