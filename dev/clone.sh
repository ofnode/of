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

#---------------------------------

cd src

# v 2.0 release
setup assimp 7e2ead https://github.com/procedural/assimp

# v 2.8.1 release
setup freeglut b3d5bc https://github.com/procedural/freeglut

# v 3.16.0 release
setup freeimage 62b55b https://github.com/procedural/freeimage

# v 1.11.0 release
setup glew 442545 https://github.com/omniavinco/glew-cmake

# v 3.1.0 master
setup glfw 0a6cb3 https://github.com/arturoc/glfw

# v 1.5.3 release
setup poco cecf7cd https://github.com/pocoproject/poco

# v 4.0.12 master
setup rtaudio 02c152 https://github.com/procedural/rtaudio

# v 0.8.4 master
setup openFrameworks 2706e5 https://github.com/openframeworks/openFrameworks

rm -rf videoinput
mkdir  videoinput
wget -q https://raw.githubusercontent.com/ofTheo/videoInput/221b16/videoInputSrcAndDemos/libs/videoInput/videoInput.cpp -O videoinput/videoInput.cpp
wget -q https://raw.githubusercontent.com/ofTheo/videoInput/221b16/videoInputSrcAndDemos/libs/videoInput/videoInput.h   -O videoinput/videoInput.h

#---------------------------------

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

cp      "$OF/dev/add/kiss/CMakeLists.txt" kiss
cp     "$OF/dev/add/tess2/CMakeLists.txt" tess2

rm -rf "$OF/addons"
mv     openFrameworks/addons     "$OF"
mv     openFrameworks/examples/* "$OF/examples"

rm -rf openFrameworks
