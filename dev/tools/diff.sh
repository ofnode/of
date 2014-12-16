#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ../..
OF="`pwd`"

#-------------------------------------------------------------------------------

find "$OF" -type f -name *.origin -print0 | while IFS= read -r -d '' i; do
    DIR="`basename "$(dirname $i)"`"
    mkdir -p "$OF"/dev/tools/diff/"$DIR"
    diff -Naur "$i" "`dirname "$i"`"/"`basename "${i%.*}"`" > "$OF"/dev/tools/diff/"$DIR"/"`basename "${i%.*}"`".patch
done
