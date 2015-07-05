#!/bin/bash

yes | sudo pacman -Syu

yes | sudo pacman -Sy --needed \
    autoconf automake bash bison bzip2 cmake flex gettext \
    git sed gperf intltool libffi libtool openssl wget xz \
    coreutils patch pkg-config perl perl-xml-parser scons \
    make unzip gettext ruby

if [ ! -d /opt/mxe ]; then
    sudo git clone https://github.com/mxe/mxe.git /opt/mxe
fi

cd /opt/mxe

sudo make MXE_TARGETS=x86_64-w64-mingw32.shared \
mingw-w64   \
winpthreads \
cairo       \
openssl     \
freetype    \
fontconfig  \
opencv      \
assimp      \
mpg123      \
openal      \
libusb1     \
libsndfile
