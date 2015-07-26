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

# v 3.17.0 release
setup freeimage 9a35d07 https://github.com/ofnode/freeimage

# v 1.12.0 master
setup glew 4c40805 https://github.com/nigels-com/glew

# v 3.1.0 release
setup glfw 7f7307b https://github.com/arturoc/glfw

# v 1.7.0 master
setup poco 04caf94 https://github.com/pocoproject/poco

# v 4.1.1 release
setup rtaudio 22c00ec https://github.com/thestk/rtaudio

# v 0.9.0 master
setup openFrameworks 45ad9ef https://github.com/openframeworks/openFrameworks

# v 1.0.1 master
setup libtess2 24e4bdd https://github.com/memononen/libtess2

# v none master
setup videoInput 3815d73 https://github.com/ofTheo/videoInput

# v 1.3.0 release
setup kissfft 7d00183 https://github.com/itdaniher/kissfft

sed -i  's/\r//'  "$OF/src/rtaudio/RtAudio.cpp"
echo    "auto/" > "$OF/src/glew/.gitignore"
rm      "$OF/src/poco/.gitignore"

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

cd      "$OF/src/glew/auto" && make

