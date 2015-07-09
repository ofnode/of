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

cd "$OF/src"

apply poco.patch
apply videoinput.patch
apply poco_cmake.patch
apply glfw_cmake.patch
apply openframeworks.patch
apply openframeworks_modules.patch

cd "$OF/src/libtess2"

apply tess2.patch
