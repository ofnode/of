#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

#---------------------------------

rm -rf src/assimp
rm -rf src/fontconfig
rm -rf src/freeglut
rm -rf src/freeimage
rm -rf src/glew
rm -rf src/glfw
rm -rf src/kiss
rm -rf src/libusb
rm -rf src/poco
rm -rf src/rtaudio
rm -rf src/tess2
rm -rf src/openframeworks

rm -rf addons

rm -rf lib
rm     lib.tar.gz 2> /dev/null
