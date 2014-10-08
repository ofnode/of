#!/bin/bash
cd `dirname $(readlink -f $0)`
cd ..
OF=`pwd`

rm lib/Release/windows/*
rm lib/Release/linux/*
rm lib/Debug/linux/*

rm -rf build
mkdir  build
cd     build

cmake .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Release
ninja
rm -rf *

cmake .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_BUILD_TYPE=Debug
ninja
rm -rf *

if [ -f /opt/mxe/mingw.cmake ]; then
    cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/mxe/mingw.cmake
    ninja
    rm -rf *
fi
