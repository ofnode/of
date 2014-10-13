#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

cd src

rm -rf fontconfig
rm -rf freeimage
rm -rf glew
rm -rf glfw
rm -rf kiss
rm -rf openframeworks
rm -rf poco
rm -rf tess2
