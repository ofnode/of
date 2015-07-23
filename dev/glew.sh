#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

#-------------------------------------------------------------------------------

cd "$OF/src/glew/auto" && make

