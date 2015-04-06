#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

#-------------------------------------------------------------------------------

mkdir -p "$OF/build/linux/release"
cd       "$OF/build/linux/release"
cmake    "$OF" -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release
ninja

mkdir -p "$OF/build/linux/debug"
cd       "$OF/build/linux/debug"
cmake    "$OF" -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug
ninja

if [ -d /opt/mxe ]; then

mkdir -p "$OF/build/windows/release"
cd       "$OF/build/windows/release"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake` -DCMAKE_BUILD_TYPE=Release
ninja

mkdir -p "$OF/build/windows/debug"
cd       "$OF/build/windows/debug"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=`find /opt/mxe -name mxe-conf.cmake` -DCMAKE_BUILD_TYPE=Debug
ninja

fi

cd  "$OF"
tar -czvf lib-linux.tar.gz lib-linux
tar -czvf lib-windows.tar.gz lib-windows
