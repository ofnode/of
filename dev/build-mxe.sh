#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

#-------------------------------------------------------------------------------

mkdir -p "$OF/build/windows/release"
cd       "$OF/build/windows/release"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake` -DCMAKE_BUILD_TYPE=Release
ninja

mkdir -p "$OF/build/windows/debug"
cd       "$OF/build/windows/debug"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake` -DCMAKE_BUILD_TYPE=Debug
ninja

cd  "$OF"
tar -czvf lib-windows-mxe.tar.gz lib-windows
