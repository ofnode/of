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

# v 1.13.0
setup glew f0067bb https://github.com/nigels-com/glew

# v 3.1.0
setup glfw 7f7307b https://github.com/ofnode/glfw

# v 1.7.0
setup poco 04caf94 https://github.com/pocoproject/poco

# v 4.1.1
setup rtaudio 22c00ec https://github.com/thestk/rtaudio

# v 0.9.0
setup openFrameworks f26cbce https://github.com/openframeworks/openFrameworks

# v 1.0.1
setup libtess2 24e4bdd https://github.com/ofnode/libtess2

# v 1.0.0
setup videoInput 97fc512 https://github.com/ofnode/videoInput

# v 1.3.0
setup kissfft 7d00183 https://github.com/ofnode/kissfft

# v 3.17.0
rm -rf freeimage
if [ ! -f FreeImage3170.zip ]; then
  wget http://downloads.sourceforge.net/freeimage/FreeImage3170.zip
fi
unzip -q FreeImage3170.zip
mv FreeImage freeimage

# Remove Windows style line endings
sed -i  's/\r//' "$OF/src/rtaudio/RtAudio.cpp"
sed -i  's/\r//' "$OF/src/freeimage/Source/LibRawLite/internal/defines.h"

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

