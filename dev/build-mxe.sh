#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

#-------------------------------------------------------------------------------

mkdir -p "$OF/build/mxe/release"
cd       "$OF/build/mxe/release"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake` -DCMAKE_BUILD_TYPE=Release
ninja

mkdir -p "$OF/build/mxe/debug"
cd       "$OF/build/mxe/debug"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake` -DCMAKE_BUILD_TYPE=Debug
ninja
