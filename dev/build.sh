#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

rm   -rf "$OF/lib"
rm       "$OF/lib.tar.gz"

mkdir -p "$OF/build/Release/linux"
cd       "$OF/build/Release/linux"
cmake    "$OF" -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release
ninja

mkdir -p "$OF/build/Debug/linux"
cd       "$OF/build/Debug/linux"
cmake    "$OF" -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug
ninja

mkdir -p "$OF/build/Release/windows"
cd       "$OF/build/Release/windows"
cmake    "$OF" -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/mxe/mingw.cmake
ninja

tar -czvf "$OF/lib.tar.gz" "$OF/lib"
