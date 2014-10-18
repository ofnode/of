#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ../..
OF="`pwd`"

ORIGINS=$(find "$OF/src" -type f -name *.origin)

for i in "$ORIGINS"; do
    DIR="`basename "$(dirname $i)"`"
    mkdir -p "$OF"/dev/tools/"$DIR"
    diff -Naur "$i" "`dirname "$i"`"/"`basename "${i%.*}"`" > "$OF"/dev/tools/"$DIR"/"`basename "${i%.*}"`".patch
done
