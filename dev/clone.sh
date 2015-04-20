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
setup assimp 7e2ead4 https://github.com/ofnode/assimp

# v 2.8.1 release
setup freeglut b3d5bc6 https://github.com/ofnode/freeglut

# v 3.16.0 release
setup freeimage 62b55b2 https://github.com/ofnode/freeimage

# v 1.11.0 release
setup glew fef9d94 https://github.com/ofnode/glew

# v 3.1.0 master
setup glfw e6d8d97 https://github.com/ofnode/glfw

# v 1.6.0 master
setup poco 676f043 https://github.com/pocoproject/poco

# v 4.0.12 master
setup rtaudio 02c1527 https://github.com/ofnode/rtaudio

# v 0.9.0 master
setup openFrameworks 1f5515b https://github.com/openframeworks/openFrameworks

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
