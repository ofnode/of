#!/bin/bash -eux

case "$TRAVIS_OS_NAME" in
  linux)
    $TRAVIS_BUILD_DIR/of/dev/install/linux/ubuntu.sh

    wget https://cmake.org/files/v3.7/cmake-3.7.0-Linux-x86_64.tar.gz -O cmake-linux.tgz
    tar xaf cmake-linux.tgz
    mv cmake-*-x86_64 cmake
  ;;
  osx)
    $TRAVIS_BUILD_DIR/of/dev/install/osx/homebrew.sh
  ;;
esac


# build of
mkdir build-of;
pushd build-of;
if [[ "${TRAVIS_OS_NAME}" == "linux" ]]; then
  export CC=gcc-6
  export CXX=g++-6
fi
case "$BUILD_TYPE" in
  Debug)
    cmake -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DOF_STATIC=$OF_STATIC ../of
    ;;
  Release)
    cmake -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DOF_STATIC=$OF_STATIC ../of
    ;;
  Coverage)
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DOF_COVERAGE=1 ../of
    ;;
esac
cmake --build . -- -j2
popd
