#!/bin/bash

export OF_ROOT=${PWD}/of
echo "OF_ROOT: $OF_ROOT"

case "$TRAVIS_OS_NAME" in
  linux)
  export CMAKE_BIN=$(readlink -f "$(find cmake/bin -name cmake -type f )")
  ;;
  osx)
  export CMAKE_BIN=$(which cmake)
  ;;
esac

mkdir build
cd build

case "$TRAVIS_OS_NAME" in
  linux)
    export CC=gcc-6
    export CXX=g++-6
    export LD_LIBRARY_PATH="/usr/lib64:$LD_LIBRARY_PATH"
    $CMAKE_BIN -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DOF_STATIC=$OF_STATIC -DCOTIRE=OFF ..
    $CMAKE_BIN --build . -- -j2
    case "$TARGET" in
      Coverage)
        gem install coveralls-lcov
        $CMAKE_BIN --build . --target of_coverage
        mv coverage.info.cleaned coverage.info
        coveralls-lcov coverage.info
      ;;
      Examples)
        cd ../examples
        mkdir build
        cd build
        $CMAKE_BIN  .. -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBUILD_ALL=OFF -DofExamples=ON -DCOTIRE=OFF;
        $CMAKE_BIN --build . -- -j2
    esac
  ;;

  osx)
    export CXX=clang++
    export CMAKE_BIN=$(which cmake)
    $CMAKE_BIN -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
               -DOOF_STATIC=$OF_STATIC \
               -DCMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH" \
               -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
               -DOF_ROOT=$OF_ROOT \
               -DCOTIRE=OFF \
               ..
    $CMAKE_BIN --build . -- -j2
    if [[ "x$TARGET" == "xExamples" ]]; then
        cd ../examples
        mkdir build
        cd build
        $CMAKE_BIN  .. -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBUILD_ALL=OFF -DofExamples=ON -DCOTIRE=OFF;
        $CMAKE_BIN --build . -- -j2
    fi
  ;;
esac
