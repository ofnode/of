#!/bin/bash -eux

case "$TRAVIS_OS_NAME" in
  linux)
    $TRAVIS_BUILD_DIR/dev/install/linux/ubuntu.sh

    wget https://cmake.org/files/v3.7/cmake-3.7.0-Linux-x86_64.tar.gz -O cmake-linux.tgz
    tar xaf cmake-linux.tgz
    mv cmake-*-x86_64 cmake
  ;;
  osx)
    $TRAVIS_BUILD_DIR/dev/install/osx/homebrew.sh
  ;;
esac
