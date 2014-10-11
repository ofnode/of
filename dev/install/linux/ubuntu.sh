#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install \
xorg-dev                \
libgtk2.0-dev           \
libudev-dev             \
llvm                    \
clang                   \
cmake                   \
ninja-build             \
libcairo2-dev           \
libssl-dev              \
freeglut3-dev           \
libfreetype6-dev

sudo rm /usr/bin/ld
sudo ln -s `which gold` /usr/bin/ld

sudo ln -s /usr/bin/llvm-symbolizer* /usr/bin/llvm-symbolizer 2> /dev/null

