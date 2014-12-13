#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"
shopt -s extglob

#---------------------------------

rm -rf src/assimp
rm -rf src/freeglut
rm -rf src/freeimage
rm -rf src/glew
rm -rf src/glfw
rm -rf src/kiss
rm -rf src/poco
rm -rf src/rtaudio
rm -rf src/tess2
rm -rf src/openframeworks
rm -rf src/videoinput

rm -rf addons
rm -rf examples/!(CMakeLists.txt)

rm -rf lib
rm     lib.tar.gz 2> /dev/null
