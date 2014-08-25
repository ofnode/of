#!/bin/bash

cd `dirname $(readlink -f $0)`

rm -rf Debug_Build
mkdir  Debug_Build
cd     Debug_Build

ANALYSE=$(dirname `readlink -f /usr/bin/scan-build`)

cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_CXX_COMPILER=$ANALYSE/c++-analyzer \
  -DCMAKE_C_COMPILER=$ANALYSE/ccc-analyzer

scan-build -analyze-headers --use-cc=clang --use-c++=clang++ --view ninja

