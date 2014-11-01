#!/bin/bash

yes | sudo pacman -Syu
yes | sudo pacman -Sy --needed \
    autoconf automake bash bison bzip2 cmake flex gettext \
    git gcc gperf intltool libffi libtool openssl wget xz \
    coreutils patch pkg-config perl perl-xml-parser scons \
    sed make unzip gettext ruby

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
mpg123      \
openal      \
libsndfile

sudo make MXE_TARGETS=x86_64-w64-mingw32.shared \
openal      \
libsndfile

sudo ln -s /opt/mxe/usr/x86_64-w64-mingw32.static/share/cmake/mxe-conf.cmake /opt/mxe/mingw.cmake 2> /dev/null

