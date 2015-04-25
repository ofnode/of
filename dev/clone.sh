#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

function setup() {
  rm -rf $1
  if [ ! -f $2.zip ]; then
    wget $3/archive/$2.zip
  fi
  unzip -q $2.zip
  mv  $1-* $1
}

#-------------------------------------------------------------------------------

cd src

# v 2.0 release
setup assimp 997ce39 https://github.com/ofnode/assimp

# v 2.8.1 release
setup freeglut 6eecfb5 https://github.com/ofnode/freeglut

# v 3.16.0 release
setup freeimage 91e18e9 https://github.com/ofnode/freeimage

# v 1.11.0 release
setup glew 4c7a8db https://github.com/ofnode/glew

# v 3.1.0 release
setup glfw 2a50139 https://github.com/ofnode/glfw

# v 1.7.0 master
setup poco c6cf535 https://github.com/pocoproject/poco

# v 4.0.12 master
setup rtaudio 4d0492e https://github.com/ofnode/rtaudio

# v 0.9.0 master
setup openFrameworks a2feaee https://github.com/openframeworks/openFrameworks

rm -rf videoinput
mkdir  videoinput
wget -q https://raw.githubusercontent.com/ofTheo/videoInput/221b16/videoInputSrcAndDemos/libs/videoInput/videoInput.cpp -O videoinput/videoInput.cpp
wget -q https://raw.githubusercontent.com/ofTheo/videoInput/221b16/videoInputSrcAndDemos/libs/videoInput/videoInput.h   -O videoinput/videoInput.h

#-------------------------------------------------------------------------------

rm -rf openframeworks
mv     openFrameworks/libs/openFrameworks openframeworks

rm -rf tess2
mkdir  tess2

mv     openFrameworks/libs/tess2/include tess2/include
mv     openFrameworks/libs/tess2/Sources tess2/src

rm -rf kiss
mkdir  kiss

mv     openFrameworks/libs/kiss/include kiss/include
mv     openFrameworks/libs/kiss/src     kiss/src

cp     "$OF/dev/add/kiss/CMakeLists.txt"  kiss
cp     "$OF/dev/add/tess2/CMakeLists.txt" tess2

rm -rf "$OF/addons"
mv     openFrameworks/addons "$OF"

rm -rf openFrameworks
