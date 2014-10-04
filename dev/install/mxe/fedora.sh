#!/bin/bash

sudo yum -y update
sudo yum -y install \
    autoconf automake bash bison bzip2 cmake flex \
    gcc-c++ gettext git intltool make sed wget xz \
    libffi-devel libtool openssl-devel patch perl \
    pkgconfig scons unzip gperf ruby

if [ ! -d /opt/mxe ]; then
    sudo git clone https://github.com/mxe/mxe.git /opt/mxe
fi

cd /opt/mxe

sudo make MXE_TARGETS=x86_64-w64-mingw32.static \
mingw-w64   \
winpthreads \
cairo       \
openssl     \
freeglut    \
freetype

sudo ln -s /opt/mxe/usr/x86_64-w64-mingw32.static/share/cmake/mxe-conf.cmake /opt/mxe/mingw.cmake 2> /dev/null

