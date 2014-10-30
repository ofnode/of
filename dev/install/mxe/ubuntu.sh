#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install \
    autoconf automake bash bison bzip2 cmake flex gettext \
    git g++ gperf intltool libffi-dev libtool libltdl-dev \
    libssl-dev libxml-parser-perl make openssl patch perl \
    pkg-config python ruby scons sed unzip wget autopoint \
    xz-utils

if [ ! -d /opt/mxe ]; then
    sudo git clone https://github.com/mxe/mxe.git /opt/mxe
fi

cd /opt/mxe

sudo make MXE_TARGETS=x86_64-w64-mingw32.static \
mingw-w64   \
winpthreads \
cairo       \
openssl     \
freetype    \
assimp      \
opencv      \
openal      \
libsndfile

sudo make MXE_TARGETS=x86_64-w64-mingw32.shared \
openal      \
libsndfile

sudo ln -s /opt/mxe/usr/x86_64-w64-mingw32.static/share/cmake/mxe-conf.cmake /opt/mxe/mingw.cmake 2> /dev/null

