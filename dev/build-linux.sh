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
