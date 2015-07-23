#!/bin/bash
cd "`dirname "$(readlink -f $0)"`"
cd ..
OF="`pwd`"

function apply() {
  echo
  echo "$1"
  patch -Np1 < "$OF/dev/patches/$1"
}

#-------------------------------------------------------------------------------

cd "$OF/src/glfw"

apply glfw_cmake.patch

cd "$OF/src/libtess2"

apply tess2.patch

cd "$OF/src/poco"

apply poco.patch
apply poco_cmake.patch

cd "$OF/src/videoinput"

apply videoinput.patch

cd "$OF/src/openframeworks"

apply openframeworks.patch
apply openframeworks_modules.patch
apply openframeworks_mingw_unicode.patch

cd "$OF/src/rtaudio"

apply rtaudio.patch

