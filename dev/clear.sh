#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..

#-------------------------------------------------------------------------------

rm -rf src/freeimage
rm -rf src/glew
rm -rf src/glfw
rm -rf src/kiss
rm -rf src/openframeworks
rm -rf src/poco
rm -rf src/rtaudio
rm -rf src/libtess2
rm -rf src/videoinput

rm -rf addons
