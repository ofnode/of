#!/bin/bash

sudo yum -y update
sudo yum -y install   \
libstdc++-static      \
xorg-x11-server-devel \
libXcursor-devel      \
libXrandr-devel       \
libXi-devel           \
gtk2-devel            \
libudev-devel         \
llvm                  \
clang                 \
clang-analyzer        \
ninja-build           \
cairo-devel           \
openssl-devel         \
freeglut-devel        \
freetype-devel

sudo ln -s /usr/bin/ninja-build /usr/bin/ninja 2> /dev/null

