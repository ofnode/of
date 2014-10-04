#!/bin/bash

yes | sudo pacman -Syu
yes | sudo pacman -Sy --needed \
xorg-server-devel              \
libxcursor                     \
libxrandr                      \
libxi                          \
gtk2                           \
llvm                           \
clang                          \
clang-analyzer                 \
ninja                          \
cairo                          \
openssl                        \
freeglut                       \
freetype2

