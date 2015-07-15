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

mkdir -p src
cd src

# v 3.16.0 release
setup freeimage 427cc3c https://github.com/ofnode/freeimage

# v 1.11.0 release
setup glew 4c7a8db https://github.com/ofnode/glew

# v 3.1.0 release
setup glfw 2a50139 https://github.com/ofnode/glfw

# v 1.7.0 master
setup poco c6cf535 https://github.com/pocoproject/poco

# v 4.0.12 release
setup rtaudio d6956ae https://github.com/ofnode/rtaudio

# v 0.9.0 master
setup openFrameworks d292ad5 https://github.com/openframeworks/openFrameworks

# v 1.0.1 master
setup libtess2 24e4bdd https://github.com/memononen/libtess2

# v latest master
setup videoInput 874840a https://github.com/ofTheo/videoInput

if [ ! -f kiss_fft130.tar.gz ]; then
  wget http://downloads.sourceforge.net/project/kissfft/kissfft/v1_3_0/kiss_fft130.tar.gz
fi

rm  -rf kiss
tar -xf kiss_fft130.tar.gz
mv      kiss_fft130 kiss

cp      "$OF/dev/add/libtess2/CMakeLists.txt" libtess2
cp      "$OF/dev/add/kiss/CMakeLists.txt"     kiss

rm  -rf videoinput
mkdir   videoinput
mv      videoInput/videoInputSrcAndDemos/libs/videoInput/videoInput.cpp videoinput/
mv      videoInput/videoInputSrcAndDemos/libs/videoInput/videoInput.h   videoinput/
rm  -rf videoInput

rm  -rf utf8cpp
mv      openFrameworks/libs/utf8cpp utf8cpp

rm  -rf openframeworks
mv      openFrameworks/libs/openFrameworks openframeworks

rm  -rf "$OF/addons"
mv      openFrameworks/addons "$OF"

rm  -rf openFrameworks

